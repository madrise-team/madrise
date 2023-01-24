#include "mta-helper.fx"

float Time;

float screenW;
float screenH;

texture noiseTex;
sampler2D noiseSampler = sampler_state
{
    Texture = (noiseTex);
};


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


float bigger(float a, float b, float smearing){
    float res = a - b;
    res+=smearing;

    return clamp( res/(smearing*2) ,0,1);
}

/// [SETTINGS] ///////////////////////////////////////////////////////
float4 origColor = float4( 0.0784, 0.20, 0.884, 1);
float4 intenseColor = float4( 0.0784, 0.9274, 0.984, 1)*2;
float4 coreColor = float4( 0.554, 0.0, 0.404, 1);
float efxPos = 0;
float efxColType = 1;  // 1 - intense, 0 - core

float efxSmearing = 0.1;
float trgSmearing = 0.015;
float ovpSmearing = 0.03;

float rectSize = 40;
/// [SETTINGS] ///////////////////////////////////////////////////////


float4 processTriangles(PSInput PS, int tNum, float rectSize, float tTime, float4 efxColor){

    float2 coords = PS.TexCoord;

    coords.x += rectSize/2*tNum;

    int yNum = floor(coords.y / rectSize);
    int chet = yNum%2;
    int invChet = 1 - chet;
    coords.x += rectSize/2*chet;
    int xNum = floor(coords.x / rectSize);

    float xNumR = xNum * rectSize / screenW;
    float yNumR = yNum * rectSize / screenH;

    ////////////////////////////////////////////////
    // noise ///////////////////////////////////
    //
        float noiseVal = tex2D(noiseSampler, float2(xNumR - yNumR/3*tNum ,yNumR) + (tTime+2*tNum)/15).r;
        float slowNoiseVal = tex2D(noiseSampler, float2(xNumR - yNumR*tNum,yNumR + xNumR*tNum) + tTime/25 + 5*chet).r;

    ////////////////////////////////////////////////
    // EFX ///////////////////////////////////
    //
        float posR = xNumR - yNumR/5 + noiseVal/5;
        float efxPxl = bigger(posR, efxPos, efxSmearing) - clamp( (posR/2 - efxPos)/3 ,0,1);

    ////////////////////////////////////////////////
    // Triangles /////////////////////////////
    //
        float2 smes = (coords % rectSize) / rectSize;  //( |0...1|)
        float invSmesY = abs(tNum-smes.y);

        float power = tex2D(noiseSampler, (xNumR - yNumR/5.0f + tTime)/35   ).r;
        power = clamp(power*1.5 - slowNoiseVal*(1-efxColType)*efxPxl , 0.45, 1.06);
        float value = clamp(power + efxPxl/4,0.01,1);

        float fillSize = invSmesY - (1 - value);

        float flsz_d2 = fillSize/2;
        float fillS = 0.5 - flsz_d2;
        float fillE = 0.5 + flsz_d2;

        float pxlSv = bigger( smes.x , fillS, trgSmearing);
        float pxlEv = bigger( smes.x , fillE, trgSmearing);

        float fillSizeRect_d2 = value/2;
        float yFillE =  (0.5 + fillSizeRect_d2);
        float yCutSv = bigger( smes.y , (0.49 - fillSizeRect_d2) , trgSmearing );
        float yCutEv = bigger( smes.y , yFillE , trgSmearing );

        float colVal = (pxlSv - pxlEv) * (yCutSv - yCutEv) * 0.5;

        float4 finColor = colVal;

    ////////////////////////////////////////////////
    // overpower ///////////////////////////////////
    //
        float overpower = clamp(power - 1 ,0,1);

        float overPxl_i = bigger( smes.x , fillS + overpower , ovpSmearing );
        float overPxl = (1 - overPxl_i) * colVal;
        finColor += overPxl/2 - 0.4*tNum*overPxl;

        float overPxl_i2 = bigger( smes.x , fillE - overpower , ovpSmearing );
        finColor -= overPxl_i2/4.0*colVal;

        float overY_i =  bigger( invSmesY , yFillE - overpower/1.5 , ovpSmearing);
        float overY = overY_i * colVal;
        finColor += overY - 1.2*(1-tNum)*overY;

    ////////////////////////////////////////////////

    float efxPower = colVal*efxPxl*(noiseVal+0.4);
    finColor = (((origColor + slowNoiseVal/9)*2*finColor)*value ) * (1 - efxPower) + efxPower*efxColor;
    return finColor;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{

    PS.TexCoord += rectSize*3;
        
    float4 efxColor = intenseColor*efxColType + coreColor*(1- efxColType);

    float tTime = Time/10;
    float4 finColor1 = float4(0,0,0,1);
    float4 finColor2 = finColor1;
    finColor1 = processTriangles(PS, 0 ,rectSize, tTime          ,efxColor); 
    finColor2 = processTriangles(PS, 1 ,rectSize, tTime + 0.035  ,efxColor);
    finColor1.a = 1;
    finColor2.a = 1;

    //finColor2 = 0;
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
        //PixelShader  = compile ps_3_0 tAST();
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

