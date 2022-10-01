loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful S
import('cannons/cannons_Prefabs.lua')() -- CannonsTables
-------------------------------------------------------------------------------------------------------------------------------------





--Cannon Framework Serverside -------------------------------------------------------------------------------------------------------
gunSerial = 0
function spasPlayerCannon(player,gunprops)
	gunSerial = gunSerial + 1
	local gunT = cannonsT[gunprops.gunKey]
	takeAllWeapons(player)
	giveWeapon(player,gunT.saweaponId,90000,true)

	gunprops.gunSerial = gunSerial
	triggerClientEvent("canonSpas",root,player,gunprops)
end
addEvent("spasPlayerCannon",true)
addEventHandler("spasPlayerCannon",root,spasPlayerCannon)

--
addCommandHandler("gg",function(player,_)
	spasPlayerCannon(player,{gunKey = "tazer"})	
end)

addEvent("shootGun",true)
addEventHandler("shootGun",root,function(gunSerial,argData)		-- shooter = source
	triggerClientEvent("shootGun",root,gunSerial,argData)
end)
addEvent("endshootGun",true)
addEventHandler("endshootGun",root,function(gunSerial,argData)		-- shooter = source
	triggerClientEvent("endshootGun",root,gunSerial,argData)
end)