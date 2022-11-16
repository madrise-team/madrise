-- 					 --
-- c_cam2RTAlternate.lua					 --
--									 --
					 --
cam2RTAlternate = {}					 --
cam2RTAlternate.__index = cam2RTAlternate					 --
local extraBuffer = {instance = 0, depthRT = nil, colorRT = nil}					 --
local getRTStatus = dxGetStatus().VideoCardNumRenderTargets					 --
local distFade = {60, 40}					 --
					 --
function cam2RTAlternate: create( inMatrix, inSize, ... )					 --
	local extraTable = {...}					 --
	local cAlternate = {					 --
		worldShader = DxShader( "fx/cam2RTAlternate_world.fx", 0, distFade[1], false, "world,object,other" ),					 --
		vehicleShader = DxShader( "fx/cam2RTAlternate_vehicle.fx", 0, distFade[1], false, "vehicle,ped" ),					 --
		addBlendWorldShader = nil,					 --
		myImage = CMat3DMaskProj: create(),					 --
		isMaskEnable = false,					 --
		myMatrix = inMatrix,					 --
		size = Vector2( inSize.x, inSize.y ),					 --
		color = (( type( extraTable[1] )=="number") and extraTable[1] or tocolor( 255, 255, 255, 255 )),					 --
		skipWorld = ((( type( extraTable[2] )=="boolean" ) and extraTable[2] == true ) and extraTable[2] or false ),					 --
		skipPedVeh = ((( type( extraTable[3] )=="boolean" ) and extraTable[3] == true ) and extraTable[3] or false ),					 --
		objectList = (( type( extraTable[4] )=="table" ) and extraTable[4] or false),					 --
		isBillboard = ((( type( extraTable[5] )=="boolean" ) and extraTable[5] == true ) and extraTable[5] or false ),					 --
		worldShaderSmap = {}					 --
					}					 --
	extraTable = nil					 --
						 --
	cAlternate.isAllValid = cAlternate.worldShader and cAlternate.vehicleShader and cAlternate.myImage 					 --
	if not cAlternate.isAllValid then					 --
		return false 					 --
	end					 --
					 --
	updateCameraMatrix( cAlternate.worldShader, inMatrix )					 --
	updateCameraMatrix( cAlternate.vehicleShader, inMatrix )					 --
						 --
	cAlternate.worldShader:setValue( "sPixelSize", 1 / scx, 1 / scy )					 --
	cAlternate.vehicleShader:setValue( "sPixelSize", 1 / scx, 1 / scy )					 --
						 --
	cAlternate.worldShader:setValue( "gDistFade", distFade[1], distFade[2] )						 --
	cAlternate.vehicleShader:setValue( "gDistFade", distFade[1], distFade[2] )					 --
						 --
	cAlternate.myImage:setBillboard( cAlternate.isBillboard )					 --
	cAlternate.worldShader:setValue( "sCameraBillboard", cAlternate.isBillboard )					 --
	cAlternate.vehicleShader:setValue( "sCameraBillboard", cAlternate.isBillboard )					 --
					 --
	if getRTStatus > 1 then					 --
		-- handle the shadowmap case					 --
		if cAlternate.objectList then					 --
			if cAlternate.objectList[1][1] then					 --
				local j = 0					 --
				for i, val in ipairs(cAlternate.objectList) do					 --
					if val[2] then					 --
						j = j + 1					 --
						-- when there is a smap texture in the table					 --
						cAlternate.worldShaderSmap[j] = {}					 --
						cAlternate.worldShaderSmap[j].shader = DxShader( "fx/cam2RTMirror_world_smap.fx", 0, 120, false, "object" )					 --
						if not cAlternate.worldShaderSmap[j].shader then					 --
							return false					 --
						end					 --
						cAlternate.worldShaderSmap[j].object = val[1]					 --
						cAlternate.worldShaderSmap[j].texture = val[2]					 --
									 --
						cAlternate.worldShaderSmap[j].shader:applyToWorldTexture( "*", cAlternate.worldShaderSmap[i].object )						 --
						cAlternate.worldShaderSmap[j].shader:setValue( "gTextureS", cAlternate.worldShaderSmap[i].texture )					 --
						cAlternate.worldShaderSmap[i].shader:setValue( "sCameraBillboard", cAlternate.isBillboard )					 --
						cAlternate.worldShaderSmap[j].shader:setValue( "sPixelSize", 1 / scx, 1 / scy )					 --
						cAlternate.worldShaderSmap[j].shader:setValue( "gDistFade", distFade[1], distFade[2] )					 --
						updateCameraMatrix( cAlternate.worldShaderSmap[j].shader, inMatrix )									 --
					elseif val[1] then					 --
						-- when there is no smap texture					 --
						cAlternate.worldShader:applyToWorldTexture( "*", val[1] )					 --
					end					 --
					if not cAlternate.worldShaderSmap[j] then 					 --
						return false					 --
					end					 --
				end					 --
				j = 0;					 --
			end					 --
		end						 --
						 --
		-- apply shaders to the world textures					 --
		if not cAlternate.skipWorld then					 --
			applyEffectToTextures( cAlternate.worldShader, textureApplyList, textureRemoveList )					 --
		end							 --
		-- apply shader to vehicles					 --
		if not cAlternate.skipPedVeh then					 --
			applyEffectToTextures( cAlternate.vehicleShader, textureApplyList, textureRemoveList )					 --
		end					 --
		if (#cAlternate.worldShaderSmap > 0) then					 --
			if not cAlternate.skipWorld then					 --
				-- remove world standard shader from smap textures (if smap objects)					 --
				for i, val in ipairs( cAlternate.worldShaderSmap ) do					 --
					local texNames = engineGetModelTextureNames( getElementModel( cAlternate.worldShaderSmap[i].object ))					 --
					for _,name in ipairs( texNames ) do					 --
						cAlternate.worldShader:removeFromWorldTexture( name )					 --
					end						 --
				end					 --
			end					 --
		else					 --
			-- if no shadowmap, but objects					 --
			if (type( cAlternate.objectList )== "table" ) then					 --
				for i, thisObj in ipairs( cAlternate.objectList ) do					 --
					cAlternate.worldShader:applyToWorldTexture( "*", thisObj )					 --
				end					 --
			end					 --
		end					 --
	else					 --
		-- make object invisible if shader is not applied					 --
		if cAlternate.objectList then					 --
			for _,applyMatch in ipairs( cAlternate.objectList ) do					 --
				if type( applyMatch ) == "table" then					 --
					applyMatch[1]:setAlpha( 0 )					 --
				else					 --
					applyMatch:setAlpha( 0 )					 --
				end					 --
			end					 --
		end					 --
	end					 --
								 --
	-- handle the screen					 --
	cAlternate.myImage:setFlipVertex( true )					 --
	cAlternate.myImage:setCullMode( 1 )					 --
	cAlternate.myImage:setPosition( inMatrix:getPosition() )					 --
	cAlternate.myImage:setRotation( inMatrix:getRotation("XZY") )					 --
	cAlternate.myImage:setSize( cAlternate.size )						 --
						 --
	if cAlternate.color then					 --
		cAlternate.myImage:setColor( cAlternate.color )					 --
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
		for i, v in ipairs(cAlternate.worldShaderSmap) do					 --
			v.shader:setValue( "depthRT", extraBuffer.depthRT )					 --
			v.shader:setValue( "colorRT", extraBuffer.colorRT )									 --
		end					 --
		cAlternate.worldShader:setValue( "depthRT", extraBuffer.depthRT )					 --
		cAlternate.vehicleShader:setValue( "depthRT", extraBuffer.depthRT )					 --
		cAlternate.worldShader:setValue( "colorRT", extraBuffer.colorRT )					 --
		cAlternate.vehicleShader:setValue( "colorRT", extraBuffer.colorRT )					 --
		cAlternate.myImage:setTexture( extraBuffer.colorRT )					 --
		self.__index = self						 --
		setmetatable( cAlternate, self )					 --
		return cAlternate					 --
	elseif getRTStatus == 1 then					 --
		self.__index = self						 --
		setmetatable( cAlternate, self )					 --
		return cAlternate							 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTAlternate: addBlendTextures( blendTexList )					 --
	if self.isAllValid then					 --
		if not self.addBlendWorldShader then					 --
			self.addBlendWorldShader = DxShader( "fx/cam2RTAlternate_world_add.fx", 0, 120, false, "world,object,other")					 --
			self.addBlendWorldShader:setValue( "sCameraBillboard", self.isBillboard )					 --
			self.addBlendWorldShader:setValue( "sPixelSize", 1 / scx, 1 / scy )					 --
			self.addBlendWorldShader:setValue( "gDistFade", distFade[1], distFade[2] )					 --
			updateCameraMatrix( self.addBlendWorldShader, self.myMatrix )					 --
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
function cam2RTAlternate: setBillboard( isBill )					 --
	if self.isAllValid then					 --
		self.isBillboard = isBill					 --
		-- handle the shadowmap case					 --
		if self.objectList then					 --
			if (#self.worldShaderSmap > 0) then						 --
				for i, val in ipairs( self.worldShaderSmap ) do					 --
					self.worldShaderSmap[i].shader:setValue( "sCameraBillboard", isBill )					 --
				end					 --
			end					 --
		end						 --
		self.worldShader:setValue( "sCameraBillboard", isBill )					 --
		self.vehicleShader:setValue( "sCameraBillboard", isBill )					 --
					 --
		self.myImage:setBillboard( isBill )					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTAlternate: setMaskEnable( isMask, thisTex )					 --
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
function cam2RTAlternate: setMatrix( inMatrix )					 --
	if self.isAllValid then					 --
		self.myMatrix = inMatrix					 --
		-- handle the shadowmap case					 --
		if self.objectList then					 --
			if (#self.worldShaderSmap > 0) then						 --
				for i, val in ipairs( self.worldShaderSmap ) do					 --
					updateCameraMatrix( self.worldShaderSmap[i].shader, inMatrix )						 --
				end					 --
			end					 --
		end					 --
		if self.addBlendWorldShader then					 --
			updateCameraMatrix( self.addBlendWorldShader, inMatrix )					 --
		end					 --
		updateCameraMatrix( self.worldShader, inMatrix )					 --
		updateCameraMatrix( self.vehicleShader, inMatrix )					 --
							 --
		self.myImage:setPosition( inMatrix:getPosition() )					 --
		self.myImage:setRotation( inMatrix:getRotation("XZY") )					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTAlternate: setSize( inSize )					 --
	if self.isAllValid then					 --
		self.size = Vector2( inSize.x, inSize.y )					 --
		self.myImage:setSize( self.size )					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTAlternate: getRenderTargets()					 --
	if extraBuffer.colorRT and extraBuffer.depthRT then					 --
		return extraBuffer.colorRT, extraBuffer.depthRT					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTAlternate: draw()					 --
	if self.isAllValid then					 --
		self.myImage: draw()					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
function cam2RTAlternate: destroy()					 --
	if self.isAllValid then					 --
		-- handle the shadowmap case					 --
		if self.objectList then					 --
			if (#self.worldShaderSmap > 0) then							 --
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
