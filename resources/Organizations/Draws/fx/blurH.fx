texture screen;
sampler2D SamplerScreene = sampler_state
{
    Texture = (screen);
};
float3 texel_radius;





struct PSInput
{
  float4 Position : POSITION0;
  float4 Diffuse  : COLOR0;
  float2 TexCoord : TEXCOORD0;
};
struct PsOut
 {
  float4 Color      : COLOR0;
  float4 RTColor    : COLOR1;
 };

float4 PixelShaderFunction1(PSInput PS) : COLOR0
{
    float offset = 1.0 / 300.0; 

    float2 offsets[] = {
        float2(-offset, 0), // top-left
        float2(0,0), // top-left
        float2(0, offset), // top-left
    };

    float kernel[] = {
        2.0 /8,  4.0 /8,  2.0 /8
    };

    float4 sampleTex[9];
    for(int i = 0; i < 3; i++)
    {
        sampleTex[i] = tex2D(SamplerScreene, PS.TexCoord + offsets[i]);
    }

    float4 col = float4(0,0,0,1);
    for(int j = 0; j < 3; j++)
        col += sampleTex[j] * kernel[j];

    float4 finColor = float4(col.xyz,1.0);

    return finColor;
}

PsOut PixelShaderFunction2(PSInput PS) : COLOR0
{
    float r = 15;
    float totalScale = 1.0 + r;
    float4 value = tex2D(SamplerScreene, PS.TexCoord) * totalScale;

    float x = 1.0;
    while (x <= r)
    {
      float2 dudv = texel_radius.xy * x;
      float scale = 1.0 + r - x;
      value += scale * (tex2D(SamplerScreene, PS.TexCoord - dudv) +
                        tex2D(SamplerScreene, PS.TexCoord + dudv));
      x += 1.0;
    }

    PsOut OUTer;
    OUTer.Color = value / totalScale / totalScale;
    OUTer.RTColor = OUTer.Color;

    return OUTer;

} 

//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique blocky
{
    pass P0
    {
        PixelShader  = compile ps_2_0 PixelShaderFunction1();
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

