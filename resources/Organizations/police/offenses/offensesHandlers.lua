damageTypes = {
	["Rocket"] = 19,
	["Burnt"] = 37,
	["Rammed"] = 49,
	["Ranover/Helicopter Blades"] = 50,
	["Explosion"] = 51,
	["Driveby"] = 52,
	["Drowned"] = 53,
	["Fall"] = 54,
	["Unknown"] = 55,
	["Melee"] = 56,
	["Weapon"] = 57,
	["Tank Grenade"] = 59,
	["Blown"] = 63
}

local offsReciptionDistance = 75

function generateOFFS(offender,victim,offenseID)
	local mX,mY,mZ = getElementPosition(offender) 	
	local witnesses = getPLayersInRange(mX,mY,mZ,offsReciptionDistance)

	witnesses[tostring(victim)] = nil
	witnesses[tostring(offender)] = nil

	handleOffs(offender, victim, witnesses, offenseID)
end


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--// УДАР РУКАЛИЦО
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
addEventHandler("onPlayerDamage",root,function(attacker, weapon, bodypart, loss)
	if not attacker then return end
	if weapon ~= 0 then return end

	local victimNick = getPlayerNickName(source)
	local offenderNick = getPlayerNickName(attacker)

	outputChatBox("Ох нихуя себе блять! Произошло опиздюливаие игрока [ "..victimNick.." ] игроком ["..offenderNick.." ]")
	outputChatBox("Регистрирую правонарушение")

	generateOFFS(attacker,source,OFFsIds["РукаЛицо"])
end)