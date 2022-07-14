// 
// file: primitive3D_projectedTextureConeNoNRM.fx
// version: v1.6
// author: Ren712
//

//--------------------------------------------------------------------------------------
// Settings
//--------------------------------------------------------------------------------------
float4 sLightColor = float4(0,0,0,0);
texture sTexture;
float2 sPicSize = float2(1,1);
float sProjFov = 1.3;
float3 sLightRotation = float3(0,0,0);
bool bProjectionPosition = false;
float3 sSurfaceNormal = float3(0,0,0);
float3 sLightPosition = float3(0,0,0);
float sLightAttenuation = 1;
float sLightAttenuationPower = 2;
int sSubdivUnit = 1;

float sSurfaceAttenuation = 0.2;
float sSurfaceAttenuationPower = 0.1;
float sSurfaceOffset = 0;

bool sFlipTexture = false;

float2 gDistFade = float2(250,150);

int fDestBlend = 6;
float2 sHalfPixel = float2(0.000625,0.00083);
float2 sPixelSize = float2(0.00125,0.00166);

//--------------------------------------------------------------------------------------
// Variables set by MTA
//--------------------------------------------------------------------------------------
texture gDepthBuffer : DEPTHBUFFER;
float4x4 gProjectionMainScene : PROJECTION_MAIN_SCENE;
float4x4 gViewMainScene : VIEW_MAIN_SCENE;
int gFogEnable < string renderState="FOGENABLE"; >;
float4 gFogColor < string renderState="FOGCOLOR"; >;
float gFogStart < string renderState="FOGSTART"; >;
float gFogEnd < string renderState="FOGEND"; >;
static const float PI = 3.14159265f;
int gCapsMaxAnisotropy < string deviceCaps="MaxAnisotropy"; >;
int CUSTOMFLAGS < string skipUnusedParameters = "yes"; >;

//--------------------------------------------------------------------------------------
// Sampler 
//--------------------------------------------------------------------------------------
sampler SamplerTexture = sampler_state
{
    Texture = (sTexture);
    AddressU = Border;
    AddressV = Border;
    MipFilter = Linear;
    MaxAnisotropy = gCapsMaxAnisotropy;
    MinFilter = Anisotropic;
    BorderColor = float4(0,0,0,0);
};

sampler SamplerDepth = sampler_state
{
    Texture = (gDepthBuffer);
    AddressU = Clamp;
    AddressV = Clamp;
    MinFilter = Point;
    MagFilter = Point;
    MipFilter = None;
    MaxMipLevel = 0;
    MipMapLodBias = 0;
};

//--------------------------------------------------------------------------------------
// Structures
//--------------------------------------------------------------------------------------
struct VSInput
{
    float3 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;
    float4 Diffuse : COLOR0;
};

struct PSInput
{
    float4 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;
    float DistFade : TEXCOORD1;
    float4 ProjCoord : TEXCOORD2;
    float3 WorldPos : TEXCOORD3;
    float4 UvToView : TEXCOORD4;
    float4 Diffuse : COLOR0;
};

//--------------------------------------------------------------------------------------
// Inverse matrix
//--------------------------------------------------------------------------------------
float4x4 inverseMatrix(float4x4 input)
{
     #define minor(a,b,c) determinant(float3x3(input.a, input.b, input.c))
     
     float4x4 cofactors = float4x4(
          minor(_22_23_24, _32_33_34, _42_43_44), 
         -minor(_21_23_24, _31_33_34, _41_43_44),
          minor(_21_22_24, _31_32_34, _41_42_44),
         -minor(_21_22_23, _31_32_33, _41_42_43),
         
         -minor(_12_13_14, _32_33_34, _42_43_44),
          minor(_11_13_14, _31_33_34, _41_43_44),
         -minor(_11_12_14, _31_32_34, _41_42_44),
          minor(_11_12_13, _31_32_33, _41_42_43),
         
          minor(_12_13_14, _22_23_24, _42_43_44),
         -minor(_11_13_14, _21_23_24, _41_43_44),
          minor(_11_12_14, _21_22_24, _41_42_44),
         -minor(_11_12_13, _21_22_23, _41_42_43),
         
         -minor(_12_13_14, _22_23_24, _32_33_34),
          minor(_11_13_14, _21_23_24, _31_33_34),
         -minor(_11_12_14, _21_22_24, _31_32_34),
          minor(_11_12_13, _21_22_23, _31_32_33)
     );
     #undef minor
     return transpose(cofactors) / determinant(input);
}

