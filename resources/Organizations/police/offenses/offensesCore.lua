local offenseTriggerSpeedLimit = 5000

--- Срок истечения давности записи
local offenseForgetTime = {days = 28}; local offenseForgetTimeSecs = convertToSecs(offenseForgetTime)
---								--


local localOffsSerial = 0

function handleOffs(offender, victim, witnesses, offenseID)
	localOffsSerial = localOffsSerial + 1	

	local offenderNick = getPlayerNickName(offender)
	local victimNick = getPlayerNickName(victim)

	local timestamp = getRealTime().timestamp

	local offsTotalSerial = 0
	for var in string.gmatch(offenderNick,"%a") do 	offsTotalSerial = offsTotalSerial + string.byte(var)  end
	for var in string.gmatch(victimNick,"%a") do  offsTotalSerial = offsTotalSerial + string.byte(var)  end
	offsTotalSerial = (offsTotalSerial + getRealTime().timestamp + localOffsSerial)

	outputChatBox("___ ---")
	outputChatBox("OFF-S: {"..offenderNick.." >> "..victimNick.."} serial: "..offsTotalSerial.. " ("..localOffsSerial.." - local) ")
	outputChatBox(" serial numeber - "..offsTotalSerial.." offenseID = "..offenseID.. " - "..OFFsIds[1])
	outputChatBox("--- ___")

	--- Отправка информации нарушителю, жертве и свидетелям
	if offender then triggerLatentClientEvent(offender,"off-s_offender",offenseTriggerSpeedLimit,root,offsTotalSerial, offenseID, timestamp) end
	if victim then triggerLatentClientEvent (victim,"off-s_victim",offenseTriggerSpeedLimit,root,offsTotalSerial, offenseID) end
	for k,witness in pairs(witnesses) do  
		if witness then
			triggerLatentClientEvent (witness,"off-s_witness",offenseTriggerSpeedLimit,root,offsTotalSerial, offenseID)
		end
	end

	--- Сохранение информации у нарушителя о совершении преступления
	if offender then
		addToAccountSavedOffence(offenderNick, offsTotalSerial,timestamp,offenseID)
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

function removeOffense(serial,offense)
	removeDbDataByColumnSearch('offenses','serial',serial)
	if offense then
		local text = "Запись: "..offense.serial.." удалена по причине истечения срока давности."
		outputChatBox(text)
		outputDebugString(text)
	end
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

	local statusCodename = statusIds[data.status]
	local statusName = statusIds[statusCodename]

--		Дебуг лол ---------------------------------------------------
	outputChatBox("+------  [ АИС Police приняла лог OFF-s ] --+")
	outputChatBox("OFF-s: "..data.serial)
	outputChatBox(statusName..": "..playerNick)
	outputChatBox("Правонарушение: "..OFFsIds[data.id])
	outputChatBox("+-------------------------------------------+")
--	----------------------------------------------------------------]]


	------ Сохранение лога в БД >> попытка урегулировать
	local statusBD, valueBD, witness = formStatus(data.status, playerLogin)
	isLogExist(data.serial,function(exist)
		if exist then	
			insertInOffensLog(data.serial, statusBD, playerLogin, witness)
		else
			insertNewOffensLog(data.serial, data.id , statusBD, valueBD)
		end

		------- Урегулирование правонарушения
		if not exist then return end

		getOffense(data.serial,function(offense)

			if getRealTime().timestamp - offense.timestamp < offenseForgetTimeSecs then
				if data.timestamp then 
					insertInOffensLog(data.serial, "timestamp", data.timestamp) 
					offense.timestamp = data.timestamp
				end
				if (offense.offender ~= nil) and (offense.victim ~= nil) then

					-- В записи правонарушения обнаружены и правонарушитель и пострадавший
					-- Назначение наказания и закрытие записи

					resolve[data.id](offense)

				end
			else
				outputChatBox("Срок давности записи по принятому логу вышел!")
				removeOffense(offense.serial,offense)
			end
		end)

	end)

	------ Удаление выгруженного лога из аккаунта (только для правонарушителя)
	if data.status == 0 then
		removeFromAccountSavedOffence(playerNick, data.serial)
	end
end)

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--// Выгрузка правонарушений из аккаунта *(при заходе на сервер)
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
addEvent("playerLogin",true)
addEventHandler("playerLogin",root,function(bdAccount)
	triggerLatentClientEvent(source,"off-s_offender",root,bdAccount.notUploadedOffenses)
end)


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--// Удаление логов с истекшим сроком давности
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
getDbRows('offenses',function(data)
	for k,offense in pairs(data) do
		if getRealTime().timestamp - offense.timestamp > offenseForgetTimeSecs then
			removeOffense(offense.serial,offense)
		end
	end
end)