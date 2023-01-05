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




addEvent("unloadOff-s",true)
addEventHandler("unloadOff-s",root,function()
	
end)