-- 
-- file: c_primitive3D_darkLight.lua
-- version: v1.6
-- author: Ren712
--
-- include: fx/primitive3D_darkLight.fx, c_common.lua

local scx,scy = guiGetScreenSize ()

CPrmLightDark = { }
CPrmLightDark.__index = CPrmLightDark
	 
-- worldPosition Vector3() , attenuation Vector1(0-n), color Vector4(0-255,0-255,0-255,0-255) 
function CPrmLightDark: create(pos, atten, col )
	local scX, scY = guiGetScreenSize()
	
	local cShader = {
		shader = DxShader( "fx/primitive3D_darkLight.fx" ),
		color = tocolor(col.x, col.y, col.z, col.w),
		position = Vector3(pos.x, pos.y, pos.z),
		attenuation = atten,
		attenuationPower = 2,
		shapeTess = 8,
		tessSwitch = false,
		tickCount = 0,
		distFade = Vector2(450, 400)
	}

	if cShader.shader then
		cShader.shader:setValue( "sLightPosition", cShader.position.x, cShader.position.y, cShader.position.z )
		cShader.shader:setValue( "sLightColor", col.x / 255, col.y / 255, col.z / 255, col.w/ 255 )
		cShader.shader:setValue( "sLightAttenuation", cShader.attenuation )
		cShader.shader:setValue( "sLightAttenuationPower", cShader.attenuationPower )
		
		cShader.shader:setValue( "gDistFade", cShader.distFade.x, cShader.distFade.y )
		
		cShader.shader:setValue( "sPixelSize", 1 / scX, 1 / scY )
		cShader.shader:setValue( "sHalfPixel", 1/(scX * 2), 1/(scY * 2) )
		
		if isSM3DBSupported then 
			local distFromCam = ( pos - getCamera().matrix.position ).length
			if ( distFromCam < 4 * atten ) then 	
				cShader.trianglestrip = createPrimitiveQuadUV(Vector2(cShader.shapeTess, cShader.shapeTess))
				cShader.shader:setValue( "sSubdivUnit", cShader.shapeTess )
				cShader.tessSwitch = true
			else
				cShader.trianglestrip = createPrimitiveQuadUV(Vector2(1, 1))
				cShader.shader:setValue( "sSubdivUnit", 1 )
				cShader.tessSwitch = false
			end	
		end

		self.__index = self
		setmetatable( cShader, self )
		return cShader
	else
		return false
	end
end

function CPrmLightDark: setTesselationByDistance()
	if self.shader and isSM3DBSupported then
		local distFromCam = ( self.position - getCamera().matrix.position ).length
		if ( distFromCam < 4 * self.attenuation ) then 
			if not self.tessSwitch then
				self.trianglestrip = createPrimitiveQuadUV(Vector2(self.shapeTess, self.shapeTess))
				self.shader:setValue( "sSubdivUnit", self.shapeTess )
				self.tessSwitch = true
			end
		else
			if self.tessSwitch then
				self.trianglestrip = createPrimitiveQuadUV(Vector2(1, 1))
				self.shader:setValue( "sSubdivUnit", 1 )
				self.tessSwitch = false
			end
		end		
	end
end

function CPrmLightDark: setTesselationSwitchDistance( tessDis )
	if self.shader then
		self.tessDist = tessDis
		self.angTessDist = ( self.attenuation / 2 ) / math.atan( self.tessTestAngle )
		self.currTessDist = math.max( tessDis, self.angTessDist )
		self:setTesselationByDistance()
	end
end

function CPrmLightDark: setObjectTesselation( tess )
	if self.shader then
		self.shapeTess = tess
		self:setTesselationByDistance()
	end
end

function CPrmLightDark: setDistFade( distFade )
	if self.shader then
		self.distFade = distFade
		self.shader:setValue( "gDistFade", distFade.x, distFade.y )
	end
end

function CPrmLightDark: setPosition( pos )
	if self.shader then
		self.position = Vector3(pos.x, pos.y, pos.z)
		self.shader:setValue( "sLightPosition", pos.x, pos.y, pos.z )
	end
end

function CPrmLightDark: setAttenuation( atten )
	if self.shader then
		self.attenuation = atten
		self.shader:setValue( "sLightAttenuation", atten )
		self.angTessDist = ( self.attenuation / 2 ) / math.atan( self.tessTestAngle )
		self.currTessDist = math.max( self.tessDist, self.angTessDist )
		self:setTesselationByDistance()
	end
end

function CPrmLightDark: setAttenuationPower( attenPow )
	if self.shader then
		self.attenuationPower = attenPow
		self.shader:setValue( "sLightAttenuationPower", attenPow )
	end
end

function CPrmLightDark: setColor( col )
	if self.shader then
		self.color = Vector4(col.x, col.y, col.z, col.w)
		self.shader:setValue( "sLightColor", col.x / 255, col.y / 255, col.z / 255, col.w/ 255 )
	end
end

function CPrmLightDark: getObjectToCameraAngle()
	if self.position then
		local camMat = getCamera().matrix
		local camFw = camMat:getForward()
		local elementDir = ( self.position - camMat.position ):getNormalized()
		return math.acos( elementDir:dot( camFw ) / ( elementDir.length * camFw.length ))
	else
		return false
	end
end

function CPrmLightDark: getDistanceFromViewAngle( inAngle )
	if self.shader then
		return ( self.attenuation / 2 ) / math.atan(inAngle)
	else
		return false
	end
end

function CPrmLightDark: draw()
	if self.shader then
		local clipDist = math.min( self.distFade.x, getFarClipDistance() + self.attenuation )
		local distFromCam = ( self.position - getCamera().matrix.position ).length
		if ( distFromCam < clipDist ) then	
			self.tickCount = self.tickCount + lastFrameTickCount + math.random(500)
			if self.tickCount > tesselationSwitchDelta then            
				self:setTesselationByDistance()
				self.tickCount = 0
			end
			-- draw the outcome
			dxDrawMaterialPrimitive3D( "trianglestrip", self.shader, false, unpack( self.trianglestrip ) )
		end
	end
end

function CPrmLightDark: destroy()
	if self.shader then
		self.shader:destroy()
		self.shader = nil
	end
	self = nil
	return true
end
