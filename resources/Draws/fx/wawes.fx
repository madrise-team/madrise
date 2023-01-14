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

//---------------------------------------------------------------------

sampler Sampler0 = sampler_state
{
    Texture = (Tex0);
};

//---------------------------------------------------------------------
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
    float3 Position : POSITION0;
    float3 Normal : NORMAL0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};

PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    // Do morph effect by adding surface normal to the vertex position
    float vis = sin(VS.Position.y + Time);
    VS.Position.z += vis;

    // Calculate screen pos of vertex
    PS.Position = MTACalcScreenPosition ( VS.Position );

    // Pass through tex coords
    PS.TexCoord = VS.TexCoord;

    // Calc GTA lighting for peds
    PS.Diffuse = float4(vis,vis,vis,0.5);

    return PS;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float distance = sqrt( pow(PS.Position.x + dstPos.x,2) + pow(PS.Position.y + dstPos.y,2) );

    //-- Grab the pixel from the texture
    float4 finalColor = tex2D(Sampler0, PS.TexCoord);

    //-- Apply color tint
    finalColor = finalColor * PS.Diffuse;

    return float4(1,1,1,1);
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
        FillMode = 3;
        VertexShader = compile vs_2_0 VertexShaderFunction();
       // PixelShader  = compile ps_2_0 PixelShaderFunction();
    }
}
