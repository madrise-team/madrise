----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
------------------------------------
SQLStorage = exports.DB:MSC()

-------------------- players on server ---------------------------------------------
loggedPlayers = {}
playersByLogin = {}

addEvent("playerLogin",true)
addEventHandler("playerLogin",root,function(bdAccount,localBdAccount)
	loggedPlayers[bdAccount.nickname] = source
	playersByLogin[bdAccount.login] = source
end)
addEventHandler("onPlayerLogout",root,function()
	loggedPlayers[getPlayerNickName(source)] = nil
	playersByLogin[getPlayerLogin(source)] = nil
end)

function getPlayerByNickName(nickname)
	local player = loggedPlayers[nickname]
	if player then return player end
end
function getPlayerByLogin(login)
	local player = playersByLogin[login]
	if player then return player end
end

function getLoggedPlyers()
	return loggedPlayers
end





-- DEBUFG ficha --------- костыльный сбор всех акков на restarte как будт они уже залогинилсь это временно потом удалить навсякий 
for k,v in pairs(getElementsByType('player') ) do
 	local vnick = getPlayerNickName(v)
 	if not vnick then 
	 	loggedPlayers[vnick] = v
	 	getAccountInfoByNickName(vnick,function(bdAccount)
			triggerEvent("playerLogin",v,bdAccount)
	 		triggerClientEvent(v,"playerLogin",root,info)
	 	end)
 	end
end

outputDebugString("/////////////////")
outputDebugString("Игроки на сервере:")
outputDebugString("		 -")
for k,v in pairs(loggedPlayers) do
	outputDebugString(k)
end
outputDebugString("		-")
outputDebugString("//////////////////")
---------------------------------------------------------------------------------------------------------------------------------
