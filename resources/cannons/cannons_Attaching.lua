loadstring(exports.importer:load())()					 --
					 --
--wepAttach -- - -<					 --
					 --
---  idle == crouch & aim    = idle					 --
---  aim == courch   		 = aim					 --
					 --
custWepModel = 1248					 --
--------------					 --
wepAdding = 23					 --
-- 23 [ silnsed ] 					 --
-- 29 [ mp5     ]					 --
-- 30 [ ak-47   ]					 --
--------------					 --
targBone = 24					 --
					 --
					 --
addCommandHandler("wepAttach",function()					 --
	local x,y,z = getElementPosition(localPlayer)					 --
	x = x + 1					 --
					 --
	local pederMan = createPed(0, x, y, z,1)					 --
	setElementFrozen(pederMan,true)					 --
	local aimWep = true					 --
	givePedWeapon(pederMan, wepAdding,3000000000,true)					 --
	local mat = Matrix(getElementPosition(pederMan),getElementRotation(pederMan))					 --
	local aimP = mat.position + mat.forward*2					 --
	setPedAimTarget (pederMan,aimP.x,aimP.y,aimP.z)					 --
	setPedControlState(pederMan,"aim_weapon",aimWep)					 --
					 --
	local custWep = createObject(custWepModel, x, y, z)					 --
	setElementCollisionsEnabled(custWep,false)					 --
	attachElementToBone(custWep, pederMan, targBone, 0, 0, 0, 0, 0, 0)						 --
					 --
					 --
	local startOffsets = {					 --
 		x = 0.088, y = 0.018, z = 0.05,					 --
 		rx = -0.224, ry = 0.054, rz = 0.09					 --
	}					 --
					 --
					 --
	local offsetsX = startOffsets.x or 0					 --
	local offsetsY = startOffsets.y or 0					 --
	local offsetsZ = startOffsets.z or 0					 --
					 --
	local offsetsRX = startOffsets.rx or 0					 --
	local offsetsRY = startOffsets.ry or 0					 --
	local offsetsRZ = startOffsets.rz or 0					 --
					 --
	local lalter = false					 --
	local lcrtler = false					 --
	local lshifter = false					 --
					 --
	local ralter = false					 --
					 --
	local x_offM = false					 --
	local y_offM = false					 --
	local z_offM = false					 --
	 local rx_offM = false					 --
	 local ry_offM = false					 --
	 local rz_offM = false 					 --
					 --
					 --
	 local pointer = {forward = 0,right = 0,up = 0, enbled = false}					 --
					 --
	 local pointerStart = {					 --
		 forward = 0,right = 0,up = 0					 --
		}					 --
	local drawMat = false					 --
					 --
	rotatorRT = dxCreateRenderTarget(260,200,true)					 --
	function drawRotator(fulls)					 --
	 	dxSetRenderTarget(rotatorRT,true)					 --
					 --
	 	local colocor = tocolor(255,255,255,150)					 --
	 	if fulls then					 --
	 		colocor = tocolor(20,225,60,150)					 --
	 	end					 --
	 	dxDrawImage(30,(200-190)/2,200,190,"deb/Rotator.png",0,0,0,colocor)					 --
					 --
	 	dxSetRenderTarget()					 --
	end					 --
	local wTexer = dxCreateTexture(":Draws/win/winTest.png")					 --
					 --
	addEventHandler("onClientRender",root,function()					 --
	 	--dxDrawText("-"..textr,0,235,100,100,colocorT)					 --
	 	--dxDrawText(textr,670,235,100,100,colocorT)					 --
					 --
		x,y,z = getElementPosition(pederMan)					 --
					 --
		local modify = 0.001					 --
		if lcrtler then modify = 0.01 end					 --
		if lshifter then modify = 0.05 end					 --
							 --
		if lalter then modify = modify*-1 end					 --
					 --
							 --
		if not pointer.enabled then					 --
			if x_offM then offsetsX = offsetsX + modify end					 --
			if y_offM then offsetsY = offsetsY + modify end					 --
			if z_offM then offsetsZ = offsetsZ + modify end					 --
			if rx_offM then offsetsRX = offsetsRX + modify end					 --
			if ry_offM then offsetsRY = offsetsRY + modify end					 --
			if rz_offM then offsetsRZ = offsetsRZ + modify end					 --
					 --
			if x_offM and ralter then offsetsX = startOffsets.x or 0 end					 --
			if y_offM and ralter then offsetsY = startOffsets.y or 0 end					 --
			if z_offM and ralter then offsetsZ = startOffsets.z or 0 end					 --
			if rx_offM and ralter then offsetsRX = startOffsets.rx or 0 end					 --
			if ry_offM and ralter then offsetsRY = startOffsets.ry or 0 end					 --
			if rz_offM and ralter then offsetsRZ = startOffsets.rz or 0 end					 --
		else					 --
			if x_offM then pointer.forward = pointer.forward + modify end					 --
			if y_offM then pointer.right = pointer.right + modify end					 --
			if z_offM then pointer.up = pointer.up + modify end					 --
					 --
			if x_offM and ralter then pointer.forward = pointerStart.forward end					 --
			if y_offM and ralter then pointer.right = pointerStart.right end					 --
			if z_offM and ralter then pointer.up = pointerStart.up end					 --
		end					 --
					 --
					 --
		--[[dxDrawText("lalt : "..tostring(lalter),400,350 + 13*0.5)					 --
		dxDrawText("lctrl : "..tostring(lcrtler),400,350 + 13*2)					 --
		dxDrawText("lshift : "..tostring(lshifter),400,350 + 13*3)					 --
							 --
		dxDrawText("x_offM : "..tostring(x_offM),400,400 + 13*1)					 --
		dxDrawText("y_offM : "..tostring(y_offM),400,400 + 13*2)					 --
		dxDrawText("z_offM : "..tostring(z_offM),400,400 + 13*3)					 --
		dxDrawText("rx_offM : "..tostring(rx_offM),400,400 + 13*4)					 --
		dxDrawText("ry_offM : "..tostring(ry_offM),400,400 + 13*5)					 --
		dxDrawText("rz_offM : "..tostring(rz_offM),400,400 + 13*6)					 --
		]]--0					 --
					 --
					 --
		removeElementFromBone(custWep)					 --
		attachElementToBone(custWep, pederMan, targBone, offsetsX, offsetsY, offsetsZ, offsetsRX, offsetsRY, offsetsRZ)					 --
		setPedControlState(pederMan,"crouch",false)					 --
					 --
					 --
		local gx,gy,gz = getElementPosition(custWep)					 --
		local grx,gry,grz = getElementRotation(custWep)					 --
		local gMat = Matrix(gx,gy,gz, grx,gry,grz)					 --
					 --
		if pointer.enabled then					 --
			local poser = gMat.position + gMat.forward*pointer.forward + gMat.right*pointer.right + gMat.up*pointer.up					 --
								 --
			if pointer.mode then					 --
				poser = getPositionFromElementOffset(custWep,pointer.forward,pointer.right,pointer.up)					 --
			end					 --
					 --
					 --
			dxDrawMaterialLine3D(poser.x - 0.003,poser.y,poser.z,poser.x + 0.003,poser.y,poser.z,wTexer,0.003,tocolor(255,255,255,15),true)					 --
			dxDrawMaterialLine3D(poser.x,poser.y - 0.003,poser.z,poser.x,poser.y + 0.003,poser.z,wTexer,0.003,tocolor(255,255,255,15),true)					 --
			dxDrawMaterialLine3D(poser.x - 0.003,poser.y,poser.z,poser.x + 0.003,poser.y,poser.z,wTexer,0.003,tocolor(255,255,255,255))					 --
			dxDrawMaterialLine3D(poser.x,poser.y - 0.003,poser.z,poser.x,poser.y + 0.003,poser.z,wTexer,0.003,tocolor(255,255,255,255))					 --
		end					 --
					 --
		if drawMat then					 --
			local p = gMat.position					 --
			local f = gMat.position + gMat.forward					 --
			local r = gMat.position + gMat.right					 --
			local u = gMat.position + gMat.up					 --
					 --
			if pointer.mode then					 --
				f = getPositionFromElementOffset(custWep,1,0,0)					 --
				r = getPositionFromElementOffset(custWep,0,1,0)					 --
				u = getPositionFromElementOffset(custWep,0,0,1)					 --
			end					 --
					 --
			dxDrawMaterialLine3D(p.x,p.y,p.z,f.x,f.y,f.z,wTexer,0.01,tocolor(255,150,150,100),true)					 --
			dxDrawMaterialLine3D(p.x,p.y,p.z,r.x,r.y,r.z,wTexer,0.01,tocolor(150,255,150,100),true)					 --
			dxDrawMaterialLine3D(p.x,p.y,p.z,u.x,u.y,u.z,wTexer,0.01,tocolor(150,150,255,100),true)					 --
					 --
			local sx,sy = getScreenFromWorldPosition(f.x,f.y,f.z)					 --
			if sx then dxDrawText("f",sx,sy) end					 --
			local sx,sy = getScreenFromWorldPosition(r.x,r.y,r.z)					 --
			if sx then dxDrawText("r",sx,sy) end					 --
			local sx,sy = getScreenFromWorldPosition(u.x,u.y,u.z)					 --
			if sx then dxDrawText("u",sx,sy) end					 --
					 --
					 --
					 --
		end					 --
					 --
					 --
		local sx,sy = getScreenFromWorldPosition(x,y,z+1)					 --
		if sx then					 --
			sx = sx - 50					 --
			local aix = sx - 25					 --
			local aiy = sy					 --
			local coclocol = tocolor(100,100,100,50)					 --
			local coclocol2 = tocolor(150,160,120,255)					 --
			if isPedAiming(pederMan) then					 --
				coclocol = tocolor(110,255,180,255)					 --
				coclocol2 = tocolor(0,0,0,255)					 --
			end					 --
			dxDrawRectangle(aix-5,aiy-2,28,20,coclocol)					 --
			dxDrawText("Aim",aix,aiy,100,100,coclocol2)					 --
					 --
			local crx = sx + 15					 --
			local cry = sy					 --
			local coclocol = tocolor(100,100,100,50)					 --
			local coclocol2 = tocolor(150,160,120,255)					 --
			if isPedDucked(pederMan) then					 --
				coclocol = tocolor(110,255,180,255)					 --
				coclocol2 = tocolor(0,0,0,255)					 --
			end					 --
			dxDrawRectangle(crx-5,cry-2,30,20,coclocol)					 --
			dxDrawText("Crch",crx,cry,100,100,coclocol2)					 --
					 --
			local frx = sx + 55					 --
			local fry = sy					 --
			local coclocol = tocolor(100,100,100,50)					 --
			local coclocol2 = tocolor(150,160,120,255)					 --
			if getPedControlState(pederMan,"forwards") then					 --
				coclocol = tocolor(110,255,180,255)					 --
				coclocol2 = tocolor(0,0,0,255)					 --
			end					 --
			dxDrawRectangle(frx-5,fry-2,30,20,coclocol)					 --
			dxDrawText("Frw",frx,fry,100,100,coclocol2)					 --
					 --
					 --
			if pointer.enabled then					 --
				local colo = tocolor(150,125,200,225)					 --
				local nametagPointeerModa = "Pointer"					 --
					 --
				dxDrawRectangle(sx-30,sy-27,110,20,colo)					 --
				dxDrawText(nametagPointeerModa,sx-25,sy-25,100,100,tocolor(255,255,255,255))					 --
			end					 --
					 --
			if pointer.mode then					 --
				dxDrawRectangle(sx-30,sy-47,110,20,tocolor(200,125,112,225))					 --
				dxDrawText("matrix2 mode",sx-25,sy-45,100,100,tocolor(255,255,255,255))					 --
			end					 --
					 --
		end					 --
	end)					 --
	bindKey("z","down",function()					 --
		aimWep = not aimWep					 --
		setPedControlState(pederMan,"aim_weapon",aimWep)					 --
	end)					 --
	bindKey("x","down",function()					 --
		setPedControlState(pederMan,"crouch",true)					 --
	end)					 --
	bindKey("1","down",function(_,state)					 --
		local forw = getPedControlState(pederMan,"forwards")					 --
		setPedControlState(pederMan,"forwards", not forw)					 --
	end)					 --
					 --
					 --
	bindKey("lalt","both",function(_,state)					 --
		lalter = state == "down"					 --
	end)					 --
	bindKey("ralt","both",function(_,state)					 --
		ralter = state == "down"					 --
	end)					 --
					 --
	bindKey("lctrl","both",function(_,state)					 --
		lcrtler = state == "down"					 --
	end)					 --
	bindKey("lshift","both",function(_,state)					 --
		lshifter = state == "down"					 --
	end)					 --
					 --
	bindKey("num_7","both",function(_,state)					 --
		x_offM = state == "down"					 --
	end)					 --
	bindKey("num_8","both",function(_,state)					 --
		y_offM = state == "down"					 --
		outputChatBox(tostring(x_offM))					 --
	end)					 --
	bindKey("num_9","both",function(_,state)					 --
		z_offM = state == "down"					 --
	end)					 --
	bindKey("num_4","both",function(_,state)					 --
		rx_offM = state == "down"					 --
	end)					 --
	bindKey("num_5","both",function(_,state)					 --
		ry_offM = state == "down"					 --
	end)					 --
	bindKey("num_6","both",function(_,state)					 --
		rz_offM = state == "down"					 --
	end)					 --
					 --
	local rent = function()					 --
		dxDrawRectangle(200,200,20,20)					 --
							 --
	end					 --
	bindKey("num_2","both",function(_,state)					 --
		setPedControlState(pederMan,"fire",state == "down")					 --
	end)					 --
					 --
	bindKey("0","up",function(_,state)					 --
		pointer.enabled = not pointer.enabled					 --
	end)					 --
	bindKey("9","up",function(_,state)					 --
		if pointer.mode ~= "matrix2" then					 --
			pointer.mode = "matrix2"					 --
		else					 --
			pointer.mode = nil					 --
		end					 --
	end)					 --
					 --
					 --
	bindKey("8","up",function(_,state)					 --
		drawMat = not drawMat							 --
	end)					 --
					 --
					 --
					 --
					 --
					 --
	bindKey("num_3","up",function(_,state)					 --
		outputConsole(" ")					 --
		outputConsole("offset = {")					 --
		outputConsole(" x = "..offsetsX..", y = "..offsetsY..", z = "..offsetsZ..",")					 --
		outputConsole(" rx = "..offsetsRX..", ry = "..offsetsRY..", rz = "..offsetsRZ)					 --
		outputConsole("}")					 --
		outputConsole(" ")					 --
					 --
		local modeComment = ""					 --
		if pointer.mode then					 --
			modeComment = "                     -- matrix2"					 --
		end					 --
					 --
		outputConsole("point = {")					 --
		outputConsole(" forward = "..pointer.forward..", right = "..pointer.right..", up = "..pointer.up..modeComment)					 --
		outputConsole("}")					 --
		outputConsole(" ")					 --
					 --
	end)					 --
end)					 --
