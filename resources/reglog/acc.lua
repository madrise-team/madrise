-------------------- players on server ---------------------------------------------
loggedPlayers = {}
addEvent("playerLogin",true)
addEventHandler("playerLogin",root,function(bdAccount,localBdAccount)
	loggedPlayers[bdAccount.nickname] = source
end)
addEventHandler("onPlayerQuit",root,function()
	local nick = getPlayerNickName(source)
	loggedPlayers[nick] = nil
end)
function getPlayerByNickName(nickname)
	local player = loggedPlayers[nickname]
	if player then return player end
end
function getLoggedPlyers()
	return loggedPlayers
end







-----------DEBUG сбор всех акков на restarte как будт они уже залогинилсь это временно потом удалить навсякий ----
for k,v in pairs(getElementsByType('player') ) do
 	loggedPlayers[getPlayerNickName(v)] = v
 	triggerClientEvent(v,"playerLogin",root)
end

outputDebugString("/////////////////\nИгроки на сервере:\n		 -")
for k,v in pairs(loggedPlayers) do
	outputDebugString(k)
end
outputDebugString("		-\n//////////////////")
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------