-- 
-- c_cam2RTMirror.lua
--				

cam2RTMirror = {}
cam2RTMirror.__index = cam2RTMirror
local extraBuffer = {instance = 0, depthRT = nil, colorRT = nil}
local getRTStatus = dxGetStatus().VideoCardNumRenderTargets
local distFade = {60, 40}

function cam2RTMirror: create( inMatrix, inSize, ... )
	local extraTable = {...}
	local cMirror = {
		worldShader = DxShader( "fx/cam2RTMirror_world.fx", 0, distFade[1], true, "world,other,object" ),
		vehicleShader = DxShader( "fx/cam2RTMirror_vehicle.fx", 0, distFade[1], true, "vehicle,ped" ),
		addBlendWorldShader = nil,
		myImage = CMat3DMaskProj: create(),
		isMaskEnable = false,
		myMatrix = inMatrix,
		size = Vector2( inSize.x, inSize.y ),
		color = (( type( extraTable[1] )=="number") and extraTable[1] or tocolor( 255, 255, 255, 255 )),
		skipWorld = ((( type( extraTable[2] )=="boolean" ) and extraTable[2] == true ) and extraTable[2] or false ),
		skipPedVeh = ((( type( extraTable[3] )=="boolean" ) and extraTable[3] == true ) and extraTable[3] or false ),
		objectList = (( type( extraTable[4] )=="table" ) and extraTable[4] or false),
		isBillboard = ((( type( extraTable[5] )=="boolean" ) and extraTable[5] == true ) and extraTable[5] or false ),
		worldShaderSmap = {}
					}
	extraTable = nil
	
	cMirror.isAllValid = cMirror.worldShader and cMirror.vehicleShader and cMirror.myImage 
	if not cMirror.isAllValid then
		return false 
	end 

	updateCameraMatrix( cMirror.worldShader, inMatrix )
	updateCameraMatrix( cMirror.vehicleShader, inMatrix )
	
	cMirror.worldShader:setValue( "sPixelSize", 1 / scx, 1 / scy )
	cMirror.vehicleShader:setValue( "sPixelSize", 1 / scx, 1 / scy )
	
	cMirror.worldShader:setValue( "gDistFade", distFade[1], distFade[2] )	
	cMirror.vehicleShader:setValue( "gDistFade", distFade[1], distFade[2] )
	
	cMirror.myImage:setBillboard( cMirror.isBillboard )
	cMirror.worldShader:setValue( "sCameraBillboard", cMirror.isBillboard )
	cMirror.vehicleShader:setValue( "sCameraBillboard", cMirror.isBillboard )

	if getRTStatus > 1 then
		-- handle the shadowmap case
		if cMirror.objectList then
			if cMirror.objectList[1][1] then
				local j = 0
				for i, val in ipairs( cMirror.objectList ) do
					if val[2] then
						j = j + 1
						-- when there is a smap texture in the table
						cMirror.worldShaderSmap[j] = {}
						cMirror.worldShaderSmap[j].shader = DxShader( "fx/cam2RTMirror_world_smap.fx", 0, 15, true, "object" )
						if not cMirror.worldShaderSmap[j].shader then
							return false
						end
						cMirror.worldShaderSmap[j].object = val[1]
						cMirror.worldShaderSmap[j].texture = val[2]
				
						cMirror.worldShaderSmap[j].shader:applyToWorldTexture( "*", cMirror.worldShaderSmap[i].object )	
						cMirror.worldShaderSmap[j].shader:setValue( "gTextureS", cMirror.worldShaderSmap[i].texture )
						cMirror.worldShaderSmap[j].shader:setValue( "sCameraBillboard", cMirror.isBillboard )
						cMirror.worldShaderSmap[j].shader:setValue( "sPixelSize", 1 / scx, 1 / scy )
						cMirror.worldShaderSmap[j].shader:setValue( "gDistFade", distFade[1], distFade[2] )
						updateCameraMatrix( cMirror.worldShaderSmap[j].shader, inMatrix )				
					elseif val[1] then
						-- when there is no smap texture
						cMirror.worldShader:applyToWorldTexture( "*", val[1] )
					end
					if not cMirror.worldShaderSmap[j] then 
						return false
					end
				end
				j = 0;
			end
		end	
	
		-- apply shaders to the world textures
		if not cMirror.skipWorld then
			applyEffectToTextures( cMirror.worldShader, textureApplyList, textureRemoveList )
		end		
		-- apply shader to vehicles
		if not cMirror.skipPedVeh then
			applyEffectToTextures( cMirror.vehicleShader, textureApplyList, textureRemoveList )
		end
		if ( #cMirror.worldShaderSmap > 0 ) then
			if not cMirror.skipWorld then
				-- remove world standard shader from smap textures (if smap objects)
				for i, val in ipairs( cMirror.worldShaderSmap ) do
					local texNames = engineGetModelTextureNames( getElementModel( cMirror.worldShaderSmap[i].object ))
					for _,name in ipairs( texNames ) do
						cMirror.worldShader:removeFromWorldTexture( name )
					end	
				end
			end
		else
			-- if no shadowmap, but objects
			if cMirror.objectList then
				for _, thisObj in ipairs( cMirror.objectList ) do
					cMirror.worldShader:applyToWorldTexture( "*", thisObj )	
				end
			end
		end
	end

	-- handle the screen
	cMirror.myImage:setFlipVertex( true )
	cMirror.myImage:setCullMode( 1 )
	cMirror.myImage:setPosition( inMatrix:getPosition() )
	cMirror.myImage:setRotation( inMatrix:getRotation("XZY") )
	cMirror.myImage:setSize( cMirror.size )
	
	if cMirror.color then
		cMirror.myImage:setColor( cMirror.color )
	end

	if getRTStatus > 1 then
		if extraBuffer.instance == 0 then
			extraBuffer.depthRT = DxRenderTarget( scx, scy, false )
			extraBuffer.colorRT = DxRenderTarget( scx, scy, false )
		end
	end
	
	if extraBuffer.depthRT and extraBuffer.colorRT then
		extraBuffer.instance = extraBuffer.instance + 1
		for i, v in ipairs( cMirror.worldShaderSmap ) do
			v.shader:setValue( "depthRT", extraBuffer.depthRT )
			v.shader:setValue( "colorRT", extraBuffer.colorRT )				
		end
		cMirror.worldShader:setValue( "depthRT", extraBuffer.depthRT )
		cMirror.vehicleShader:setValue( "depthRT", extraBuffer.depthRT )
		cMirror.worldShader:setValue( "colorRT", extraBuffer.colorRT )
		cMirror.vehicleShader:setValue( "colorRT", extraBuffer.colorRT )
		cMirror.myImage:setTexture( extraBuffer.colorRT )
		self.__index = self	
		setmetatable( cMirror, self )
		return cMirror
	elseif getRTStatus == 1 then
		self.__index = self	
		setmetatable( cMirror, self )
		return cMirror		
	else
		return false
	end
end

function cam2RTMirror: addBlendTextures( blendTexList )
	if self.isAllValid then
		if not self.addBlendWorldShader then
			self.addBlendWorldShader = DxShader( "fx/cam2RTMirror_world_add.fx", 0, 15, true, "world,other,object" )
			self.addBlendWorldShader:setValue( "sCameraBillboard", self.isBillboard )
			self.addBlendWorldShader:setValue( "sPixelSize", 1 / scx, 1 / scy )
			self.addBlendWorldShader:setValue( "gDistFade", distFade[1], distFade[2] )
			updateCameraMatrix( self.addBlendWorldShader, self.myMatrix )
			if extraBuffer.depthRT and extraBuffer.colorRT then
				self.addBlendWorldShader:setValue( "depthRT", extraBuffer.depthRT )
				self.addBlendWorldShader:setValue( "colorRT", extraBuffer.colorRT )
			end
		end
		for i, val in ipairs( blendTexList ) do
			self.addBlendWorldShader:applyToWorldTexture( val )
		end		
	end
end

function cam2RTMirror: setBillboard( isBill )
	if self.isAllValid then
		self.isBillboard = isBill
		-- handle the shadowmap case
		if self.objectList then
			if (#self.worldShaderSmap > 0) then	
				for i, val in ipairs( self.worldShaderSmap ) do
					self.worldShaderSmap[i].shader:setValue( "sCameraBillboard", isBill )
				end
			end
		end	
		self.worldShader:setValue( "sCameraBillboard", isBill )
		self.vehicleShader:setValue( "sCameraBillboard", isBill )

		self.myImage:setBillboard( isBill )
		return true
	else
		return false
	end
end

function cam2RTMirror: setMaskEnable( isMask, thisTex )
	if self.isAllValid then
		self.isMaskEnable = isMask
		self.myImage:setMaskEnable( isMask )
		if thisTex then
			self.myImage:setMaskTexture( thisTex )
		end
		return true
	else
		return false
	end
end

function cam2RTMirror: setMatrix( inMatrix )
	if self.isAllValid then
		self.myMatrix = inMatrix
		-- handle the shadowmap case
		if self.objectList then
			if ( #self.worldShaderSmap > 0 ) then	
				for i, val in ipairs( self.worldShaderSmap ) do
					updateCameraMatrix( self.worldShaderSmap[i].shader, inMatrix )	
				end
			end
		end	
		if self.addBlendWorldShader then
			updateCameraMatrix( self.addBlendWorldShader, inMatrix )
		end
		updateCameraMatrix( self.worldShader, inMatrix )
		updateCameraMatrix( self.vehicleShader, inMatrix )
		
		self.myImage:setPosition( inMatrix:getPosition() )
		self.myImage:setRotation( inMatrix:getRotation("XZY") )
		return true
	else
		return false
	end
end

function cam2RTMirror: setSize( inSize )
	if self.isAllValid then
		self.size = Vector2( inSize.x, inSize.y )
		self.myImage:setSize( self.size )
		return true
	else
		return false
	end
end

function cam2RTMirror: getRenderTargets()
	if extraBuffer.colorRT and extraBuffer.depthRT then
		return extraBuffer.colorRT, extraBuffer.depthRT
	else
		return false
	end
end

function cam2RTMirror: draw()
	if self.isAllValid then
		self.myImage: draw()
		return true
	else
		return false
	end
end

function cam2RTMirror: destroy()
	if self.isAllValid then
		-- handle the shadowmap case
		if self.objectList then
			if ( #self.worldShaderSmap > 0 ) then		
				for i, val in ipairs( self.worldShaderSmap ) do
					self.worldShaderSmap[i].shader:removeFromWorldTexture( "*" )
					self.worldShaderSmap[i].shader:destroy()			
				end
			end
		end	
		self.worldShader:removeFromWorldTexture( "*" )
		self.vehicleShader:removeFromWorldTexture( "*" )
		self.worldShader:destroy()
		self.vehicleShader:destroy()
		self.myImage:destroy()
		if getRTStatus > 1 then
			extraBuffer.instance = extraBuffer.instance - 1
			if extraBuffer.depthRT and extraBuffer.colorRT and extraBuffer.instance == 0 then
				extraBuffer.depthRT:destroy()
				extraBuffer.colorRT:destroy()
			end
		end
		self = nil
		return true
	end
	return false
end

---------------------------------------------------------------------------------------------------
-- manage shared render targets
---------------------------------------------------------------------------------------------------					
addEventHandler( "onClientPreRender", root,
    function()
		if extraBuffer.instance == 0 then return end
		-- Clear third render target
		extraBuffer.colorRT:setAsTarget( true )
		dxSetRenderTarget()
		-- Clear second render target
		extraBuffer.depthRT:setAsTarget( false )
		dxDrawRectangle( 0, 0, scx, scy )
		dxSetRenderTarget()	
    end
, true, "high" )
