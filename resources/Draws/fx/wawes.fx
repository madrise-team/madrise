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
float4x4 WorldViewProjection;
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

float2 rand2(float2 p){
    float a = sin(p.x *656.684  + p.y *164.654);
    float b = cos(p.x *96.6547  + p.y *468.6321);
    return frac(float2(a,b));  
}

float voronoy(float2 uv){
    float result;

    float minD = 100;

    for(int i=0; i < 10; i++){
        float2 r = rand2(i);
        float2 p = sin(r * Time/25);
        float d = length(uv - p);
        if(d < minD) { minD = d; }
    }

    return minD;
}   

PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    float vis = voronoy(VS.Position.xy);
    //VS.Position.z += vis;

    PS.Position = mul(float4(VS.Position, 1), WorldViewProjection);
    PS.Diffuse = float4(VS.Position.xy,0,1);
    PS.TexCoord = VS.TexCoord;

    return PS;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{

    float4 finalColor = tex2D(Sampler0, PS.TexCoord) * PS.Diffuse;
    //finalColor = voronoy(PS.TexCoord);
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
