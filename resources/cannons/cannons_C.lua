loadstring(exports.importer:load())()					 --
import('RRL_Scripts/usfulC.lua')()    -- Usful C					 --
import('RRL_Scripts/usfulSh.lua')()    -- Usful C					 --
import('cannons/cannons_Prefabs.lua')()    -- CannonsTables					 --
					 --
for i=1,230 do					 --
	setPedStat(localPlayer,i,1000)					 --
end					 --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
screenW, screenH = guiGetScreenSize()					 --
wTex = dxCreateTexture(":Draws/win/winTest.png")					 --
thin200Font = dxCreateFont(":Draws/Fonts/Jost-Regular.ttf",12,false,"antialiased")					 --
					 --
					 --
voidDff = engineLoadDFF("void.dff")							------------------					 --
engineReplaceModel(voidDff,347)								--- Замена Silnsed					 --
															------------------					 --
					 --
					 --
					 --
tazerDFF = engineLoadDFF("can/Police/tazer/tazer.dff")				------------------					 --
tazerTXD = engineLoadTXD("can/Police/tazer/tazer.txd")					 --
engineImportTXD(tazerTXD, 	1248)					 --
engineReplaceModel(tazerDFF, 1248)									--- Замена Tazer					 --
tazerTarger = dxCreateTexture("can/Police/tazer/targer.png")		------------------					 --
tazerVoltIco = "can/Police/tazer/icovolt.png"							------------------					 --
					 --
					 --
					 --
					 --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
function addSh_block(blockTime)					 --
	if sh_block < blockTime then sh_block = blockTime end					 --
end					 --
function setFr_block(blockTime)					 --
	if fr_block < blockTime then fr_block = blockTime end					 --
	fr_block_tS = tick					 --
end					 --
					 --
function getPedWeaponsSlots(ped)					 --
	local playerWeapons = {}					 --
	table.insert(playerWeapons,0)					 --
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then					 --
		for i=1,12 do					 --
			local wep = getPedWeapon(ped,i)					 --
			if wep and wep ~= 0 then					 --
				table.insert(playerWeapons,i)					 --
			end					 --
		end					 --
	else					 --
		return false					 --
	end					 --
	return playerWeapons					 --
end					 --
--moveControlTable = {"stand", "crouch", "walk"}					 --
sh_block = 0					 --
fr_block = 0					 --
fr_block_tS = 0					 --
function canShoosh()					 --
	if sh_block > 0 then return false end					 --
					 --
	local st0 = getPedTask(localPlayer, "secondary", 0)					 --
	if st0 == "TASK_SIMPLE_USE_GUN" then					 --
		local state = getPedMoveState(localPlayer)					 --
		if tick - fr_block_tS > fr_block then					 --
		---------------------------------------------------					 --
		local x,y,z = getElementPosition(localPlayer)					 --
		local rx,ry,rz = getElementRotation(localPlayer)					 --
			local matter = Matrix(x,y,z,rx,ry,rz)					 --
			local spont = matter.position					 --
			local pont = matter.position + matter.forward/1.4					 --
			local hasHit, hitX, hitY, hitZ, element = processLineOfSight(					 --
				spont.x,spont.y,spont.z,--s					 --
				 pont.x, pont.y, pont.z,					 --
				true,	--checkBuildings					 --
				true,	--checkVehicles					 --
				true,	--checkPlayers					 --
				true,	--checkObjects					 --
				true,	--checkDummies					 --
				true,	--seeThroughStuff					 --
				false,  --ignoreSomeObjectsForCamera					 --
				true,  --shootThroughStuff 					 --
				localPlayer					 --
			)					 --
			if hasHit then					 --
				addSh_block(35)					 --
				return false					 --
			else								 --
				return true					 --
			end					 --
		---------------------------------------------------					 --
		end					 --
	end					 --
end					 --
					 --
					 --
					 --
setPedWeaponSlot(localPlayer,1)					 --
toggleControl("next_weapon",false)					 --
toggleControl("previous_weapon",false)					 --
ofs = {}					 --
					 --
-------------------------------------------------------------------------------------------------------------------------					 --
		-- localgun 	= localPlayer cannon					 --
		-- attachedGun 	= someone 's (including localPlayer) cannon					 --
-------------------------------------------------------------------------------------------------------------------------					 --
--																			Вся процедура выдачи оруж начинается с серва!					 --
attachedGuns = {}	-- All guns - индексация по string плеера					 --
defaultBone = 24					 --
					 --
--Cannon Framework-------------------------------------------------------------------------------------------------------					 --
function addLocalGun(gunProps)					 --
	my_atG_key = attachGun(localPlayer,gunProps).gunSerial						 --
	my_atG = attachedGuns[my_atG_key]					 --
end					 --
function attachGun(player,gunProps)					 --
	if player == nil then return end					 --
  attachedGuns[gunProps.gunSerial] = {gunSerial = gunProps.gunSerial}					 --
	local atG = attachedGuns[gunProps.gunSerial]					 --
					 --
	atG.gunT = cannonsT[gunProps.gunKey]					 --
	atG.gunObject = createObject(atG.gunT.modelId, 0, 0, 0)					 --
	setElementCollisionsEnabled(atG.gunObject,false)					 --
					 --
	atG.player = player					 --
	atG.playerStates = {					 --
		aim = isPedAiming(player),					 --
		crouch = isPedDucked(player)					 --
	}					 --
					 --
	local ofs = atG.gunT.offsets.aim					 --
	attachElementToBone(atG.gunObject, player, atG.gunT.bone or defaultBone,					 --
			ofs.x, 	ofs.y, 	ofs.z,					 --
			ofs.rx, ofs.ry, ofs.rz					 --
	)					 --
	atG.playerStates.change = true					 --
					 --
	return atG					 --
end					 --
playerCannon = false					 --
function getPlayerCanonPosition()					 --
    if not playerCannon then return end					 --
    return {ofs.x,   ofs.y,  ofs.z,					 --
      ofs.rx, ofs.ry, ofs.rz}					 --
end					 --
					 --
addEvent("resetCannon",true)					 --
addEventHandler("resetCannon",root,function(player,gunProps)					 --
    playerCannon = true					 --
    attachGun(player,gunProps)					 --
end)					 --
					 --
addEvent("canonSpas",true)					 --
addEventHandler("canonSpas",root,function(player,gunProps)					 --
	if (not player) or (not gunProps) then					 --
		outputDebugString("Cannons spasGun args error:")					 --
		outputDebugString("player - "..tostring(player))					 --
		outputDebugString("gunProps - "..tostring(gunProps))					 --
	end					 --
					 --
	if player == localPlayer then					 --
		addLocalGun(gunProps)					 --
	else					 --
		attachGun(player,gunProps)					 --
	end					 --
end)					 --
					 --
-------------------------------------------------------------------------------------------------------------------------					 --
mouse1Fire  = false					 --
-------------------------------------------------------------------------------------------------------------------------					 --
addEventHandler("onClientRender",root,function()					 --
	if my_atG_key then					 --
		if my_atG.gunT.frame then my_atG.gunT.frame(my_atG) end					 --
	end						 --
end)					 --
addEventHandler("onClientPedsProcessed",root,function()					 --
	if getPedMoveState(localPlayer) == "crawl" or getPedControlState("crouch") then 					 --
		local orgran = 40					 --
		if getPedControlState("left") or getPedControlState("right") then					 --
			orgran = 70	end					 --
		addSh_block(orgran)					 --
	end					 --
	sh_block = sh_block - 1					 --
	tick = getTickCount()					 --
					 --
	------------------ localGunHandling ----------------------------------------------------------------------------------						 --
					 --
	if my_atG_key then					 --
					 --
		local cshosh = canShoosh()					 --
		if cshosh and getKeyState("mouse2") then					 --
			if not my_atG.crossShowed then 					 --
				my_atG.crossShowed = true					 --
				if my_atG.gunT.crossShow then my_atG.gunT.crossShow(my_atG) end					 --
			end					 --
					 --
			if my_atG.gunT.crossFuc == true then					 --
				setPlayerHudComponentVisible ("crosshair",my_atG.gunT.crossFuc)					 --
			end					 --
		else					 --
			setPlayerHudComponentVisible ("crosshair",false)					 --
			if my_atG.crossShowed then					 --
				my_atG.crossShowed = false					 --
				if my_atG.gunT.crossHide then my_atG.gunT.crossHide(my_atG) end					 --
			end					 --
		end					 --
					 --
		if my_atG.gunT.ppframe then my_atG.gunT.ppframe(my_atG) end					 --
					 --
		toggleControl("fire",false)					 --
		---- shoot handling					 --
		if getKeyState("mouse1") and cshosh then					 --
			mouse1Fire = true					 --
			if my_atG.gunT.canShoot then					 --
				toggleControl("fire",true)					 --
			else					 --
				my_atG.gunT.shoot_Init(my_atG)					 --
			end					 --
		else					 --
			if mouse1Fire then 					 --
				mouse1Fire = false					 --
				if my_atG.gunT.shoot_End then my_atG.gunT.shoot_End(my_atG) end					 --
			end					 --
		end					 --
	end					 --
						 --
					 --
	------------------ attachedGuns -------------------------------------------------------------------------------------					 --
	for k,atG in pairs(attachedGuns) do						 --
		local pedAim = isPedAiming(atG.player)					 --
		local pedCrch = isPedDucked(atG.player)					 --
					 --
		getPedControlState(atG.player,"forwards")					 --
					 --
		if (pedAim ~= atG.playerStates.aim) or (pedCrch ~= atG.playerStates.crouch) then					 --
			atG.playerStates.change = true					 --
					 --
			atG.playerStates.aim = pedAim					 --
			atG.playerStates.crouch = pedCrch					 --
		end					 --
		if atG.playerStates.change then					 --
			atG.playerStates.change = false					 --
			if ((not atG.playerStates.aim) and (not atG.playerStates.crouch)) or ((atG.playerStates.aim) and (atG.playerStates.crouch)) then					 --
				--  idle || crouch & aim --					 --
			  	local ofs = atG.gunT.offsets.idle					 --
			  	setAttachedElementToBoneOffsets(atG.gunObject,					 --
					ofs.x, 	ofs.y, 	ofs.z,					 --
					ofs.rx, ofs.ry, ofs.rz,					 --
					5					 --
				)					 --
			elseif atG.playerStates.aim or atG.playerStates.crouch then					 --
				--  aim || crouch  --					 --
			  	local ofs = atG.gunT.offsets.aim					 --
			  	setAttachedElementToBoneOffsets(atG.gunObject,					 --
					ofs.x, 	ofs.y, 	ofs.z,					 --
					ofs.rx, ofs.ry, ofs.rz,					 --
					5					 --
				)					 --
			end					 --
		end					 --
	end					 --
end,true,"low-1")					 --
					 --
					 --
