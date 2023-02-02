#include "mta-helper.fx"

//-- These variables are set automatically by MTA
float4x4 World;
float4x4 View;
float4x4 Projection;
float Time;

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

/// [WAWES SETTINGS] ///////////////////////////////////////////////////////
float4 WaveA = float4(1,    0.25,       0.3, 12);
float4 WaveB = float4(0.5,  1,          0.4, 17);
float4 WaveC = float4(0.25, -1,         0.15, 6);
float timeSpeedK = 0.012;
/// [WAWES SETTINGS] ///////////////////////////////////////////////////////

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

    PS.Diffuse = ( (VS.Position.z + 1)/2 + (sin(tTime/100)+1)/2);
    PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection);
    PS.TexCoord = VS.TexCoord;
    return PS;
}



float bigger(float a, float b, float smearing){
    float res = a - b;
    res+=smearing;

    return clamp( res/(smearing*2) ,0,1);
}

/// [PATTERN SETTINGS] ///////////////////////////////////////////////////////
float4 origColor = float4( 0.0784, 0.20, 0.884, 1);
float4 intenseColor_o = float4( 0.0784, 0.9274, 0.984, 1)*2;
float4 intenseColor = float4( 0.0784, 0.70, 0.884, 1)*2;
float4 coreColor = float4( 0.654, 0.0, 0.404, 1);
float efxPos = 0;
float efxColType = 1;  // 1 - intense, 0 - core

float efxSmearing = 0.1;
float trgSmearing = 0.015  *40;
float ovpSmearing = 0.03   *40;

float rectSize = 0.005;

texture RT < string renderTarget = "yes"; >;
/// [PATTERN SETTINGS] ///////////////////////////////////////////////////////


float4 processTriangles(PSInput PS, int tNum, float rectSize, float tTime, float4 efxColor){
    float2 coords = PS.TexCoord;

    coords.xy = coords.yx;

    coords.x += rectSize/2*tNum;
    coords.y *= 2.0f / 3.25f ;

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
        float noiseVal = tex2D(noiseSampler, float2(xNumR - yNumR*5*tNum ,yNumR)*20 + (tTime+2*tNum)/5).r;
        float slowNoiseVal = tex2D(noiseSampler, float2(xNumR - yNumR*tNum,yNumR + xNumR*tNum)*20 + tTime/25 + 5*chet).r;

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

        float power = tex2D(noiseSampler, (xNumR - yNumR/5.0f + tTime)/15   ).r;
        power = clamp(power*1.5 - slowNoiseVal/2*(1-efxColType)*efxPxl , 0.6, 1.06);
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

struct PS_OUT {
    float4 color : COLOR0 ;  
    float4 rtColor : COLOR1 ;
};

PS_OUT PixelShaderFunction(PSInput PS) : COLOR0
{

    PS.TexCoord += rectSize*3;
        
    float4 efxColor = intenseColor*efxColType + coreColor*(1- efxColType);

    float tTime = Time/25;
    float4 tr1Color = float4(0,0,0,1);
    float4 tr2Color = tr1Color;
    tr1Color = processTriangles(PS, 0 ,rectSize, tTime          ,efxColor); 
    tr2Color = processTriangles(PS, 1 ,rectSize, tTime + 0.035  ,efxColor);
    tr1Color.a = 1;
    tr2Color.a = 1;

    PS_OUT psout = (PS_OUT)0;

    psout.color = 0;
    psout.rtColor = (tr1Color + tr2Color)*(PS.Diffuse+0.5);

    return psout;
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
