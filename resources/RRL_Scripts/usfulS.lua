function usfulS()
------------------------------------------------------------------------------------------------------------
import('RRL_Scripts/usfulSh.lua')()
import('RRL_Scripts/usfulRoots.lua')()
import('RRL_Scripts/usfulDB.lua')()
import('reglog/accUsful.lua')()
------------------------------------------------------------------------------------------------------------
function CameraFadingAnimation(thePlayer,FadeTime,timeInFade,red,green,blue)
	FadeTime = FadeTime or 1000
	timeInFade = timeInFade or 1000

	fadeCamera (thePlayer,false,FadeTime/1000,red or 5,green or 5,blue or 15)
	setTimer(function()
		fadeCamera(thePlayer,true,FadeTime/1000)
	end,FadeTime + timeInFade,1)
end

function setPlayerPositon(thePlayer,x,y,z,zRot,interior,dimension)
	if interior then setElementInterior(thePlayer, interior) end
	if dimension then setElementDimension(thePlayer, dimension) end
	setElementPosition(thePlayer,x,y,z)
	setElementRotation(thePlayer,0,0,zRot)
end
function spawnPlayerAtPosition(thePlayer,x,y,z,zRot,interior,dimension,spawnfuc)
	CameraFadingAnimation(thePlayer,2500,1000)
	setTimer(function()
		spawnPlayer(thePlayer,x,y,z,zRot,getElementModel(thePlayer),0, 0)
		setPlayerPositon(thePlayer,x,y,z,zRot,interior,dimension)
		setCameraTarget(thePlayer)
		if spawnfuc then spawnfuc() end
	end,3000,1)
end

function PlayerTransition(thePlayer,x,y,z,zRot,interior,dimension)
	CameraFadingAnimation(thePlayer)
	toggleAllControls(thePlayer, false)
	setTimer(function()
		setPlayerPositon(thePlayer,x,y,z,zRot,interior,dimension)
		toggleAllControls(thePlayer, true)
	end,1000,1)

end

function clearPlayerAnim(thePlayer)
	local _,_,rz = getElementRotation(thePlayer)
	local x,y,z = getElementPosition(thePlayer)
	setPlayerPositon(thePlayer,x,y,z,rz)
end






function createClientElement(thePlayer, key, modelId, x, y, z, rx, ry, rz, isLowLOD)
	triggerClientEvent (thePlayer,'createClientElement',root, key, modelId, x, y, z, rx, ry, rz, isLowLOD)
	return {["tag"] = "clientElement",["key"] = key}
end
function destroyClientElement(thePlayer, key)
	local keytoc = key
	if type(key) == "table" then keytoc = key.key end
	triggerClientEvent(thePlayer,'destroyClientElement',root, keytoc)
end


boneElms = {}
function attachElementToBone(element, ped, bone, offX, offY, offZ, offrx, offry, offrz)
	removeElementFromBone(element)
	triggerClientEvent('attachElementToBone',root, element, ped, bone, offX, offY, offZ, offrx, offry, offrz)
	local dimIntFunc = function(dim,int)
		setElementDimension(element,dim)
        setElementInterior(element,int)
	end
	local destroyFunct = function()
		removeElementFromBone(element)
	end
	addEventHandler("elmDimIntChanged", ped, dimIntFunc)
	addEventHandler("onElementDestroy", element, destroyFunct)
	boneElms[tostring(element)] = {dimIntFunc,destroyFunct, ["ped"] = ped}
end
function removeElementFromBone(element)
	triggerClientEvent('removeElementFromBone',root, element)
	
	if boneElms[tostring(element)] then
		removeEventHandler("elmDimIntChanged", boneElms[tostring(element)].ped, boneElms[tostring(element)][1])
		removeEventHandler("onElementDestroy", element, boneElms[tostring(element)][2])
		boneElms[tostring(element)] = nil
	end
end

