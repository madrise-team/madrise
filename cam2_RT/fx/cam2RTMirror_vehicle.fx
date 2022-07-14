// 
// cam2RTMirror_vehicle.fx
// version: v1.2
// author: Ren712
//

//------------------------------------------------------------------------------------------
// Variables
//------------------------------------------------------------------------------------------
float3 sCameraPosition = float3(0,0,0);
float3 sCameraForward = float3(0,0,0);
bool sCameraBillboard = false;
float2 gDistFade = float2(400, 350);
float2 sPixelSize = float2(0.00125,0.00166);

//------------------------------------------------------------------------------------------
// Settings
//------------------------------------------------------------------------------------------
// Secondary render target texture
texture colorRT < string renderTarget = "yes"; >;
texture depthRT < string renderTarget = "yes"; >;

//------------------------------------------------------------------------------------------
// Include some common stuff
//------------------------------------------------------------------------------------------
int gCullMode < string renderState="CULLMODE"; >; 
float gAlphaRef < string renderState="ALPHAREF"; >; 
#include "mta-helper.fx"

//------------------------------------------------------------------------------------------
// Sampler for the main texture
//------------------------------------------------------------------------------------------
sampler2D Sampler0 = sampler_state
{
    Texture = (gTexture0);
};

sampler2D SamplerDepth = sampler_state
{
    Texture = (depthRT);
    AddressU = Clamp;
    AddressV = Clamp;
    MinFilter = Point;
    MagFilter = Point;
    MipFilter = None;
    SRGBTexture = false;
    MaxMipLevel = 0;
    MipMapLodBias = 0;
};

sampler2D SamplerColor = sampler_state
{
    Texture = (colorRT);
    AddressU = Clamp;
    AddressV = Clamp;
    MinFilter = Point;
    MagFilter = Point;
    MipFilter = None;
    SRGBTexture = false;
    MaxMipLevel = 0;
    MipMapLodBias = 0;
};

//------------------------------------------------------------------------------------------
// Structure of data sent to the vertex shader
//------------------------------------------------------------------------------------------
struct VSInput
{
    float3 Position : POSITION0;
    float3 Normal : NORMAL0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};

//------------------------------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//------------------------------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float3 Specular : COLOR1;
    float2 TexCoord : TEXCOORD0;
    float3 TexProj : TEXCOORD1;
    float3 Normal : TEXCOORD2;
    float PlaneDist : TEXCOORD3;
    float4 Depth : TEXCOORD4;
};

//------------------------------------------------------------------------------------------
// Create reflection matrix 
//------------------------------------------------------------------------------------------
float4x4 createReflectionMatrix( float3 pos, float3 fwVec)
{
    float3 N = normalize( fwVec ); // The "forward" vector.
    float D = - N.x * pos.x - N.y * pos.y - N.z * pos.z;

    // Create a 4x4 reflection matrix
    float4x4 reflectionMatrix = {
        float4( 1 - 2 * N.x * N.x,   - 2 * N.x * N.y,    -2 * N.x * N.z, -2 * N.x * D ),
        float4(   - 2 * N.x * N.y, 1 - 2 * N.y * N.y,    -2 * N.y * N.z, -2 * N.y * D ),
        float4(   - 2 * N.x * N.z,   - 2 * N.y * N.z, 1 - 2 * N.z * N.z, -2 * N.z * D ),
        float4(                 0,                 0,                 0,            1 )
    };
    return transpose(reflectionMatrix);
}

//------------------------------------------------------------------------------------------
// lightEnableState

int gLight0Enable           < string lightEnableState="0,Enable"; >;
int gLight1Enable           < string lightEnableState="1,Enable"; >;
int gLight2Enable           < string lightEnableState="2,Enable"; >;
int gLight3Enable           < string lightEnableState="3,Enable"; >;
int gLight4Enable           < string lightEnableState="4,Enable"; >;

// lightState 

float4 gLight0Diffuse           < string lightState="0,Diffuse"; >;
float3 gLight0Direction         < string lightState="0,Direction"; >;
float4 gLight1Diffuse           < string lightState="1,Diffuse"; >;
float3 gLight1Direction         < string lightState="1,Direction"; >;
float4 gLight2Diffuse           < string lightState="2,Diffuse"; >;
float3 gLight2Direction         < string lightState="2,Direction"; >;
float4 gLight3Diffuse           < string lightState="3,Diffuse"; >;
float3 gLight3Direction         < string lightState="3,Direction"; >;
float4 gLight4Diffuse           < string lightState="4,Diffuse"; >;
float3 gLight4Direction         < string lightState="4,Direction"; >;

