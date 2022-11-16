					 --
-------------------------------------------------------------------------------					 --
weapons = {}					 --
-------------------------------------------------------------------------------					 --
weapons.ak47 = {}					 --
	weapons.ak47.name = "AK-47"					 --
	weapons.ak47.id = 30					 --
	weapons.ak47.cost = 100					 --
	weapons.ak47.bullets = 120					 --
	weapons.ak47.marker = createMarker(298.91223, -35.14608, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.ak47.marker, 1)					 --
	--setElementDimension(weapons.ak47.marker, 80)					 --
weapons.m4 = {}					 --
	weapons.m4.name = "M4"					 --
	weapons.m4.id = 31					 --
	weapons.m4.cost = 150					 --
	weapons.m4.bullets = 120					 --
	weapons.m4.marker = createMarker(298.91223, -32.25956, 1000.5802, "cylinder", 1.0, 80, 80, 80, 0)					 --
	setElementInterior(weapons.m4.marker, 1)					 --
weapons.kastet = {}					 --
	weapons.kastet.name = "Кастет"					 --
	weapons.kastet.id = 1					 --
	weapons.kastet.cost = 100					 --
	weapons.kastet.bullets = 1					 --
	weapons.kastet.marker = createMarker(289.18066, -40.8137, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.kastet.marker, 1)						 --
weapons.knife = {}					 --
	weapons.knife.name = "Нож"					 --
	weapons.knife.id = 4					 --
	weapons.knife.cost = 100					 --
	weapons.knife.bullets = 1					 --
	weapons.knife.marker = createMarker(290.61829, -40.8137, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.knife.marker, 1)						 --
weapons.colt = {}					 --
	weapons.colt.name = "Colt 45"					 --
	weapons.colt.id = 22					 --
	weapons.colt.cost = 100					 --
	weapons.colt.bullets = 100					 --
	weapons.colt.marker = createMarker(289.91757, -31.02784, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.colt.marker, 1)					 --
weapons.deagle = {}					 --
	weapons.deagle.name = "Deagle"					 --
	weapons.deagle.id = 24					 --
	weapons.deagle.cost = 100					 --
	weapons.deagle.bullets = 100					 --
	weapons.deagle.marker = createMarker(291.37808, -31.02784, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.deagle.marker, 1)					 --
weapons.shotgun = {}					 --
	weapons.shotgun.name = "Shotgun"					 --
	weapons.shotgun.id = 25					 --
	weapons.shotgun.cost = 100					 --
	weapons.shotgun.bullets = 100					 --
	weapons.shotgun.marker = createMarker(285.39651, -39.28011, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.shotgun.marker, 1)					 --
weapons.uzi = {}					 --
	weapons.uzi.name = "Uzi"					 --
	weapons.uzi.id = 28					 --
	weapons.uzi.cost = 100					 --
	weapons.uzi.bullets = 100					 --
	weapons.uzi.marker = createMarker(292.83459, -31.02784, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.uzi.marker, 1)					 --
weapons.tec = {}					 --
	weapons.tec.name = "Tec-9"					 --
	weapons.tec.id = 32					 --
	weapons.tec.cost = 100					 --
	weapons.tec.bullets = 100					 --
	weapons.tec.marker = createMarker(294.29721, -31.02784, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.tec.marker, 1)					 --
weapons.shotg = {}					 --
	weapons.shotg.name = "Sawed-off"					 --
	weapons.shotg.id = 26					 --
	weapons.shotg.cost = 100					 --
	weapons.shotg.bullets = 100					 --
	weapons.shotg.marker = createMarker(295.84882, -31.02784, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.shotg.marker, 1)					 --
weapons.riffle = {}					 --
	weapons.riffle.name = "Rifle"					 --
	weapons.riffle.id = 33					 --
	weapons.riffle.cost = 100					 --
	weapons.riffle.bullets = 100					 --
	weapons.riffle.marker = createMarker(285.39651, -35.45837, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.riffle.marker, 1)					 --
weapons.armor = {}					 --
	weapons.armor.name = "Бронежилет"					 --
	weapons.armor.id = 33					 --
	weapons.armor.cost = 100					 --
	weapons.armor.bullets = 100					 --
	weapons.armor.marker = createMarker(294.3782, -38.35971, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.armor.marker, 1)					 --
