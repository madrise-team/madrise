-- 
-- file: c_material3D_mask_proj.lua
-- version: v1.5
-- author: Ren712
-- This class allows creation of screen space dxImages in 3d world space.
--
  
local scx,scy = guiGetScreenSize ()
    
CMat3DMaskProj = { }
CMat3DMaskProj.__index = CMat3DMaskProj
     
function CMat3DMaskProj: create( )
	local scX, scY = guiGetScreenSize()
	local cShader = {
		shader = dxCreateShader( "line2material3D/fx/material3D_mask_proj.fx" ),
		texture = nil,
		mask = nil,
        maskEnable = false,
		color = 1,
		texCoord = {Vector2(1, 1),Vector2(0, 0)},
		position = Vector3(0,0,0),
		rotation = Vector3(0,0,0),
		size = Vector2(0,0),
		billboard = false,
		zEnable = true,
		zWriteEnable = true,
		flipVertex = false,
		fogEnable = true,
		cullMode = 2
	}
	if cShader.shader then
		-- screen resolution also to scale image size and proportions to 1x1 world unit
		cShader.shader:setValue( "sScrRes", {scX, scY} )
		-- pass position and a forward vector to recreate gWorld matrix
		cShader.shader:setValue( "sElementRotation", 0, 0, 0 )
		cShader.shader:setValue( "sElementPosition", 0, 0, 0 )
		cShader.shader:setValue( "sElementSize", 1, 1 )
		cShader.shader:setValue( "sFlipTexture", false )
		cShader.shader:setValue( "sFlipVertex", cShader.flipVertex )
		cShader.shader:setValue( "sIsBillboard", cShader.billboard )
		cShader.shader:setValue( "uvMul", cShader.texCoord[1].x, cShader.texCoord[1].y )
		cShader.shader:setValue( "uvPos", cShader.texCoord[2].x, cShader.texCoord[2].y )
		cShader.shader:setValue( "sFogEnable", cShader.fogEnable )
		cShader.shader:setValue( "fZEnable", cShader.zEnable )
		cShader.shader:setValue( "fZWriteEnable", cShader.zWriteEnable )
		cShader.shader:setValue( "fCullMode", cShader.cullMode )
		cShader.shader:setValue( "fMaskEnable", cShader.maskEnable )
		self.__index = self
		setmetatable( cShader, self )
		return cShader
	else
		return false
	end
end

function CMat3DMaskProj: setTexture( texture )
	if self.shader then
		self.texture = texture
		self.shader:setValue( "sTexColor", texture )		
	end
end

function CMat3DMaskProj: setMaskTexture( maskTex )
	if self.shader then
		self.mask = maskTex 
		self.shader:setValue( "sTexMask", maskTex )		
	end
end

function CMat3DMaskProj: setMaskEnable( isEnabled )
	if self.shader then
		self.maskEnable = isEnabled 
		self.shader:setValue( "fMaskEnable", isEnabled )		
	end
end

function CMat3DMaskProj: setPosition( pos )
	if self.shader then
		self.position = pos
		self.shader:setValue( "sElementPosition", pos.x, pos.y, pos.z )
	end
end

function CMat3DMaskProj: setCullMode( cull )
	if self.shader then
		self.cullMode = cull
		self.shader:setValue( "fCullMode", cull )
	end
end

function CMat3DMaskProj: setZEnable( isEnabled )
	if self.shader then
		self.zEnable = isEnabled
		self.shader:setValue( "fZEnable", isEnabled )
	end
end

function CMat3DMaskProj: setZWriteEnable( isEnabled )
	if self.shader then
		self.zWriteEnable = isEnabled
		self.shader:setValue( "fZWriteEnable", isEnabled )
	end
end

function CMat3DMaskProj: setFogEnable( isEnabled )
	if self.shader then
		self.fogEnable = isEnabled
		self.shader:setValue( "fFogEnable", isEnabled )
	end
end

function CMat3DMaskProj: setFlipVertex( flip )
	if self.shader then
		self.flipVertex = flip
		self.shader:setValue( "sFlipVertex", flip )
	end
end

-- rotation order "ZXY"
function CMat3DMaskProj: setRotation( rot )
	if self.shader then
		self.rotation = rot
		self.shader:setValue( "sElementRotation", math.rad( rot.x ), math.rad( rot.y ), math.rad( rot.z ))
	end
end

function CMat3DMaskProj: setSize( siz )
	if self.shader then
		self.size = siz
		self.shader:setValue( "sElementSize", siz.x, siz.y )
	end
end

function CMat3DMaskProj: setTexCoord( uvMul, uvPos )
	if self.shader then
		self.texCoord = { uvMul, uvPos }		
		self.shader:setValue( "uvMul", uvMul.x, uvMul.y )
		self.shader:setValue( "uvPos", uvPos.x, uvPos.y )
	end
end

function CMat3DMaskProj: setBillboard( isBill )
	if self.shader then
		self.billboard = isBill
		self.shader:setValue( "sIsBillboard", isBill )
	end
end

function CMat3DMaskProj: setColor( col )
	if self.shader then
		self.color = col
	end
end

function CMat3DMaskProj: draw()
	if self.shader then
		-- draw the outcome
		dxDrawMaterialLine3D( 0 + self.position.x, 0 + self.position.y, self.position.z + 0.5, 0 + self.position.x, 0 + self.position.y, 
			self.position.z - 0.5, self.shader, 1, self.color, 0 + self.position.x,1 +  self.position.y,0 + self.position.z )	
	end
end
        
function CMat3DMaskProj: destroy()
	if self.shader then
		destroyElement( self.shader )
	end
	self = nil
end
