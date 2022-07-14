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
    float offset = 1.0 / 150.0; 

    float2 offsets[] = {
        float2(-offset, -offset), 
        float2(0,       -offset), 
        float2(offset,  -offset),
        float2(-offset,       0), 
        float2(0,             0), 
        float2(offset,        0),
        float2(-offset, offset), 
        float2(0,       offset), 
        float2(offset,  offset)
    };

    float kernel[] = {
        1.0 /16,  2.0 /16,  1.0 /16,
        2.0 /16,  4.0 /16,  2.0 /16,
        1.0 /16,  2.0 /16,  1.0 /16
    };

    float4 sampleTex[9];
    for(int i = 0; i < 9; i++)
    {
        sampleTex[i] = tex2D(SamplerScreene, PS.TexCoord + offsets[i]);
    }

    float4 col = float4(0,0,0,1);
    for(int j = 0; j < 9; j++)
        col += sampleTex[j] * kernel[j];

    //float4 finColor = float4(col.xyz + float3(0.015,0.025,0.025),1.0);
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