//--------------------------------------------------------------------------------------
// Create world matrix with world position and euler rotation
//--------------------------------------------------------------------------------------
float4x4 createWorldMatrix(float3 pos, float3 rot)
{
    float4x4 eleMatrix = {
        float4(cos(rot.z) * cos(rot.y) - sin(rot.z) * sin(rot.x) * sin(rot.y), 
                cos(rot.y) * sin(rot.z) + cos(rot.z) * sin(rot.x) * sin(rot.y), -cos(rot.x) * sin(rot.y), 0),
        float4(-cos(rot.x) * sin(rot.z), cos(rot.z) * cos(rot.x), sin(rot.x), 0),
        float4(cos(rot.z) * sin(rot.y) + cos(rot.y) * sin(rot.z) * sin(rot.x), sin(rot.z) * sin(rot.y) - 
                cos(rot.z) * cos(rot.y) * sin(rot.x), cos(rot.x) * cos(rot.y), 0),
        float4(pos.x,pos.y,pos.z, 1),
    };
    return eleMatrix;
}

//--------------------------------------------------------------------------------------
// Create view matrix 
//--------------------------------------------------------------------------------------
float4x4 createViewMatrix( float3 pos, float3 fwVec, float3 upVec )
{
    float3 zaxis = normalize( fwVec );    // The "forward" vector.
    float3 xaxis = normalize( cross( -upVec, zaxis ));// The "right" vector.
    float3 yaxis = cross( xaxis, zaxis );     // The "up" vector.

    // Create a 4x4 view matrix from the right, up, forward and eye position vectors
    float4x4 viewMatrix = {
        float4(      xaxis.x,            yaxis.x,            zaxis.x,       0 ),
        float4(      xaxis.y,            yaxis.y,            zaxis.y,       0 ),
        float4(      xaxis.z,            yaxis.z,            zaxis.z,       0 ),
        float4(-dot( xaxis, pos ), -dot( yaxis, pos ), -dot( zaxis, pos ),  1 )
    };
    return viewMatrix;
}

//------------------------------------------------------------------------------------------
// Create orthographic projection matrix 
//------------------------------------------------------------------------------------------
float4x4 createPerspectiveProjectionMatrix(float near_plane, float far_plane, float fov_horiz, float fov_aspect)
{
    float h, w, Q;

    w = 1/tan(fov_horiz * 0.5);
    h = w / fov_aspect;
    Q = far_plane/(far_plane - near_plane);

    float4x4 projectionMatrix = {
        float4(w, 0, 0, 0 ), float4(0, h, 0, 0), float4(0, 0, Q, 1), float4(0, 0, -Q*near_plane, 0)
    };    
    return projectionMatrix;
}

//--------------------------------------------------------------------------------------
// Get sphere vertex position
//--------------------------------------------------------------------------------------
float3 getSphereVertexPosition(float3 inPosition, float3 scale)
{
    float3 outPosition;
    outPosition.z = cos(2 * inPosition.x * PI) / 2;
	outPosition.x = sin(2 * inPosition.x * PI) / 2;
	outPosition.xz *= cos(inPosition.y * PI);
	outPosition.y = sin(inPosition.y * PI) / 2;
    return outPosition * scale;
}

