--[[local offsReciptionDistance = 75

function generateOFFS(victim)
	
	local mX,mY,mZ = getElementPosition(localPlayer) 	
	local witnesses = getPLayersInRange(mX,mY,mZ,offsReciptionDistance)

	witnesses[tostring(victim)] = nil
	witnesses[tostring(localPlayer)] = nil

	triggerServerEvent("off-s",root, localPlayer,victim,witnesses)
end

addEvent("off-sGenerate",true)
addEventHandler("off-sGenerate",)
]]

unloadedOffences = {}



-------- Обработка offense signal
addEvent("off-s_offender",true)		--+-- Нарушитель
addEventHandler("off-s_offender",root,function(offsSer, offenseID)
	outputChatBox("#FF0C3FЯ нарушитель с серийным номером: ".. offsSer.." , код = "..offenseID,255,255,255,true)
end)

addEvent("off-s_victim",true)		--+-- Жертва
addEventHandler("off-s_victim",root,function(offsSer, offenseID)
	outputChatBox("#FFBB3FЯ жертва номера: ".. offsSer.." , код = "..offenseID,255,255,255,true)
	table.insert(unloadedOffences, {offsSer = offsSer, offenseID = offenseID})

end)

addEvent("off-s_witness",true)		--+-- Свидетель
addEventHandler("off-s_witness",root,function(offsSer, offenseID)
	outputChatBox("#0CFFFFЯ свидетель номера: ".. offsSer.." , код = "..offenseID,255,255,255,true)
	table.insert(unloadedOffences, {offsSer = offsSer, offenseID = offenseID})
	
end)