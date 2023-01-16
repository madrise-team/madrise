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
    float2 smes = PS.TexCoord % rectSize;

    int xNum = floor(PS.TexCoord.x / rectSize);
    int yNum = floor(PS.TexCoord.y / rectSize);

    float xDel = 5.0f;
    float xNumD = xNum / xDel;
    float yNumD = yNum / xDel / 5.0f;


    float value = (sin( xNumD - yNumD + Time/3 )+1)/2 + 0.2;

    float fillSize = 0.65*value/2 + 0.1;
    float fillTo = (0.5 + fillSize/2);

    float fillS = rectSize*(1 - fillTo);
    float fillE = rectSize*fillTo;

    float colVal = 0;
    if ((smes.x > fillS ) && (smes.x < fillE )){
        colVal = value;
    }
    if ((smes.y > fillS ) && (smes.y < fillE )){
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

float4 PixelShaderFunction_Pixelz(PSInput PS) : COLOR0
{
    float tTime = Time/2.5;

    float rectSize = 8;
    float2 smes = PS.TexCoord % rectSize;

    int xNum = floor(PS.TexCoord.x / rectSize);
    int yNum = floor(PS.TexCoord.y / rectSize);

    float xDel = 25.0f;
    float xNumD = xNum / xDel;
    float yNumD = yNum / xDel / 5.0f;

    float value = (sin( xNumD - yNumD + tTime/3 )+1)/2 + 0.2;

    float fillSize = (0.65*value + 0.1);
   // fillSize = 1  * (smes.y/rectSize);
    float fillTo = (0.5 + fillSize/2);

    float fillS = rectSize*(1 - fillTo);
    float fillE = rectSize*fillTo;

    float colVal = 0;
    if ((smes.x > fillS ) && (smes.x < fillE )){
        colVal = value;
    }
    if ((smes.y > fillS ) && (smes.y < fillE )){
        colVal = colVal;
    }else{
        colVal = 0;
    }

    float rMod = (sin(xNum/200.0f + tTime/1.0)+1)/2  ;
    float gMod = (sin(yNum/200.0f + tTime/1.2)+1)/2  ;
    float bMod = (cos((xNum-yNum/5)/100.0f + tTime/1.8)+1)/2  ;

    float r = colVal *rMod * value;
    float g = colVal *gMod * value;
    float b = colVal *bMod * value;

    float4 finColor = float4(r,g,b, 1) * 1.5;
    finColor = floor(finColor * 4.0) / 4.0;    // Sampling
    

    finColor.a = 1;
    return finColor;
}




float4 processTriangles(PSInput PS, int tNum, float rectSize, float tTime){

    //float2 coords = PS.TexCoord + ((sin(tTime) + 1)/2)*100;
    float2 coords = PS.TexCoord;

    coords.x += rectSize/2*tNum;

    int yNum = floor(coords.y / rectSize);
    int chet = yNum%2;
    coords.x += rectSize/2*chet;
    int xNum = floor(coords.x / rectSize);

    float2 smes = (coords % rectSize) / rectSize;  //( |0...1|)


    float xDel = 4.0f;
    float xNumD = xNum / xDel;
    float yNumD = yNum / xDel / 5.0f;

    float power = (sin( xNumD - yNumD + tTime/3 )+1)/2 + 0.4;
    float value = clamp(power,0,1);

    //float value = (sin(tTime) + 1)/2;
    //value = 1 - 0.2;

    float fillSize = abs(tNum-smes.y) - (1 - value)/1.5;

    float flsz_d2 = fillSize/2;
    float fillS = 0.5 - flsz_d2 + 0.0000001;
    float fillE = 0.5 + flsz_d2;


    int pxlSe = clamp( (smes.x + 0.0001)   / fillS, 0,1);
    int pxlEs = clamp(  smes.x             / fillE, 0,1);

    float fillSizeRect_d2 = value/2;
    int yCutSe = clamp(  (smes.y + 0.0001) / (0.5 - fillSizeRect_d2)  , 0,1);
    int yCutEs = clamp(  smes.y / (0.5 + fillSizeRect_d2)  , 0,1);

    float colVal = (pxlSe.x - pxlEs.x) * (yCutSe - yCutEs) * 0.8;

    float4 finColor = float4(colVal,colVal,colVal, 1);
    
    /////////////////////////////////////

    float overpower = clamp(power - 1,0,1);
    float overX = (fillS - 0.001) + overpower*fillSizeRect_d2;
    int overPxl_i = clamp( smes.x / overX ,0,1);
    float overPxl = (1 - overPxl_i) * colVal;

    finColor += overPxl;

    /////////////////////////////////////

    finColor.a = 1;
    return finColor;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float tTime = Time/2.5;

    float rectSize = 5;

    float4 finColor1 = processTriangles(PS, 0 ,rectSize,tTime);
    float4 finColor2 = processTriangles(PS, 1 ,rectSize,tTime); // time + 20?

    
    return finColor1 + finColor2;
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