//--------------------------------------------------------------------------------------
// Vertex Shader 
//--------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    // set proper position and scale of the quad
    VS.Position.xyz = float3(- 0.5 + VS.TexCoord.xy, 0);
	
    // scale the sphere
    if (sSubdivUnit >= 2) 
    {
        // correct radius depending on tesselation
        float sphRadius = 1 / cos(radians(180 / sSubdivUnit));
		
        // get size
        float awgSize = max(sPicSize.x, sPicSize.y);
        float3 corrAtten = float3(awgSize, sLightAttenuation, awgSize);
	
        // shape the sphere
        float3 scaleNorm = normalize(0.5 * corrAtten * sphRadius);
        float3 resultPos = getSphereVertexPosition(VS.Position.xyz, scaleNorm);
        VS.Position.xyz = resultPos * length(2 * sLightAttenuation * sphRadius);
    }
    else VS.Position.xy *= sLightAttenuation * 2.5; 

    // flip texCoords.x
    VS.TexCoord.x = 1 - VS.TexCoord.x;

    // create WorldMatrix for the quad
    float4x4 sWorld = createWorldMatrix(sLightPosition, sLightRotation);
	
    // get clip planes
    float nearClip = - gProjectionMainScene[3][2] / gProjectionMainScene[2][2];
    float farClip = gProjectionMainScene[3][2] / (1 - gProjectionMainScene[2][2]);
	
    // get view Matrix
    float4x4 sViewInverse = inverseMatrix(gViewMainScene);
	
    // set altered projection matrix to prevent clipping parts of the material when small farClipDistance
    float4x4 sProjection = gProjectionMainScene;
    float objDist = distance(sViewInverse[3].xyz, sLightPosition) + sLightAttenuation / 2;
    float farPlaneAlt = max(farClip, objDist);
    sProjection[2].z = farPlaneAlt/(farPlaneAlt - nearClip);
    sProjection[3].z =  - sProjection[2].z * nearClip;
	
    // calculate screen position of the vertex
    float4 wPos = mul(float4( VS.Position, 1), sWorld);
	
    float4 vPos = 0;
    float4x4 sWorldView = mul(sWorld, gViewMainScene);
    if (sSubdivUnit >= 2) vPos = mul(wPos, gViewMainScene);
       else vPos = float4(VS.Position.xyz + sWorldView[3].xyz, 1);
    PS.Position = mul(vPos, gProjectionMainScene);
	
    // fade object
    float DistFromCam = distance(sViewInverse[3].xyz, sLightPosition);
    float2 DistFade = float2(max(0.3, min(gDistFade.x, farClip ) - sLightAttenuation), max(0, min(gDistFade.y, gFogStart) - sLightAttenuation));
    PS.DistFade = saturate((DistFromCam - DistFade.x)/(DistFade.y - DistFade.x));

    // pass texCoords and vertex color to PS
    PS.TexCoord = VS.TexCoord;
    PS.Diffuse = VS.Diffuse * sLightColor;
	
    // set texCoords for projective texture
    float projectedX = (0.5 * (PS.Position.w + PS.Position.x));
    float projectedY = (0.5 * (PS.Position.w - PS.Position.y));
    PS.ProjCoord.xyz = float3(projectedX, projectedY, PS.Position.w);
	
    // Get distance from plane
    PS.ProjCoord.w = dot(sViewInverse[2].xyz, sLightPosition - sViewInverse[3].xyz) + 2 * sLightAttenuation;
	
    // calculations for perspective-correct position recontruction
    float2 uvToViewADD = - 1 / float2(gProjectionMainScene[0][0], gProjectionMainScene[1][1]);	
    float2 uvToViewMUL = -2.0 * uvToViewADD.xy;
    PS.UvToView = float4(uvToViewMUL, uvToViewADD);
	
    return PS;
}

PSInput VertexShaderFunctionNoDB(VSInput VS)
{
    PSInput PS = (PSInput)0;

    // get position if bProjectionPosition
    float3 lightRotation = sLightRotation;
    float3 lightPosition = sLightPosition;
	float3 fwVec = - normalize(sSurfaceNormal) + float3(0.001,0.001,0.001);
    if (bProjectionPosition) 
    {
        lightRotation = float3(asin(fwVec.z / length(fwVec)), 0, -atan2(fwVec.x, fwVec.y));
        lightPosition -= fwVec * 0.05;
    }

    // set proper position and scale of the quad
    VS.Position.xyz = float3(- 0.5 + VS.TexCoord.xy, 0);	
	
    // set proper size to the quad
    VS.Position.xy *= sLightAttenuation * 2.5;
	
    VS.Position.xyz = VS.Position.xzy;
	
    // flip texCoords.x
    VS.TexCoord.x = 1 - VS.TexCoord.x;

    // create WorldMatrix for the quad
    float4x4 sWorld = createWorldMatrix(lightPosition, lightRotation);

    // calculate screen position of the vertex
    float4 wPos = mul(float4(VS.Position, 1), sWorld);
    float4 vPos = mul(wPos, gViewMainScene); 
    PS.Position = mul(vPos, gProjectionMainScene);
	
    // pass world position
    PS.WorldPos = wPos.xyz;

    // get clip values
    float nearClip = - gProjectionMainScene[3][2] / gProjectionMainScene[2][2];
    float farClip = (gProjectionMainScene[3][2] / (1 - gProjectionMainScene[2][2]));
	
    // get view Matrix
    float4x4 sViewInverse = inverseMatrix(gViewMainScene);
	
    // fade object
    float DistFromCam = distance(sViewInverse[3].xyz, sLightPosition);
    float2 DistFade = float2(max(0.3, min(gDistFade.x, farClip ) - sLightAttenuation), max(0, min(gDistFade.y, gFogStart) - sLightAttenuation));
    PS.DistFade = saturate((DistFromCam - DistFade.x)/(DistFade.y - DistFade.x));

    // pass texCoords and vertex color to PS
    PS.TexCoord = VS.TexCoord;
    PS.Diffuse = VS.Diffuse * sLightColor;
	
    return PS;
}

