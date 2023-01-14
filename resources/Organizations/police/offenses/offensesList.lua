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
function sepDeb(space)
	outputChatBox("----------------------", root ,255,100,225)
	if space then outputChatBox(" ") end
end
function debOffenseInfo(offense)
	sepDeb()
	outputChatBox("Уреголирование правонарушения <Номер OFF-S: "..offense.serial..">\nПравонарушитель - "
			..offense.offender.."\nПострадавший - "..offense.victim.."\nTimestamp правонарушения - ["..offense.timestamp.."]\n    Урегулирование:" , root ,255,100,225)
end

resolve = {
	[1] = function(offense)
		debOffenseInfo(offense)
		outputChatBox("ИГНОРИРОВАТЬ! РукаЛицо это не то чем хотят заниматься правоохранительные органы" , root ,255,100,225)
		sepDeb(true)
	end

}