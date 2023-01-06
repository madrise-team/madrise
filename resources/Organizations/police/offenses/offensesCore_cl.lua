----- imports
loadstring(exports.importer:load())()
import('TCN/TCN_usful_cl.lua')()    -- TCN
------------------------------------

local offsTransmitTime = 5

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

function transmitOFFSlog(offsSer, offenseID, status)
	local hwoText = "Лог Правонарушителя"
	if status == 1 then
		hwoText = "Лог Пострадавшего"
	elseif status == 2 then
		hwoText = "Лог Свидетеля правонарушения"
	end

	TCNtrasmit({time = offsTransmitTime,text = "OFF-s: "..hwoText.." #"..offsSer},function()
		triggerServerEvent("unloadOff-s",root,{
			player = localPlayer, 
			status = status,
			serial = offsSer, 
			id = offenseID
		})
	end)
end



-------- Обработка offense signal
addEvent("off-s_offender",true)		--+-- Нарушитель
addEventHandler("off-s_offender",root,function(offsSer, offenseID)
	outputChatBox("#FF0C3FЯ нарушитель с серийным номером: ".. offsSer.." , код = "..offenseID,255,255,255,true)
	transmitOFFSlog(offsSer, offenseID, 0)
end)

addEvent("off-s_victim",true)		--+-- Жертва
addEventHandler("off-s_victim",root,function(offsSer, offenseID)
	outputChatBox("#FFBB3FЯ жертва номера: ".. offsSer.." , код = "..offenseID,255,255,255,true)
	transmitOFFSlog(offsSer, offenseID, 1)
end)

addEvent("off-s_witness",true)		--+-- Свидетель
addEventHandler("off-s_witness",root,function(offsSer, offenseID)
	outputChatBox("#0CFFFFЯ свидетель номера: ".. offsSer.." , код = "..offenseID,255,255,255,true)
	transmitOFFSlog(offsSer, offenseID, 2)
	
end)


--[[
local dannie = 0
bindKey("0","down",function()
	dannie = dannie + 1
	local name = '"Радномные данные '..dannie..'"'
	outputChatBox('Отправлю '..name..' черерз ТКС')
	TCNtrasmit({time = 15+dannie,text = name},function()
		outputChatBox("#77FC2F Данные #FF22CC"..name.." #77FC2Fотправлены это типо произошло и вот это вывелось ибо данные отправлены",255,255,255,true)
	end)
end)
--]]