//--------------------------------------------------------------------------------------
//-- Get value from the depth buffer
//-- Uses define set at compile time to handle RAWZ special case (which will use up a few more slots)
//--------------------------------------------------------------------------------------
float FetchDepthBufferValue( float2 uv )
{
    float4 texel = tex2D(SamplerDepth, uv);
#if IS_DEPTHBUFFER_RAWZ
    float3 rawval = floor(255.0 * texel.arg + 0.5);
    float3 valueScaler = float3(0.996093809371817670572857294849, 0.0038909914428586627756752238080039, 1.5199185323666651467481343000015e-5);
    return dot(rawval, valueScaler / 255.0);
#else
    return texel.r;
#endif
}

//--------------------------------------------------------------------------------------
//-- Use the last scene projecion matrix to linearize the depth value a bit more
//--------------------------------------------------------------------------------------
float Linearize(float posZ)
{
    return gProjectionMainScene[3][2] / (posZ - gProjectionMainScene[2][2]);
}

//--------------------------------------------------------------------------------------
// GetPositionFromDepth
//--------------------------------------------------------------------------------------
float3 GetPositionFromDepth(float2 coords, float4 uvToView)
{
    return float3(coords.x * uvToView.x + uvToView.z, (1 - coords.y) * uvToView.y + uvToView.w, 1.0) 
        * Linearize(FetchDepthBufferValue(coords.xy));
}

//--------------------------------------------------------------------------------------
// GetPositionFromDepthMatrix
//--------------------------------------------------------------------------------------
float3 GetPositionFromDepthMatrix(float2 coords, float4x4 g_matInvProjection)
{
    float4 vProjectedPos = float4(coords.x * 2 - 1, (1 - coords.y) * 2 - 1, FetchDepthBufferValue(coords), 1.0f);
    float4 vPositionVS = mul(vProjectedPos, g_matInvProjection);  
    return vPositionVS.xyz / vPositionVS.w;  
}

//--------------------------------------------------------------------------------------
// More accurate than GetNormalFromDepth
//--------------------------------------------------------------------------------------
float3 GetNormalFromDepthMatrix(float2 coords, float4x4 g_matInvProjection)
{
    float3 offs = float3(sPixelSize.xy, 0);

    float3 f = GetPositionFromDepthMatrix(coords.xy, g_matInvProjection);
    float3 d_dx1 = - f + GetPositionFromDepthMatrix(coords.xy + offs.xz, g_matInvProjection);
    float3 d_dx2 =   f - GetPositionFromDepthMatrix(coords.xy - offs.xz, g_matInvProjection);
    float3 d_dy1 = - f + GetPositionFromDepthMatrix(coords.xy + offs.zy, g_matInvProjection);
    float3 d_dy2 =   f - GetPositionFromDepthMatrix(coords.xy - offs.zy, g_matInvProjection);

    d_dx1 = lerp(d_dx1, d_dx2, abs(d_dx1.z) > abs(d_dx2.z));
    d_dy1 = lerp(d_dy1, d_dy2, abs(d_dy1.z) > abs(d_dy2.z));

    return (- normalize(cross(d_dy1, d_dx1)));
}