-- attachedGuns functional hanling					 --
------------------------------------------------------------------------------------------------------------------------					 --
addEvent("shootGun",true)								--- Это происходит уже у всех игроков, 					 --
addEventHandler("shootGun",root,function(gunSerial,args)		--- 	ориентировчка с сервера					 --
	local atG = attachedGuns[gunSerial]					 --
	if not atG then return end					 --
					 --
	args = args or {}					 --
	if args.endShootTrigger then 					 --
		if atG.gunT.shootEnding then atG.gunT.shootEnding(atG,args) end					 --
		return					 --
	end					 --
					 --
	atG.gunT.shoot(atG,args)					 --
end)					 --
					 --
					 --
					 --
local animations = {					 --
  airport = {"thrw_barl_thrw"},					 --
  attractors = {					 --
    "stepsit_in",					 --
    "stepsit_loop",					 --
    "stepsit_out"					 --
  },					 --
  bar = {					 --
    "barcustom_get",					 --
    "barcustom_loop",					 --
    "barcustom_order",					 --
    "barman_idle",					 --
    "barserve_bottle",					 --
    "barserve_give",					 --
    "barserve_glass",					 --
    "barserve_in",					 --
    "barserve_loop",					 --
    "barserve_order",					 --
    "dnk_stndf_loop",					 --
    "dnk_stndm_loop"					 --
  },					 --
  baseball = {					 --
    "bat_1",					 --
    "bat_2",					 --
    "bat_3",					 --
    "bat_4",					 --
    "bat_block",					 --
    "bat_hit_1",					 --
    "bat_hit_2",					 --
    "bat_hit_3",					 --
    "bat_idle",					 --
    "bat_m",					 --
    "bat_part"					 --
  },					 --
  bd_fire = {					 --
    "bd_fire1",					 --
    "bd_fire2",					 --
    "bd_fire3",					 --
    "bd_gf_wave",					 --
    "bd_panic_01",					 --
    "bd_panic_02",					 --
    "bd_panic_03",					 --
    "bd_panic_04",					 --
    "bd_panic_loop",					 --
    "grlfrd_kiss_03",					 --
    "m_smklean_loop",					 --
    "playa_kiss_03",					 --
    "wash_up"					 --
  },					 --
  beach = {					 --
    "bather",					 --
    "lay_bac_loop",					 --
    "parksit_m_loop",					 --
    "parksit_w_loop",					 --
    "sitnwait_loop_w"					 --
  },					 --
  benchpress = {					 --
    "gym_bp_celebrate",					 --
    "gym_bp_down",					 --
    "gym_bp_getoff",					 --
    "gym_bp_geton",					 --
    "gym_bp_up_a",					 --
    "gym_bp_up_b",					 --
    "gym_bp_up_smooth"					 --
  },					 --
  bf_injection = {					 --
    "bf_getin_lhs",					 --
    "bf_getin_rhs",					 --
    "bf_getout_lhs",					 --
    "bf_getout_rhs"					 --
  },					 --
  biked = {					 --
    "biked_back",					 --
    "biked_drivebyft",					 --
    "biked_drivebylhs",					 --
    "biked_drivebyrhs",					 --
    "biked_fwd",					 --
    "biked_getoffback",					 --
    "biked_getofflhs",					 --
    "biked_getoffrhs",					 --
    "biked_hit",					 --
    "biked_jumponl",					 --
    "biked_jumponr",					 --
    "biked_kick",					 --
    "biked_left",					 --
    "biked_passenger",					 --
    "biked_pushes",					 --
    "biked_ride",					 --
    "biked_right",					 --
    "biked_shuffle",					 --
    "biked_still"					 --
  },					 --
  bikeh = {					 --
    "bikeh_back",					 --
    "bikeh_drivebyft",					 --
    "bikeh_drivebylhs",					 --
    "bikeh_drivebyrhs",					 --
    "bikeh_fwd",					 --
    "bikeh_getoffback",					 --
    "bikeh_getofflhs",					 --
    "bikeh_getoffrhs",					 --
    "bikeh_hit",					 --
    "bikeh_jumponl",					 --
    "bikeh_jumponr",					 --
    "bikeh_kick",					 --
    "bikeh_left",					 --
    "bikeh_passenger",					 --
    "bikeh_pushes",					 --
    "bikeh_ride",					 --
    "bikeh_right",					 --
    "bikeh_still"					 --
  },					 --
  bikeleap = {					 --
    "bk_blnce_in",					 --
    "bk_blnce_out",					 --
    "bk_jmp",					 --
    "bk_rdy_in",					 --
    "bk_rdy_out",					 --
    "struggle_cesar",					 --
    "struggle_driver",					 --
    "truck_driver",					 --
    "truck_getin"					 --
  },					 --
  bikes = {					 --
    "bikes_back",					 --
    "bikes_drivebyft",					 --
    "bikes_drivebylhs",					 --
    "bikes_drivebyrhs",					 --
    "bikes_fwd",					 --
    "bikes_getoffback",					 --
    "bikes_getofflhs",					 --
    "bikes_getoffrhs",					 --
    "bikes_hit",					 --
    "bikes_jumponl",					 --
    "bikes_jumponr",					 --
    "bikes_kick",					 --
    "bikes_left",					 --
    "bikes_passenger",					 --
    "bikes_pushes",					 --
    "bikes_ride",					 --
    "bikes_right",					 --
    "bikes_snatch_l",					 --
    "bikes_snatch_r",					 --
    "bikes_still"					 --
  },					 --
  bikev = {					 --
    "bikev_back",					 --
    "bikev_drivebyft",					 --
    "bikev_drivebylhs",					 --
    "bikev_drivebyrhs",					 --
    "bikev_fwd",					 --
    "bikev_getoffback",					 --
    "bikev_getofflhs",					 --
    "bikev_getoffrhs",					 --
    "bikev_hit",					 --
    "bikev_jumponl",					 --
    "bikev_jumponr",					 --
    "bikev_kick",					 --
    "bikev_left",					 --
    "bikev_passenger",					 --
    "bikev_pushes",					 --
    "bikev_ride",					 --
    "bikev_right",					 --
    "bikev_still"					 --
  },					 --
  bike_dbz = {					 --
    "pass_driveby_bwd",					 --
    "pass_driveby_fwd",					 --
    "pass_driveby_lhs",					 --
    "pass_driveby_rhs"					 --
  },					 --
  bmx = {					 --
    "bmx_back",					 --
    "bmx_bunnyhop",					 --
    "bmx_drivebyft",					 --
    "bmx_driveby_lhs",					 --
    "bmx_driveby_rhs",					 --
    "bmx_fwd",					 --
    "bmx_getoffback",					 --
    "bmx_getofflhs",					 --
    "bmx_getoffrhs",					 --
    "bmx_jumponl",					 --
    "bmx_jumponr",					 --
    "bmx_left",					 --
    "bmx_pedal",					 --
    "bmx_pushes",					 --
    "bmx_ride",					 --
    "bmx_right",					 --
    "bmx_sprint",					 --
    "bmx_still"					 --
  },					 --
  bomber = {					 --
    "bom_plant",					 --
    "bom_plant_2idle",					 --
    "bom_plant_crouch_in",					 --
    "bom_plant_crouch_out",					 --
    "bom_plant_in",					 --
    "bom_plant_loop"					 --
  },					 --
  box = {					 --
    "boxhipin",					 --
    "boxhipup",					 --
    "boxshdwn",					 --
    "boxshup",					 --
    "bxhipwlk",					 --
    "bxhwlki",					 --
    "bxshwlk",					 --
    "bxshwlki",					 --
    "bxwlko",					 --
    "catch_box"					 --
  },					 --
  bsktball = {					 --
    "bball_def_jump_shot",					 --
    "bball_def_loop",					 --
    "bball_def_stepl",					 --
    "bball_def_stepr",					 --
    "bball_dnk",					 --
    "bball_dnk_gli",					 --
    "bball_dnk_gli_o",					 --
    "bball_dnk_lnch",					 --
    "bball_dnk_lnch_o",					 --
    "bball_dnk_lnd",					 --
    "bball_dnk_o",					 --
    "bball_idle",					 --
    "bball_idle2",					 --
    "bball_idle2_o",					 --
    "bball_idleloop",					 --
    "bball_idleloop_o",					 --
    "bball_idle_o",					 --
    "bball_jump_cancel",					 --
    "bball_jump_cancel_o",					 --
    "bball_jump_end",					 --
    "bball_jump_shot",					 --
    "bball_jump_shot_o",					 --
    "bball_net_dnk_o",					 --
    "bball_pickup",					 --
    "bball_pickup_o",					 --
    "bball_react_miss",					 --
    "bball_react_score",					 --
    "bball_run",					 --
    "bball_run_o",					 --
    "bball_skidstop_l",					 --
    "bball_skidstop_l_o",					 --
    "bball_skidstop_r",					 --
    "bball_skidstop_r_o",					 --
    "bball_walk",					 --
    "bball_walkstop_l",					 --
    "bball_walkstop_l_o",					 --
    "bball_walkstop_r",					 --
    "bball_walkstop_r_o",					 --
    "bball_walk_o",					 --
    "bball_walk_start",					 --
    "bball_walk_start_o"					 --
  },					 --
  buddy = {					 --
    "buddy_crouchfire",					 --
    "buddy_crouchreload",					 --
    "buddy_fire",					 --
    "buddy_fire_poor",					 --
    "buddy_reload"					 --
  },					 --
  bus = {					 --
    "bus_close",					 --
    "bus_getin_lhs",					 --
    "bus_getin_rhs",					 --
    "bus_getout_lhs",					 --
    "bus_getout_rhs",					 --
    "bus_jacked_lhs",					 --
    "bus_open",					 --
    "bus_open_rhs",					 --
    "bus_pullout_lhs"					 --
  },					 --
  camera = {					 --
    "camcrch_cmon",					 --
    "camcrch_idleloop",					 --
    "camcrch_stay",					 --
    "camcrch_to_camstnd",					 --
    "camstnd_cmon",					 --
    "camstnd_idleloop",					 --
    "camstnd_lkabt",					 --
    "camstnd_to_camcrch",					 --
    "piccrch_in",					 --
    "piccrch_out",					 --
    "piccrch_take",					 --
    "picstnd_in",					 --
    "picstnd_out",					 --
    "picstnd_take"					 --
  },					 --
  car = {					 --
    "fixn_car_loop",					 --
    "fixn_car_out",					 --
    "flag_drop",					 --
    "sit_relaxed",					 --
    "tap_hand",					 --
    "tyd2car_bump",					 --
    "tyd2car_high",					 --
    "tyd2car_low",					 --
    "tyd2car_med",					 --
    "tyd2car_turnl",					 --
    "tyd2car_turnr"					 --
  },					 --
  carry = {					 --
    "crry_prtial",					 --
    "liftup",					 --
    "liftup05",					 --
    "liftup105",					 --
    "putdwn",					 --
    "putdwn05",					 --
    "putdwn105"					 --
  },					 --
  car_chat = {					 --
    "carfone_in",					 --
    "carfone_loopa",					 --
    "carfone_loopa_to_b",					 --
    "carfone_loopb",					 --
    "carfone_loopb_to_a",					 --
    "carfone_out",					 --
    "car_sc1_bl",					 --
    "car_sc1_br",					 --
    "car_sc1_fl",					 --
    "car_sc1_fr",					 --
    "car_sc2_fl",					 --
    "car_sc3_br",					 --
    "car_sc3_fl",					 --
    "car_sc3_fr",					 --
    "car_sc4_bl",					 --
    "car_sc4_br",					 --
    "car_sc4_fl",					 --
    "car_sc4_fr",					 --
    "car_talkm_in",					 --
    "car_talkm_loop",					 --
    "car_talkm_out"					 --
  },					 --
  casino = {					 --
    "cards_in",					 --
    "cards_loop",					 --
    "cards_lose",					 --
    "cards_out",					 --
    "cards_pick_01",					 --
    "cards_pick_02",					 --
    "cards_raise",					 --
    "cards_win",					 --
    "dealone",					 --
    "manwinb",					 --
    "manwind",					 --
    "roulette_bet",					 --
    "roulette_in",					 --
    "roulette_loop",					 --
    "roulette_lose",					 --
    "roulette_out",					 --
    "roulette_win",					 --
    "slot_bet_01",					 --
    "slot_bet_02",					 --
    "slot_in",					 --
    "slot_lose_out",					 --
    "slot_plyr",					 --
    "slot_wait",					 --
    "slot_win_out",					 --
    "wof"					 --
  },					 --
  chainsaw = {					 --
    "csaw_1",					 --
    "csaw_2",					 --
    "csaw_3",					 --
    "csaw_g",					 --
    "csaw_hit_1",					 --
    "csaw_hit_2",					 --
    "csaw_hit_3",					 --
    "csaw_part",					 --
    "idle_csaw",					 --
    "weapon_csaw",					 --
    "weapon_csawlo"					 --
  },					 --
  choppa = {					 --
    "choppa_back",					 --
    "choppa_bunnyhop",					 --
    "choppa_drivebyft",					 --
    "choppa_driveby_lhs",					 --
    "choppa_driveby_rhs",					 --
    "choppa_fwd",					 --
    "choppa_getoffback",					 --
    "choppa_getofflhs",					 --
    "choppa_getoffrhs",					 --
    "choppa_jumponl",					 --
    "choppa_jumponr",					 --
    "choppa_left",					 --
    "choppa_pedal",					 --
    "choppa_pushes",					 --
    "choppa_ride",					 --
    "choppa_right",					 --
    "choppa_sprint",					 --
    "choppa_still"					 --
  },					 --
  clothes = {					 --
    "clo_buy",					 --
    "clo_in",					 --
    "clo_out",					 --
    "clo_pose_hat",					 --
    "clo_pose_in",					 --
    "clo_pose_in_o",					 --
    "clo_pose_legs",					 --
    "clo_pose_loop",					 --
    "clo_pose_out",					 --
    "clo_pose_out_o",					 --
    "clo_pose_shoes",					 --
    "clo_pose_torso",					 --
    "clo_pose_watch"					 --
  },					 --
  coach = {					 --
    "coach_inl",					 --
    "coach_inr",					 --
    "coach_opnl",					 --
    "coach_opnr",					 --
    "coach_outl",					 --
    "coach_outr"					 --
  },					 --
  colt45 = {					 --
    "2guns_crouchfire",					 --
    "colt45_crouchfire",					 --
    "colt45_crouchreload",					 --
    "colt45_fire",					 --
    "colt45_fire_2hands",					 --
    "colt45_reload",					 --
    "sawnoff_reload"					 --
  },					 --
  cop_ambient = {					 --
    "copbrowse_in",					 --
    "copbrowse_loop",					 --
    "copbrowse_nod",					 --
    "copbrowse_out",					 --
    "copbrowse_shake",					 --
    "coplook_in",					 --
    "coplook_loop",					 --
    "coplook_nod",					 --
    "coplook_out",					 --
    "coplook_shake",					 --
    "coplook_think",					 --
    "coplook_watch"					 --
  },					 --
  cop_dvbyz = {					 --
    "cop_dvby_b",					 --
    "cop_dvby_ft",					 --
    "cop_dvby_l",					 --
    "cop_dvby_r"					 --
  },					 --
  crack = {					 --
    "bbalbat_idle_01",					 --
    "bbalbat_idle_02",					 --
    "crckdeth1",					 --
    "crckdeth2",					 --
    "crckdeth3",					 --
    "crckdeth4",					 --
    "crckidle1",					 --
    "crckidle2",					 --
    "crckidle3",					 --
    "crckidle4"					 --
  },					 --
  crib = {					 --
    "crib_console_loop",					 --
    "crib_use_switch",					 --
    "ped_console_loop",					 --
    "ped_console_loose",					 --
    "ped_console_win"					 --
  },					 --
  dam_jump = {					 --
    "dam_dive_loop",					 --
    "dam_land",					 --
    "dam_launch",					 --
    "jump_roll",					 --
    "sf_jumpwall"					 --
  },					 --
  dancing = {					 --
    "bd_clap",					 --
    "bd_clap1",					 --
    "dance_loop",					 --
    "dan_down_a",					 --
    "dan_left_a",					 --
    "dan_loop_a",					 --
    "dan_right_a",					 --
    "dan_up_a",					 --
    "dnce_m_a",					 --
    "dnce_m_b",					 --
    "dnce_m_c",					 --
    "dnce_m_d",					 --
    "dnce_m_e"					 --
  },					 --
  dealer = {					 --
    "dealer_deal",					 --
    "dealer_idle",					 --
    "dealer_idle_01",					 --
    "dealer_idle_02",					 --
    "dealer_idle_03",					 --
    "drugs_buy",					 --
    "shop_pay"					 --
  },					 --
  dildo = {					 --
    "dildo_1",					 --
    "dildo_2",					 --
    "dildo_3",					 --
    "dildo_block",					 --
    "dildo_g",					 --
    "dildo_hit_1",					 --
    "dildo_hit_2",					 --
    "dildo_hit_3",					 --
    "dildo_idle"					 --
  },					 --
  dodge = {					 --
    "cover_dive_01",					 --
    "cover_dive_02",					 --
    "crushed",					 --
    "crush_jump"					 --
  },					 --
  dozer = {					 --
    "dozer_align_lhs",					 --
    "dozer_align_rhs",					 --
    "dozer_getin_lhs",					 --
    "dozer_getin_rhs",					 --
    "dozer_getout_lhs",					 --
    "dozer_getout_rhs",					 --
    "dozer_jacked_lhs",					 --
    "dozer_jacked_rhs",					 --
    "dozer_pullout_lhs",					 --
    "dozer_pullout_rhs"					 --
  },					 --
  drivebys = {					 --
    "gang_drivebylhs",					 --
    "gang_drivebylhs_bwd",					 --
    "gang_drivebylhs_fwd",					 --
    "gang_drivebyrhs",					 --
    "gang_drivebyrhs_bwd",					 --
    "gang_drivebyrhs_fwd",					 --
    "gang_drivebytop_lhs",					 --
    "gang_drivebytop_rhs"					 --
  },					 --
  fat = {					 --
    "fatidle",					 --
    "fatidle_armed",					 --
    "fatidle_csaw",					 --
    "fatidle_rocket",					 --
    "fatrun",					 --
    "fatrun_armed",					 --
    "fatrun_csaw",					 --
    "fatrun_rocket",					 --
    "fatsprint",					 --
    "fatwalk",					 --
    "fatwalkstart",					 --
    "fatwalkstart_csaw",					 --
    "fatwalkst_armed",					 --
    "fatwalkst_rocket",					 --
    "fatwalk_armed",					 --
    "fatwalk_csaw",					 --
    "fatwalk_rocket",					 --
    "idle_tired"					 --
  },					 --
  fight_b = {					 --
    "fightb_1",					 --
    "fightb_2",					 --
    "fightb_3",					 --
    "fightb_block",					 --
    "fightb_g",					 --
    "fightb_idle",					 --
    "fightb_m",					 --
    "hitb_1",					 --
    "hitb_2",					 --
    "hitb_3"					 --
  },					 --
  fight_c = {					 --
    "fightc_1",					 --
    "fightc_2",					 --
    "fightc_3",					 --
    "fightc_block",					 --
    "fightc_blocking",					 --
    "fightc_g",					 --
    "fightc_idle",					 --
    "fightc_m",					 --
    "fightc_spar",					 --
    "hitc_1",					 --
    "hitc_2",					 --
    "hitc_3"					 --
  },					 --
  fight_d = {					 --
    "fightd_1",					 --
    "fightd_2",					 --
    "fightd_3",					 --
    "fightd_block",					 --
    "fightd_g",					 --
    "fightd_idle",					 --
    "fightd_m",					 --
    "hitd_1",					 --
    "hitd_2",					 --
    "hitd_3"					 --
  },					 --
  fight_e = {					 --
    "fightkick",					 --
    "fightkick_b",					 --
    "hit_fightkick",					 --
    "hit_fightkick_b"					 --
  },					 --
  finale = {					 --
    "fin_climb_in",					 --
    "fin_cop1_climbout2",					 --
    "fin_cop1_loop",					 --
    "fin_cop1_stomp",					 --
    "fin_hang_l",					 --
    "fin_hang_loop",					 --
    "fin_hang_r",					 --
    "fin_hang_slip",					 --
    "fin_jump_on",					 --
    "fin_land_car",					 --
    "fin_land_die",					 --
    "fin_legsup",					 --
    "fin_legsup_l",					 --
    "fin_legsup_loop",					 --
    "fin_legsup_r",					 --
    "fin_let_go"					 --
  },					 --
  finale2 = {					 --
    "fin_cop1_climbout",					 --
    "fin_cop1_fall",					 --
    "fin_cop1_loop",					 --
    "fin_cop1_shot",					 --
    "fin_cop1_swing",					 --
    "fin_cop2_climbout",					 --
    "fin_switch_p",					 --
    "fin_switch_s"					 --
  },					 --
  flame = {					 --
    "flame_fire",					 --
    "flower_attack",					 --
    "flower_attack_m",					 --
    "flower_hit"					 --
  },					 --
  food = {					 --
    "eat_burger",					 --
    "eat_chicken",					 --
    "eat_pizza",					 --
    "eat_vomit_p",					 --
    "eat_vomit_sk",					 --
    "ff_dam_bkw",					 --
    "ff_dam_fwd",					 --
    "ff_dam_left",					 --
    "ff_dam_right",					 --
    "ff_die_bkw",					 --
    "ff_die_fwd",					 --
    "ff_die_left",					 --
    "ff_die_right",					 --
    "ff_sit_eat1",					 --
    "ff_sit_eat2",					 --
    "ff_sit_eat3",					 --
    "ff_sit_in",					 --
    "ff_sit_in_l",					 --
    "ff_sit_in_r",					 --
    "ff_sit_look",					 --
    "ff_sit_loop",					 --
    "ff_sit_out_180",					 --
    "ff_sit_out_l_180",					 --
    "ff_sit_out_r_180",					 --
    "shp_thank",					 --
    "shp_tray_in",					 --
    "shp_tray_lift",					 --
    "shp_tray_lift_in",					 --
    "shp_tray_lift_loop",					 --
    "shp_tray_lift_out",					 --
    "shp_tray_out",					 --
    "shp_tray_pose",					 --
    "shp_tray_return"					 --
  },					 --
  freeweights = {					 --
    "gym_barbell",					 --
    "gym_free_a",					 --
    "gym_free_b",					 --
    "gym_free_celebrate",					 --
    "gym_free_down",					 --
    "gym_free_loop",					 --
    "gym_free_pickup",					 --
    "gym_free_putdown",					 --
    "gym_free_up_smooth"					 --
  },					 --
  gangs = {					 --
    "dealer_deal",					 --
    "dealer_idle",					 --
    "drnkbr_prtl",					 --
    "drnkbr_prtl_f",					 --
    "drugs_buy",					 --
    "hndshkaa",					 --
    "hndshkba",					 --
    "hndshkca",					 --
    "hndshkcb",					 --
    "hndshkda",					 --
    "hndshkea",					 --
    "hndshkfa",					 --
    "hndshkfa_swt",					 --
    "invite_no",					 --
    "invite_yes",					 --
    "leanidle",					 --
    "leanin",					 --
    "leanout",					 --
    "prtial_gngtlka",					 --
    "prtial_gngtlkb",					 --
    "prtial_gngtlkc",					 --
    "prtial_gngtlkd",					 --
    "prtial_gngtlke",					 --
    "prtial_gngtlkf",					 --
    "prtial_gngtlkg",					 --
    "prtial_gngtlkh",					 --
    "prtial_hndshk_01",					 --
    "prtial_hndshk_biz_01",					 --
    "shake_cara",					 --
    "shake_cark",					 --
    "shake_carsh",					 --
    "smkcig_prtl",					 --
    "smkcig_prtl_f"					 --
  },					 --
  ghands = {					 --
    "gsign1",					 --
    "gsign1lh",					 --
    "gsign2",					 --
    "gsign2lh",					 --
    "gsign3",					 --
    "gsign3lh",					 --
    "gsign4",					 --
    "gsign4lh",					 --
    "gsign5",					 --
    "gsign5lh",					 --
    "lhgsign1",					 --
    "lhgsign2",					 --
    "lhgsign3",					 --
    "lhgsign4",					 --
    "lhgsign5",					 --
    "rhgsign1",					 --
    "rhgsign2",					 --
    "rhgsign3",					 --
    "rhgsign4",					 --
    "rhgsign5"					 --
  },					 --
  ghetto_db = {					 --
    "gdb_car2_ply",					 --
    "gdb_car2_smo",					 --
    "gdb_car2_swe",					 --
    "gdb_car_ply",					 --
    "gdb_car_ryd",					 --
    "gdb_car_smo",					 --
    "gdb_car_swe"					 --
  },					 --
  goggles = {"goggles_put_on"},					 --
  graffiti = {					 --
    "graffiti_chkout",					 --
    "spraycan_fire"					 --
  },					 --
  graveyard = {					 --
    "mrnf_loop",					 --
    "mrnm_loop",					 --
    "prst_loopa"					 --
  },					 --
  grenade = {					 --
    "weapon_start_throw",					 --
    "weapon_throw",					 --
    "weapon_throwu"					 --
  },					 --
  gymnasium = {					 --
    "gymshadowbox",					 --
    "gym_bike_celebrate",					 --
    "gym_bike_fast",					 --
    "gym_bike_faster",					 --
    "gym_bike_getoff",					 --
    "gym_bike_geton",					 --
    "gym_bike_pedal",					 --
    "gym_bike_slow",					 --
    "gym_bike_still",					 --
    "gym_jog_falloff",					 --
    "gym_shadowbox",					 --
    "gym_tread_celebrate",					 --
    "gym_tread_falloff",					 --
    "gym_tread_getoff",					 --
    "gym_tread_geton",					 --
    "gym_tread_jog",					 --
    "gym_tread_sprint",					 --
    "gym_tread_tired",					 --
    "gym_tread_walk",					 --
    "gym_walk_falloff",					 --
    "pedals_fast",					 --
    "pedals_med",					 --
    "pedals_slow",					 --
    "pedals_still"					 --
  },					 --
  haircuts = {					 --
    "brb_beard_01",					 --
    "brb_buy",					 --
    "brb_cut",					 --
    "brb_cut_in",					 --
    "brb_cut_out",					 --
    "brb_hair_01",					 --
    "brb_hair_02",					 --
    "brb_in",					 --
    "brb_loop",					 --
    "brb_out",					 --
    "brb_sit_in",					 --
    "brb_sit_loop",					 --
    "brb_sit_out"					 --
  },					 --
  heist9 = {					 --
    "cas_g2_gasko",					 --
    "swt_wllpk_l",					 --
    "swt_wllpk_l_back",					 --
    "swt_wllpk_r",					 --
    "swt_wllpk_r_back",					 --
    "swt_wllshoot_in_l",					 --
    "swt_wllshoot_in_r",					 --
    "swt_wllshoot_out_l",					 --
    "swt_wllshoot_out_r",					 --
    "use_swipecard"					 --
  },					 --
  int_house = {					 --
    "bed_in_l",					 --
    "bed_in_r",					 --
    "bed_loop_l",					 --
    "bed_loop_r",					 --
    "bed_out_l",					 --
    "bed_out_r",					 --
    "lou_in",					 --
    "lou_loop",					 --
    "lou_out",					 --
    "wash_up"					 --
  },					 --
  int_office = {					 --
    "ff_dam_fwd",					 --
    "off_sit_2idle_180",					 --
    "off_sit_bored_loop",					 --
    "off_sit_crash",					 --
    "off_sit_drink",					 --
    "off_sit_idle_loop",					 --
    "off_sit_in",					 --
    "off_sit_read",					 --
    "off_sit_type_loop",					 --
    "off_sit_watch"					 --
  },					 --
  int_shop = {					 --
    "shop_cashier",					 --
    "shop_in",					 --
    "shop_looka",					 --
    "shop_lookb",					 --
    "shop_loop",					 --
    "shop_out",					 --
    "shop_pay",					 --
    "shop_shelf"					 --
  },					 --
  jst_buisness = {					 --
    "girl_01",					 --
    "girl_02",					 --
    "player_01",					 --
    "smoke_01"					 --
  },					 --
  kart = {					 --
    "kart_getin_lhs",					 --
    "kart_getin_rhs",					 --
    "kart_getout_lhs",					 --
    "kart_getout_rhs"					 --
  },					 --
  kissing = {					 --
    "bd_gf_wave",					 --
    "gfwave2",					 --
    "gf_carargue_01",					 --
    "gf_carargue_02",					 --
    "gf_carspot",					 --
    "gf_streetargue_01",					 --
    "gf_streetargue_02",					 --
    "gift_get",					 --
    "gift_give",					 --
    "grlfrd_kiss_01",					 --
    "grlfrd_kiss_02",					 --
    "grlfrd_kiss_03",					 --
    "playa_kiss_01",					 --
    "playa_kiss_02",					 --
    "playa_kiss_03"					 --
  },					 --
  knife = {					 --
    "kill_knife_ped_damage",					 --
    "kill_knife_ped_die",					 --
    "kill_knife_player",					 --
    "kill_partial",					 --
    "knife_1",					 --
    "knife_2",					 --
    "knife_3",					 --
    "knife_4",					 --
    "knife_block",					 --
    "knife_g",					 --
    "knife_hit_1",					 --
    "knife_hit_2",					 --
    "knife_hit_3",					 --
    "knife_idle",					 --
    "knife_part",					 --
    "weapon_knifeidle"					 --
  },					 --
  lapdan1 = {					 --
    "lapdan_d",					 --
    "lapdan_p"					 --
  },					 --
  lapdan2 = {					 --
    "lapdan_d",					 --
    "lapdan_p"					 --
  },					 --
  lapdan3 = {					 --
    "lapdan_d",					 --
    "lapdan_p"					 --
  },					 --
  lowrider = {					 --
    "f_smklean_loop",					 --
    "lrgirl_bdbnce",					 --
    "lrgirl_hair",					 --
    "lrgirl_hurry",					 --
    "lrgirl_idleloop",					 --
    "lrgirl_idle_to_l0",					 --
    "lrgirl_l0_bnce",					 --
    "lrgirl_l0_loop",					 --
    "lrgirl_l0_to_l1",					 --
    "lrgirl_l12_to_l0",					 --
    "lrgirl_l1_bnce",					 --
    "lrgirl_l1_loop",					 --
    "lrgirl_l1_to_l2",					 --
    "lrgirl_l2_bnce",					 --
    "lrgirl_l2_loop",					 --
    "lrgirl_l2_to_l3",					 --
    "lrgirl_l345_to_l1",					 --
    "lrgirl_l3_bnce",					 --
    "lrgirl_l3_loop",					 --
    "lrgirl_l3_to_l4",					 --
    "lrgirl_l4_bnce",					 --
    "lrgirl_l4_loop",					 --
    "lrgirl_l4_to_l5",					 --
    "lrgirl_l5_bnce",					 --
    "lrgirl_l5_loop",					 --
    "m_smklean_loop",					 --
    "m_smkstnd_loop",					 --
    "prtial_gngtlkb",					 --
    "prtial_gngtlkc",					 --
    "prtial_gngtlkd",					 --
    "prtial_gngtlke",					 --
    "prtial_gngtlkf",					 --
    "prtial_gngtlkg",					 --
    "prtial_gngtlkh",					 --
    "rap_a_loop",					 --
    "rap_b_loop",					 --
    "rap_c_loop",					 --
    "sit_relaxed",					 --
    "tap_hand"					 --
  },					 --
  md_chase = {					 --
    "carhit_hangon",					 --
    "carhit_tumble",					 --
    "donutdrop",					 --
    "fen_choppa_l1",					 --
    "fen_choppa_l2",					 --
    "fen_choppa_l3",					 --
    "fen_choppa_r1",					 --
    "fen_choppa_r2",					 --
    "fen_choppa_r3",					 --
    "hangon_stun_loop",					 --
    "hangon_stun_turn",					 --
    "md_bike_2_hang",					 --
    "md_bike_jmp_bl",					 --
    "md_bike_jmp_f",					 --
    "md_bike_lnd_bl",					 --
    "md_bike_lnd_die_bl",					 --
    "md_bike_lnd_die_f",					 --
    "md_bike_lnd_f",					 --
    "md_bike_lnd_roll",					 --
    "md_bike_lnd_roll_f",					 --
    "md_bike_punch",					 --
    "md_bike_punch_f",					 --
    "md_bike_shot_f",					 --
    "md_hang_lnd_roll",					 --
    "md_hang_loop"					 --
  },					 --
  md_end = {					 --
    "end_sc1_ply",					 --
    "end_sc1_ryd",					 --
    "end_sc1_smo",					 --
    "end_sc1_swe",					 --
    "end_sc2_ply",					 --
    "end_sc2_ryd",					 --
    "end_sc2_smo",					 --
    "end_sc2_swe"					 --
  },					 --
  medic = {"cpr"},					 --
  misc = {					 --
    "bitchslap",					 --
    "bmx_celebrate",					 --
    "bmx_comeon",					 --
    "bmx_idleloop_01",					 --
    "bmx_idleloop_02",					 --
    "bmx_talkleft_in",					 --
    "bmx_talkleft_loop",					 --
    "bmx_talkleft_out",					 --
    "bmx_talkright_in",					 --
    "bmx_talkright_loop",					 --
    "bmx_talkright_out",					 --
    "bng_wndw",					 --
    "bng_wndw_02",					 --
    "case_pickup",					 --
    "door_jet",					 --
    "grab_l",					 --
    "grab_r",					 --
    "hiker_pose",					 --
    "hiker_pose_l",					 --
    "idle_chat_02",					 --
    "kat_throw_k",					 --
    "kat_throw_o",					 --
    "kat_throw_p",					 --
    "pass_rifle_o",					 --
    "pass_rifle_ped",					 --
    "pass_rifle_ply",					 --
    "pickup_box",					 --
    "plane_door",					 --
    "plane_exit",					 --
    "plane_hijack",					 --
    "plunger_01",					 --
    "plyrlean_loop",					 --
    "plyr_shkhead",					 --
    "run_dive",					 --
    "scratchballs_01",					 --
    "seat_lr",					 --
    "seat_talk_01",					 --
    "seat_talk_02",					 --
    "seat_watch",					 --
    "smalplane_door",					 --
    "smlplane_door"					 --
  },					 --
  mtb = {					 --
    "mtb_back",					 --
    "mtb_bunnyhop",					 --
    "mtb_drivebyft",					 --
    "mtb_driveby_lhs",					 --
    "mtb_driveby_rhs",					 --
    "mtb_fwd",					 --
    "mtb_getoffback",					 --
    "mtb_getofflhs",					 --
    "mtb_getoffrhs",					 --
    "mtb_jumponl",					 --
    "mtb_jumponr",					 --
    "mtb_left",					 --
    "mtb_pedal",					 --
    "mtb_pushes",					 --
    "mtb_ride",					 --
    "mtb_right",					 --
    "mtb_sprint",					 --
    "mtb_still"					 --
  },					 --
  muscular = {					 --
    "msclewalkst_armed",					 --
    "msclewalkst_csaw",					 --
    "mscle_rckt_run",					 --
    "mscle_rckt_walkst",					 --
    "mscle_run_csaw",					 --
    "muscleidle",					 --
    "muscleidle_armed",					 --
    "muscleidle_csaw",					 --
    "muscleidle_rocket",					 --
    "musclerun",					 --
    "musclerun_armed",					 --
    "musclesprint",					 --
    "musclewalk",					 --
    "musclewalkstart",					 --
    "musclewalk_armed",					 --
    "musclewalk_csaw",					 --
    "musclewalk_rocket"					 --
  },					 --
  nevada = {					 --
    "nevada_getin",					 --
    "nevada_getout"					 --
  },					 --
  on_lookers = {					 --
    "lkaround_in",					 --
    "lkaround_loop",					 --
    "lkaround_out",					 --
    "lkup_in",					 --
    "lkup_loop",					 --
    "lkup_out",					 --
    "lkup_point",					 --
    "panic_cower",					 --
    "panic_hide",					 --
    "panic_in",					 --
    "panic_loop",					 --
    "panic_out",					 --
    "panic_point",					 --
    "panic_shout",					 --
    "pointup_in",					 --
    "pointup_loop",					 --
    "pointup_out",					 --
    "pointup_shout",					 --
    "point_in",					 --
    "point_loop",					 --
    "point_out",					 --
    "shout_01",					 --
    "shout_02",					 --
    "shout_in",					 --
    "shout_loop",					 --
    "shout_out",					 --
    "wave_in",					 --
    "wave_loop",					 --
    "wave_out"					 --
  },					 --
  otb = {					 --
    "betslp_in",					 --
    "betslp_lkabt",					 --
    "betslp_loop",					 --
    "betslp_out",					 --
    "betslp_tnk",					 --
    "wtchrace_cmon",					 --
    "wtchrace_in",					 --
    "wtchrace_loop",					 --
    "wtchrace_lose",					 --
    "wtchrace_out",					 --
    "wtchrace_win"					 --
  },					 --
  parachute = {					 --
    "fall_skydive",					 --
    "fall_skydive_accel",					 --
    "fall_skydive_die",					 --
    "fall_skydive_l",					 --
    "fall_skydive_r",					 --
    "para_decel",					 --
    "para_decel_o",					 --
    "para_float",					 --
    "para_float_o",					 --
    "para_land",					 --
    "para_land_o",					 --
    "para_land_water",					 --
    "para_land_water_o",					 --
    "para_open",					 --
    "para_open_o",					 --
    "para_rip_land_o",					 --
    "para_rip_loop_o",					 --
    "para_rip_o",					 --
    "para_steerl",					 --
    "para_steerl_o",					 --
    "para_steerr",					 --
    "para_steerr_o"					 --
  },					 --
  park = {					 --
    "tai_chi_in",					 --
    "tai_chi_loop",					 --
    "tai_chi_out"					 --
  },					 --
  paulnmac = {					 --
    "piss_in",					 --
    "piss_loop",					 --
    "piss_out",					 --
    "pnm_argue1_a",					 --
    "pnm_argue1_b",					 --
    "pnm_argue2_a",					 --
    "pnm_argue2_b",					 --
    "pnm_loop_a",					 --
    "pnm_loop_b",					 --
    "wank_in",					 --
    "wank_loop",					 --
    "wank_out"					 --
  },					 --
  ped = {					 --
    "abseil",					 --
    "arrestgun",					 --
    "atm",					 --
    "bike_elbowl",					 --
    "bike_elbowr",					 --
    "bike_fallr",					 --
    "bike_fall_off",					 --
    "bike_pickupl",					 --
    "bike_pickupr",					 --
    "bike_pullupl",					 --
    "bike_pullupr",					 --
    "bomber",					 --
    "car_alignhi_lhs",					 --
    "car_alignhi_rhs",					 --
    "car_align_lhs",					 --
    "car_align_rhs",					 --
    "car_closedoorl_lhs",					 --
    "car_closedoorl_rhs",					 --
    "car_closedoor_lhs",					 --
    "car_closedoor_rhs",					 --
    "car_close_lhs",					 --
    "car_close_rhs",					 --
    "car_crawloutrhs",					 --
    "car_dead_lhs",					 --
    "car_dead_rhs",					 --
    "car_doorlocked_lhs",					 --
    "car_doorlocked_rhs",					 --
    "car_fallout_lhs",					 --
    "car_fallout_rhs",					 --
    "car_getinl_lhs",					 --
    "car_getinl_rhs",					 --
    "car_getin_lhs",					 --
    "car_getin_rhs",					 --
    "car_getoutl_lhs",					 --
    "car_getoutl_rhs",					 --
    "car_getout_lhs",					 --
    "car_getout_rhs",					 --
    "car_hookertalk",					 --
    "car_jackedlhs",					 --
    "car_jackedrhs",					 --
    "car_jumpin_lhs",					 --
    "car_lb",					 --
    "car_lb_pro",					 --
    "car_lb_weak",					 --
    "car_ljackedlhs",					 --
    "car_ljackedrhs",					 --
    "car_lshuffle_rhs",					 --
    "car_lsit",					 --
    "car_open_lhs",					 --
    "car_open_rhs",					 --
    "car_pulloutl_lhs",					 --
    "car_pulloutl_rhs",					 --
    "car_pullout_lhs",					 --
    "car_pullout_rhs",					 --
    "car_qjacked",					 --
    "car_rolldoor",					 --
    "car_rolldoorlo",					 --
    "car_rollout_lhs",					 --
    "car_rollout_rhs",					 --
    "car_shuffle_rhs",					 --
    "car_sit",					 --
    "car_sitp",					 --
    "car_sitplo",					 --
    "car_sit_pro",					 --
    "car_sit_weak",					 --
    "car_tune_radio",					 --
    "climb_idle",					 --
    "climb_jump",					 --
    "climb_jump2fall",					 --
    "climb_jump_b",					 --
    "climb_pull",					 --
    "climb_stand",					 --
    "climb_stand_finish",					 --
    "cower",					 --
    "crouch_roll_l",					 --
    "crouch_roll_r",					 --
    "dam_arml_frmbk",					 --
    "dam_arml_frmft",					 --
    "dam_arml_frmlt",					 --
    "dam_armr_frmbk",					 --
    "dam_armr_frmft",					 --
    "dam_armr_frmrt",					 --
    "dam_legl_frmbk",					 --
    "dam_legl_frmft",					 --
    "dam_legl_frmlt",					 --
    "dam_legr_frmbk",					 --
    "dam_legr_frmft",					 --
    "dam_legr_frmrt",					 --
    "dam_stomach_frmbk",					 --
    "dam_stomach_frmft",					 --
    "dam_stomach_frmlt",					 --
    "dam_stomach_frmrt",					 --
    "door_lhinge_o",					 --
    "door_rhinge_o",					 --
    "drivebyl_l",					 --
    "drivebyl_r",					 --
    "driveby_l",					 --
    "driveby_r",					 --
    "drive_boat",					 --
    "drive_boat_back",					 --
    "drive_boat_l",					 --
    "drive_boat_r",					 --
    "drive_l",					 --
    "drive_lo_l",					 --
    "drive_lo_r",					 --
    "drive_l_pro",					 --
    "drive_l_pro_slow",					 --
    "drive_l_slow",					 --
    "drive_l_weak",					 --
    "drive_l_weak_slow",					 --
    "drive_r",					 --
    "drive_r_pro",					 --
    "drive_r_pro_slow",					 --
    "drive_r_slow",					 --
    "drive_r_weak",					 --
    "drive_r_weak_slow",					 --
    "drive_truck",					 --
    "drive_truck_back",					 --
    "drive_truck_l",					 --
    "drive_truck_r",					 --
    "drown",					 --
    "duck_cower",					 --
    "endchat_01",					 --
    "endchat_02",					 --
    "endchat_03",					 --
    "ev_dive",					 --
    "ev_step",					 --
    "facanger",					 --
    "facgum",					 --
    "facsurp",					 --
    "facsurpm",					 --
    "factalk",					 --
    "facurios",					 --
    "fall_back",					 --
    "fall_collapse",					 --
    "fall_fall",					 --
    "fall_front",					 --
    "fall_glide",					 --
    "fall_land",					 --
    "fall_skydive",					 --
    "fight2idle",					 --
    "fighta_1",					 --
    "fighta_2",					 --
    "fighta_3",					 --
    "fighta_block",					 --
    "fighta_g",					 --
    "fighta_m",					 --
    "fightidle",					 --
    "fightshb",					 --
    "fightshf",					 --
    "fightsh_bwd",					 --
    "fightsh_fwd",					 --
    "fightsh_left",					 --
    "fightsh_right",					 --
    "flee_lkaround_01",					 --
    "floor_hit",					 --
    "floor_hit_f",					 --
    "fucku",					 --
    "gang_gunstand",					 --
    "gas_cwr",					 --
    "getup",					 --
    "getup_front",					 --
    "gum_eat",					 --
    "guncrouchbwd",					 --
    "guncrouchfwd",					 --
    "gunmove_bwd",					 --
    "gunmove_fwd",					 --
    "gunmove_l",					 --
    "gunmove_r",					 --
    "gun_2_idle",					 --
    "gun_butt",					 --
    "gun_butt_crouch",					 --
    "gun_stand",					 --
    "handscower",					 --
    "handsup",					 --
    "hita_1",					 --
    "hita_2",					 --
    "hita_3",					 --
    "hit_back",					 --
    "hit_behind",					 --
    "hit_front",					 --
    "hit_gun_butt",					 --
    "hit_l",					 --
    "hit_r",					 --
    "hit_walk",					 --
    "hit_wall",					 --
    "idlestance_fat",					 --
    "idlestance_old",					 --
    "idle_armed",					 --
    "idle_chat",					 --
    "idle_csaw",					 --
    "idle_gang1",					 --
    "idle_hbhb",					 --
    "idle_rocket",					 --
    "idle_stance",					 --
    "idle_taxi",					 --
    "idle_tired",					 --
    "jetpack_idle",					 --
    "jog_femalea",					 --
    "jog_malea",					 --
    "jump_glide",					 --
    "jump_land",					 --
    "jump_launch",					 --
    "jump_launch_r",					 --
    "kart_drive",					 --
    "kart_l",					 --
    "kart_lb",					 --
    "kart_r",					 --
    "kd_left",					 --
    "kd_right",					 --
    "ko_shot_face",					 --
    "ko_shot_front",					 --
    "ko_shot_stom",					 --
    "ko_skid_back",					 --
    "ko_skid_front",					 --
    "ko_spin_l",					 --
    "ko_spin_r",					 --
    "pass_smoke_in_car",					 --
    "phone_in",					 --
    "phone_out",					 --
    "phone_talk",					 --
    "player_sneak",					 --
    "player_sneak_walkstart",					 --
    "roadcross",					 --
    "roadcross_female",					 --
    "roadcross_gang",					 --
    "roadcross_old",					 --
    "run_1armed",					 --
    "run_armed",					 --
    "run_civi",					 --
    "run_csaw",					 --
    "run_fat",					 --
    "run_fatold",					 --
    "run_gang1",					 --
    "run_left",					 --
    "run_old",					 --
    "run_player",					 --
    "run_right",					 --
    "run_rocket",					 --
    "run_stop",					 --
    "run_stopr",					 --
    "run_wuzi",					 --
    "seat_down",					 --
    "seat_idle",					 --
    "seat_up",					 --
    "shot_leftp",					 --
    "shot_partial",					 --
    "shot_partial_b",					 --
    "shot_rightp",					 --
    "shove_partial",					 --
    "smoke_in_car",					 --
    "sprint_civi",					 --
    "sprint_panic",					 --
    "sprint_wuzi",					 --
    "swat_run",					 --
    "swim_tread",					 --
    "tap_hand",					 --
    "tap_handp",					 --
    "turn_180",					 --
    "turn_l",					 --
    "turn_r",					 --
    "walk_armed",					 --
    "walk_civi",					 --
    "walk_csaw",					 --
    "walk_doorpartial",					 --
    "walk_drunk",					 --
    "walk_fat",					 --
    "walk_fatold",					 --
    "walk_gang1",					 --
    "walk_gang2",					 --
    "walk_old",					 --
    "walk_player",					 --
    "walk_rocket",					 --
    "walk_shuffle",					 --
    "walk_start",					 --
    "walk_start_armed",					 --
    "walk_start_csaw",					 --
    "walk_start_rocket",					 --
    "walk_wuzi",					 --
    "weapon_crouch",					 --
    "woman_idlestance",					 --
    "woman_run",					 --
    "woman_runbusy",					 --
    "woman_runfatold",					 --
    "woman_runpanic",					 --
    "woman_runsexy",					 --
    "woman_walkbusy",					 --
    "woman_walkfatold",					 --
    "woman_walknorm",					 --
    "woman_walkold",					 --
    "woman_walkpro",					 --
    "woman_walksexy",					 --
    "woman_walkshop",					 --
    "xpressscratch"					 --
  },					 --
  player_dvbys = {					 --
    "plyr_drivebybwd",					 --
    "plyr_drivebyfwd",					 --
    "plyr_drivebylhs",					 --
    "plyr_drivebyrhs"					 --
  },					 --
  playidles = {					 --
    "shift",					 --
    "shldr",					 --
    "stretch",					 --
    "strleg",					 --
    "time"					 --
  },					 --
  police = {					 --
    "coptraf_away",					 --
    "coptraf_come",					 --
    "coptraf_left",					 --
    "coptraf_stop",					 --
    "cop_getoutcar_lhs",					 --
    "cop_move_fwd",					 --
    "crm_drgbst_01",					 --
    "door_kick",					 --
    "plc_drgbst_01",					 --
    "plc_drgbst_02"					 --
  },					 --
  pool = {					 --
    "pool_chalkcue",					 --
    "pool_idle_stance",					 --
    "pool_long_shot",					 --
    "pool_long_shot_o",					 --
    "pool_long_start",					 --
    "pool_long_start_o",					 --
    "pool_med_shot",					 --
    "pool_med_shot_o",					 --
    "pool_med_start",					 --
    "pool_med_start_o",					 --
    "pool_place_white",					 --
    "pool_short_shot",					 --
    "pool_short_shot_o",					 --
    "pool_short_start",					 --
    "pool_short_start_o",					 --
    "pool_walk",					 --
    "pool_walk_start",					 --
    "pool_xlong_shot",					 --
    "pool_xlong_shot_o",					 --
    "pool_xlong_start",					 --
    "pool_xlong_start_o"					 --
  },					 --
  poor = {					 --
    "winwash_start",					 --
    "winwash_wash2beg"					 --
  },					 --
  python = {					 --
    "python_crouchfire",					 --
    "python_crouchreload",					 --
    "python_fire",					 --
    "python_fire_poor",					 --
    "python_reload"					 --
  },					 --
  quad = {					 --
    "quad_back",					 --
    "quad_driveby_ft",					 --
    "quad_driveby_lhs",					 --
    "quad_driveby_rhs",					 --
    "quad_fwd",					 --
    "quad_getoff_b",					 --
    "quad_getoff_lhs",					 --
    "quad_getoff_rhs",					 --
    "quad_geton_lhs",					 --
    "quad_geton_rhs",					 --
    "quad_hit",					 --
    "quad_kick",					 --
    "quad_left",					 --
    "quad_passenger",					 --
    "quad_reverse",					 --
    "quad_ride",					 --
    "quad_right"					 --
  },					 --
  quad_dbz = {					 --
    "pass_driveby_bwd",					 --
    "pass_driveby_fwd",					 --
    "pass_driveby_lhs",					 --
    "pass_driveby_rhs"					 --
  },					 --
  rapping = {					 --
    "laugh_01",					 --
    "rap_a_in",					 --
    "rap_a_loop",					 --
    "rap_a_out",					 --
    "rap_b_in",					 --
    "rap_b_loop",					 --
    "rap_b_out",					 --
    "rap_c_loop"					 --
  },					 --
  rifle = {					 --
    "rifle_crouchfire",					 --
    "rifle_crouchload",					 --
    "rifle_fire",					 --
    "rifle_fire_poor",					 --
    "rifle_load"					 --
  },					 --
  riot = {					 --
    "riot_angry",					 --
    "riot_angry_b",					 --
    "riot_challenge",					 --
    "riot_chant",					 --
    "riot_fuku",					 --
    "riot_punches",					 --
    "riot_shout"					 --
  },					 --
  rob_bank = {					 --
    "cat_safe_end",					 --
    "cat_safe_open",					 --
    "cat_safe_open_o",					 --
    "cat_safe_rob",					 --
    "shp_handsup_scr"					 --
  },					 --
  rocket = {					 --
    "idle_rocket",					 --
    "rocketfire",					 --
    "run_rocket",					 --
    "walk_rocket",					 --
    "walk_start_rocket"					 --
  },					 --
  rustler = {					 --
    "plane_align_lhs",					 --
    "plane_close",					 --
    "plane_getin",					 --
    "plane_getout",					 --
    "plane_open"					 --
  },					 --
  ryder = {					 --
    "ryd_beckon_01",					 --
    "ryd_beckon_02",					 --
    "ryd_beckon_03",					 --
    "ryd_die_pt1",					 --
    "ryd_die_pt2",					 --
    "van_crate_l",					 --
    "van_crate_r",					 --
    "van_fall_l",					 --
    "van_fall_r",					 --
    "van_lean_l",					 --
    "van_lean_r",					 --
    "van_pickup_e",					 --
    "van_pickup_s",					 --
    "van_stand",					 --
    "van_stand_crate",					 --
    "van_throw"					 --
  },					 --
  scratching = {					 --
    "scdldlp",					 --
    "scdlulp",					 --
    "scdrdlp",					 --
    "scdrulp",					 --
    "sclng_l",					 --
    "sclng_r",					 --
    "scmid_l",					 --
    "scmid_r",					 --
    "scshrtl",					 --
    "scshrtr",					 --
    "sc_ltor",					 --
    "sc_rtol"					 --
  },					 --
  shamal = {					 --
    "shamal_align",					 --
    "shamal_getin_lhs",					 --
    "shamal_getout_lhs",					 --
    "shamal_open"					 --
  },					 --
  shop = {					 --
    "rob_2idle",					 --
    "rob_loop",					 --
    "rob_loop_threat",					 --
    "rob_shifty",					 --
    "rob_stickup_in",					 --
    "shp_duck",					 --
    "shp_duck_aim",					 --
    "shp_duck_fire",					 --
    "shp_gun_aim",					 --
    "shp_gun_duck",					 --
    "shp_gun_fire",					 --
    "shp_gun_grab",					 --
    "shp_gun_threat",					 --
    "shp_handsup_scr",					 --
    "shp_jump_glide",					 --
    "shp_jump_land",					 --
    "shp_jump_launch",					 --
    "shp_rob_givecash",					 --
    "shp_rob_handsup",					 --
    "shp_rob_react",					 --
    "shp_serve_end",					 --
    "shp_serve_idle",					 --
    "shp_serve_loop",					 --
    "shp_serve_start",					 --
    "smoke_ryd"					 --
  },					 --
  shotgun = {					 --
    "shotgun_crouchfire",					 --
    "shotgun_fire",					 --
    "shotgun_fire_poor"					 --
  },					 --
  silenced = {					 --
    "crouchreload",					 --
    "silencecrouchfire",					 --
    "silence_fire",					 --
    "silence_reload"					 --
  },					 --
  skate = {					 --
    "skate_idle",					 --
    "skate_run",					 --
    "skate_sprint"					 --
  },					 --
  smoking = {					 --
    "f_smklean_loop",					 --
    "m_smklean_loop",					 --
    "m_smkstnd_loop",					 --
    "m_smk_drag",					 --
    "m_smk_in",					 --
    "m_smk_loop",					 --
    "m_smk_out",					 --
    "m_smk_tap"					 --
  },					 --
  sniper = {					 --
    "weapon_sniper"					 --
  },					 --
  spraycan = {					 --
    "spraycan_fire",					 --
    "spraycan_full"					 --
  },					 --
  strip = {					 --
    "ply_cash",					 --
    "pun_cash",					 --
    "pun_holler",					 --
    "pun_loop",					 --
    "strip_a",					 --
    "strip_b",					 --
    "strip_c",					 --
    "strip_d",					 --
    "strip_e",					 --
    "strip_f",					 --
    "strip_g",					 --
    "str_a2b",					 --
    "str_b2a",					 --
    "str_b2c",					 --
    "str_c1",					 --
    "str_c2",					 --
    "str_c2b",					 --
    "str_loop_a",					 --
    "str_loop_b",					 --
    "str_loop_c"					 --
  },					 --
  sunbathe = {					 --
    "batherdown",					 --
    "batherup",					 --
    "lay_bac_in",					 --
    "lay_bac_out",					 --
    "parksit_m_idlea",					 --
    "parksit_m_idleb",					 --
    "parksit_m_idlec",					 --
    "parksit_m_in",					 --
    "parksit_m_out",					 --
    "parksit_w_idlea",					 --
    "parksit_w_idleb",					 --
    "parksit_w_idlec",					 --
    "parksit_w_in",					 --
    "parksit_w_out",					 --
    "sbathe_f_lieb2sit",					 --
    "sbathe_f_out",					 --
    "sitnwait_in_w",					 --
    "sitnwait_out_w"					 --
  },					 --
  swat = {					 --
    "gnstwall_injurd",					 --
    "jmp_wall1m_180",					 --
    "rail_fall",					 --
    "rail_fall_crawl",					 --
    "swt_breach_01",					 --
    "swt_breach_02",					 --
    "swt_breach_03",					 --
    "swt_go",					 --
    "swt_lkt",					 --
    "swt_sty",					 --
    "swt_vent_01",					 --
    "swt_vent_02",					 --
    "swt_vnt_sht_die",					 --
    "swt_vnt_sht_in",					 --
    "swt_vnt_sht_loop",					 --
    "swt_wllpk_l",					 --
    "swt_wllpk_l_back",					 --
    "swt_wllpk_r",					 --
    "swt_wllpk_r_back",					 --
    "swt_wllshoot_in_l",					 --
    "swt_wllshoot_in_r",					 --
    "swt_wllshoot_out_l",					 --
    "swt_wllshoot_out_r"					 --
  },					 --
  sweet = {					 --
    "ho_ass_slapped",					 --
    "lafin_player",					 --
    "lafin_sweet",					 --
    "plyr_hndshldr_01",					 --
    "sweet_ass_slap",					 --
    "sweet_hndshldr_01",					 --
    "sweet_injuredloop"					 --
  },					 --
  swim = {					 --
    "swim_breast",					 --
    "swim_crawl",					 --
    "swim_dive_under",					 --
    "swim_glide",					 --
    "swim_jumpout",					 --
    "swim_tread",					 --
    "swim_under"					 --
  },					 --
  sword = {					 --
    "sword_1",					 --
    "sword_2",					 --
    "sword_3",					 --
    "sword_4",					 --
    "sword_block",					 --
    "sword_hit_1",					 --
    "sword_hit_2",					 --
    "sword_hit_3",					 --
    "sword_idle",					 --
    "sword_part"					 --
  },					 --
  tank = {					 --
    "tank_align_lhs",					 --
    "tank_close_lhs",					 --
    "tank_doorlocked",					 --
    "tank_getin_lhs",					 --
    "tank_getout_lhs",					 --
    "tank_open_lhs"					 --
  },					 --
  tattoos = {					 --
    "tat_arml_in_o",					 --
    "tat_arml_in_p",					 --
    "tat_arml_in_t",					 --
    "tat_arml_out_o",					 --
    "tat_arml_out_p",					 --
    "tat_arml_out_t",					 --
    "tat_arml_pose_o",					 --
    "tat_arml_pose_p",					 --
    "tat_arml_pose_t",					 --
    "tat_armr_in_o",					 --
    "tat_armr_in_p",					 --
    "tat_armr_in_t",					 --
    "tat_armr_out_o",					 --
    "tat_armr_out_p",					 --
    "tat_armr_out_t",					 --
    "tat_armr_pose_o",					 --
    "tat_armr_pose_p",					 --
    "tat_armr_pose_t",					 --
    "tat_back_in_o",					 --
    "tat_back_in_p",					 --
    "tat_back_in_t",					 --
    "tat_back_out_o",					 --
    "tat_back_out_p",					 --
    "tat_back_out_t",					 --
    "tat_back_pose_o",					 --
    "tat_back_pose_p",					 --
    "tat_back_pose_t",					 --
    "tat_back_sit_in_p",					 --
    "tat_back_sit_loop_p",					 --
    "tat_back_sit_out_p",					 --
    "tat_bel_in_o",					 --
    "tat_bel_in_t",					 --
    "tat_bel_out_o",					 --
    "tat_bel_out_t",					 --
    "tat_bel_pose_o",					 --
    "tat_bel_pose_t",					 --
    "tat_che_in_o",					 --
    "tat_che_in_p",					 --
    "tat_che_in_t",					 --
    "tat_che_out_o",					 --
    "tat_che_out_p",					 --
    "tat_che_out_t",					 --
    "tat_che_pose_o",					 --
    "tat_che_pose_p",					 --
    "tat_che_pose_t",					 --
    "tat_drop_o",					 --
    "tat_idle_loop_o",					 --
    "tat_idle_loop_t",					 --
    "tat_sit_in_o",					 --
    "tat_sit_in_p",					 --
    "tat_sit_in_t",					 --
    "tat_sit_loop_o",					 --
    "tat_sit_loop_p",					 --
    "tat_sit_loop_t",					 --
    "tat_sit_out_o",					 --
    "tat_sit_out_p",					 --
    "tat_sit_out_t"					 --
  },					 --
  tec = {					 --
    "tec_crouchfire",					 --
    "tec_crouchreload",					 --
    "tec_fire",					 --
    "tec_reload"					 --
  },					 --
  train = {					 --
    "tran_gtup",					 --
    "tran_hng",					 --
    "tran_ouch",					 --
    "tran_stmb"					 --
  },					 --
  truck = {					 --
    "truck_align_lhs",					 --
    "truck_align_rhs",					 --
    "truck_closedoor_lhs",					 --
    "truck_closedoor_rhs",					 --
    "truck_close_lhs",					 --
    "truck_close_rhs",					 --
    "truck_getin_lhs",					 --
    "truck_getin_rhs",					 --
    "truck_getout_lhs",					 --
    "truck_getout_rhs",					 --
    "truck_jackedlhs",					 --
    "truck_jackedrhs",					 --
    "truck_open_lhs",					 --
    "truck_open_rhs",					 --
    "truck_pullout_lhs",					 --
    "truck_pullout_rhs",					 --
    "truck_shuffle"					 --
  },					 --
  uzi = {					 --
    "uzi_crouchfire",					 --
    "uzi_crouchreload",					 --
    "uzi_fire",					 --
    "uzi_fire_poor",					 --
    "uzi_reload"					 --
  },					 --
  van = {					 --
    "van_close_back_lhs",					 --
    "van_close_back_rhs",					 --
    "van_getin_back_lhs",					 --
    "van_getin_back_rhs",					 --
    "van_getout_back_lhs",					 --
    "van_getout_back_rhs",					 --
    "van_open_back_lhs",					 --
    "van_open_back_rhs"					 --
  },					 --
  vending = {					 --
    "vend_drink2_p",					 --
    "vend_drink_p",					 --
    "vend_eat1_p",					 --
    "vend_eat_p",					 --
    "vend_use",					 --
    "vend_use_pt2"					 --
  },					 --
  vortex = {					 --
    "car_jumpin_lhs",					 --
    "car_jumpin_rhs",					 --
    "vortex_getout_lhs",					 --
    "vortex_getout_rhs"					 --
  },					 --
  wayfarer = {					 --
    "wf_back",					 --
    "wf_drivebyft",					 --
    "wf_drivebylhs",					 --
    "wf_drivebyrhs",					 --
    "wf_fwd",					 --
    "wf_getoffback",					 --
    "wf_getofflhs",					 --
    "wf_getoffrhs",					 --
    "wf_hit",					 --
    "wf_jumponl",					 --
    "wf_jumponr",					 --
    "wf_kick",					 --
    "wf_left",					 --
    "wf_passenger",					 --
    "wf_pushes",					 --
    "wf_ride",					 --
    "wf_right",					 --
    "wf_still"					 --
  },					 --
  weapons = {					 --
    "shp_1h_lift",					 --
    "shp_1h_lift_end",					 --
    "shp_1h_ret",					 --
    "shp_1h_ret_s",					 --
    "shp_2h_lift",					 --
    "shp_2h_lift_end",					 --
    "shp_2h_ret",					 --
    "shp_2h_ret_s",					 --
    "shp_ar_lift",					 --
    "shp_ar_lift_end",					 --
    "shp_ar_ret",					 --
    "shp_ar_ret_s",					 --
    "shp_g_lift_in",					 --
    "shp_g_lift_out",					 --
    "shp_tray_in",					 --
    "shp_tray_out",					 --
    "shp_tray_pose"					 --
  },					 --
  wuzi = {					 --
    "cs_dead_guy",					 --
    "cs_plyr_pt1",					 --
    "cs_plyr_pt2",					 --
    "cs_wuzi_pt1",					 --
    "cs_wuzi_pt2",					 --
    "walkstart_idle_01",					 --
    "wuzi_follow",					 --
    "wuzi_greet_plyr",					 --
    "wuzi_greet_wuzi",					 --
    "wuzi_grnd_chk",					 --
    "wuzi_stand_loop",					 --
    "wuzi_walk"					 --
  }					 --
}					 --
					 --
					 --