//------------------------------------------------------------------------------------------
// MTACalcGTACompleteDiffuse
// - Calculate GTA lighting including pointlights for vehicles (all 4 lights)
//------------------------------------------------------------------------------------------
float4 MTACalcGTACompleteDiffuse( float3 WorldNormal, float4 InDiffuse )
{
    // Calculate diffuse color by doing what D3D usually does
    float4 ambient  = gAmbientMaterialSource  == 0 ? gMaterialAmbient  : InDiffuse;
    float4 diffuse  = gDiffuseMaterialSource  == 0 ? gMaterialDiffuse  : InDiffuse;
    float4 emissive = gEmissiveMaterialSource == 0 ? gMaterialEmissive : InDiffuse;

    float4 TotalAmbient = ambient * ( gGlobalAmbient + gLightAmbient );

    // Add all the 4 pointlights
    float DirectionFactor=0;
    float4 TotalDiffuse=0;
	
    if (gLight1Enable) {
    DirectionFactor = max(0,dot(WorldNormal, -gLight1Direction ));
    TotalDiffuse += ( gLight1Diffuse * DirectionFactor );
                     }
    if (gLight2Enable) {
    DirectionFactor = max(0,dot(WorldNormal, -gLight2Direction ));
    TotalDiffuse += ( gLight2Diffuse * DirectionFactor );
                     }
    if (gLight3Enable) {
    DirectionFactor = max(0,dot(WorldNormal, -gLight3Direction ));
    TotalDiffuse += ( gLight3Diffuse * DirectionFactor );
                     }
    if (gLight4Enable) {
    DirectionFactor = max(0,dot(WorldNormal, -gLight4Direction ));
    TotalDiffuse += ( gLight4Diffuse * DirectionFactor );
                     }	
					 
    TotalDiffuse *= diffuse;
	
    float4 OutDiffuse = saturate(TotalDiffuse + TotalAmbient + emissive);
    OutDiffuse.a *= diffuse.a;

    return OutDiffuse;
}

//------------------------------------------------------------------------------------------
// VertexShaderFunction
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS )
{
    PSInput PS = (PSInput)0;

    // Calculate screen pos of vertex
    float4 worldPos = mul(float4(VS.Position.xyz, 1), gWorld);
	
    // Create mirror camera matrix
    float3 cameraForward = normalize(sCameraForward);
    if (sCameraBillboard) cameraForward = - gViewInverse[2].xyz;
    float4x4 sMirror = createReflectionMatrix(sCameraPosition, cameraForward);
    float4x4 sView = mul(sMirror, gView);	
	
    // Pass vertex position to pixel shader
    float4 viewPos = mul(worldPos, sView);
    PS.Position = mul(viewPos, gProjection);
	
    // Get distance from plane
    PS.PlaneDist = dot(cameraForward, worldPos.xyz - sCameraPosition);

    // Pass through tex coord
    PS.TexCoord = VS.TexCoord;

    // Set texCoords for projective texture
    float4 Position = mul(viewPos, gProjection);
    float projectedX = (0.5 * (PS.Position.w + PS.Position.x));
    float projectedY = (0.5 * (PS.Position.w - PS.Position.y));
    PS.TexProj.xyz = float3(projectedX, projectedY, PS.Position.w); 
	
    // Calculate world normal
    PS.Normal = mul(VS.Normal, (float3x3)gWorld);
	
    // Calculate vertex lighting
    PS.Diffuse = MTACalcGTACompleteDiffuse(PS.Normal, VS.Diffuse);
    float specHigh = MTACalculateSpecular(gCameraDirection, gLight1Direction, PS.Normal, gMaterialSpecPower) * 0.75;
    PS.Specular.rgb = saturate(gMaterialSpecular.rgb * specHigh);
	
    // Pass depth
    PS.Depth = float4(viewPos.z, viewPos.w, PS.Position.z, PS.Position.w);
	
    return PS;
}

//------------------------------------------------------------------------------------------
// Pack Unit Float [0,1] into RGB24
//------------------------------------------------------------------------------------------
float3 UnitToColor24New(in float depth) 
{
    // Constants
    const float3 scale	= float3(1.0, 256.0, 65536.0);
    const float2 ogb	= float2(65536.0, 256.0) / 16777215.0;
    const float normal	= 256.0 / 255.0;
	
    // Avoid Precision Errors
    float3 unit	= (float3)depth;
    unit.gb	-= floor(unit.gb / ogb) * ogb;
	
    // Scale Up
    float3 color = unit * scale;
	
    // Use Fraction to emulate Modulo
    color = frac(color);
	
    // Normalize Range
    color *= normal;
	
    // Mask Noise
    color.rg -= color.gb / 256.0;

    return color;
}

