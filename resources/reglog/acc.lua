-------------------- players on server ---------------------------------------------
loggedPlayers = {}
addEvent("playerLogin",true)
addEventHandler("playerLogin",root,function(bdAccount,localBdAccount)
	loggedPlayers[bdAccount.nickname] = source
	loggedPlayers[bdAccount.id] = source
end)
addEventHandler("onPlayerQuit",root,function()
	local nick = getPlayerNickName(source)
	local id = getPlayerID(source)
	
	if (not nick) or (not id) then return end

	loggedPlayers[nick] = nil
	loggedPlayers[id] = nil
end)
function getPlayerByNickName(nickname)
	local player = loggedPlayers[nickname]
	if player then return player end
end
function getPlayerByID(id)
	local player = loggedPlayers[id]
	if player then return player end
end
function getLoggedPlyers()
	return loggedPlayers
end







-----------DEBUG сбор всех акков на restarte как будт они уже залогинилсь это временно потом удалить навсякий ----
for k,player in pairs(getElementsByType('player') ) do
 	local id  = getPlayerID(player)
 	if id then
	 	getAccountColumn(id,'*',function(bdAccount)
	 		triggerEvent("playerLogin",player, bdAccount)
			triggerClientEvent(player,"playerLogin",root)
	 	end)
 	end
end

setTimer(function()
	local vals = {}
	for k,v in pairs(loggedPlayers) do
		local keystr = tostring(v)
		if not vals[keystr] then vals[keystr] = {} end
		
		local tabKey = "nick"
		if tonumber(k) then tabKey = "id" end
		vals[keystr][tabKey] = k
	end

	local outDebStr = ""
	for k,v in pairs(vals) do
		outDebStr = outDebStr .. v.id .. " ".. v.nick .."\n"
	end
	outDebStr = string.sub(outDebStr, 0, #outDebStr-1)
	outputDebugString("\n/////////////////  Игроки на сервере:\n\n"..outDebStr.."\n\n//////////////////")
end,2000,1)
------------------------------------------------------------------------------------------------------------------