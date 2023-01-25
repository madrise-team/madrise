#include "mta-helper.fx"

//-- Declare the textures. These are set using dxSetShaderValue( shader, "Tex0", texture )
texture Tex0;
texture Tex1;

//-- Declare a user variable. This can be set using dxSetShaderValue( shader, "PositionOfCheese", 1, 2, 3 )
float3 dstPos = float3(0,0,0);

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

PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    float vis = voronoy_simple(VS.TexCoord);
    VS.Position.z -= vis*vis*40;

    PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection);
    PS.Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse );
    PS.TexCoord = VS.TexCoord;

    PS.Diffuse.rg = vis*vis*4;

    return PS;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{

    float4 finalColor = PS.Diffuse;
    //finalColor.gb = voronoy_simple(PS.TexCoord);
    return finalColor;
}


//-----------------------------------------------------------------------------
//-- Techniques
//-----------------------------------------------------------------------------

//--
//-- MTA will try this technique first:
//--
technique complercated
{
    pass P0
    {
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader  = compile ps_3_0 PixelShaderFunction();
    }
}
