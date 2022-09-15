texture RT <string renderTarget = "yes";>;
texture screen;
sampler2D SamplerScreene = sampler_state
{
    Texture = (screen);
};

const float offset[] = {0.0, 1.0, 2.0, 3.0, 4.0};
const float weight[] = {
  0.2270270270, 0.1945945946, 0.1216216216,
  0.0540540541, 0.0162162162
};




struct PSInput
{
  float4 Position : POSITION0;
  float4 Diffuse  : COLOR0;
  float2 TexCoord : TEXCOORD0;
};




float4 PixelShaderFunction1(PSInput PS) : COLOR0
{
    float4 finColor = float4(0,0,0,0);
    
    return finColor;
}
float4 PixelShaderFunction2(PSInput PS) : COLOR0
{
    float4 finColor = tex2D(SamplerScreene, PS.TexCoord);
    
    return finColor;
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
    pass P1
    {        
        PixelShader  = compile ps_2_0 PixelShaderFunction2();
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

