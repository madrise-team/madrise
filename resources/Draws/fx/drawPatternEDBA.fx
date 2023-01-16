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


float bigger(float a, float b){
    float res = a - b;
    res+=0.015;

    return clamp( res/0.03 ,0,1);
}

float4 processTriangles(PSInput PS, int tNum, float rectSize, float tTime){

    float2 coords = PS.TexCoord;

    coords.x += rectSize/2*tNum;

    int yNum = floor(coords.y / rectSize);
    int chet = yNum%2;
    coords.x += rectSize/2*chet;
    int xNum = floor(coords.x / rectSize);

    float2 smes = (coords % rectSize) / rectSize;  //( |0...1|)
    float invSmesY = abs(tNum-smes.y);

    float xDel = 4.0f;
    float xNumD = xNum / xDel;
    float yNumD = yNum / xDel / 5.0f;

    float power = (sin( xNumD - yNumD + tTime/3 )+1)/2 + 0.4;
    float value = clamp(power,0,1); //value = 1 - 0.2;

    float fillSize = invSmesY - (1 - value);

    float flsz_d2 = fillSize/2;
    float fillS = 0.5 - flsz_d2;
    float fillE = 0.5 + flsz_d2;


    float pxlSv = bigger( smes.x , fillS);
    float pxlEv = bigger( smes.x , fillE);

    float fillSizeRect_d2 = value/2;
    float yFillE =  (0.5 + fillSizeRect_d2);
    float yCutSv = bigger( smes.y , (0.5 - fillSizeRect_d2) );
    float yCutEv = bigger( smes.y , yFillE );

    float colVal = (pxlSv - pxlEv) * (yCutSv - yCutEv) * 0.5;

    float4 finColor = float4(colVal,colVal,colVal, 1);
    
    //if(true) {return finColor;}

    /////////////////////////////////////
    float overpower = (power - 1) / 7;

    float overPxl_i = bigger( smes.x , fillS + overpower );
    float overPxl = (1 - overPxl_i) * colVal;
    finColor += overPxl/2 - 1*tNum*overPxl;

    float overPxl_i2 = bigger( smes.x , fillE - overpower );
    finColor -= overPxl_i2/6.0*colVal;

    float overY_i =  bigger( invSmesY , yFillE - overpower);
    float overY = overY_i * colVal;
    finColor += overY - 1.2*(1-tNum)*overY;
    /////////////////////////////////////

    finColor.a = 1;
    return finColor;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float tTime = Time/2.5;

    float rectSize = 50;

    PS.TexCoord += 1000;

    float4 finColor1 = float4(0,0,0,1);
    float4 finColor2 = finColor1;
    finColor1 = processTriangles(PS, 0 ,rectSize,tTime); 
    finColor2 = processTriangles(PS, 1 ,rectSize,tTime +1); // time + 20?

    
    return finColor1 + finColor2;
}

float4 tester(PSInput PS) : COLOR0
{
    float a = PS.TexCoord.x;
    float b = 500;

    float res = bigger(a,b);

    return float4(res,res,res,1);
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