function addVhodVihod(marker, type)
	local VhodVihod = {}
	VhodVihod.Vhod = createMarker(marker[1][1], marker[1][2], marker[1][3]+0.05, type[1], type[2], type[3], type[4], type[5], type[6])
	setElementInterior(VhodVihod.Vhod, marker[1][4])
	setElementDimension(VhodVihod.Vhod, marker[1][5])
	if marker[1][6] then
		VhodVihod.Blib = createBlip(marker[1][1], marker[1][2], marker[1][3]+0.05, marker[1][6], 2, 255, 0, 0, 255, 0, 300)
	end

	VhodVihod.Vihod = createMarker (marker[2][1], marker[2][2], marker[2][3]+0.05, type[1], type[2], type[3], type[4], type[5], type[6])
	setElementInterior(VhodVihod.Vihod, marker[2][4])
	setElementDimension(VhodVihod.Vihod, marker[2][5])

	
	addEventHandler("onMarkerHit", VhodVihod.Vhod, function(thePlayer)
		if not thePlayer then return end
		if (getElementType(thePlayer) ~= "player") or (getPedOccupiedVehicleSeat(thePlayer) ~= false) then return end
		if getElementDimension(thePlayer) == getElementDimension(VhodVihod.Vhod) then
			PlayerTransition(thePlayer,marker[3][1], marker[3][2], marker[3][3], marker[3][4], marker[3][5], marker[3][6])
		end
	end)

	addEventHandler("onMarkerHit", VhodVihod.Vihod, function(thePlayer)
		if not thePlayer then return end
		if (getElementType(thePlayer) ~= "player") or (getPedOccupiedVehicleSeat(thePlayer) ~= false) then return end
		if getElementDimension(thePlayer) == getElementDimension(VhodVihod.Vihod) then
			PlayerTransition(thePlayer,marker[4][1], marker[4][2], marker[4][3], marker[4][4], marker[4][5], marker[4][6])
		end
	end)
end

function createGerageDoorMarkerFunctional(marker,posToTp,rotToTp,dim,int,ourDim)
	local unbinder
	unbinder = function(thePlayer)
		unbindKey(thePlayer,'j','down',tpFuk,thePlayer)
	end
	local tpFuk
	tpFuk = function(_,_,_,thePlayer)
		if getElementDimension(thePlayer) == ourDim then
			if getPedOccupiedVehicleSeat(thePlayer) == 0 then
				local veh = getPedOccupiedVehicle(thePlayer)
				
				local occuupants = {}
				for k,v in pairs(getVehicleOccupants(veh)) do
					toggleControl (v, "enter_exit", false) 
					CameraFadingAnimation(v,2000,1000)
	
					table.insert(occuupants,k,v)
				end
				setTimer(function()
					setElementDimension(veh,dim)
					setElementInterior(veh,int)
					setElementDimension(thePlayer,dim)
					setElementInterior(thePlayer,int)
					setElementPosition(veh,posToTp.x,posToTp.y,posToTp.z)
					setElementRotation(veh,rotToTp.x,rotToTp.y,rotToTp.z)
	
					for k,v in pairs(occuupants) do
						warpPedIntoVehicle(v,veh,k)
						toggleControl (v, "enter_exit", true)
					end
	
					setTimer(function()
						triggerClientEvent("vehColGhostMode",root,veh,false)
						setTimer(function()
							triggerClientEvent("vehColGhostMode",root,veh,true)
						end,6000,1)
					end,500,1)
	
					unbinder(thePlayer)
				end,2100,1)
			end
		else return end
	end
	addEventHandler("onMarkerHit",marker,function(thePlayer)
		if getElementType(thePlayer) ~= "player" then return end
		bindKey(thePlayer,'j','down',tpFuk,thePlayer)
	end)
	addEventHandler("onMarkerLeave",marker,function(thePlayer)
		if getElementType(thePlayer) ~= "player" then return end
		unbinder(thePlayer)
	end)
end
function createGerageDoorFunctional(enterP,outP)
	enterP.pos.z = enterP.pos.z + 1
	outP.pos.z = outP.pos.z + 1

	local vihod = createMarker(outP.pos.x, outP.pos.y, outP.pos.z, "cylinder", 5.0, 0, 0, 0, 0)
	local vhod = createMarker(enterP.pos.x, enterP.pos.y, enterP.pos.z, "cylinder", 5.0, 0, 0, 0, 0)

	setElementDimension(vihod,outP.dim)
	setElementInterior(vihod,outP.int)

	setElementDimension(vhod,enterP.dim)
	setElementInterior(vhod,enterP.int)
		
	createGerageDoorMarkerFunctional(vihod,enterP.pos,enterP.rot,enterP.dim,enterP.int,outP.dim)
	createGerageDoorMarkerFunctional(vhod,outP.pos,outP.rot,outP.dim,outP.int,enterP.dim)
