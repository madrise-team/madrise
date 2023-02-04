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
const float gridSize = 500;
const float thickness = 2;
const float smooth = 2;
const float2 offset;
const float scale = 1;

const float intense = 1;
const float4 gridColor = float4(0.4,0.65,0.9,0.1);
const float4 areaColor = float4(0.05,0.1,0.4,0.75);

float2 screenSize;
/// [SETTINGS] //////////////////////////////////////////


float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float2 cord = (PS.TexCoord - offset)* screenSize / scale;
    if (cord.x<0){
        cord.x -= thickness + smooth;
    }
    if (cord.y<0){
        cord.y -= thickness + smooth;
    }


    float2 inPos = abs(cord % (gridSize));

    float2 gridPos = 1 - abs((PS.TexCoord - 0.5) * (PS.TexCoord - 0.5))*3;

    float cr_thickness = thickness*(1-scale)*3 + thickness;

    float grid_x = 1 - bigger_smooth(inPos.x, cr_thickness, smooth);
    float grid_y = 1 - bigger_smooth(inPos.y, cr_thickness, smooth);

    float grid = grid_x + grid_y;
    grid = clamp(grid,0,1) * gridPos.x * gridPos.y;

    return (grid * gridColor + gridPos.x*gridPos.y*areaColor)*intense;
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

