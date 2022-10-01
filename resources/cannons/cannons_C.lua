loadstring(exports.importer:load())()
import('RRL_Scripts/usfulC.lua')()    -- Usful C
import('RRL_Scripts/usfulSh.lua')()    -- Usful C
import('cannons/cannons_Prefabs.lua')()    -- CannonsTables

for i=1,230 do
	setPedStat(localPlayer,i,1000)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

screenW, screenH = guiGetScreenSize()
wTex = dxCreateTexture(":Draws/win/winTest.png")
thin200Font = dxCreateFont(":Draws/Fonts/Jost-Regular.ttf",12,false,"antialiased")


voidDff = engineLoadDFF("void.dff")							------------------
engineReplaceModel(voidDff,347)								--- Замена Silnsed
															------------------



tazerDFF = engineLoadDFF("can/Police/tazer/tazer.dff")				------------------
tazerTXD = engineLoadTXD("can/Police/tazer/tazer.txd")
engineImportTXD(tazerTXD, 	1248)
engineReplaceModel(tazerDFF, 1248)									--- Замена Tazer
tazerTarger = dxCreateTexture("can/Police/tazer/targer.png")		------------------
tazerVoltIco = "can/Police/tazer/icovolt.png"							------------------




------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function addSh_block(blockTime)
	if sh_block < blockTime then sh_block = blockTime end
end
function setFr_block(blockTime)
	if fr_block < blockTime then fr_block = blockTime end
	fr_block_tS = tick
end

function getPedWeaponsSlots(ped)
	local playerWeapons = {}
	table.insert(playerWeapons,0)
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=1,12 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,i)
			end
		end
	else
		return false
	end
	return playerWeapons
end
--moveControlTable = {"stand", "crouch", "walk"}
sh_block = 0
fr_block = 0
fr_block_tS = 0
function canShoosh()
	if sh_block > 0 then return false end

	local st0 = getPedTask(localPlayer, "secondary", 0)
	if st0 == "TASK_SIMPLE_USE_GUN" then
		local state = getPedMoveState(localPlayer)
		if tick - fr_block_tS > fr_block then
		---------------------------------------------------
		local x,y,z = getElementPosition(localPlayer)
		local rx,ry,rz = getElementRotation(localPlayer)
			local matter = Matrix(x,y,z,rx,ry,rz)
			local spont = matter.position
			local pont = matter.position + matter.forward/1.4
			local hasHit, hitX, hitY, hitZ, element = processLineOfSight(
				spont.x,spont.y,spont.z,--s
				 pont.x, pont.y, pont.z,
				true,	--checkBuildings
				true,	--checkVehicles
				true,	--checkPlayers
				true,	--checkObjects
				true,	--checkDummies
				true,	--seeThroughStuff
				false,  --ignoreSomeObjectsForCamera
				true,  --shootThroughStuff 
				localPlayer
			)
			if hasHit then
				addSh_block(35)
				return false
			else			
				return true
			end
		---------------------------------------------------
		end
	end
end



setPedWeaponSlot(localPlayer,1)
toggleControl("next_weapon",false)
toggleControl("previous_weapon",false)


-------------------------------------------------------------------------------------------------------------------------
		-- localgun 	= localPlayer cannon
		-- attachedGun 	= someone 's (including localPlayer) cannon
-------------------------------------------------------------------------------------------------------------------------
--																			Вся процедура выдачи оруж начинается с серва!
attachedGuns = {}	-- All guns - индексация по string плеера
defaultBone = 24

--Cannon Framework-------------------------------------------------------------------------------------------------------
function addLocalGun(gunProps)
	my_atG_key = attachGun(localPlayer,gunProps).gunSerial	
	my_atG = attachedGuns[my_atG_key]
end
function attachGun(player,gunProps)
	attachedGuns[gunProps.gunSerial] = {gunSerial = gunProps.gunSerial}
	local atG = attachedGuns[gunProps.gunSerial]

	atG.gunT = cannonsT[gunProps.gunKey]
	atG.gunObject = createObject(atG.gunT.modelId, 0, 0, 0)
	setElementCollisionsEnabled(atG.gunObject,false)

	atG.player = player
	atG.playerStates = {
		aim = isPedAiming(player),
		crouch = isPedDucked(player)
	}

	local ofs = atG.gunT.offsets.aim
	attachElementToBone(atG.gunObject, player, atG.gunT.bone or defaultBone,
			ofs.x, 	ofs.y, 	ofs.z,
			ofs.rx, ofs.ry, ofs.rz
	)
	atG.playerStates.change = true

	return atG
