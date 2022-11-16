-- 					 --
-- c_resource_test.lua					 --
--					 --
local maskTex = DxTexture("tex/mask.png", "argb", true, "clamp")					 --
					 --
local thisMirror = nil					 --
					 --
addEventHandler( "onClientResourceStart", resourceRoot, function()					 --
	setCameraInterior ( 15 )					 --
	setElementInterior( localPlayer, 15 )					 --
	setElementPosition( localPlayer, 2222, -1151, 1026 )					 --
	local mirrorMat = Matrix( Vector3( 2217.229, -1150.458, 1026.796 ), Vector3( 0, 0, 275 ))					 --
	thisMirror = cam2RTMirror:create( mirrorMat, Vector2( 4, 3 ), tocolor(255,255,255,255), false, false )					 --
	--thisMirror:setBillboard(true)					 --
	thisMirror:setMaskEnable(true, maskTex)					 --
	--thisMirror: addBlendTextures( {"*"} )					 --
end					 --
)					 --
					 --
addEventHandler( "onClientResourceStop", resourceRoot, function()					 --
	thisMirror:destroy()					 --
end					 --
)					 --
					 --
addEventHandler( "onClientPreRender", root, function()					 --
	if thisMirror then					 --
		thisMirror:draw()					 --
	end					 --
end					 --
)					 --
					 --
--[[					 --
local thisAlternate = nil					 --
local thisCorona = nil					 --
					 --
addEventHandler( "onClientResourceStart", resourceRoot, function()					 --
	setCameraInterior ( 0 )					 --
	setElementInterior( localPlayer, 0 )					 --
	setElementPosition( localPlayer, 2491.939, -1664.5896, 14.5012 )					 --
 					 --
	local myobject1 = createObject(18028, 2468.6001, -1667.6, 14.5, 0, 0, 0, true )					 --
	local myobject2 = createObject(1574, 2477.3999, -1663.3, 12.3, 0, 0, 0, true )					 --
					 --
	local alternateMat = Matrix( Vector3( 2475, -1663.7480, 14.0562 ), Vector3(0, 0, -90 ))					 --
	thisAlternate = cam2RTAlternate:create( alternateMat, Vector2( 4, 3 ), tocolor(255,255,255,255), true, true, {myobject1, myobject2})					 --
	thisAlternate:setBillboard(true)					 --
	thisAlternate:setMaskEnable(true, maskTex)					 --
					 --
	--thisCorona = CMat3DCorAlt:create( maskTex, Vector3(2476.2846, -1663.4042, 12), 4, Vector4( 255,0,0,255 ))					 --
	--thisCorona:setCameraEnable(true)					 --
	--thisCorona:setCameraBillboard(true)					 --
	--thisCorona:setCameraMatrix(alternateMat)					 --
	--local colorRT, depthRT = thisAlternate:getRenderTargets()					 --
	--thisCorona:setCam2RenderTargets( colorRT, depthRT )					 --
					 --
end					 --
)					 --
					 --
addEventHandler( "onClientResourceStop", resourceRoot, function()					 --
	thisAlternate:destroy()					 --
end					 --
)					 --
					 --
addEventHandler( "onClientPreRender", root, function()					 --
	if thisAlternate then						 --
		thisAlternate:draw()					 --
	end					 --
	if thisCorona then					 --
		thisCorona:draw()					 --
	end					 --
end					 --
)					 --
]]--					 --
--[[					 --
local thisScreen = nil					 --
					 --
addEventHandler( "onClientResourceStart", resourceRoot, function()					 --
	setCameraInterior ( 15 )					 --
	setElementInterior( localPlayer, 15 )					 --
	setElementPosition( localPlayer, 2222, -1151, 1026 )					 --
	local screenMat = Matrix( Vector3( 2217.229, -1150.458, 1026.796 ), Vector3( 0, 0, 275 ))					 --
	local cameraMat = Matrix( Vector3( 2217.229, -1150.458, 1026.796 ), Vector3( 0, 0, 275 ))					 --
	thisScreen = cam2RTScreen:create( cameraMat, screenMat, Vector2( 4, 3 ))					 --
end					 --
)					 --
					 --
addEventHandler( "onClientResourceStop", resourceRoot, function()					 --
	thisScreen:destroy()					 --
end					 --
)					 --
					 --
addEventHandler( "onClientPreRender", root, function()					 --
	if thisScreen then					 --
		thisScreen:draw()					 --
	end					 --
end					 --
)					 --
]]--					 --
--[[					 --
local thisImage = nil					 --
					 --
addEventHandler( "onClientResourceStart", resourceRoot, function()					 --
	outputChatBox('You might want to change world drawing range by changing shader range from 60 to 0 - look in c_cam2RTImage.lua line 12, 13')					 --
	local cameraMat = getCamera():getMatrix()					 --
	thisImage = cam2RTImage:create( cameraMat, true )					 --
end					 --
)					 --
					 --
addEventHandler( "onClientResourceStop", resourceRoot, function()					 --
	thisImage:destroy()					 --
end					 --
)					 --
					 --
addEventHandler( "onClientPreRender", root, function()					 --
	if thisImage then					 --
		local mat = localPlayer:getMatrix()					 --
		local pos = mat:getPosition() - mat:getForward() * 2					 --
		local rot = mat:getRotation() - Vector3( 0, 0, 180 )					 --
		local camMatrix = Matrix( pos, rot)					 --
		thisImage: setCameraMatrix( camMatrix )					 --
	end					 --
end					 --
)					 --
					 --
local sx, sy = guiGetScreenSize ()					 --
addEventHandler( "onClientHUDRender", root, function()					 --
	if thisImage then					 --
		myImage = thisImage:getRenderTarget()					 --
		local colR, colG, colB = getSkyGradient()					 --
		dxDrawRectangle(sx / 2 - sy * 0.25, 0, sy * 0.5, sy * ((sy/ sx) * 0.4), tocolor(colR, colG, colB, 255))					 --
		dxDrawImage(sx / 2 - sy * 0.25, 0, sy * 0.5, sy * ((sy/ sx) * 0.4), myImage)					 --
	end					 --
end					 --
)					 --
]]--					 --