//--------------------------------------------------------------------------------------
//  Calculates normals based on partial depth buffer derivatives.
//--------------------------------------------------------------------------------------
float3 GetNormalFromDepth(float2 coords, float4 uvToView)
{
    float3 offs = float3(sPixelSize.xy, 0);

    float3 f = GetPositionFromDepth(coords.xy, uvToView);
    float3 d_dx1 = - f + GetPositionFromDepth(coords.xy + offs.xz, uvToView);
    float3 d_dx2 =   f - GetPositionFromDepth(coords.xy - offs.xz, uvToView);
    float3 d_dy1 = - f + GetPositionFromDepth(coords.xy + offs.zy, uvToView);
    float3 d_dy2 =   f - GetPositionFromDepth(coords.xy - offs.zy, uvToView);

    d_dx1 = lerp(d_dx1, d_dx2, abs(d_dx1.z) > abs(d_dx2.z));
    d_dy1 = lerp(d_dy1, d_dy2, abs(d_dy1.z) > abs(d_dy2.z));

    return (- normalize(cross(d_dy1, d_dx1)));
}

//--------------------------------------------------------------------------------------
// Pixel shaders 
//--------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    // get projective texture coords
    float2 TexProj = PS.ProjCoord.xy / PS.ProjCoord.z;
    TexProj += sHalfPixel.xy;
	
    // get logarithmic and linear scene depth
    float bufferValue = FetchDepthBufferValue(TexProj);
    float linearDepth = Linearize(bufferValue);
	
    // disregard calculations when depth value is close to 1 and beyound light radius
    if (bufferValue > 0.99999f) return 0;
    if ((linearDepth - PS.ProjCoord.w) > 0) return 0;
	
    // calculate view inverse matrix
    float4x4 sViewInverse = inverseMatrix(gViewMainScene);
	
    // retrieve world position from scene depth
    float3 viewPos = GetPositionFromDepth(TexProj.xy, PS.UvToView);
    float3 worldPos = mul(float4(viewPos.xyz, 1),  sViewInverse).xyz;
	
    // Create world view and projection matrices (for the projective texture)	
    float4x4 sWorld = createWorldMatrix(sLightPosition, sLightRotation);
	float camDist = max(sPicSize.x, sPicSize.y) / 3;
    float4x4 sView = createViewMatrix(sLightPosition - sWorld[1].xyz * (camDist + 0.05), sWorld[1].xyz, sWorld[2].xyz);
    float4x4 sProjection = createPerspectiveProjectionMatrix(0.3, 400, sProjFov, sPicSize.y / sPicSize.x);
	
    // Get projective texture coordinates
    viewPos = mul(float4(worldPos.xyz, 1), sView).xyz;
    float4 projPos = mul(float4(viewPos.xyz, 1), sProjection);
	
    float projX = (0.5 * (projPos.w + projPos.x));
    float projY = (0.5 * (projPos.w - projPos.y));
    float2 texCoord = float2(projX, projY) / projPos.w;
    texCoord.x = 1 - texCoord.x;
	
    // cut parts beyond the (0 - 1) coords and behind camera
    if ((texCoord.x > 1) || (texCoord.x < 0) || (texCoord.y > 1) || (texCoord.y < 0) || (viewPos.z < 0)) return 0;
	
    // get projection surface normal vector
    float3 surfaceNormal = float3(0,0,0);
    if (bProjectionPosition) surfaceNormal = sSurfaceNormal;
    else surfaceNormal = - sWorld[1].xyz;
	
    // compute the distance from light and surface
    float fSDistance = abs(dot(surfaceNormal, worldPos.xyz - sLightPosition) + sSurfaceOffset);
    float fLDistance = distance(sLightPosition, worldPos.xyz);
	
    // compute the light attenuation
    float fSAttenuation = 1 - saturate(fSDistance / sSurfaceAttenuation);
    fSAttenuation = pow(fSAttenuation, sSurfaceAttenuationPower);
	
    // compute the surface attenuation
    float fLAttenuation = 1 - saturate(fLDistance / sLightAttenuation);
    fLAttenuation = pow(fLAttenuation, sLightAttenuationPower);
	
    // combine attenuation
    float fAttenuation = fLAttenuation;
    if (bProjectionPosition) fAttenuation *= fSAttenuation;
	
    // apply diffuse color
    float4 finalColor = PS.Diffuse;
	
    // combine
    finalColor.a *= fAttenuation;
	
    // apply distance fade
    finalColor.a *= saturate(PS.DistFade);
	
    // flip texCoords.x
    if (sFlipTexture) texCoord = float2( 1 - texCoord.y, texCoord.x);
	
    // add projective texture
    texCoord.x = 1 - texCoord.x;
    float4 texel = tex2D(SamplerTexture, texCoord);
    finalColor *= texel;

    return saturate(finalColor);
}

