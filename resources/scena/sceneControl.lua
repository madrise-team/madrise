function getVectorLen(vec)					 --
	return math.sqrt(vec.x^2 + vec.y^2 + vec.z^2)					 --
end					 --
					 --
					 --
addEvent("pedsSync",true)					 --
					 --
pedVidelkaTex = dxCreateRenderTarget(100,100,true)					 --
scenaEnabled = false					 --
addCommandHandler("scena",function()					 --
	scenaEnabled = true					 --
					 --
	Peds = {}					 --
	addEvent("yourCreatedPed",true)					 --
	addEventHandler("yourCreatedPed",root,function(ped)					 --
		Peds[#Peds + 1] = {ped = ped,selected = true,group = 1}					 --
		if selection == 0 then selection = 1 end					 --
	end)					 --
					 --
					 --
					 --
	function createPedVidelka()					 --
		dxSetRenderTarget(pedVidelkaTex,true)					 --
		local modeSave = dxGetBlendMode()					 --
		dxSetBlendMode("overwrite")					 --
		dxDrawRectangle(0,0,100,100,tocolor(200,200,200,235))					 --
		dxDrawRectangle(4,4,92,92,tocolor(40,40,40,235))					 --
		dxDrawRectangle(10,10,80,80,tocolor(0,0,0,0))					 --
		dxSetBlendMode(modeSave)					 --
		dxSetRenderTarget()					 --
	end					 --
					 --
	function applyToAllPeds(funct,selectedOnly,inverseSelection)					 --
		local isSelectedBool = true					 --
		if inverseSelection then 					 --
			isSelectedBool = false					 --
		end					 --
					 --
		for k,p in pairs(Peds) do					 --
			if (selectedOnly and (p.selected==isSelectedBool)) or (selectedOnly ~= true) then					 --
				funct(p,k)					 --
			end					 --
		end					 --
	end					 --
	function getSelectedPeds()					 --
		local sP = {}					 --
		for k,v in pairs(Peds) do					 --
			if v.selected then					 --
				sP[#sP + 1] = v					 --
			end					 --
		end					 --
		return sP					 --
	end					 --
					 --
	colors = {	tocolor(40,40,40,255),					 --
					tocolor(0,80,120,255),					 --
					tocolor(255,160,0,255),					 --
					tocolor(40,160,52,255),					 --
					tocolor(240,240,80,255),					 --
					tocolor(160,0,140,255),					 --
					tocolor(160,255,0,255),					 --
					tocolor(120,200,20,255),					 --
					tocolor(240,240,220,255),					 --
					tocolor(255,200,40,255)}					 --
					 --
					 --
	selection = 0					 --
					 --
	screenWid,screenHeh = guiGetScreenSize()					 --
	lshifterKey = false					 --
	laltKey = false					 --
					 --
	targetPosX = 0					 --
	targetPosY = 0					 --
	targetPosZ = 0					 --
					 --
	hitX = 0					 --
	hitY = 0					 --
	hitZ = 0					 --
	hitElement = nil					 --
					 --
					 --
	addEventHandler("onClientRender",root,function()					 --
		createPedVidelka()					 --
		if getKeyState("lshift") then					 --
			lshifterKey = true					 --
		else					 --
			lshifterKey = false					 --
		end					 --
		if getKeyState("lalt") then					 --
			laltKey = true					 --
		else					 --
			laltKey = false					 --
		end					 --
					 --
					 --
					 --
					 --
					 --
		local cX,cY,cZ = getWorldFromScreenPosition(screenWid/2,screenHeh/2,0.01)					 --
		local clX,clY,clZ = getWorldFromScreenPosition(screenWid/2,screenHeh/2.7,200)						 --
		local hit, hitcX, hitcY, hitcZ, hitedElement = processLineOfSight ( cX, cY, cZ, 					 --
	                                       									clX,	clY,	clZ, 					 --
	                                       									true,true,true,true,true)					 --
		hitX = hitcX					 --
		hitY = hitcY					 --
		hitZ = hitcZ					 --
					 --
		hitElement = nil					 --
		if hitedElement then					 --
			hitElement = hitedElement					 --
		end					 --
					 --
					 --
					 --
		dxDrawRectangle(screenWid/2-1,screenHeh/2.7-1,2,2)					 --
		dxDrawRectangle(screenWid - 300 - 15,screenHeh - 200 - 15,500,500,tocolor(200,200,200,150))					 --
		dxDrawRectangle(screenWid - 370 ,screenHeh - 200 - 15,55,500,tocolor(10,10,10,150))					 --
					 --
		local numI = 0					 --
		local MaxSelX = (18-1)*(10 + 8)					 --
		applyToAllPeds(function(pedT)					 --
			numI = numI + 1					 --
			local pedX,pedY,pedZ = getElementPosition(pedT.ped)					 --
			local sx,sy = getScreenFromWorldPosition(pedX,pedY,pedZ + 0.4)					 --
			if sx and sy then 					 --
				sx = sx - 4					 --
				sy = sy - 4					 --
				dxDrawRectangle(sx-1,sy-1,10,10,tocolor(255,255,255,55))					 --
				dxDrawRectangle(sx,sy,8,8,colors[pedT.group])					 --
				dxDrawText(numI,sx,sy - 17)					 --
			end					 --
					 --
			local smeserDrawer = math.floor(numI/18)					 --
			local selY = screenHeh - 200 + (44*smeserDrawer)					 --
					 --
			local selX = (screenWid - 300) + (numI-1)*(10 + 8) - MaxSelX*smeserDrawer					 --
					 --
			dxDrawRectangle(selX,selY,10,10,colors[pedT.group])					 --
			dxDrawText(numI,selX-2,selY - 17)					 --
			if pedT.selected then 					 --
				dxDrawImage(selX - 3,selY - 3,16,16,pedVidelkaTex,0,0,0,tocolor(20,20,20,255)) 					 --
				dxDrawImage(selX - 2,selY - 2,14,14,pedVidelkaTex)					 --
			end					 --
		end)					 --
		local selX = (screenWid - 300) + (selection-1)*(10 + 8)					 --
		local selY = screenHeh - 200					 --
		if selection ~= 0 then dxDrawText("^",selX-2,selY + 12,nil,nl,tocolor(20,20,20,255),1.5) end					 --
					 --
					 --
		if hit then 					 --
			if hitElement then					 --
				if (getElementType(hitElement) == "vehicle") and (not mouse2pressed) then					 --
					if mKey2 then targetElement = hitElement end					 --
				elseif (getElementType(hitElement) == "ped") and (not mouse2pressed) then					 --
					if mKey2 then targetElement = hitElement end										 --
				elseif (getElementType(hitElement) == "player") and (not mouse2pressed) then					 --
					if mKey2 then targetElement = hitElement end					 --
				else					 --
					hitElement = false					 --
				end					 --
			end					 --
					 --
					 --
			if mKey2 then					 --
				if not hitElement then					 --
					mouse2pressed = true					 --
					 --
					targetPosX = hitX					 --
					targetPosY = hitY					 --
					targetPosZ = hitZ					 --
					 --
					targetElement = nil					 --
				end					 --
			else					 --
				mouse2pressed = false					 --
			end					 --
		end					 --
					 --
		if targetElement then					 --
			local tx,ty,tz = getElementPosition(targetElement)					 --
					 --
			targetPosX = tx					 --
			targetPosY = ty					 --
			targetPosZ = tz					 --
		end					 --
					 --
		local ftx,fty,ftz = getCameraMatrix()					 --
		if not targetElement then dxDrawMaterialLine3D(targetPosX - 0.01, targetPosY - 0.01, targetPosZ - 0.1, targetPosX + 0.01, targetPosY + 0.01, targetPosZ + 0.1, false, pedVidelkaTex, 0.19, tocolor(0,255,255,255),true,ftx,fty,ftz)					 --
		elseif getElementType(targetElement) == "vehicle" then					 --
			local tx,ty,tz = getElementPosition(targetElement)					 --
			dxDrawMaterialLine3D(tx, ty, tz + 0.3, tx, ty, tz + 0.6, false, pedVidelkaTex, 0.3, tocolor(0,255,0,255),true,ftx,fty,ftz)					 --
		elseif getElementType(targetElement) == "ped" then					 --
			local tx,ty,tz = getElementPosition(targetElement)					 --
			dxDrawMaterialLine3D(tx, ty, tz + 0.35, tx, ty, tz + 0.45, false, pedVidelkaTex, 0.1, tocolor(255,255,0,255),true,ftx,fty,ftz)					 --
		elseif getElementType(targetElement) == "player" then					 --
			local tx,ty,tz = getElementPosition(targetElement)					 --
			dxDrawMaterialLine3D(tx, ty, tz + 0.3, tx, ty, tz + 0.45, false, pedVidelkaTex, 0.15, tocolor(245,80,80,255),true,ftx,fty,ftz)					 --
		end					 --
					 --
					 --
	end)					 --
					 --
	bindKey("mouse2","down",function()					 --
		mKey2 = true					 --
	end)					 --
	bindKey("mouse2","up",function()					 --
		mKey2 = false					 --
	end)					 --
	bindKey("z","down",function()					 --
		mKey2 = true					 --
	end)					 --
	bindKey("z","up",function()					 --
		mKey2 = false					 --
	end)					 --
					 --
					 --
					 --
	mouse2pressed = false					 --
					 --
	function lockSelection()					 --
		if selection < 1 then					 --
			selection = #Peds					 --
		end					 --
		if selection > #Peds then					 --
			selection = 1					 --
		end					 --
		if #Peds == 0 then					 --
			selection = 0					 --
		end					 --
	end					 --
					 --
	bindKey("num_6","down",function()					 --
		if laltKey then return end					 --
		selection = selection + 1					 --
		lockSelection()					 --
	end)					 --
	bindKey("num_4","down",function()					 --
		if laltKey then return end					 --
		selection = selection - 1					 --
		lockSelection()					 --
	end)					 --
	bindKey("num_5","down",function()					 --
		Peds[selection].selected = not Peds[selection].selected					 --
	end)					 --
					 --
					 --
					 --
					 --
	bindKey("num_7","down",function()					 --
		if laltKey then					 --
			applyToAllPeds(function(pedT)					 --
				pedT.lookTarget = {targetPosX, targetPosY, targetPosZ,0}					 --
				syncPeds()					 --
				setPedLookAtLookTarget(pedT)					 --
			end,true)					 --
		else					 --
			applyToAllPeds(function(pedT)					 --
				pedT.lookTarget = {targetPosX, targetPosY, targetPosZ,pedsLookTimer}					 --
				syncPeds()					 --
				setPedLookAtLookTarget(pedT)					 --
			end,true)					 --
		end					 --
	end)					 --
	local waiter = 0					 --
	local lshit = false					 --
	bindKey("num_8","down",function()					 --
		if lshifterKey then					 --
			lshit = true					 --
		end					 --
		if laltKey then					 --
			applyToAllPeds(function(pedT)					 --
				setPedControlState(pedT.ped,"forwards",false)					 --
				pedT.moveTarget = nil					 --
				pedT.marshrut = nil					 --
			end,true)					 --
		else					 --
			local dist = (#getSelectedPeds() + 2)/2					 --
			if dist > 5 then dist = 5 end					 --
			applyToAllPeds(function(pedT)					 --
				waiter = waiter + math.random(30,80)/100					 --
				setTimer(function()					 --
					setPedGoingToTarget(pedT,dist,lshit)					 --
					waiter = 0					 --
					lshit = false					 --
				end,60 + waiter*400,1)					 --
			end,true)					 --
		end					 --
	end)					 --
					 --
	bindKey("n","down",function()					 --
		applyToAllPeds(function(pedT)					 --
			setPedControlState(pedT.ped,"crouch",true)					 --
			if laltKey then					 --
				pedT.crouchingOff = 5					 --
			end					 --
		end,true)					 --
		syncPeds()					 --
	end)					 --
	bindKey("g","down",function()					 --
		applyToAllPeds(function(pedT)					 --
			if lshifterKey then					 --
				setPedControlState(pedT.ped,"sprint",not getPedControlState(pedT.ped,"sprint"))					 --
			else					 --
				setPedControlState(pedT.ped,"walk",not getPedControlState(pedT.ped,"walk"))					 --
			end					 --
								 --
			if laltKey then					 --
				setPedControlState(pedT.ped,"sprint",false)					 --
				setPedControlState(pedT.ped,"walk",false)					 --
			end					 --
		end,true)					 --
		syncPeds()					 --
	end)					 --
					 --
	for key=1,9 do					 --
		local i = key					 --
		bindKey(i,"down",function()					 --
			if lshifterKey then					 --
				applyToAllPeds(function(pedT)					 --
					pedT.group = key					 --
				end,true)					 --
					 --
			elseif laltKey then					 --
				applyToAllPeds(function(pedT)					 --
					pedT.selected = false					 --
				end)					 --
			else					 --
				applyToAllPeds(function(pedT)					 --
					pedT.selected = (pedT.group == i)					 --
				end)					 --
			end					 --
		end)					 --
	end					 --
	bindKey("m","down",function()					 --
		if laltKey then					 --
			applyToAllPeds(function(pedT)					 --
				pedT.selected = false					 --
			end)					 --
		else					 --
			applyToAllPeds(function(pedT)					 --
				pedT.selected = true					 --
			end)					 --
		end					 --
	end)					 --
					 --
	pedsLookTimer = 10000					 --
					 --
					 --
	function toGrad(num)					 --
		return num*180/math.pi					 --
	end					 --
	function getZAngleFromControllerToTarget(pedT,targetT)					 --
		target = targetT					 --
		if not target then					 --
			target = {targetPosX,targetPosY,targetPosZ}					 --
		end					 --
					 --
		local elm					 --
		if type(pedT) ~= "table" then					 --
			elm = pedT					 --
		else					 --
			elm = pedT.ped					 --
		end					 --
		local posX,posY,posZ = getElementPosition(elm)					 --
		return toGrad(math.atan2(posX - target[1],posY - target[2]))					 --
	end					 --
					 --
					 --
	function setPedRotateToTarget(pedT)					 --
		local pedPosX,pedPosY,pedPosZ = getElementPosition(pedT.ped)					 --
		if getDistanceBetweenPoints3D(targetPosX,targetPosY,targetPosZ,pedPosX,pedPosY,pedPosZ) > 0.2 then					 --
			setElementRotation(pedT.ped,0,0,180-getZAngleFromControllerToTarget(pedT))					 --
		end					 --
	end					 --
					 --
	function setPedGoingToTarget(pedT,dist,lshit)					 --
		pedT.moveTarget = {targetPosX,targetPosY,targetPosZ}					 --
		if lshit and (#marshruts[marshrutSelected] > 0) then					 --
			pedT.marshrut = marshruts[marshrutSelected]					 --
			pedT.marshrutPoint = 1					 --
			pedT.moveTarget = {pedT.marshrut[pedT.marshrutPoint][1],pedT.marshrut[pedT.marshrutPoint][2],pedT.marshrut[pedT.marshrutPoint][1]}					 --
		end					 --
					 --
		pedT.moveTarget.dist = dist or 2					 --
					 --
		if targetElement then					 --
			pedT.moveTarget.targetElement = targetElement					 --
			if (getElementType(targetElement) == "ped") or (getElementType(targetElement) == "player") then					 --
				--					 --
			elseif getElementType(targetElement) == "vehicle" then					 --
				pedT.moveTarget.veh = targetElement					 --
				pedT.moveTarget.passanger = true					 --
				if lshit then					 --
					pedT.moveTarget.passanger = false					 --
					pedT.marshrut = nil					 --
				end					 --
			end					 --
		end					 --
					 --
		local veher = getPedOccupiedVehicle(pedT.ped)					 --
		if veher and (veher ~= pedT.moveTarget.veh) then					 --
			setPedExitVehicle (pedT.ped)					 --
		end					 --
	end					 --
					 --
	addEventHandler("onClientRender",root,function()					 --
		for ind,vev in ipairs(marshruts) do					 --
			local sel = ""					 --
			if ind == marshrutSelected then sel = "<-" end					 --
			dxDrawText(ind..": "..#vev.." "..sel,screenWid - 360,screenHeh-200 + (ind-2)*14)					 --
					 --
			local prevPos					 --
			for i,v in ipairs(vev) do					 --
				if not prevPos then					 --
					prevPos = {v[1],v[2],v[3]}					 --
				end					 --
					 --
				local colerN = colors[ind]					 --
				if i == 1 then colerN = tocolor(255,255,255,255) end					 --
				dxDrawMaterialLine3D(v[1] - 0.01,v[2] - 0.01, v[3] - 0.1, v[1] + 0.01, v[2] + 0.01, v[3] + 0.1, false, pedVidelkaTex, 0.19, colerN,true,ftx,fty,ftz)					 --
					 --
				if v.animtion then					 --
					local sx,sy = getScreenFromWorldPosition(v[1],v[2],v[3] + 0.4)					 --
					if sx and sy then					 --
						dxDrawText(v.animtion[1].." : "..v.animtion[2],sx - 10,sy - 17)					 --
					end					 --
				end					 --
					 --
				if i == 2 then colerN = tocolor(255,255,255,255) end					 --
				dxDrawMaterialLine3D(prevPos[1],prevPos[2],prevPos[3], v[1], v[2], v[3], false, pedVidelkaTex, 0.1, colerN,true)					 --
					 --
				prevPos = {v[1],v[2],v[3]}					 --
			end					 --
		end					 --
					 --
					 --
					 --
					 --
		applyToAllPeds(function(pedT)					 --
			local _,_,zr = getElementRotation(pedT.ped)					 --
			if pedT.crouchingOff then					 --
				setPedControlState(pedT.ped,"crouch",true)					 --
				pedT.crouchingOff = pedT.crouchingOff - 1					 --
				if pedT.crouchingOff <= 0 then					 --
					pedT.crouchingOff = nil					 --
				end					 --
			else					 --
				setPedControlState(pedT.ped,"crouch",false)					 --
			end					 --
					 --
			if pedT.moveTarget then					 --
				if pedT.moveTarget.targetElement then					 --
					local targPosX,targPosY,targPosZ = getElementPosition(pedT.moveTarget.targetElement)					 --
					local z = {targPosX,targPosY,targPosZ}					 --
					 --
					z.targetElement = pedT.moveTarget.targetElement					 --
					z.veh = pedT.moveTarget.veh					 --
					z.passanger = pedT.moveTarget.passanger					 --
					 --
					pedT.moveTarget = z					 --
				end					 --
					 --
				setPedCameraRotation(pedT.ped,180+getZAngleFromControllerToTarget(pedT,pedT.moveTarget))					 --
									 --
					 --
				local dist = 2					 --
				if pedT.moveTarget.veh then					 --
					dist = 10					 --
				end					 --
				dist = pedT.moveTarget.dist or dist					 --
					 --
				local pmx,pmy,pmz = getElementPosition(pedT.ped)					 --
				if getDistanceBetweenPoints2D(pedT.moveTarget[1],pedT.moveTarget[2],pmx,pmy) < dist then					 --
					if pedT.marshrut then					 --
						if pedT.marshrutPoint < #pedT.marshrut then					 --
							pedT.marshrutPoint = pedT.marshrutPoint + 1					 --
							pedT.moveTarget = {pedT.marshrut[pedT.marshrutPoint][1],pedT.marshrut[pedT.marshrutPoint][2],pedT.marshrut[pedT.marshrutPoint][1]}					 --
						else					 --
							pedT.marshrut = nil					 --
							pedT.moveTarget = nil					 --
							setPedControlState(pedT.ped,"forwards",false)					 --
						end					 --
					else					 --
						setPedControlState(pedT.ped,"forwards",false)					 --
					 --
						if pedT.moveTarget.veh then					 --
							setPedEnterVehicle(pedT.ped,pedT.moveTarget.targetElement,pedT.moveTarget.passanger)					 --
						end					 --
					end					 --
				else					 --
					setPedControlState(pedT.ped,"forwards",true)					 --
				end					 --
			end					 --
		end)					 --
	end)					 --
					 --
	marshrutSelected = 1					 --
	marshruts = {{},{},{},{},{},{},{}}					 --
					 --
	bindKey("e","down",function()					 --
		if laltKey then					 --
			marshruts[marshrutSelected] = {}					 --
			if lshifterKey then					 --
				marshruts = {{},{},{},{},{},{},{}}					 --
			end					 --
		else					 --
			marshruts[marshrutSelected][#marshruts[marshrutSelected] + 1] = {targetPosX,targetPosY,targetPosZ}					 --
		end					 --
	end)					 --
	function fixMarshrut()					 --
		if marshrutSelected <= 0 then marshrutSelected = #marshruts end					 --
		if marshrutSelected > #marshruts then marshrutSelected = 1 end					 --
	end					 --
	bindKey("num_4","down",function()					 --
		if laltKey then					 --
			marshrutSelected = marshrutSelected - 1					 --
			fixMarshrut()					 --
		end					 --
	end)					 --
	bindKey("num_6","down",function()					 --
		if laltKey then					 --
			marshrutSelected = marshrutSelected + 1					 --
			fixMarshrut()					 --
		end					 --
	end)					 --
					 --
					 --
					 --
					 --
					 --
					 --
	addCommandHandler("givePedTWeapon",function(player,weaponId)					 --
		triggerServerEvent("givePedTWeapon",root,getSelectedPeds(),weaponId)					 --
	end)					 --
					 --
	aiming = false					 --
	bindKey("num_2","both",function(key,state)					 --
		applyToAllPeds(function(pedT)					 --
			aiming = (state == "down")					 --
			if aiming then					 --
				pedT.aim = true					 --
				pedT.aimSkip = 0					 --
				pedT.lookTarget = {targetPosX,targetPosY,targetPosZ}					 --
			else					 --
				pedT.aim = nil					 --
			end					 --
		end,true)					 --
	end) 					 --
	bindKey("num_3","both",function(key,state)					 --
		applyToAllPeds(function(pedT)					 --
			if pedT.fireTimer then killTimer(pedT.fireTimer) end					 --
			pedT.fireTimer = setTimer(function()					 --
				setPedControlState(pedT.ped,"fire",(state == "down"))					 --
				pedT.fire = (state == "down")					 --
				pedT.fireTimer = nil					 --
			end,math.random(60,600),1)					 --
		end,true)					 --
	end)					 --
	local aimCadrs = 0					 --
	addEventHandler("onClientRender",root,function()					 --
		aimCadrs = aimCadrs + 1					 --
		applyToAllPeds(function(pedT)					 --
			if pedT.aim then					 --
				if aimCadrs % 40 == 0 then					 --
					pedT.aimSkip = 5					 --
				end					 --
					 --
				local pedPos = Vector3(getElementPosition(pedT.ped))					 --
				local distance = getDistanceBetweenPoints3D(targetPosX,targetPosY,targetPosZ,pedPos.x,pedPos.y,pedPos.z)					 --
				if distance > 1 then					 --
					if not getPedControlState(pedT.ped,"forwards") then setPedRotateToTarget(pedT) end					 --
					--if distance > 2.4 and (math.abs(getZAngleFromControllerToTarget(pedT,pedT.lookTarget)) < 80) then					 --
					if distance > 2.4 then					 --
						setPedControlState(pedT.ped,"aim_weapon",true)					 --
						if pedT.fire then setPedControlState(pedT.ped,"fire",true) end					 --
									 --
						if pedT.aimSkip < 0 then					 --
							pedT.lookTarget = {targetPosX,targetPosY,targetPosZ,100}					 --
						else					 --
							pedT.aimSkip = pedT.aimSkip - 1					 --
						end					 --
						setPedLookAtLookTarget(pedT)					 --
					else					 --
						setPedControlState(pedT.ped,"aim_weapon",false)					 --
						setPedControlState(pedT.ped,"fire",false)					 --
					end					 --
				end					 --
			else					 --
				setPedControlState(pedT.ped,"aim_weapon",false)					 --
				if not pedT.fire then 					 --
					setPedControlState(pedT.ped,"fire",false) 					 --
				end					 --
			end					 --
		end,true)					 --
	end)					 --
					 --
	-------------------------------------------------------------------					 --
	bindKey("x","down",function()					 --
		applyToAllPeds(function(pedT)							 --
			pedT.drive = not laltKey					 --
			if pedT.drive then					 --
				pedT.driveMarshrut = nil					 --
				pedT.driveTarget = {targetPosX,targetPosY,targetPosZ}					 --
				if targetElement then 					 --
					pedT.driveTargetElement = targetElement 					 --
				else					 --
					pedT.driveTargetElement = nil					 --
				end					 --
			else					 --
				pedT.driveMarshrut = nil					 --
				pedT.driveTarget = nil					 --
			end					 --
		end,true)					 --
	end)					 --
					 --
	bindKey("q","down",function()					 --
		applyToAllPeds(function(pedT)							 --
			if #marshruts[marshrutSelected] > 0 then					 --
				pedT.drive = true					 --
				pedT.driveMarshrut = marshruts[marshrutSelected]					 --
				pedT.driveMarshrutPoint = 1					 --
				pedT.driveTarget = marshruts[marshrutSelected][1]					 --
			end					 --
		end,true)					 --
	end)					 --
					 --
	local cadr = 0					 --
					 --
	addEventHandler("onClientRender",root,function()					 --
		cadr = cadr + 1					 --
		if cadr == 10000 then cadr = 0 end					 --
		applyToAllPeds(function(pedT)					 --
			if not pedT.drive then return end					 --
					 --
			if not pedT.drive then return end					 --
					 --
			if not getPedOccupiedVehicleSeat(pedT.ped) == 0 then					 --
				return					 --
			end					 --
					 --
			if pedT.driveTargetElement then					 --
				local dtePos = Vector3(getElementPosition(pedT.driveTargetElement))					 --
				pedT.driveTarget = {dtePos.x,dtePos.y,dtePos.z}					 --
			end					 --
					 --
			local veh = getPedOccupiedVehicle(pedT.ped)					 --
			local vehPos = Vector3(getElementPosition(veh))					 --
			local vehRot = Vector3(getElementRotation(veh))					 --
					 --
			setPedControlState(pedT.ped,"vehicle_right",false)					 --
			setPedControlState(pedT.ped,"vehicle_left",false)					 --
			setPedControlState(pedT.ped,"accelerate",false)					 --
			setPedControlState(pedT.ped,"handbrake",false)					 --
			setPedControlState(pedT.ped,"brake_reverse",false)					 --
					 --
			local dist = 0					 --
			local velosity = getVectorLen(Vector3(getElementVelocity(veh)))					 --
			if pedT.driveTarget then					 --
				if pedT.driveTarget[1] and pedT.driveTarget[2] then					 --
					dist = getDistanceBetweenPoints2D(vehPos.x,vehPos.y,pedT.driveTarget[1],pedT.driveTarget[2])					 --
				else					 --
					pedT.driveTarget = nil					 --
					pedT.drive = false					 --
				end					 --
			end					 --
								 --
					 --
			local mDist = 10					 --
			if pedT.driveTargetElement then mDist = 11 end					 --
					 --
			if dist > mDist then					 --
				setPedControlState(pedT.ped,"accelerate",true)					 --
					 --
				local ugol = (360-(getZAngleFromControllerToTarget(veh,pedT.driveTarget) + 180)) - vehRot.z					 --
					 --
				if math.abs(ugol) > 180 then					 --
					ugol = ugol - 360*(math.abs(ugol)/ugol)					 --
				end					 --
					 --
					 --
					 --
				local reverse = 1					 --
					 --
				setPedControlState(pedT.ped,"brake_reverse",false)					 --
				if (math.abs(ugol) > 140) and (dist < 30) then					 --
					setPedControlState(pedT.ped,"accelerate",false)					 --
					setPedControlState(pedT.ped,"brake_reverse",true)					 --
					reverse = -1					 --
					 --
					ugol = (360-getZAngleFromControllerToTarget(veh,pedT.driveTarget)) - vehRot.z					 --
					if math.abs(ugol) > 180 then					 --
						ugol = ugol - 360*(math.abs(ugol)/ugol)					 --
					end					 --
				end					 --
					 --
				local _,_,velZ = getElementAngularVelocity (veh)					 --
					 --
				local skip = false					 --
				if (math.abs(velosity) > 0.5) or (math.abs(ugol) < 10) then					 --
					skip = true					 --
					if cadr%3 == 0 then	skip = false end					 --
				end					 --
					 --
					 --
					 --
				local povorot = false					 --
				if ugol > 6*reverse then					 --
					 setPedControlState(pedT.ped,"vehicle_left",true)					 --
					povorot = true					 --
				elseif ugol < -6*reverse then					 --
					setPedControlState(pedT.ped,"vehicle_right",true)					 --
					povorot = true					 --
				else					 --
										 --
					 --
				end					 --
					 --
				if povorot and (velosity) > 0.25 then					 --
					setPedControlState(pedT.ped,"accelerate",false)					 --
				end					 --
					 --
				if velosity > 0.4 and math.abs(ugol) > 50 then					 --
					setPedControlState(pedT.ped,"handbrake",true)					 --
				end					 --
					 --
					 --
					 --
			else					 --
				--pedT.driveTarget = nil					 --
				if pedT.driveMarshrut then					 --
					pedT.driveMarshrutPoint = pedT.driveMarshrutPoint + 1					 --
					if pedT.driveMarshrutPoint > #pedT.driveMarshrut then					 --
						pedT.driveMarshrut = nil					 --
					else					 --
						pedT.driveTarget = pedT.driveMarshrut[pedT.driveMarshrutPoint]					 --
					end					 --
				end					 --
				setPedControlState(pedT.ped,"handbrake",true)					 --
				--setPedControlState(pedT.ped,"brake_reverse",true)					 --
			end					 --
		end)					 --
		applyToAllPeds(function(pedT)					 --
			--[[					 --
			dxDrawRectangle(400,400,30,30,tocolor(30,30,30,120))					 --
			dxDrawRectangle(400,450,30,30,tocolor(30,30,30,120))					 --
			dxDrawRectangle(360,424,30,30,tocolor(30,30,30,120))					 --
			dxDrawRectangle(440,424,30,30,tocolor(30,30,30,120))					 --
					 --
			dxDrawRectangle(360,490,110,30,tocolor(30,30,30,120))					 --
					 --
			if getPedControlState(pedT.ped,"accelerate") then	dxDrawRectangle(400,400,30,30) end					 --
			if getPedControlState(pedT.ped,"brake_reverse") then	dxDrawRectangle(400,450,30,30) end					 --
			if getPedControlState(pedT.ped,"vehicle_left") then	dxDrawRectangle(360,424,30,30) end					 --
			if getPedControlState(pedT.ped,"vehicle_right") then	dxDrawRectangle(440,424,30,30) end					 --
								 --
			if getPedControlState(pedT.ped,"handbrake") then	dxDrawRectangle(360,490,110,30) end]]					 --
		end)					 --
	end)					 --
					 --
					 --
					 --
	bindKey("l","down",function()					 --
		if targetElement then					 --
			--if getElementType(targetElement) == "vehicle" then					 --
			--	triggerServerEvent("vehAttacherTudaSuda",root,targetElement)					 --
			--end					 --
		end					 --
	end)					 --
					 --
	addCommandHandler('warppeds',function(player,marhrut)					 --
		local marsher = marshruts[marhrut or marshrutSelected]					 --
					 --
					 --
		if #marsher > 0 then					 --
			local poser = Vector3(marsher[1],marsher[2],marsher[3])					 --
			applyToAllPeds(function(pedT)					 --
				local smeser = Vector3(math.random(-300,300)/100,math.random(-300,300)/100,1.4)					 --
				local posPoint = poser + smeser					 --
					 --
				local vehpeda = getPedOccupiedVehicle(pedT.ped)					 --
				if vehpeda then					 --
					if getPedOccupiedVehicleSeat(pedT.ped) == 0 then					 --
						triggerServerEvent('setVehPos',root,vehpeda,posPoint.x,posPoint.y,posPoint.z)					 --
					end					 --
				else					 --
					setElementPosition(pedT.ped,posPoint.x,posPoint.y,posPoint.z)					 --
				end					 --
				pedT.moveTarget = nil					 --
				pedT.driveTarget = nil									 --
			end,true)					 --
		end					 --
	end)					 --
	addCommandHandler("setAnimPed",function(player,animBlock,anim)					 --
		applyToAllPeds(function(pedT)					 --
			setPedAnimation(pedT.ped,animBlock,anim)					 --
		end)					 --
	end)					 --
	addCommandHandler("addPointAnimation",function(player,animBlock,anim)					 --
		marshruts[marshrutSelected][#marshruts[marshrutSelected]].animtion = {animBlock,anim}					 --
	end)					 --
					 --
					 --
					 --
end) -- end Scena -------------------------------------------------					 --
					 --
function setPedLookAtLookTarget(pedTab)					 --
	local pedT = pedTab					 --
	if not pedT.lookTarget then return end					 --
	setPedAimTarget(pedT.ped, pedT.lookTarget[1], pedT.lookTarget[2], pedT.lookTarget[3])					 --
	setTimer(function()					 --
		if not pedT.lookTarget then return end					 --
		setPedLookAt(pedT.ped, pedT.lookTarget[1], pedT.lookTarget[2], pedT.lookTarget[3], pedT.lookTarget[4], 200)					 --
		pedT.lookTarget = nil					 --
	end,140,1)					 --
end					 --
					 --
					 --
--[[					 --
addEvent("vehAttacherTudaSuda",true)					 --
addEventHandler("vehAttacherTudaSuda",root,function(veh)					 --
	outputChatBox("vehAttacherTudaSuda")					 --
					 --
	attachElements(createObject(1550, 0, 0, 0, 0, 0, 0, true),veh, 0.43,-2.96,0.85,20,0,10)					 --
	attachElements(createObject(1550, 0, 0, 0, 0, 0, 0, true),veh, 0.15,-3.3,0.65,90,20,50)					 --
					 --
	attachElements(createObject(1829, 0, 0, 0, 0, 0, 0, true),veh, -0.36,-2.7,0.9,0,0,0)					 --
					 --
					 --
	outputChatBox("done")					 --
end)					 --
]]					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
--------------------------Sync Peds					 --
	pedsInter = {}					 --
					 --
	myLpKey = tostring(localPlayer)					 --
	function syncPeds()					 --
		pedsData = {}					 --
		if not scenaEnabled then return end					 --
		applyToAllPeds(function(pedT)					 --
			local pedDat = {ped = pedT.ped}					 --
					 --
			local pedPosX,pedPosY,pedPosZ = getElementPosition(pedT.ped)					 --
			pedDat.pos = {pedPosX,pedPosY,pedPosZ}					 --
			local pedPosRX,pedPosRY,pedPosRZ = getElementRotation(pedT.ped)					 --
			pedDat.rot = {pedPosRX,pedPosRY,pedPosRZ}					 --
					 --
			pedDat.lookTarget = pedT.lookTarget					 --
					 --
			pedDat.controls = {}					 --
			for k,v in pairs(pedsControls) do					 --
				pedDat.controls[v] = getPedControlState(pedT.ped,v)					 --
			end					 --
					 --
			pedDat.duck = getPedTask ( pedT.ped, "secondary", 1)					 --
					 --
			--local block, anim, time, loop, updatePosition, interruptable, freezeLastFrame, blendTime, restoreTaskOnAnimEnd = getPedAnimation(pedT.ped)					 --
			--time = time or {}					 --
			--pedDat.anim = {anim = anim, block = block, time = time.time, loop = time.loop, updatePosition = time.updatePosition, interruptable = time.interruptable, freezeLastFrame = time.freezeLastFrame, blendTime = time.blendTime, restoreTaskOnAnimEnd =	 time.restoreTaskOnAnimEnd}					 --
					 --
								 --
					 --
								 --
			pedsData[#pedsData + 1] = pedDat					 --
		end)					 --
					 --
		pedsData.initer = myLpKey					 --
		if #pedsData > 0 then triggerLatentServerEvent("pedsSync",100*1024*1024,root,pedsData) end					 --
	end					 --
	setTimer(syncPeds,1000,0)					 --
					 --
					 --
	--syncDebugRT = dxCreateRenderTarget(screenWid,screenHeh,true)					 --
	--syncDebugPed =  createPed (0,0,0,0,0)					 --
	--givePedWeapon(syncDebugPed,31,3000,true)					 --
						 --
					 --
	addEventHandler("pedsSync",root,function(data)					 --
		if data.initer == myLpKey then 					 --
			return					 --
		end					 --
		--dxSetRenderTarget(syncDebugRT,true)					 --
					 --
		for i,pDat in ipairs(data) do					 --
			local klch = tostring(pDat.ped)					 --
								 --
			pedsInter[klch] = pDat					 --
					 --
			--pedsInter[klch].ped = syncDebugPed					 --
					 --
			pedsInter[klch].initerpol = 0					 --
			pedsInter[klch].oldPos = Vector3(getElementPosition(pDat.ped))					 --
			pedsInter[klch].oldRot = Vector3(getElementRotation(pDat.ped))					 --
					 --
			for k,v in pairs(pDat.controls) do					 --
				setPedControlState(pDat.ped,k,v)					 --
			end					 --
					 --
			if pDat.lookTarget then					 --
				setPedLookAtLookTarget(pDat)					 --
			end					 --
					 --
			if getPedTask (pedsInter[klch].ped, "secondary", 1) ~= pDat.duck then					 --
				setPedControlState(pedsInter[klch].ped,"crouch",true)					 --
			end					 --
					 --
			--local an = pDat.anim					 --
			--if an.anim == false then an.anim = nil end					 --
					 --
			--local _,animatNow = getPedAnimation(pDat.ped)					 --
			---if animatNow ~= an.anim then					 --
			--	setPedAnimation(pDat.ped,an.block,an.anim,an.time,an.loop,an.updatePosition,an.interruptable,an.freezeLastFrame,an.blendTime,an.retainPedState)					 --
			--end					 --
					 --
		end					 --
					 --
					 --
		--dxSetRenderTarget(syncDebugRT,true)					 --
	end)					 --
	addEventHandler("onClientRender",root,function()					 --
		for k,v in pairs(pedsInter) do					 --
			if v.ped then 					 --
				if v.initerpol <= 5 then					 --
					setPedControlState(v.ped,"crouch",false)					 --
					 --
					local _,_,pedRZ = getElementRotation(v.ped)					 --
					 --
					local pedNowPos = Vector3(getElementPosition(v.ped))					 --
										 --
					if getDistanceBetweenPoints3D(pedNowPos.x,pedNowPos.y,pedNowPos.z,v.pos[1],v.pos[2],v.pos[3]) > 0.005 then					 --
						local interPosSmes = Vector3(v.pos[1] - v.oldPos.x,v.pos[2] - v.oldPos.y,v.pos[3] - v.oldPos.z)					 --
						local newPos = pedNowPos + interPosSmes/5					 --
					 --
						setElementPosition(v.ped,newPos.x,newPos.y,newPos.z,false)					 --
					end					 --
					 --
					local rotSmes = (v.rot[3] - v.oldRot.z)					 --
					if math.abs(rotSmes) > 180 then					 --
						rotSmes = rotSmes - 360*(math.abs(rotSmes)/rotSmes)					 --
					end					 --
					local newPedRz = pedRZ + rotSmes/5					 --
					if newPedRz > 360 then newPedRz = newPedRz - 360 end					 --
					if newPedRz < 0 then newPedRz = newPedRz + 360 end					 --
					 --
					setElementRotation(v.ped,0,0,newPedRz,"default",true)					 --
					 --
					 --
					v.initerpol = v.initerpol + 1					 --
				end					 --
			end					 --
		end					 --
	end)					 --
					 --
					 --
	----------------------*--------					 --
					 --
					 --
keysControl = {mouse1 = {"fire"},w = {"forwards","accelerate"},s = {"backwards","brake_reverse"},a = {"left","vehicle_left"},d = {"right","vehicle_right"},c = {"crouch"},lshift = {"sprint"},space = {"jump","brake_reverse","handbrake"}}					 --
pedsControls = {}					 --
for k,v in pairs(keysControl) do					 --
	for k,v2 in pairs(v) do					 --
		pedsControls[#pedsControls + 1] = v2					 --
	end					 --
end					 --
table.insert(pedsControls,"aim_weapon")					 --
table.insert(pedsControls,"walk")					 --
					 --
					 --
					 --
					 --
					 --
ContrlPeds = {}					 --
addCommandHandler("addControlPeds",function(player)					 --
	applyToAllPeds(function(pedT)					 --
		local ped = pedT.ped					 --
		ContrlPeds[tostring(ped)] = {indx = #ContrlPeds+1,ped = ped}					 --
	end,true)					 --
					 --
	if targetElement then					 --
		local ped					 --
		if getElementType(targetElement) == "vehicle" then					 --
			ped = getVehicleOccupant(targetElement)					 --
		end					 --
		if ped then					 --
			ContrlPeds[tostring(ped)] = {indx = #ContrlPeds+1,ped = ped}					 --
		end					 --
	end					 --
end)					 --
addCommandHandler("removeConrolPeds",function(player)					 --
	applyToAllPeds(function(pedT)					 --
		local ped = pedT.ped					 --
		ContrlPeds[tostring(ped)] = nil					 --
	end,true)					 --
end)					 --
					 --
					 --
for k,v in pairs(keysControl) do					 --
	bindKey(k,"down",function()					 --
		for keyPeder,peder in pairs(ContrlPeds) do					 --
			for _,control in pairs(v) do					 --
				setPedControlState(peder.ped,control,true)						 --
			end					 --
		end					 --
	end)					 --
	bindKey(k,"up",function()					 --
		for keyPeder,peder in pairs(ContrlPeds) do					 --
			for _,control in pairs(v) do					 --
				setPedControlState(peder.ped,control,false)					 --
			end					 --
		end					 --
	end)					 --
end					 --
					 --
					 --
addEventHandler("onClientRender",root,function()					 --
	for k,v in pairs(ContrlPeds) do							 --
		setPedCameraRotation(v.ped,getPedCameraRotation(localPlayer))					 --
	end					 --
end)					 --
