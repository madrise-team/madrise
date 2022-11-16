-- 					 --
-- c_cam2RTScreen.lua					 --
--									 --
					 --
cam2RTScreen = {}					 --
cam2RTScreen.__index = cam2RTScreen					 --
local extraBuffer = {instance = 0, depthRT = nil, colorRT = nil}					 --
local getRTStatus = dxGetStatus().VideoCardNumRenderTargets					 --
local distFade = {60, 40}					 --
					 --
function cam2RTScreen: create( camMatrix, scrMatrix, scrSize, ... )					 --
	local extraTable = {...}					 --
	local cScreen = {					 --
		worldShader = DxShader( "fx/cam2RTScreen_world.fx", 0, distFade[1], true, "world,object,other" ),					 --
		vehicleShader = DxShader( "fx/cam2RTScreen_world.fx", 0, distFade[1], true, "vehicle,ped" ),					 --
		addBlendWorldShader = nil,					 --
		myImage = CMat3DMask: create(),					 --
		isMaskEnable = false,					 --
		myMatrix = camMatrix,					 --
		size = Vector2( scrSize.x, scrSize.y ),					 --
		color = (( type( extraTable[1] )=="number") and extraTable[1] or tocolor( 255, 255, 255, 255 )),					 --
		skipWorld = ((( type( extraTable[2] )=="boolean" ) and extraTable[2] == true ) and extraTable[2] or false ),					 --
		skipPedVeh = ((( type( extraTable[3] )=="boolean" ) and extraTable[3] == true ) and extraTable[3] or false ),					 --
		objectList = (( type( extraTable[4] )=="table" ) and extraTable[4] or false),					 --
		worldShaderSmap = {}					 --
					}					 --
	extraTable = nil					 --
					 --
	cScreen.isAllValid = cScreen.worldShader and cScreen.vehicleShader and cScreen.myImage 					 --
	if not cScreen.isAllValid then					 --
		return false 					 --
	end					 --
					 --
	-- standard settings					 --
	local scX, scY = 800, 600					 --
	local fov = math.rad( 70 )					 --
	local nearClip = 0.3					 --
	local farClip = 600					 --
					 --
	updateProjectionMatrix( cScreen.worldShader, nearClip, farClip, fov, scX, scY )					 --
	updateProjectionMatrix( cScreen.vehicleShader, nearClip, farClip, fov, scX, scY )					 --
								 --
	updateCameraMatrix( cScreen.worldShader, camMatrix )					 --
	updateCameraMatrix( cScreen.vehicleShader, camMatrix )					 --
						 --
	cScreen.worldShader:setValue( "sPixelSize", 1 / scx, 1 / scy )					 --
	cScreen.vehicleShader:setValue( "sPixelSize", 1 / scx, 1 / scy )					 --
						 --
	cScreen.worldShader:setValue( "gDistFade", distFade[1], distFade[2] )						 --
	cScreen.vehicleShader:setValue( "gDistFade", distFade[1], distFade[2] )					 --
						 --
	if getRTStatus > 1 then					 --
		-- handle the shadowmap case					 --
		if cScreen.objectList then					 --
			if cScreen.objectList[1][1] then					 --
				local j = 0					 --
				for i, val in ipairs( cScreen.objectList ) do					 --
					if val[2] then					 --
						j = j + 1					 --
						-- when there is a smap texture in the table					 --
						cScreen.worldShaderSmap[j] = {}					 --
						cScreen.worldShaderSmap[j].shader = DxShader( "fx/cam2RTScreen_world_smap.fx", 0, 60, true, "object" )					 --
						if not cScreen.worldShaderSmap[j].shader then					 --
							return false					 --
						end					 --
						cScreen.worldShaderSmap[j].object = val[1]					 --
						cScreen.worldShaderSmap[j].texture = val[2]					 --
									 --
						cScreen.worldShaderSmap[j].shader:applyToWorldTexture( "*", cScreen.worldShaderSmap[i].object )						 --
						cScreen.worldShaderSmap[j].shader:setValue( "gTextureS", cScreen.worldShaderSmap[i].texture )					 --
						cScreen.worldShaderSmap[j].shader:setValue( "sPixelSize", 1 / scx, 1 / scy )					 --
						cMirror.worldShaderSmap[j].shader:setValue( "gDistFade", distFade[1], distFade[2] )					 --
						updateCameraMatrix( cScreen.worldShaderSmap[j].shader, inMatrix )									 --
					elseif val[1] then					 --
						-- when there is no smap texture					 --
						cScreen.worldShader:applyToWorldTexture( "*", val[1] )					 --
					end					 --
					if not cScreen.worldShaderSmap[j] then 					 --
						return false					 --
					end					 --
				end					 --
				j = 0;					 --
			end					 --
		end						 --
						 --
		-- apply shaders to the world textures					 --
		if not cScreen.skipWorld then					 --
			applyEffectToTextures( cScreen.worldShader, textureApplyList, textureRemoveList )					 --
		end							 --
		-- apply shader to vehicles					 --
		if not cScreen.skipPedVeh then					 --
			applyEffectToTextures( cScreen.vehicleShader, textureApplyList, textureRemoveList )					 --
		end					 --
		if ( #cScreen.worldShaderSmap > 0 ) then					 --
			if not cScreen.skipWorld then					 --
				-- remove world standard shader from smap textures (if smap objects)					 --
				for i, val in ipairs( cScreen.worldShaderSmap ) do					 --
					local texNames = engineGetModelTextureNames( getElementModel( cScreen.worldShaderSmap[i].object ))					 --
					for _,name in ipairs( texNames ) do					 --
						cScreen.worldShader:removeFromWorldTexture( name )					 --
					end						 --
				end					 --
			end					 --
		else					 --
			-- if no shadowmap, but objects					 --
			if cScreen.objectList then					 --
				for _, thisObj in ipairs( cScreen.objectList ) do					 --
					cScreen.worldShader:applyToWorldTexture( "*", thisObj )						 --
				end					 --
			end					 --
		end					 --
	end					 --
								 --
	cScreen.myImage:setFlipVertex( true )					 --
	cScreen.myImage:setCullMode( 1 )					 --
						 --
	cScreen.myImage:setPosition( scrMatrix:getPosition() )					 --
	cScreen.myImage:setRotation( scrMatrix:getRotation("XZY") )					 --
	cScreen.myImage:setSize( cScreen.size )					 --
						 --
	if cScreen.color then					 --
		cScreen.myImage:setColor( cScreen.color )					 --
	end					 --
					 --
	if getRTStatus > 1 then					 --
		if extraBuffer.instance == 0 then					 --
			extraBuffer.depthRT = DxRenderTarget( scx, scy, false )					 --
			extraBuffer.colorRT = DxRenderTarget( scx, scy, false )					 --
		end					 --
	end					 --
						 --
	if extraBuffer.depthRT and extraBuffer.colorRT then					 --
		extraBuffer.instance = extraBuffer.instance + 1					 --
		for i, v in ipairs( cScreen.worldShaderSmap ) do					 --
			v.shader:setValue( "depthRT", extraBuffer.depthRT )					 --
			v.shader:setValue( "colorRT", extraBuffer.colorRT )									 --
		end					 --
		cScreen.worldShader:setValue( "depthRT", extraBuffer.depthRT )					 --
		cScreen.vehicleShader:setValue( "depthRT", extraBuffer.depthRT )					 --
		cScreen.worldShader:setValue( "colorRT", extraBuffer.colorRT )					 --
		cScreen.vehicleShader:setValue( "colorRT", extraBuffer.colorRT )					 --
		cScreen.myImage:setTexture( extraBuffer.colorRT )					 --
		self.__index = self						 --
		setmetatable( cScreen, self )					 --
		return cScreen					 --
	elseif getRTStatus == 1 then					 --
		self.__index = self						 --
		setmetatable( cScreen, self )					 --
		return cScreen							 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTScreen: addBlendTextures( blendTexList )					 --
	if self.isAllValid then					 --
		if not self.addBlendWorldShader then					 --
			self.addBlendWorldShader = DxShader( "fx/cam2RTScreen_world_add.fx", 0, 60, true, "world,object,other" )					 --
			self.addBlendWorldShader:setValue( "sCameraBillboard", self.isBillboard )					 --
			updateCameraMatrix( self.addBlendWorldShader, self.myMatrix )					 --
			-- standard settings					 --
			local scX, scY = 800, 600					 --
			local fov = math.rad( 70 )					 --
			local nearClip = 0.3					 --
			local farClip = 600					 --
			updateProjectionMatrix( self.addBlendWorldShader, nearClip, farClip, fov, scX, scY )					 --
			self.addBlendWorldShader:setValue( "sPixelSize", 1 / scx, 1 / scy )					 --
			self.addBlendWorldShader:setValue( "gDistFade", distFade[1], distFade[2] )					 --
			if extraBuffer.depthRT and extraBuffer.colorRT then					 --
				self.addBlendWorldShader:setValue( "depthRT", extraBuffer.depthRT )					 --
				self.addBlendWorldShader:setValue( "colorRT", extraBuffer.colorRT )					 --
			end					 --
		end					 --
		for i, val in ipairs( blendTexList ) do					 --
			self.addBlendWorldShader:applyToWorldTexture( val )					 --
		end							 --
	end					 --
end					 --
					 --
function cam2RTScreen: setMaskEnable( isMask, thisTex )					 --
	if self.isAllValid then					 --
		self.isMaskEnable = isMask					 --
		self.myImage:setMaskEnable( isMask )					 --
		if thisTex then					 --
			self.myImage:setMaskTexture( thisTex )					 --
		end					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTScreen: setProjection( nearClip, farClip, fov, scX, scY )					 --
	if self.isAllValid then					 --
		-- handle the shadowmap case					 --
		if self.objectList then					 --
			if ( #self.worldShaderSmap > 0 ) then						 --
				for i, val in ipairs( self.worldShaderSmap ) do					 --
					updateProjectionMatrix( self.worldShaderSmap[i].shader, nearClip, farClip, fov, scX, scY )					 --
				end					 --
			end					 --
		end					 --
		if self.addBlendWorldShader then					 --
			updateProjectionMatrix(  self.addBlendWorldShader, nearClip, farClip, fov, scX, scY )					 --
		end					 --
		updateProjectionMatrix( self.worldShader, nearClip, farClip, fov, scX, scY )					 --
		updateProjectionMatrix( self.vehicleShader, nearClip, farClip, fov, scX, scY )					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
					 --
function cam2RTScreen: setCameraMatrix( camMatrix )					 --
	if self.isAllValid then					 --
		self.myMatrix = camMatrix					 --
		-- handle the shadowmap case					 --
		if self.objectList then					 --
			if ( #self.worldShaderSmap > 0 ) then						 --
				for i, val in ipairs( self.worldShaderSmap ) do					 --
					updateCameraMatrix( self.worldShaderSmap[i].shader, inMatrix )						 --
				end					 --
			end					 --
		end					 --
		if self.addBlendWorldShader then					 --
			updateCameraMatrix( self.addBlendWorldShader, camMatrix )					 --
		end					 --
		updateCameraMatrix( self.worldShader, camMatrix )					 --
		updateCameraMatrix( self.vehicleShader, camMatrix )					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTScreen: setScreenMatrix( scrMatrix )					 --
	if self.isAllValid then					 --
		self.myImage:setPosition( scrMatrix:getPosition() )					 --
		self.myImage:setRotation( scrMatrix:getRotation("XZY") )					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTScreen: setSize( inSize )					 --
	if self.isAllValid then					 --
		self.size = Vector2( inSize.x, inSize.y )					 --
		self.myImage:setSize( self.size )					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTScreen: getRenderTargets()					 --
	if extraBuffer.colorRT and extraBuffer.depthRT then					 --
		return extraBuffer.colorRT, extraBuffer.depthRT					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTScreen: draw()					 --
	if self.isAllValid then					 --
		self.myImage: draw()					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTScreen: destroy()					 --
	if self.isAllValid then					 --
		-- handle the shadowmap case					 --
		if self.objectList then					 --
			if ( #self.worldShaderSmap > 0 ) then							 --
				for i, val in ipairs( self.worldShaderSmap ) do					 --
					self.worldShaderSmap[i].shader:removeFromWorldTexture( "*" )					 --
					self.worldShaderSmap[i].shader:destroy()								 --
				end					 --
			end					 --
		end						 --
		self.worldShader:removeFromWorldTexture( "*" )					 --
		self.vehicleShader:removeFromWorldTexture( "*" )					 --
		self.worldShader:destroy()					 --
		self.vehicleShader:destroy()					 --
		self.myImage:destroy()					 --
		if getRTStatus > 1 then					 --
			extraBuffer.instance = extraBuffer.instance - 1					 --
			if extraBuffer.depthRT and extraBuffer.colorRT and extraBuffer.instance == 0 then					 --
				extraBuffer.depthRT:destroy()					 --
				extraBuffer.colorRT:destroy()					 --
			end					 --
		end					 --
		self = nil					 --
		return true					 --
	end					 --
	return false					 --
end					 --
					 --
---------------------------------------------------------------------------------------------------					 --
-- manage shared render targets					 --
---------------------------------------------------------------------------------------------------										 --
addEventHandler( "onClientPreRender", root,					 --
    function()					 --
		if extraBuffer.instance == 0 then return end					 --
		-- Clear third render target					 --
		extraBuffer.colorRT:setAsTarget( true )					 --
		dxSetRenderTarget()					 --
		-- Clear second render target					 --
		extraBuffer.depthRT:setAsTarget( false )					 --
		dxDrawRectangle( 0, 0, scx, scy )					 --
		dxSetRenderTarget()						 --
    end					 --
, true, "high" )					 --
