#define GENERATE_NORMALS      // Uncomment for normals to be generated
#include "mta-helper.fx"

//-- Declare the textures. These are set using dxSetShaderValue( shader, "Tex0", texture )
texture Tex0;


//-- These variables are set automatically by MTA
float4x4 World;
float4x4 View;
float4x4 Projection;
float Time;


sampler Sampler0 = sampler_state
{
    Texture = (Tex0);
};

//---------------------------------------------------------------------
// Structure of data sent to the vertex and pixel shader
//---------------------------------------------------------------------
struct VSInput
{
    float3 Position : POSITION0;
    float3 Normal : NORMAL0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};
//---------------------------------------------------------------------


float2 random( float2 pos )
{ 
    return frac(
        sin(
            float2(
                dot(pos, float2(12.9898,78.233))
            ,   dot(pos, float2(-148.998,-65.233))
            )
        ) * 43758.5453
    );
}
float value_noise( float2 pos )
{
    float2 p = floor( pos );
    float2 f = frac( pos );

    float v00 = random( p + float2( 0.0, 0.0 ) ).x;
    float v10 = random( p + float2( 1.0, 0.0 ) ).x;
    float v01 = random( p + float2( 0.0, 1.0 ) ).x;
    float v11 = random( p + float2( 1.0, 1.0 ) ).x;

    float2 u = f * f * ( 3.0 - 2.0 * f );

    return smoothstep( smoothstep( v00, v10, u.x ), smoothstep( v01, v11, u.x ), u.y );
}

float voronoi( float2 v )
{
    float2 v_floor = floor( v );
    float2 v_frac = frac( v );

    float min_dist = 2.0;

    for( int y = -1; y <= 1; y ++ ) {
        for( int x = -1; x <= 1; x ++ ) {
            float2 n = float2( float( x ), float( y ) );
            float2 p = random( v_floor + n );
            float2 diff = p + n;
            float d = distance( v_frac, diff );

            min_dist = min( min_dist, d );
        }
    }

    return min_dist;
}


float2 rand2(float2 p){
    float a = sin(p.x *656.684  + p.y *164.654);
    float b = cos(p.x *96.6547  + p.y *468.6321);
    return frac(float2(a,b));  
}

float voronoy_simple(float2 uv){
    float result;

    float minD = 100;

    for(int i=0; i < 50; i++){
        float2 r = rand2(i);
        float2 p = sin(r * Time/10);
        float d = length(uv - p);
        if(d < minD) { minD = d; }
    }

    return minD;
}   


texture patTex;
sampler patTexSample = sampler_state
{
    Texture = (patTex);
};
texture noiseTex;
sampler2D noiseSampler = sampler_state
{
    Texture = (noiseTex);
};

float4 WaveA = float4(1, 0,   0.5, 20.0);
float4 WaveB = float4(1, 0,   0.5, 20.0);
float4 WaveC = float4(1, 0,   0.5, 20.0);
float timeSpeedK = 1;

float3 GerstnerWave(float4 wave, float3 p, float tTime){
    float steepness = wave.z;
    float wavelength = wave.w;
    float k = 2 * PI / wavelength;
    float c = sqrt(100 / k);
    float2 d = normalize(wave.xy);
    float f = k * (dot(d, p.xy) - c * tTime);
    float a = steepness / k;

    return float3(
        d.x * (a * cos(f)),
        d.y * (a * cos(f)),
        a * sin(f)
    );
}

PSInput WaweVertex(VSInput VS)
{
    PSInput PS = (PSInput)0;

    float tTime = Time * timeSpeedK;

    float3 gridPoint = VS.Position.xyz;
    float3 p = gridPoint;
    p += GerstnerWave(WaveA, gridPoint, tTime);
    p += GerstnerWave(WaveB, gridPoint, tTime);
    p += GerstnerWave(WaveC, gridPoint, tTime);
    VS.Position.xyz = p;
    //VS.Position.z -= voronoy_simple(p.xy);

    PS.Diffuse = ( VS.Position.z+ 1 )/4 + 0.5;
    PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection);
    PS.TexCoord = VS.TexCoord;
    return PS;
}



float bigger(float a, float b, float smearing){
    float res = a - b;
    res+=smearing;

    return clamp( res/(smearing*2) ,0,1);
}


float screenW;
float screenH;

/// [SETTINGS] ///////////////////////////////////////////////////////
float4 origColor = float4( 0.0784, 0.20, 0.884, 1);
float4 intenseColor = float4( 0.0784, 0.9274, 0.984, 1)*2;
float4 coreColor = float4( 0.554, 0.0, 0.404, 1);
float efxPos = 0;
float efxColType = 1;  // 1 - intense, 0 - core

