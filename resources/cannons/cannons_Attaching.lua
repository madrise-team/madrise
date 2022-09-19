loadstring(exports.importer:load())()
import('RRL_Scripts/usfulC.lua')()    -- Usful C



custWepModel = 1248
--------------
wepAdding = 23
-- 23 [ silnsed ] 
-- 29 [ mp5     ]
-- 30 [ ak-47   ]
--------------
targBone = 25


addCommandHandler("wepoAttach",function()
	local x,y,z = getElementPosition(localPlayer)
	x = x + 1

	local pederMan = createPed(0, x, y, z,1)
	local aimWep = true
	givePedWeapon(pederMan, wepAdding,3000000000,true)
	local mat = Matrix(getElementPosition(pederMan),getElementRotation(pederMan))
	local aimP = mat.position + mat.forward*100
	setPedAimTarget (pederMan,aimP.x,aimP.y,aimP.z)
	setPedControlState(pederMan,"aim_weapon",aimWep)

	local custWep = createObject(custWepModel, x, y, z)
	setElementCollisionsEnabled(custWep,false)
	attachElementToBone(custWep, pederMan, targBone, 0, 0, 0, 0, 0, 0)	




	local offsetsX = 0
	local offsetsY = 0
	local offsetsZ = 0

	local offsetsRX = 0
	local offsetsRY = 0
	local offsetsRZ = 0

	local lalter = false
	local lcrtler = false
	local lshifter = false

	local ralter = false

	local x_offM = false
	local y_offM = false
	local z_offM = false
	 local rx_offM = false
	 local ry_offM = false
	 local rz_offM = false 



	rotatorRT = dxCreateRenderTarget(260,200,true)
	outputChatBox(tostring(rotatorRT))
	function drawRotator(fulls)
	 	dxSetRenderTarget(rotatorRT,true)

	 	local colocor = tocolor(255,255,255,150)
	 	if fulls then
	 		colocor = tocolor(20,225,60,150)
	 	end
	 	dxDrawImage(30,(200-190)/2,200,190,"deb/Rotator.png",0,0,0,colocor)

	 	dxSetRenderTarget()
	end

	addEventHandler("onClientRender",root,function()
	 	--dxDrawText("-"..textr,0,235,100,100,colocorT)
	 	--dxDrawText(textr,670,235,100,100,colocorT)

		x,y,z = getElementPosition(pederMan)

		local modify = 0.002
		if lcrtler then modify = 0.01 end
		if lshifter then modify = 0.05 end
		
		if lalter then modify = modify*-1 end

		if x_offM then offsetsX = offsetsX + modify end
		if y_offM then offsetsY = offsetsY + modify end
		if z_offM then offsetsZ = offsetsZ + modify end
		if rx_offM then offsetsRX = offsetsRX + modify end
		if ry_offM then offsetsRY = offsetsRY + modify end
		if rz_offM then offsetsRZ = offsetsRZ + modify end

		if x_offM and ralter then offsetsX = 0 end
		if y_offM and ralter then offsetsY = 0 end
		if z_offM and ralter then offsetsZ = 0 end
		if rx_offM and ralter then offsetsRX = 0 end
		if ry_offM and ralter then offsetsRY = 0 end
		if rz_offM and ralter then offsetsRZ = 0 end



		--[[dxDrawText("lalt : "..tostring(lalter),400,350 + 13*0.5)
		dxDrawText("lctrl : "..tostring(lcrtler),400,350 + 13*2)
		dxDrawText("lshift : "..tostring(lshifter),400,350 + 13*3)


		
		dxDrawText("x_offM : "..tostring(x_offM),400,400 + 13*1)
		dxDrawText("y_offM : "..tostring(y_offM),400,400 + 13*2)
		dxDrawText("z_offM : "..tostring(z_offM),400,400 + 13*3)
		dxDrawText("rx_offM : "..tostring(rx_offM),400,400 + 13*4)
		dxDrawText("ry_offM : "..tostring(ry_offM),400,400 + 13*5)
		dxDrawText("rz_offM : "..tostring(rz_offM),400,400 + 13*6)
		]]--0



		removeElementFromBone(custWep)
		attachElementToBone(custWep, pederMan, targBone, offsetsX, offsetsY, offsetsZ, offsetsRX, offsetsRY, offsetsRZ)
		setPedControlState(pederMan,"crouch",false)

		local sx,sy = getScreenFromWorldPosition(x,y,z+1)
		if sx then
			local aix = sx - 25
			local aiy = sy
			local coclocol = tocolor(100,100,100,50)
			local coclocol2 = tocolor(150,160,120,255)
			if aimWep then
				coclocol = tocolor(110,255,180,255)
				coclocol2 = tocolor(0,0,0,255)
			end
			dxDrawRectangle(aix-5,aiy-2,28,20,coclocol)
			dxDrawText("Aim",aix,aiy,100,100,coclocol2)




			local crx = sx + 15
			local cry = sy
			local coclocol = tocolor(100,100,100,50)
			local coclocol2 = tocolor(150,160,120,255)
			if isPedDucked(pederMan) then
				coclocol = tocolor(110,255,180,255)
				coclocol2 = tocolor(0,0,0,255)
			end
			dxDrawRectangle(crx-5,cry-2,30,20,coclocol)
			dxDrawText("Crch",crx,cry,100,100,coclocol2)
		end
	end)
	bindKey("z","down",function()
		aimWep = not aimWep
		setPedControlState(pederMan,"aim_weapon",aimWep)
	end)
	bindKey("x","down",function()
		setPedControlState(pederMan,"crouch",true)
	end)



	bindKey("lalt","both",function(_,state)
		lalter = state == "down"
	end)
	bindKey("ralt","both",function(_,state)
		ralter = state == "down"
	end)

	bindKey("lctrl","both",function(_,state)
		lcrtler = state == "down"
	end)
	bindKey("lshift","both",function(_,state)
		lshifter = state == "down"
	end)

	bindKey("num_7","both",function(_,state)
		x_offM = state == "down"
	end)
	bindKey("num_8","both",function(_,state)
		y_offM = state == "down"
		outputChatBox(tostring(x_offM))
	end)
	bindKey("num_9","both",function(_,state)
		z_offM = state == "down"
	end)
	bindKey("num_4","both",function(_,state)
		rx_offM = state == "down"
	end)
	bindKey("num_5","both",function(_,state)
		ry_offM = state == "down"
	end)
	bindKey("num_6","both",function(_,state)
		rz_offM = state == "down"
	end)


	bindKey("num_3","both",function(_,state)
		outputConsole(" ")
		outputConsole("offsets = {")
		outputConsole(" x = "..offsetsX..", y = "..offsetsY..", z = "..offsetsZ..",")
		outputConsole(" rx = "..offsetsRX..", ry = "..offsetsRY..", rz = "..offsetsRZ)
		outputConsole("}")
		outputConsole(" ")
	end)
end)


--[[

simpleIdle
aim = crouch
crouchAim

--- tazer
	-- aim
	offsets = {
 		x = 0.006, y = 0.018, z = 0.046,
 		rx = -0.238, ry = -0.11, rz = -0.624
	}



]]