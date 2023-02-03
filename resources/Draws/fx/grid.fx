struct PSInput
{
  float4 Diffuse  : COLOR0;
  float2 TexCoord : TEXCOORD0;
};


float bigger(float a, float b){
    return clamp( a - b ,0,1);
}

float bigger_smooth(float a, float b, float smearing){
    float res = a - b;
    res+=smearing;

    return clamp( res/(smearing*2) ,0,1);
}


/// [SETTINGS] //////////////////////////////////////////
float gridSize = 250;
float thickness = 5;

/// [SETTINGS] //////////////////////////////////////////


float4 PixelShaderFunction(PSInput PS) : COLOR0
{
  //  PS.vPos += 2500;    

 //   float4 grid = bigger(PS.vPos.x % gridSize, gridSize-thickness) + bigger(PS.vPos.y % gridSize, gridSize-thickness);
 //   float finColor = grid ;

    return PS.TexCoord.x;
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

