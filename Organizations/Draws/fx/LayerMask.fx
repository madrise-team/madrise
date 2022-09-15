texture textura;
texture mask;
float threshold;
sampler2D SamplerScreene = sampler_state
{
    Texture = (textura);
};
sampler2D SamplerMaks = sampler_state
{
    Texture = (mask);
};
float3 texel_radius;


struct PSInput
{
  float4 Position : POSITION0;
  float4 Diffuse  : COLOR0;
  float2 TexCoord : TEXCOORD0;
};

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float4 texColor = tex2D(SamplerScreene, PS.TexCoord);
    float4 maskColor = tex2D(SamplerMaks, PS.TexCoord);

    return float4(texColor.xyz, texColor.a*maskColor.a);
}

//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique blocky
{
    pass P0
    {
        PixelShader  = compile ps_2_0 PixelShaderFunction();
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