end

addEvent("canonSpas",true)
addEventHandler("canonSpas",root,function(player,gunProps)
	if (not player) or (not gunProps) then
		outputDebugString("Cannons spasGun args error:")
		outputDebugString("player - "..tostring(player))
		outputDebugString("gunProps - "..tostring(gunProps))
	end

	if player == localPlayer then
		addLocalGun(gunProps)
	else
		attachGun(player,gunProps)
	end
end)

-------------------------------------------------------------------------------------------------------------------------
mouse1Fire  = false
-------------------------------------------------------------------------------------------------------------------------
addEventHandler("onClientRender",root,function()
	if my_atG_key then
		if my_atG.gunT.frame then my_atG.gunT.frame(my_atG) end
	end	
end)
addEventHandler("onClientPedsProcessed",root,function()
	if getPedMoveState(localPlayer) == "crawl" or getPedControlState("crouch") then 
		local orgran = 40
		if getPedControlState("left") or getPedControlState("right") then
			orgran = 70	end
		addSh_block(orgran)
	end
	sh_block = sh_block - 1
	tick = getTickCount()

	------------------ localGunHandling ----------------------------------------------------------------------------------	

	if my_atG_key then

		local cshosh = canShoosh()
		if cshosh and getKeyState("mouse2") then
			if not my_atG.crossShowed then 
				my_atG.crossShowed = true
				if my_atG.gunT.crossShow then my_atG.gunT.crossShow(my_atG) end
			end

			if my_atG.gunT.crossFuc == true then
				setPlayerHudComponentVisible ("crosshair",my_atG.gunT.crossFuc)
			end
		else
			setPlayerHudComponentVisible ("crosshair",false)
			if my_atG.crossShowed then
				my_atG.crossShowed = false
				if my_atG.gunT.crossHide then my_atG.gunT.crossHide(my_atG) end
			end
		end

		if my_atG.gunT.ppframe then my_atG.gunT.ppframe(my_atG) end

		toggleControl("fire",false)
		---- shoot handling
		if getKeyState("mouse1") and cshosh then
			mouse1Fire = true
			if my_atG.gunT.canShoot then
				toggleControl("fire",true)
			else
				my_atG.gunT.shoot_Init(my_atG)
			end
		else
			if mouse1Fire then 
				mouse1Fire = false
				if my_atG.gunT.shoot_End then my_atG.gunT.shoot_End(my_atG) end
			end
		end
	end
	

	------------------ attachedGuns -------------------------------------------------------------------------------------
	for k,atG in pairs(attachedGuns) do	
		local pedAim = isPedAiming(atG.player)
		local pedCrch = isPedDucked(atG.player)

		getPedControlState(atG.player,"forwards")

		if (pedAim ~= atG.playerStates.aim) or (pedCrch ~= atG.playerStates.crouch) then
			atG.playerStates.change = true

			atG.playerStates.aim = pedAim
			atG.playerStates.crouch = pedCrch
		end
		if atG.playerStates.change then
			atG.playerStates.change = false
			if ((not atG.playerStates.aim) and (not atG.playerStates.crouch)) or ((atG.playerStates.aim) and (atG.playerStates.crouch)) then
				--  idle || crouch & aim --
			  	local ofs = atG.gunT.offsets.idle
			  	setAttachedElementToBoneOffsets(atG.gunObject,
					ofs.x, 	ofs.y, 	ofs.z,
					ofs.rx, ofs.ry, ofs.rz,
					5
				)
			elseif atG.playerStates.aim or atG.playerStates.crouch then
				--  aim || crouch  --
			  	local ofs = atG.gunT.offsets.aim
			  	setAttachedElementToBoneOffsets(atG.gunObject,
					ofs.x, 	ofs.y, 	ofs.z,
					ofs.rx, ofs.ry, ofs.rz,
					5
				)
			end
		end
	end
end,true,"low-1")


-- attachedGuns functional hanling
------------------------------------------------------------------------------------------------------------------------
addEvent("shootGun",true)								--- Это происходит уже у всех игроков, 
addEventHandler("shootGun",root,function(gunSerial,args)		--- 	ориентировчка с сервера
	local atG = attachedGuns[gunSerial]
	if not atG then return end

	args = args or {}
	if args.endShootTrigger then 
		if atG.gunT.shootEnding then atG.gunT.shootEnding(atG,args) end
		return
	end

	atG.gunT.shoot(atG,args)
end)