weapons.spaz = {}					 --
	weapons.spaz.name = "SPAZ-12"					 --
	weapons.spaz.id = 27					 --
	weapons.spaz.cost = 100					 --
	weapons.spaz.bullets = 100					 --
	weapons.spaz.marker = createMarker(285.39651, -31.73584, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.spaz.marker, 1)					 --
weapons.granade = {}					 --
	weapons.granade.name = "Граната"					 --
	weapons.granade.id = 16					 --
	weapons.granade.cost = 100					 --
	weapons.granade.bullets = 100					 --
	weapons.granade.marker = createMarker(297.37152, -31.02784, 1000.5802, "cylinder", 1.0, 80, 180, 80, 0)					 --
	setElementInterior(weapons.granade.marker, 1)					 --
					 --
					 --
-------------------------------------------------------------------------------					 --
--weapons.cost = {}					 --
--	weapons.cost.ak47 = 100					 --
--	weapons.cost.m4 = 150					 --
--weapons.id = {}					 --
--	weapons.id.ak47 = 30					 --
--	weapons.id.m4 = 31					 --
--weapons.bullets = {}					 --
--	weapons.bullets.ak47 = 120					 --
--	weapons.bullets.m4 = 120					 --
--weapons.marker = {}					 --
--	weapons.marker.ak74 = createMarker(2496.5515, -1677.9412, 12.5321, "cylinder", 2.0, 80, 80, 80, 200)					 --
--	weapons.marker.m4 = createMarker(2499.5515, -1677.9412, 12.5321, "cylinder", 2.0, 80, 80, 80, 200)					 --
-------------------------------------------------------------------------------					 --
--local marker_ammo_ak47 = createMarker(2496.5515, -1677.9412, 12.5321, "cylinder", 2.0, 80, 80, 80, 200)---------------------ak47(30)					 --
--local marker_ammo_m4 = createMarker(2499.5515, -1677.9412, 12.5321, "cylinder", 2.0, 80, 80, 80, 200)---------------------m4(31)					 --
					 --
for weaponName,weapon in pairs(weapons) do					 --
	addEventHandler("onMarkerHit", weapon.marker, function(thePlayer)					 --
		if getElementType(thePlayer) ~= "player" then return end					 --
		triggerClientEvent(thePlayer,"AmmonationsMarker",root, weapon)					 --
	end)					 --
	addEventHandler("onMarkerLeave", weapon.marker, function(thePlayer)					 --
		if getElementType(thePlayer) ~= "player" then return end					 --
		triggerClientEvent(thePlayer,"leave AmmonationsMarker",root)					 --
	end)					 --
end					 --
--[[					 --
addEventHandler("onMarkerHit", weapons.ak47.marker, function(thePlayer)					 --
	if getElementType(thePlayer) ~= "player" then return end					 --
	outputChatBox(tostring(weapons.ak47))					 --
	triggerClientEvent(thePlayer,"AmmonationsMarker",root, weapons.ak47)					 --
end)					 --
addEventHandler("onMarkerLeave", weapons.ak47.marker, function(thePlayer)					 --
	if getElementType(thePlayer) ~= "player" then return end					 --
	triggerClientEvent(thePlayer,"leave AmmonationsMarker",root)					 --
end)					 --
					 --
addEventHandler("onMarkerHit", weapons.m4.marker, function(thePlayer)					 --
	if getElementType(thePlayer) ~= "player" then return end					 --
	triggerClientEvent(thePlayer,"AmmonationsMarker",root, weapons.m4)					 --
end)					 --
addEventHandler("onMarkerLeave", weapons.m4.marker, function(thePlayer)					 --
	if getElementType(thePlayer) ~= "player" then return end					 --
	triggerClientEvent(thePlayer,"leave AmmonationsMarker",root)					 --
end)--]]					 --
					 --
					 --
addEvent("y_buyer", true)					 --
addEventHandler("y_buyer", root, function(thePlayer, weaponInfo)					 --
						 --
	if weaponInfo.name == "Бронежилет" then					 --
		if getPedArmor(thePlayer) ~= 100 then					 --
			setPedArmor(thePlayer, 100)					 --
		else					 --
			outputChatBox("У Вас уже есть броня!", thePlayer)					 --
			return					 --
		end					 --
	else					 --
		giveWeapon(thePlayer, weaponInfo.id, weaponInfo.bullets)					 --
	end					 --
					 --
	takePlayerMoney(thePlayer, weaponInfo.cost)					 --
	outputChatBox("Вы купили "..weaponInfo.name.." за 100$.", thePlayer)					 --
end)					 --