local selected = 1					 --
local selectedblock = "nil"					 --
local selectedAnim = 1					 --
local animCount = 0					 --
for k,v in pairs(animations) do					 --
	animCount = animCount + 1					 --
end					 --
					 --
addEventHandler("onClientRender",root,function()					 --
	local i = 0					 --
	for k,v in pairs(animations) do					 --
		i = i + 1					 --
		local x = 10 + 100*math.floor(i/20)					 --
		local y = (i%20)*14					 --
					 --
		local col = tocolor(255,255,255,255)					 --
		if i == selected then					 --
			selectedblock = k					 --
			col = tocolor(255,100,50,255)					 --
					 --
			local j = 0					 --
			for k,anim in pairs(v) do					 --
				j = j + 1					 --
				local ax = 10 + 100*math.floor(j/20)					 --
				local ay = 300 + (j%20)*14					 --
				local colco = tocolor(255,255,255,255)					 --
									 --
				if textDraw then 					 --
					dxDrawRectangle(ax-2,ay-2,102,19,tocolor(75,10,30,240))										 --
					if selectedAnim == j then					 --
						if textDraw then dxDrawRectangle(ax-2,ay-2,102,19,tocolor(25,50,75,240)) end					 --
					end					 --
					dxDrawText(anim,ax,ay,100,100,colco) 					 --
				end					 --
			end					 --
					 --
		end					 --
		if textDraw then 					 --
			dxDrawRectangle(x-2,y-2,102,19,tocolor(10,10,75,240))					 --
			dxDrawText(k,x,y,100,100,col) 					 --
		end					 --
	end					 --
end)					 --
					 --
					 --
