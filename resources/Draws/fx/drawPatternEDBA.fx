#include "mta-helper.fx"

float Time;

float screenW;
float screenH;


struct PSInput
{
  float4 TexCoord : SV_POSITION;
};

float4 PixelShaderFunction_RECTs(PSInput PS) : COLOR0
{
    PS.TexCoord.x /= screenW;
    PS.TexCoord.y /= screenH;

    PS.TexCoord.y /= screenW/screenH;    

    float rectCount = 60;
    float rectSize = 1 / rectCount;
    float2 xySmes = PS.TexCoord % rectSize;

    int xNum = floor(PS.TexCoord.x / rectSize);
    int yNum = floor(PS.TexCoord.y / rectSize);

    float xDel = 5.0f;
    float xNumD = xNum / xDel;
    float yNumD = yNum / xDel / 5.0f;


    float value = (sin( xNumD - yNumD + Time/3 )+1)/2 + 0.2;

    float fillSize = 0.65*value + 0.1;
    float fillTo = (0.5 + fillSize/2);

    float fillS = rectSize*(1 - fillTo);
    float fillE = rectSize*fillTo;

    float colVal = 0;
    if ((xySmes.x > fillS ) && (xySmes.x < fillE )){
        colVal = value;
    }
    if ((xySmes.y > fillS ) && (xySmes.y < fillE )){
        colVal = colVal;
    }else{
        colVal = 0;
    }

    float rMod = (sin(xNum/25.0f + Time/1.0)+1)/2  *2;
    float gMod = (sin(yNum/25.0f + Time/1.2)+1)/2  *2;
    float bMod = (cos((xNum+yNum/60)/15.0f + Time/1.8)+1)/2  *2;
    float4 finColor = float4(colVal *rMod * value,
                             colVal *gMod * value,
                             colVal *bMod * value, 1);
    return finColor;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    PS.TexCoord.x /= screenW;
    PS.TexCoord.y /= screenH;

    PS.TexCoord.y /= screenW/screenH;    

    float rectCount = 60.0;
    float rectSize = 1.0 / rectCount;
    float2 xySmes = PS.TexCoord % rectSize;

    int xNum = floor(PS.TexCoord.x / rectSize);
    int yNum = floor(PS.TexCoord.y / rectSize);

    float xDel = 5.0f;
    float xNumD = xNum / xDel;
    float yNumD = yNum / xDel / 5.0f;

    float value = (sin( xNumD - yNumD + Time/3 )+1)/2 + 0.2;

    float fillSize = (0.65*value + 0.1);
    fillSize = 1  * (xySmes.y/rectSize);
    float fillTo = (0.5 + fillSize/2);

    float fillS = rectSize*(1 - fillTo);
    float fillE = rectSize*fillTo;

    float colVal = 0;
    if ((xySmes.x > fillS ) && (xySmes.x < fillE )){
        colVal = value;
    }
    if ((xySmes.y > fillS ) && (xySmes.y < fillE )){
        colVal = colVal;
    }else{
        colVal = 0;
    }

    float rMod = (sin(xNum/20.0f + Time/1.0)+1)/2  ;
    float gMod = (sin(yNum/20.0f + Time/1.2)+1)/2  ;
    float bMod = (cos((xNum+yNum/60)/10.0f + Time/1.8)+1)/2  ;

    float r = colVal *rMod * value;
    float g = colVal *gMod * value;
    float b = colVal *bMod * value;

    float4 finColor = float4(r,g,b, 1) * 1.5;
    finColor = floor(finColor * 4.0) / 4.0;    // Sampling
    

    finColor.a = 1;
    return finColor;
}

//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique fucky
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

