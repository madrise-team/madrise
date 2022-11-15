texture textura;
texture pattern;
float threshold;
sampler2D SamplerScreene = sampler_state
{
    Texture = (textura);
};
sampler2D SamplerPattern = sampler_state
{
    Texture = (pattern);
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

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float4 texColor = tex2D(SamplerScreene, PS.TexCoord);
    float4 patternColor = tex2D(SamplerPattern, PS.TexCoord);

    float colValue = patternColor.y + patternColor.z;

    float alpha = 0;
    if(threshold/255.0 > colValue){
        alpha = (threshold/255.0 - colValue);
    }
    float pluser = clamp(1 - (threshold/255.0 - colValue)/0.45,0,1);
    pluser *= 2;

    alpha = alpha * (4 - 4*pluser);

    float2 colorerRer = texColor.yz + pluser;

    return float4(texColor.x + pluser/6,texColor.y + pluser/1.6,texColor.z + pluser/1.2, texColor.a*clamp(alpha,0,1));
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

