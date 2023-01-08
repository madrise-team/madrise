---- Идентификаторы статусов участников
statusIds = {
	[0] = "offender", offender = "Правонарушитель", 
	[1] = "victim", victim = "Жертва правонарушения", 
	[2] = "witness", witness = "Свидетель правонарушения" 
}


---- Идентификаторы правнонарушений
OFFsIds = {
	["РукаЛицо"] = 1, [1] = "РукаЛицо"
}

---- Методы урегулирования правонарушений *(по идентификаторам!)
local debCol = "#FF2277"
function sepDeb(space)
	outputChatBox(debCol.."----------------------")
	if space then outputChatBox(" ") end
end
function debOffenseInfo(offense)
	sepDeb()
	outputChatBox(debCol.."Уреголирование правонарушения <Номер OFF-S: "..offense.serial..">\nПравонарушитель - "
			..offense.offender.."\nПострадавший - "..offense.victim.."\ntTimestamp правонарушения - ["..offense.timestamp.."]\n    Урегулирование:" , 255,255,255, true)
end

resolve = {
	[1] = function(offense)
		debOffenseInfo(offense)
		outputChatBox(debCol.."ИГНОРИРОВАТЬ! РукаЛицо это не то чем хотят заниматься правоохранительные органы" , 255,255,255, true)
		sepDeb(true)
	end

}