float4 PixelShaderFunctionNoDB(PSInput PS) : COLOR0
{
    // Create world view and projection matrices (for the projective texture)	
    float4x4 sWorld = createWorldMatrix(sLightPosition, sLightRotation);
	float camDist = max(sPicSize.x, sPicSize.y) / 3;
    float4x4 sView = createViewMatrix(sLightPosition - sWorld[1].xyz * (camDist + 0.05), sWorld[1].xyz, sWorld[2].xyz);
    float4x4 sProjection = createPerspectiveProjectionMatrix(0.3, 400, sProjFov, sPicSize.y / sPicSize.x);
	
    // Get projective texture coordinates
    float4 viewPos = mul(float4(PS.WorldPos.xyz, 1), sView);
    float4 projPos = mul(viewPos, sProjection);
	
    float projX = (0.5 * (projPos.w + projPos.x));
    float projY = (0.5 * (projPos.w - projPos.y));
    float2 texCoord = float2(projX, projY) / projPos.w;
    texCoord.x = 1 - texCoord.x;
	
    // cut parts beyond the (0 - 1) coords and behind camera
    if ((texCoord.x > 1) || (texCoord.x < 0) || (texCoord.y > 1) || (texCoord.y < 0) || ((viewPos.z / viewPos.w) < 0)) return 0;

    // get projection surface normal vector
    float3 surfaceNormal = float3(0,0,0);
    if (bProjectionPosition) surfaceNormal = sSurfaceNormal;
    else surfaceNormal = - sWorld[1].xyz;
	
    // compute the distance from light and surface
    float fLDistance = distance(sLightPosition, PS.WorldPos.xyz);
	
    // compute the light attenuation
    float fLAttenuation = 1 - saturate(fLDistance / sLightAttenuation);
    fLAttenuation = pow(fLAttenuation, sLightAttenuationPower);
	
    // combine attenuation
    float fAttenuation = fLAttenuation;
	
    // apply diffuse color
    float4 finalColor = PS.Diffuse;
	
    // combine
    finalColor.a *= fAttenuation;
	
    // apply distance fade
    finalColor.a *= saturate(PS.DistFade);
	
    // flip texCoords.x
    if (sFlipTexture) texCoord = float2(1 - texCoord.y, texCoord.x);
	
    // add projective texture
    texCoord.x = 1 - texCoord.x;
    float4 texel = tex2D(SamplerTexture, texCoord);
    finalColor *= texel;

    return saturate(finalColor);
}

//--------------------------------------------------------------------------------------
// Choose CullMode
//--------------------------------------------------------------------------------------
int ChooseCullMode()
{
    if (sSubdivUnit >= 2) return 3;
    else return 2;
}

//--------------------------------------------------------------------------------------
// Techniques
//--------------------------------------------------------------------------------------
technique dxDrawPrimitive3DProjectedTextureConeNoNRM
{
  pass P0
  {
    ZEnable = false;
    ZWriteEnable = false;
    CullMode = ChooseCullMode();
    ShadeMode = Gouraud;
    AlphaBlendEnable = true;
    SrcBlend = SrcAlpha;
    DestBlend = fDestBlend;
    AlphaTestEnable = true;
    AlphaRef = 1;
    AlphaFunc = GreaterEqual;
    Lighting = false;
    FogEnable = false;
    VertexShader = compile vs_3_0 VertexShaderFunction();
    PixelShader  = compile ps_3_0 PixelShaderFunction();
  }
}

technique dxDrawPrimitive3DProjectedTextureConeNoNRM_fallback
{
  pass P0
  {
    ZEnable = true;
    ZFunc = LessEqual;
    ZWriteEnable = false;
    CullMode = 2;
    ShadeMode = Gouraud;
    AlphaBlendEnable = true;
    SrcBlend = SrcAlpha;
    DestBlend = fDestBlend;
    AlphaTestEnable = true;
    AlphaRef = 1;
    AlphaFunc = GreaterEqual;
    Lighting = false;
    FogEnable = false;
    VertexShader = compile vs_2_0 VertexShaderFunctionNoDB();
    PixelShader  = compile ps_2_0 PixelShaderFunctionNoDB();
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