float efxSmearing = 0.1;
float trgSmearing = 0.015;
float ovpSmearing = 0.03;

float rectSize = 0.03;
/// [SETTINGS] ///////////////////////////////////////////////////////


float4 processTriangles(PSInput PS, int tNum, float rectSize, float tTime, float4 efxColor){

    float2 coords = PS.TexCoord;

    coords.xy = coords.yx;

    coords.x += rectSize/2*tNum;

    int yNum = floor(coords.y / rectSize);
    int chet = yNum%2;
    int invChet = 1 - chet;
    coords.x += rectSize/2*chet;
    int xNum = floor(coords.x / rectSize);

    float xNumR = xNum * rectSize;
    float yNumR = yNum * rectSize;

    ////////////////////////////////////////////////
    // noise ///////////////////////////////////
    //
        float noiseVal = tex2D(noiseSampler, float2(xNumR - yNumR/3*tNum ,yNumR) + (tTime+2*tNum)/15).r;
        float slowNoiseVal = tex2D(noiseSampler, float2(xNumR - yNumR*tNum,yNumR + xNumR*tNum) + tTime/25 + 5*chet).r;

    ////////////////////////////////////////////////
    // EFX ///////////////////////////////////
    //
        float posR = xNumR - yNumR/5 + noiseVal/5;
        float efxPxl = bigger(posR, efxPos, efxSmearing) - clamp( (posR/2 - efxPos)/3 ,0,1);

    ////////////////////////////////////////////////
    // Triangles /////////////////////////////
    //
        float2 smes = (coords % rectSize) / rectSize;  //( |0...1|)
        float invSmesY = abs(tNum-smes.y);

        float power = tex2D(noiseSampler, (xNumR - yNumR/5.0f + tTime)/35   ).r;
        power = clamp(power*1.5 - slowNoiseVal/2*(1-efxColType)*efxPxl , 0.45, 1.06);
        float value = clamp(power + efxPxl/4,0.01,1);

        float fillSize = invSmesY - (1 - value);

        float flsz_d2 = fillSize/2;
        float fillS = 0.5 - flsz_d2;
        float fillE = 0.5 + flsz_d2;

        float pxlSv = bigger( smes.x , fillS, trgSmearing);
        float pxlEv = bigger( smes.x , fillE, trgSmearing);

        float fillSizeRect_d2 = value/2;
        float yFillE =  (0.5 + fillSizeRect_d2);
        float yCutSv = bigger( smes.y , (0.49 - fillSizeRect_d2) , trgSmearing );
        float yCutEv = bigger( smes.y , yFillE , trgSmearing );

        float colVal = (pxlSv - pxlEv) * (yCutSv - yCutEv) * 0.5;

        float4 finColor = colVal;

    ////////////////////////////////////////////////
    // overpower ///////////////////////////////////
    //
        float overpower = clamp(power - 1 ,0,1);

        float overPxl_i = bigger( smes.x , fillS + overpower , ovpSmearing );
        float overPxl = (1 - overPxl_i) * colVal;
        finColor += overPxl/2 - 0.4*tNum*overPxl;

        float overPxl_i2 = bigger( smes.x , fillE - overpower , ovpSmearing );
        finColor -= overPxl_i2/4.0*colVal;

        float overY_i =  bigger( invSmesY , yFillE - overpower/1.5 , ovpSmearing);
        float overY = overY_i * colVal;
        finColor += overY - 1.2*(1-tNum)*overY;

    ////////////////////////////////////////////////

    float efxPower = colVal*efxPxl*(noiseVal+0.4);
    finColor = (((origColor + slowNoiseVal/9)*2*finColor)*value ) * (1 - efxPower) + efxPower*efxColor;
    return finColor;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{

    PS.TexCoord += rectSize*3;
        
    float4 efxColor = intenseColor*efxColType + coreColor*(1- efxColType);

    float tTime = Time/10;
    float4 finColor1 = float4(0,0,0,1);
    float4 finColor2 = finColor1;
    finColor1 = processTriangles(PS, 0 ,rectSize, tTime          ,efxColor); 
    finColor2 = processTriangles(PS, 1 ,rectSize, tTime + 0.035  ,efxColor);
    finColor1.a = 1;
    finColor2.a = 1;

    //finColor2 = 0;
    return finColor1 + finColor2;
}
//-----------------------------------------------------------------------------
//-- Techniques
//-----------------------------------------------------------------------------

technique wawes
{
    pass P0
    {
        VertexShader = compile vs_3_0 WaweVertex();
        PixelShader  = compile ps_3_0 PixelShaderFunction();
    }
}
