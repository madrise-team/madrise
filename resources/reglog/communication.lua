--- Получение списка контактов и передача на клиент
addEvent("playerLogin",true)
addEventHandler("playerLogin",root,function(bdAccount)
	local player = source

	getCustomSqlQuery( [[
		SELECT ac1.nickname AS ac1 ,ac2.nickname AS ac2, type
		FROM accounts_contacts JOIN accounts AS ac1 JOIN accounts AS ac2
		ON player1 = ac1.id AND player2 = ac2.id
		WHERE player1 = ? OR player2 = ?]]
	,function(datas)
		triggerLatentClientEvent(player,"communications_data",5000,false,root, datas)
	end, bdAccount.id, bdAccount.id)
end)


requests = {}

addEvent("addContactRequest",true)
addEventHandler("addContactRequest",root,function(player2, contactType)
	triggerLatentClientEvent(player2,"addContactRequest",5000,false,source, contactType)
	local p1Nik = getPlayerNickName(source)
	local p2Nik = getPlayerNickName(player2)
	outputChatBox("Redirected request [type("..contactType..")] from "..p1Nik.." to "..p2Nik)
end)

addEvent("addContact",true)
addEventHandler("addContact",root,function(player1, contactType)
	local player2 = source
	local player1ID = getPlayerID(player1)
	local player2ID = getPlayerID(player2)
	local p1Nik = getPlayerNickName(player1)
	local p2Nik = getPlayerNickName(player2)

	dbExec(SQLStorage,"DELETE FROM `accounts_contacts` WHERE (`player1` = ? AND `player2` = ?) OR (`player1` = ? AND `player2` = ?)",player1ID,player2ID,player2ID,player1ID)
	dbExec(SQLStorage,"INSERT INTO `accounts_contacts`(`player1`, `player2`, `type`) VALUES (?,?,?)",player1ID,player2ID, contactType)

	triggerLatentClientEvent(player1,"contactUpdate",1000,false,root,p2Nik, contactType)
	triggerLatentClientEvent(player2,"contactUpdate",1000,false,root,p1Nik, contactType)
end)


addEvent("addContactAnswer",true)
addEventHandler("addContactAnswer",root,function(player1, state)
	triggerLatentClientEvent(player1,"addContactAnswer",1000,false,root,source,false)
end)









--- deb querys UPDATE `accounts_contacts` SET `type`= 1 WHERE `player1` = 3 AND `player2` = 1