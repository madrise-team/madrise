local localOffsSerial = 0

function handleOffs(offender, victim, witnesses, offenseID)
	localOffsSerial = localOffsSerial + 1	

	local offenderNick = getPlayerNickName(offender)
	local victimNick = getPlayerNickName(victim)


	local offsTotalSerial = 0
	for var in string.gmatch(offenderNick,"%a") do 	offsTotalSerial = offsTotalSerial + string.byte(var)  end
	for var in string.gmatch(victimNick,"%a") do  offsTotalSerial = offsTotalSerial + string.byte(var)  end
	offsTotalSerial = (offsTotalSerial + getRealTime().timestamp + localOffsSerial)

	outputChatBox("___ ---")
	outputChatBox("OFF-S: {"..offenderNick.." >> "..victimNick.."} serial: "..offsTotalSerial.. " ("..localOffsSerial.." - local) ")
	outputChatBox(" serial numeber - "..offsTotalSerial.." offenseID = "..offenseID.. " - "..OFFsIds[1])
	outputChatBox("--- ___")

	--- Отправка информации нарушителю, жертве и свидетелям
	if offender then triggerLatentClientEvent(offender,"off-s_offender",5000,root,offsTotalSerial, offenseID) end
	if victim then triggerLatentClientEvent (victim,"off-s_victim",5000,root,offsTotalSerial, offenseID) end
	for k,witness in pairs(witnesses) do  
		if witness then
			triggerLatentClientEvent (witness,"off-s_witness",5000,root,offsTotalSerial, offenseID)
		end
	end

	--- Сохранение информации у нарушителя о совершении преступления
	if offender then
		local offenderNick = getPlayerNickName(offender)
		addToAccountSavedOffence(offenderNick, offsTotalSerial)
	end


end
addEvent("off-s",true)
addEventHandler("off-s",root,handleOffs)


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--// Выгрузка правонарушений
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

insertedOffenses = {}				--- серийники, которые уже вносил сервер
function getOffense(serial,callback)
	get1DbData("offenses",'serial',serial,callback)
end

function isLogExist(serial,callback)
	if insertedOffenses[serial] then callback(true); return end
	isRowExists("offenses","serial",serial,function(rowsCount)
		if rowsCount > 0 then callback(true); return end
	end)
	callback(false)
end

function insertNewOffensLog(serial, offenseId, column, value)
	insertedOffenses[serial] = true
	dbExec(SQLStorage,"INSERT INTO `offenses`(`serial`,`??`,`timestamp`,`offenseId`) VALUES (?,?,?,?)" ,column, serial ,value, getRealTime().timestamp, offenseId)
end
function insertInOffensLog(serial, column, value, witness)
	local bdFunc = setDbColumnValueByColumnSearch 
	if witness then bdFunc = addElmByValueToColumnArray end

	bdFunc('offenses','serial',serial,  column, value)
end


function formStatus(status,value)
	local statusBD = "offender"
	local valueBD = value

	local witness = false

	if status == 1 then
		statusBD = "victim"
	elseif status == 2 then
		statusBD = "witnesses"
		valueBD = toJSON(value)
		witness = true
	end

	return statusBD, valueBD, witness
end


addEvent("unloadOff-s",true)
addEventHandler("unloadOff-s",root,function(data)
	local playerNick = getPlayerNickName(data.player)
	local playerLogin = getPlayerLogin(data.player)

	local status = statusIds[data.status]
	local statusName = statusIds[status]

--		Дебуг лол ---------------------------------------------------
	outputChatBox("+------  [ АИС Police приняла лог OFF-s ] --+")
	
	outputChatBox("OFF-s: "..data.serial)
	outputChatBox(statusName..": "..playerNick)
	outputChatBox("Правонарушение: "..OFFsIds[data.id])
	
	outputChatBox("+-------------------------------------------+")
--	----------------------------------------------------------------]]


	------ Сохранение лога в БД
	local statusBD, valueBD, witness = formStatus(data.status, playerLogin)
	isLogExist(data.serial,function(exist)
		if exist then	
			insertInOffensLog(data.serial, statusBD, playerLogin, witness)
		else
			insertNewOffensLog(data.serial, data.id , statusBD, valueBD)
		end
	end)


end)