function changeSelected(ch)					 --
	if shift then					 --
		selected = selected + ch					 --
	else					 --
		selectedAnim = selectedAnim + ch					 --
	end					 --
	pufSelected()					 --
end					 --
function pufSelected()					 --
	if selected < 1 then					 --
		selected = animCount					 --
	end					 --
	if selected > animCount then					 --
		selected = 1					 --
	end					 --
	if selectedAnim > #animations[selectedblock] then					 --
		selectedAnim = 1					 --
	end					 --
	if selectedAnim < 1 then					 --
		selectedAnim = #animations[selectedblock]					 --
	end					 --
end					 --
shift = false					 --
bindKey("lshift","both",function(key,state)					 --
	shift = state == "down"					 --
end)					 --
bindKey("arrow_d","up",function()					 --
	changeSelected(1)					 --
	pufSelected()					 --
end)					 --
bindKey("arrow_u","up",function()					 --
	changeSelected(-1)					 --
	pufSelected()					 --
end)					 --
bindKey("arrow_r","up",function()					 --
	changeSelected(20)					 --
	pufSelected()					 --
end)					 --
bindKey("arrow_l","up",function()					 --
	changeSelected(-20)					 --
	pufSelected()					 --
end)					 --
					 --
					 --
bindKey("x","up",function()					 --
	 setPedAnimation(localPlayer, selectedblock, animations[selectedblock][selectedAnim], 					 --
	 	-1, 		-- time					 --
	 	true, 		-- loop					 --
	 	false,		-- updatePosition					 --
	 	true, 		-- interruptable					 --
	 	true, 		-- freezeLastFrame					 --
	 	250, 		-- blendTime					 --
	 	false		-- retainPedState					 --
	)					 --
end)					 --
bindKey("c","up",function()					 --
	textDraw = not textDraw					 --
end)					 --
textDraw = true					 --
					 --
					 --
					 --
---- crack block					 --
