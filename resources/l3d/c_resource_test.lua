--  					 --
-- c_resource_test.lua					 --
--					 --
					 --
local lightMatrix = {}					 --
local projTex, cubeTex = nil, nil					 --
					 --
bindKey("1", "down", function()					 --
    local camPos = getCamera().matrix.position + getCamera().matrix.forward * 5					 --
	local lightAttenuation = math.random(1,15)					 --
	local lightColor = Vector4(math.random(100,255), math.random(100,255), math.random(100,255), math.random(200,255))					 --
					 --
	lightMatrix[#lightMatrix + 1] = CPrmLightPoint: create(camPos, lightAttenuation, lightColor)					 --
end					 --
)					 --
					 --
bindKey("2", "down", function()					 --
    local camPos = getCamera().matrix.position + getCamera().matrix.forward * 5					 --
	local lightAttenuation = math.random(1,15)					 --
	local lightColor = Vector4(math.random(100,255), math.random(100,255), math.random(100,255), math.random(200,255))					 --
	lightMatrix[#lightMatrix + 1] = CPrmLightSpot: create(camPos, lightAttenuation, lightColor)					 --
	lightMatrix[#lightMatrix]:setTheta(math.rad(math.random(5,20))) -- Theta is the inner cone angle					 --
	lightMatrix[#lightMatrix]:setPhi(math.rad(math.random(30,50))) -- Phi is the outer cone angle					 --
	lightMatrix[#lightMatrix]:setFalloff(0.5 + math.random()) -- light intensity attenuation between the phi and theta areas					 --
	lightMatrix[#lightMatrix]:setDirection(getCamera().matrix.forward)					 --
end					 --
)					 --
					 --
bindKey("3", "down", function()					 --
    local camPos = getCamera().matrix.position + getCamera().matrix.forward * 5					 --
	local lightAttenuation = math.random(1,15)					 --
	local lightColor = Vector4(math.random(100,255), math.random(100,255), math.random(100,255), math.random(200,255))					 --
	lightMatrix[#lightMatrix + 1] = CPrmLightDark: create(camPos, lightAttenuation, lightColor)					 --
end					 --
)					 --
					 --
bindKey("4", "down", function()					 --
    local camPos = getCamera().matrix.position + getCamera().matrix.forward * 5					 --
	local lightAttenuation = math.random(1,15)					 --
	local lightColor = Vector4(math.random(100,255), math.random(100,255), math.random(100,255), math.random(200,255))					 --
	lightMatrix[#lightMatrix + 1] = CPrmLightPointNoNRM: create(camPos, lightAttenuation, lightColor)					 --
end					 --
)					 --
					 --
bindKey("5", "down", function()					 --
    local camPos = getCamera().matrix.position + getCamera().matrix.forward * 5					 --
	local lightAttenuation = math.random(1,15)					 --
	local lightColor = Vector4(math.random(100,255), math.random(100,255), math.random(100,255), math.random(200,255))					 --
	lightMatrix[#lightMatrix + 1] = CPrmLightSpotNoNRM: create(camPos, lightAttenuation, lightColor)					 --
	lightMatrix[#lightMatrix]:setTheta(math.rad(math.random(5,20))) -- Theta is the inner cone angle					 --
	lightMatrix[#lightMatrix]:setPhi(math.rad(math.random(30,50))) -- Phi is the outer cone angle					 --
	lightMatrix[#lightMatrix]:setFalloff(0.5 + math.random()) -- light intensity attenuation between the phi and theta areas					 --
	lightMatrix[#lightMatrix]:setDirection(getCamera().matrix.forward)					 --
end					 --
)					 --
					 --
bindKey("6", "down", function()					 --
    local camPos = getCamera().matrix.position + getCamera().matrix.forward * 5					 --
	local lightAttenuation = math.random(10,18)					 --
	local lightColor = Vector4(math.random(100,255), math.random(100,255), math.random(100,255), math.random(200,255))					 --
	lightMatrix[#lightMatrix + 1] = CPrmLightSpecular: create(camPos, lightAttenuation, lightColor)					 --
	--lightMatrix[#lightMatrix]:setDirection(getCamera().matrix.forward)					 --
	lightMatrix[#lightMatrix]:setFixedDirection(false)					 --
end					 --
)					 --
					 --
bindKey("7", "down", function()					 --
	lightMatrix[#lightMatrix + 1] = CPrmTextureProj: create(projTex, Vector3(0,0,0), 15, Vector3(0,0,0), Vector2(5,5), Vector4(255,255,255,255), true )					 --
	lightMatrix[#lightMatrix]:setAutoProjectionEnabled(true)					 --
	lightMatrix[#lightMatrix]:setAutoProjectionSearchLength(120)					 --
	local camMat = getCamera().matrix					 --
	camMat:setPosition(camMat.position + camMat.up * 3)					 --
	lightMatrix[#lightMatrix]:setViewMatrix(getCamera().matrix)						 --
end					 --
)					 --
					 --
bindKey("8", "down", function()					 --
	lightMatrix[#lightMatrix + 1] = CPrmTextureProjCube: create(cubeTex, Vector3(0,0,0), 15, Vector3(0,0,0), Vector4(255,255,255,255))					 --
	lightMatrix[#lightMatrix]:setPosition(getCamera().matrix.position)					 --
	lightMatrix[#lightMatrix]:setRotation(getCamera().matrix:getRotationZXY())					 --
	lightMatrix[#lightMatrix]:setRotationSpeed(Vector3(0.2,0.4,0))					 --
end					 --
)					 --
					 --
bindKey("9", "down", function()					 --
	lightMatrix[#lightMatrix + 1] = CPrmTexture: create(projTex, Vector3(0,0,0), 0.2, Vector3(0,0,0), Vector2(5,5), Vector4(255,255,255,255), true )					 --
	lightMatrix[#lightMatrix]:setAutoProjectionEnabled(true)					 --
	lightMatrix[#lightMatrix]:setAutoProjectionSearchLength(120)					 --
	local camMat = getCamera().matrix					 --
	camMat:setPosition(camMat.position + camMat.up * 3)					 --
	lightMatrix[#lightMatrix]:setViewMatrix(getCamera().matrix)						 --
end					 --
)					 --
					 --
bindKey("0", "down", function()					 --
	lightMatrix[#lightMatrix + 1] = CPrmTextureNoDB: create(projTex, Vector3(0,0,0), Vector3(0,0,0), Vector2(5,5), Vector4(255,255,255,255), true )					 --
	lightMatrix[#lightMatrix]:setAutoProjectionEnabled(true)					 --
	lightMatrix[#lightMatrix]:setAutoProjectionSearchLength(120)					 --
	local camMat = getCamera().matrix					 --
	camMat:setPosition(camMat.position + camMat.up * 3)					 --
	lightMatrix[#lightMatrix]:setViewMatrix(getCamera().matrix)						 --
end					 --
)					 --
					 --
local isDirLight = false					 --
bindKey("-", "down", function()					 --
	local camMat = getCamera().matrix					 --
	if not isDirLight then					 --
		lightMatrix[#lightMatrix + 1] = CPrmLightDirectional: create(camMat.forward, Vector4(255,255,255,255))					 --
		isDirLight = #lightMatrix					 --
	end					 --
	lightMatrix[isDirLight]:setDirection(camMat.forward)					 --
end					 --
)					 --
					 --
addEventHandler('onClientHUDRender', root, function()					 --
	for i,v in ipairs(lightMatrix) do					 --
		v:draw()					 --
	end					 --
end					 --
)					 --
					 --
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()), function()					 --
	outputChatBox("primitive3DLightBasic test:")					 --
	outputChatBox("hit'1' for point light,'2' for spot light, '3' dark light")					 --
	outputChatBox("hit'4' for point light NoNRM,'5' for spot light NoNRM")					 --
	outputChatBox("hit'6' for specular light")					 --
	outputChatBox("hit'7' for projective 2D texture")					 --
	outputChatBox("hit'8' for projective cube texture")					 --
	outputChatBox("hit'9' for textured quad")					 --
	outputChatBox("hit'0' for textured quad (simple)")					 --
	outputChatBox("hit'-' for global directional light")					 --
	projTex = dxCreateTexture("tex/creshez6.png", "dxt3")					 --
	cubeTex = dxCreateTexture("tex/cubebox.dds" )					 --
end					 --
)					 --
					 --
					 --
function createPointLite(x,y,z,la,color)					 --
	local possos = Vector3(x,y,z)					 --
	local lightAttenuation = la or 10					 --
	local lightColor = color or Vector4(math.random(100,255), math.random(100,255), math.random(100,255), math.random(200,255))					 --
					 --
	lightMatrix[#lightMatrix + 1] = CPrmLightPoint: create(possos, lightAttenuation, lightColor)					 --
end					 --