end










--------------------
 -- args.hit - hit+
 -- args.leave - leave
 -- args.player - hit works only with args.player

function createInteractMarker(args)
	local markarena =  createMarker (args.x, args.y, args.z, 
									args.theType or "cylinder", args.size, 
									args.r, args.g, args.b, args.a or 0, 
									args.player)
	setElementDimension(markarena,args.dim or 0)
	setElementInterior(markarena,args.int or 0)


	local cheackElem = function(element)			-- Корректнность Элемента
		if not element then return false end
		if getElementType(element) ~= "player" then return false end
		if args.player then
			if element ~= args.player then return false end
		end
		return true
	end

	local hit_plus = function(element)
		if cheackElem(element) then
			args.hit(element)
		end
	
	end
	local leave_plus = function(element)
		if cheackElem(element) then
			args.leave(element)
		end
	end


	addEventHandler("onMarkerHit",markarena,hit_plus)
	addEventHandler("onMarkerLeave",markarena,leave_plus)

	return {marker = markarena,hit = hit_plus, leave = leave_plus}
end
function deleteInteractMarker(interactMarkerTable)
	removeEventHandler("onMarkerHit",markarena,interactMarkerTable.hit)
	removeEventHandler("onMarkerLeave",markarena,interactMarkerTable.leave)
	destroyElement(interactMarkerTable.marker)
end

-- args.player - Object works only with args.player
function createMovebleObjectInteraction(object,args)
	if not object then
		outputDebugString("War!! creating MovebleObjectInteraction without <object>!")
		return
	end
	if type(args) ~= "table" then
		outputDebugString("War!! creating MovebleObjectInteraction, but <args ~= table>!")
		return
	end

	local x,y,z = getElementPosition(object)
	local rx,ry,rz = getElementRotation(object)
	local dim = getElementDimension(object)
	local int = getElementInterior(object)

	args.time = args.time or 4000
	args.waitToCloseTime = args.waitToCloseTime or 4000

	args.moverx = args.moverx or 0
	args.movery = args.movery or 0
	args.moverz = args.moverz or 0

	local moveng = false

	local doMoveObject = function()
		if not moveng then
			moveObject (object, args.time,
						 args.targetx or x, args.targety or y, args.targetz or z, args.moverx, args.movery, args.moverz,
						 args.strEasingType, args.fEasingPeriod, args.fEasingAmplitude, args.fEasingOvershoot)
			moveng = true
			local waitToCloseTime = args.waitToCloseTime
			setTimer(function()
				setTimer(function()
					moveng = false
				end,args.time,1)

				moveObject (object, args.time,
							 x,y,z, -(args.moverx or 0), -(args.movery or 0), -(args.moverz or 0),
							 args.strEasingType, args.fEasingPeriod, args.fEasingAmplitude, args.fEasingOvershoot)
			end,args.time + waitToCloseTime,1)
		end

	end
	local binder = function(player)
		objectInteract_RootChekingProtocol(player,args.rootT,function()
			if args.bindPressFuc then args.bindPressFuc() end
			doMoveObject()
		end) 
	end

	local itMtable = createInteractMarker({x=x,y=y,z=z,size = args.size,a = 0,player = args.player,dim = dim,int = int,
		hit = function(elm)
			bindKey(elm,args.button or "h",args.buttonState  or "down",binder,elm)
			if args.hitFuc then args.hitFuc() end
		end,
		leave = function(elm)
			unbindKey(elm,args.button or "h",args.buttonState  or "down",binder)

		end
	})

	return itMtable
end




function applyToAllPlayers(applyFuc)
	for k,v in pairs(getElementsByType ("player")) do
		applyFuc(v)
	end
end

------------------------------------------------------------------------------------------------------------
end
return usfulS