//------------------------------------------------------------------------------------------
// Unpack RGB24 into Unit Float [0,1]
//------------------------------------------------------------------------------------------
float ColorToUnit24New(in float3 color) {
    const float3 scale = float3(65536.0, 256.0, 1.0) / 65793.0;
    return dot(color, scale);
}

//------------------------------------------------------------------------------------------
// Pack Unit float [nearClip,farClip] Unit Float [0,1]
//------------------------------------------------------------------------------------------
float DistToUnit(in float dist, in float nearClip, in float farClip) 
{
    float unit = (dist - nearClip) / (farClip - nearClip);
    return unit;
}

//------------------------------------------------------------------------------------------
// Pack Unit Float [0,1] to Unit float [nearClip,farClip]
//------------------------------------------------------------------------------------------
float UnitToDist(in float unit, in float nearClip, in float farClip) 
{
    float dist = (unit * (farClip - nearClip)) + nearClip;
    return dist;
}

//------------------------------------------------------------------------------------------
// MTAApplyFog
//------------------------------------------------------------------------------------------
int gFogEnable                     < string renderState="FOGENABLE"; >;
float4 gFogColor                   < string renderState="FOGCOLOR"; >;
float gFogStart                    < string renderState="FOGSTART"; >;
float gFogEnd                      < string renderState="FOGEND"; >;
 
float3 MTAApplyFog( float3 texel, float distFromCam )
{
    if ( !gFogEnable )
        return texel;
    float fogEnd = min(gFogEnd, gDistFade.x);
    float fogStart = min(gFogStart, gDistFade.y);
    float FogAmount = (distFromCam - fogStart )/( fogEnd - fogStart);
    texel.rgb = lerp(texel.rgb, gFogColor.rgb, saturate( FogAmount));
    return texel;
}

//------------------------------------------------------------------------------------------
// Structure of color data sent to the renderer ( from the pixel shader  )
//------------------------------------------------------------------------------------------
struct Pixel
{
    float4 World : COLOR0;      // Render target #0
    float4 Color : COLOR1;      // Render target #1
    float4 Depth : COLOR2;      // Render target #2
};

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//------------------------------------------------------------------------------------------
Pixel PixelShaderFunction(PSInput PS)
{
    Pixel output;

    // Get texture pixel
    float4 texel = tex2D(Sampler0, PS.TexCoord);
	
    // Get projective texture coords	
    float2 TexProj = PS.TexProj.xy / PS.TexProj.z;
    TexProj += sPixelSize.xy * 0.5;

    // Check if pixel is drawn in front of camera plane
    float alphaRef = (gAlphaRef / 255);
    if ((PS.PlaneDist > 0) && ((texel.a * PS.Diffuse.a) > alphaRef))
    {
        output.World = 0;
    }
    else
    {
        // Draw nothing
        output.World = 0;
        output.Color = 0;
        output.Depth = 0;  
        return output;
    }

    // Get current pixel depth [0 - 1]
    float depth = (PS.Depth.z / PS.Depth.w) * 0.5;
	
    // Get packed depth texture
    float3 packedDepth = tex2D(SamplerDepth, TexProj).rgb;
	
    // Unpack depth texture
    float depthVal = ColorToUnit24New(packedDepth);
	
    // Compare with current pixel depth
    if ((depthVal >= depth * 0.99995f) && (PS.PlaneDist > 0))
    {
        // Color render target
        float4 color = texel;
        color.rgb *= PS.Diffuse.rgb;
        color.rgb += PS.Specular;
        color.rgb = saturate(color.rgb);
        color.a *= PS.Diffuse.a;	
        output.Color = color;
        output.Color.rgb = MTAApplyFog( output.Color.rgb, PS.Depth.z / PS.Depth.w );
		
        // Depth render target
        output.Depth.rgb = UnitToColor24New(depth);
        output.Depth.a = 1;
    }
    else
    {
        // Color render target
        output.Color = 0;
		
        // Depth render target
        output.Depth = 0;
    }

    return output;
}

//------------------------------------------------------------------------------------------
// Invert cull mode
//------------------------------------------------------------------------------------------
int invertCullMode()
{
    if (gCullMode == 2) return 3;
    if (gCullMode == 3) return 2;
        else return 1;
}

//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique cam_mirror_vehicle_mrt
{
    pass P0
    {
        AlphaBlendEnable = true;
        AlphaTestEnable = false;
        AlphaFunc = GreaterEqual;
        ShadeMode = Gouraud;
        ZEnable = false;
        FogEnable = false;
        SrcBlend = One;
        DestBlend = InvSrcAlpha;
        CullMode = invertCullMode();
        SRGBWriteEnable = false;
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader = compile ps_3_0 PixelShaderFunction();
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
