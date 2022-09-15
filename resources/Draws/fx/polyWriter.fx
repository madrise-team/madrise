int MAXpolySize = 16;
float polygonX[16];  // use MAXpolySize
float polygonY[16];  // use MAXpolySize

float screenResX;
float screenResY;

struct PSInput
{
    float2 PixelSreenCoord : VPOS;
    float4 Diffuse : COLOR0;
};

bool isInPoly(float2 pont) {
    bool inPol = false;
    for (int i = 0;i < MAXpolySize;i=i+1){
        if(any(polygonX[i+1])){
            float2 nowP = float2(polygonX[i],polygonY[i]);
            float2 nexP = float2(polygonX[i+1],polygonY[i+1]);
            
            float minXp = nowP.x;
            float2 minYp = float2(nowP.x,nowP.y);
            
            float maxXp = nexP.x;
            float2 maxYp = float2(nexP.x,nexP.y);

            
            if(nexP.x < nowP.x){
                minXp = nexP.x;
                maxXp = nowP.x;
            }
            if(nexP.y < nowP.y){
                minYp = float2(nexP.x,nexP.y);
                maxYp = float2(nowP.x,nowP.y);
            }

            
            float yRotn = (pont.y - minYp.y)/(maxYp.y - minYp.y);
            if(maxYp.x < minYp.x){
                yRotn = 1-yRotn;
            }

            float xR = maxXp - minXp;            
            float needX = minXp.x + xR*yRotn;
            
            if ((pont.y > 0)){
                if ((pont.y > minYp.y) && (pont.y < maxYp.y) && (pont.x > needX)){
                    inPol = !inPol;
                }
            }
        }
    }
    return inPol;
}

float4 PixelShaderFunction(PSInput PS) : COLOR0
{

    float4 color = float4(0,0,0,0);
    float2 posXY = float2(PS.PixelSreenCoord.x ,PS.PixelSreenCoord.y);

    if(isInPoly(posXY)){
        color = float4(1,1,1,1);
    }

    return color;
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique normall
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

