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

struct VSInput
{
    float3 Position : POSITION;
    float4 Diffuse  : COLOR0;
    float2 TexCoord : TEXCOORD0;
};

struct PSInput
{
  float4 Position : POSITION0;
  float4 Diffuse  : COLOR0;
  float2 TexCoord : TEXCOORD0;
};

PSInput VertexShaderExample(VSInput VS)
{
    PSInput PS = (PSInput)0;

    //-- Transform vertex position (You nearly always have to do something like this)
    PS.Position = mul(float4(VS.Position, 1), WorldViewProjection);

    //-- Copy the color and texture coords so the pixel shader can use them
    PS.Diffuse = VS.Diffuse;
    PS.TexCoord = VS.TexCoord;

    return PS;
}

float4 PixelShaderExample(PSInput PS) : COLOR0
{
    float distance = sqrt( pow(PS.Position.x + dstPos.x,2) + pow(PS.Position.y + dstPos.y,2) );

    //-- Grab the pixel from the texture
    float4 finalColor = tex2D(Sampler0, PS.TexCoord);

    //-- Apply color tint
    finalColor = finalColor * PS.Diffuse;

    return PS.Diffuse;
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
        VertexShader = compile vs_2_0 VertexShaderExample();
        PixelShader  = compile ps_2_0 PixelShaderExample();
    }
}
