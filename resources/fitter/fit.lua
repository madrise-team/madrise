--outputChatBox("asdasd")					 --
					 --
engineReplaceModel (engineLoadDFF('ramka.dff', 1851), 1851)					 --
					 --
					 --
function rounderStr(ch,toS)					 --
	local feterte = toS or 5					 --
	return string.format("%."..tostring(feterte).."f", ch)					 --
end					 --
 					 --
function getMatrix(elm)					 --
	return Matrix(Vector3(getElementPosition(elm)),Vector3(getElementRotation(elm)))					 --
end					 --
					 --
function alter()					 --
	globaler = true					 --
	if getKeyState("lalt") then					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
					 --
clearBool = false					 --
function hangOn()					 --
	local col = createColCircle(2487.02783,-1665.55371, 45)					 --
	local lastPosX,lastPosY,lastPosZ					 --
	addEventHandler("onClientRender",root,function()					 --
		local x,y,z = getElementPosition(localPlayer)					 --
		if isInsideColShape(col, x,y,z) then					 --
			if not clearBool then 					 --
				triggerEvent("checkAvto",root)					 --
			end					 --
			clearBool = true					 --
			lastPosX,lastPosY,lastPosZ = getElementPosition(localPlayer)					 --
		else					 --
			if lastPosX and clearBool then					 --
				--setElementPosition(localPlayer,lastPosX,lastPosY,lastPosZ)					 --
				setElementInterior(localPlayer,0,lastPosX,lastPosY,lastPosZ)					 --
				setElementDimension(localPlayer,0)					 --
				local veh = getPedOccupiedVehicle(localPlayer)					 --
				if veh then					 --
					setElementInterior(veh,0,lastPosX,lastPosY,lastPosZ)					 --
					setElementDimension(veh,0)					 --
				end					 --
			end					 --
		end					 --
	end)					 --
end					 --
					 --
function contorl()					 --
	if getKeyState("lctrl") then					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
function shift()					 --
	if getKeyState("lshift") then					 --
		return true					 --
	else					 --
		return false					 --
	end					 --
end					 --
function pressed(state)					 --
	if state then 					 --
		return 1					 --
	else					 --
		return 0					 --
	end					 --
end					 --
					 --
					 --
function fitAvtoRamka()					 --
						 --
	local x = 0					 --
	local y = 0					 --
	local z = 0					 --
	local rx = 0					 --
	local ry = 0					 --
	local rz = 0					 --
	local ramker = createObject(1851, 10000, 10000, 10000, 0, 0, 0)					 --
					 --
	local xMod = 0					 --
	local yMod = 0					 --
	local zMod = 0					 --
	local rxMod = 0					 --
	local ryMod = 0					 --
	local rzMod = 0					 --
					 --
						 --
	local veher = getPedOccupiedVehicle(localPlayer)					 --
	if not veher or veher then					 --
		hangOn()					 --
		--outputChatBox("Вы не в машине Э")					 --
		return					 --
	end					 --
					 --
	if globaler then return end					 --
					 --
	local vx,vy,vz = getElementPosition(veher)					 --
	local vrx,vry,vrz = getElementRotation(veher)					 --
					 --
	local cordModder					 --
	local rotModder					 --
					 --
	local showVspomogat = true					 --
					 --
	addEventHandler("onClientRender",root,function()					 --
		vx,vy,vz = getElementPosition(veher)					 --
		vrx,vry,vrz = getElementRotation(veher)					 --
					 --
		cordModder = 40					 --
		rotModder = 1					 --
		altReversModder = 1					 --
		if shift() then 					 --
			cordModder = 10					 --
			rotModder = 10					 --
		end					 --
		if contorl() then 					 --
			cordModder = 500					 --
			rotModder = 0.1					 --
		end					 --
		if alter() then 					 --
			altReversModder = -1					 --
		end					 --
					 --
		xMod = pressed(getKeyState("num_1"))/cordModder*altReversModder					 --
		yMod = pressed(getKeyState("num_2"))/cordModder*altReversModder					 --
		zMod = pressed(getKeyState("num_3"))/cordModder*altReversModder					 --
		rxMod = pressed(getKeyState("num_7"))*rotModder*altReversModder					 --
		ryMod = pressed(getKeyState("num_8"))*rotModder*altReversModder					 --
		rzMod = pressed(getKeyState("num_9"))*rotModder*altReversModder					 --
					 --
		x = x + xMod					 --
		y = y + yMod					 --
		z = z + zMod					 --
					 --
		rx = rx + rxMod					 --
		ry = ry + ryMod					 --
		rz = rz + rzMod					 --
					 --
		attachElements(ramker, veher, x, y, z, rx, ry, rz)					 --
					 --
		dxDrawRectangle(190,290,250,116,tocolor(10,10,10,224))					 --
					 --
		dxDrawText("x: "..rounderStr(x).." y: "..rounderStr(y).." z: "..rounderStr(z),200,300)					 --
		dxDrawText("rx: "..rounderStr(rx).." ry: "..rounderStr(ry).." rz: "..rounderStr(rz),200,320)					 --
					 --
		dxDrawText("xMod: "..rounderStr(xMod,3).." yMod: "..rounderStr(yMod,3).." zMod: "..rounderStr(zMod,3),200,360)					 --
		dxDrawText("rxMod: "..rounderStr(rxMod,3).." ryMod: "..rounderStr(ryMod,3).." rzMod: "..rounderStr(rzMod,3),200,380)					 --
					 --
					 --
		local mat = Matrix(Vector3(vx,vy,vz),Vector3(vrx,vry,vrz))					 --
		local aPoint = mat.position + mat.right*x + mat.forward*y + mat.up*z					 --
					 --
		local sx,sy = getScreenFromWorldPosition(aPoint.x,aPoint.y,aPoint.z)					 --
		if sx and sy then					 --
			if showVspomogat then dxDrawRectangle ( sx - 3, sy - 3, 6, 6,tocolor(10,170,225,255),true,false)end					 --
		end					 --
	end)					 --
					 --
	bindKey("num_5","down",function()					 --
		showVspomogat = not showVspomogat					 --
	end)					 --
	bindKey("num_6","down",function()					 --
		outputChatBox("x: "..rounderStr(x).." y: "..rounderStr(y).." z: "..rounderStr(z))					 --
		outputChatBox("rx: "..rounderStr(rx).." ry: "..rounderStr(ry).." rz: "..rounderStr(rz))					 --
	end)					 --
					 --
	addCommandHandler("set",function(_,wat,val)					 --
		val = tonumber(val)					 --
		if type(val) == "number" then					 --
			local change = true					 --
			if wat == "x" then					 --
				x = val					 --
			elseif wat == "y" then					 --
				y = val					 --
			elseif wat == "z" then					 --
				z = val					 --
			elseif wat == "rx" then					 --
				rx = val					 --
			elseif wat == "ry" then					 --
				ry = val					 --
			elseif wat == "rz" then					 --
				rz = val					 --
			else					 --
				change = false					 --
			end					 --
					 --
			if change then					 --
				outputChatBox("Значение "..wat.." обновлено на "..val)					 --
			else					 --
				outputChatBox("Ошибка при popIt-ке изменить значение")					 --
			end					 --
		end					 --
	end)					 --
					 --
end					 --
alter()					 --
fitAvtoRamka()					 --
addCommandHandler("fitRamka",fitAvtoRamka,false)					 --
