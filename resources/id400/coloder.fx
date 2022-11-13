float Time;

//sampler Sampler0 = sampler_state
//{
//    Texture = (Tex0);
//};

struct PSInput
{
    float4  Position : TEXCOORD0;
    float2 PixelSreenCoord : VPOS;
    float4 Diffuse : COLOR0;
};

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float4 uv = PS.Position;

    float3 col = 0.5 + 0.5*cos((Time*1.1)+uv.xyz+float3(0,2,4));

    return float4(col,1.0);
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique normall
{

    pass P0
    {
        PixelShader  = compile ps_3_0 PixelShaderFunction();
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}

