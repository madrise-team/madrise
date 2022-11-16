----- imports					 --
loadstring(exports.importer:load())()					 --
import('RRL_Scripts/usfulS.lua')()    -- Usful Server					 --
					 --
import('loking/lokingWoksCoords.lua')()    -- Works Coords [+ Usful Shared]					 --
------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
pravayaVorotinaIkosaWorka = createObject (985, 1386.06372, -1653.32727, 14.08198, 0, 0, 270, false)					 --
levayaVorotinaIkosaWorka = createObject (986, 1386.05688, -1645.36707, 14.08435, 0, 0, 270, false)					 --
					 --
function getMatrix(elm)					 --
	return Matrix(Vector3(getElementPosition(elm)),Vector3(getElementRotation(elm)))					 --
end					 --
-------------------------------------------------Проверки----------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
function zalogDone(player, zalog)					 --
	if getPlayerMoney(player) >= zalog then					 --
		takePlayerMoney (player, zalog)					 --
		return true					 --
	else					 --
		outputChatBox("У вас не хватает денег для оплаты залога за рабочий транспорт.", player)					 --
		return false 					 --
	end					 --
end					 --
					 --
function isItAPlayer(element,player)					 --
	if not element then return false end					 --
	if element == player then					 --
		return true					 --
	else					 --
		if getElementType(element) == "vehicle" then					 --
			if getVehicleOccupant(element, 0) == player then					 --
				return true					 --
			end						 --
		end					 --
	end					 --
end					 --
					 --
function isVehicle(element)					 --
	if not element then return false end					 --
	if getElementType(element) == "vehicle" then					 --
		return true					 --
	end					 --
end					 --
					 --
function playerAvtoCheck(session, object)					 --
	if not session.avto then					 --
		return true					 --
	else					 --
		if JobsContent[session.jobName].checkAvto and not (session.checkAvto == false) then					 --
			if getPedOccupiedVehicle(session.player) == session.avto then return true end					 --
			if object == session.avto then return true end					 --
		else					 --
			return true					 --
		end					 --
		outputChatBox("!! Вы должны быть в казенном авто !!", session.player)  															---  Не в машине ---					 --
	end					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
------------------------------------------------   Некоторый функционал работ    ----------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
function secsNforAvtoTimer(secsN,secsNfuc,alltimefuc)					 --
	local bakedFuc = function(itteration,minSecs)					 --
		if alltimefuc then alltimefuc() end					 --
		if minSecs.fullsec <= secsN then					 --
			if secsNfuc then secsNfuc() end					 --
		end					 --
	end					 --
	return bakedFuc					 --
end					 --
function avtoTimer30secsBakedFuc(message)					 --
	return secsNforAvtoTimer(30,function()					 --
		outputChatBox(message or "Внимание! Если вы не вернетесь в рабочий транспрот в течении 30 секунд, работа будет завершена досрочно!")					 --
	end)					 --
end					 --
function findClearPlaceIndex(array)					 --
	for i,v in ipairs(array) do					 --
		if not v.placeHolded then return i end					 --
	end					 --
	return false					 --
end					 --
function getRandomClearPlace(array)					 --
	if not findClearPlaceIndex(array) then return false end					 --
						 --
	local iter = 0					 --
					 --
	while iter < 10000 do					 --
		iter = iter + 1					 --
					 --
		local pointIndex = math.random(1, #array)					 --
					 --
		if not array[pointIndex].placeHolded then					 --
			return pointIndex					 --
		end					 --
	end					 --
end					 --
					 --
function createPlaceHolder(x,y,z,type,size,r,g,b,a,session,func,placeHoldArray,holdingAvto)					 --
	placeHoldArray.placeHolded = true					 --
					 --
	holdingAvto = holdingAvto or session.avto					 --
					 --
	addNewMarker(x, y, z, type or "checkpoint", size, r,g,b,a, holdingAvto, session, func,"onMarkerLeave",function()					 --
		placeHoldArray.placeHolded = false					 --
	end)					 --
end					 --
					 --
					 --
function addNewMarker(x,y,z,type,size,r,g,b,a,chekedElement,session,func,eventName,destroyFunction)					 --
	local session = session or {}					 --
	local func = func or function()					 --
	end					 --
					 --
	local marka = {}					 --
	marka.tag = "marka"					 --
	marka.index = #session.markers + 1					 --
	session.markers[marka.index] = marka					 --
					 --
	marka.localMarker = createMarker (x,y,z,type,size, r, g, b, a, session.player)					 --
					 --
	local removed = false					 --
						 --
	local remove					 --
	local fuc					 --
	marka.remove = function()					 --
		if not removed then					 --
			removeEventHandler(eventName or "onMarkerHit",marka.localMarker,marka.fuc)					 --
			destroyElement(marka.localMarker)					 --
					 --
			if destroyFunction then	destroyFunction() end					 --
					 --
			removed = true					 --
			session.markers[marka.index] = nil					 --
		end					 --
	end					 --
	fuc = function(object)					 --
		if not isItAPlayer(object,chekedElement) then return end 					 --
		if not playerAvtoCheck(session, object) then return end					 --
					 --
		if func() ~= "cancel" then                                             -------проверка на неудаление чекпоинта					 --
			marka.remove()					 --
		end					 --
	end					 --
	marka.fuc = fuc					 --
					 --
	addEventHandler(eventName or "onMarkerHit",marka.localMarker,fuc)					 --
					 --
					 --
	return marka					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа доставки----------------------------------------------------------------------------------------------Работа доставки---------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа доставки----------------------------------------------------------------------------------------------Работа доставки---------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local dostJob = {}					 --
dostJob.checkAvto = true                                                             -------Нужна ли проверка на авто					 --
dostJob.zalog = 500					 --
					 --
dostJob.autos = CoordsDostJob.autos					 --
dostJob.roads = CoordsDostJob.roads					 --
dostJob.autoTipe = {414, 456, 498, 499}					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
dostJob.nachalo = function(session)					 --
	session.nachaloBlibDost = createBlip(-49.89774, -267.93707, 5.64368+1000, 51, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	addNewMarker(-49.89774, -267.93707, 5.64368, "cylinder", 2.0, 225, 0, 0, 200, session.player,session,function()					 --
		if zalogDone(session.player, dostJob.zalog) then					 --
							 --
		local avtoNum = findClearPlaceIndex(dostJob.autos)					 --
			if not avtoNum then 					 --
				outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
				return "cancel" 					 --
			end					 --
			session.avtoCoord = dostJob.autos[avtoNum]					 --
			session.roadNum = math.random(1, #dostJob.roads)					 --
			session.TipeAvtoNum = math.random(1, #dostJob.autoTipe)					 --
			session.TipeAvto = dostJob.autoTipe[session.TipeAvtoNum]					 --
						 --
			session.avto =  createVehicle (session.TipeAvto, session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "Dost Ltd")					 --
			createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,dostJob.autos[avtoNum])					 --
			session.createAvtoHandler(session.avto)					 --
			session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
								 --
			session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
						 --
			dostJob.doDostPoint(session)					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
dostJob.doDostPoint = function(session)					 --
	session.markerCoord = dostJob.roads[session.roadNum]					 --
	session.blipDost = createBlip(session.markerCoord[1], session.markerCoord[2], session.markerCoord[3]+1000, 56, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	addNewMarker(session.markerCoord[1], session.markerCoord[2], session.markerCoord[3], "checkpoint", 3.0, 200, 0, 0, 150, session.player,session,function()					 --
		destroyElement(session.blipDost); session.blipDost = nil					 --
		session.blipKonca = createBlip(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4]+1000, 56, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
		addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], "checkpoint", 3.0, 200, 0, 0, 150, session.player,session,function()					 --
			destroyElement(session.blipKonca); session.blipKonca = nil					 --
			dostJob.endJob(session)					 --
		end)					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
						 --
dostJob.endJob = function(session, endCode)					 --
	if not isEror(endCode) then givePlayerMoney(session.player,((session.avtoCoord[2]-session.markerCoord[1])^2 + (session.avtoCoord[3]-session.markerCoord[2])^2)^0.5) end					 --
	if not isEror(endCode) then givePlayerMoney(session.player,dostJob.zalog) end					 --
					 --
	local player,jobName = session.player, session.jobName					 --
	session.endJob()					 --
	dostJob.nachalo(createSession(player,jobName))					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа автобуса----------------------------------------------------------------------------------------------Работа автобуса---------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа автобуса----------------------------------------------------------------------------------------------Работа автобуса---------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local busJob = {}					 --
busJob.checkAvto = true                                                              -------Нужна ли проверка на авто					 --
busJob.zalog = 800					 --
					 --
busJob.autos = CoordsBusJob.autos					 --
busJob.roads = CoordsBusJob.roads					 --
-------------------------------------------------------------------------------------------------------------					 --
busJob.marshrutNums = {					 --
	---- Список доступных маршрутов из списка roads для городов, а также индекс отправного маркера 					 --
	---  { [1] = LS, [2] = SF, [3] = LV }					 --
					 --
	[1] = { {1,["start"] = 1,["endIndx"] = 45,["pay"] = 2000},					 --
			{2,["start"] = 1,["endIndx"] = 61,["pay"] = 2000},					 --
			{4,["start"] = 1,["endIndx"] = 19,["pay"] = 2000},					 --
			{5,["start"] = 1,["endIndx"] = 43,["pay"] = 2000}  },	--LS					 --
					 --
	[2] = { {2,["start"] = 25,["endIndx"] = 24,["pay"] = 2000},					 --
			{3,["start"] = 1, ["endIndx"] = 54,["pay"] = 2000},					 --
			{6,["start"] = 1, ["endIndx"] = 42,["pay"] = 2000},					 --
			{7,["start"] = 1, ["endIndx"] = 30,["pay"] = 2000}  },	--SF					 --
					 --
	[3] = { {1,["start"] = 25,["endIndx"] = 24,["pay"] = 2000},					 --
			{3,["start"] = 28,["endIndx"] = 27,["pay"] = 2000},					 --
			{8,["start"] = 1,["endIndx"] = 30,["pay"] = 2000},					 --
			{9,["start"] = 1,["endIndx"] = 62,["pay"] = 2000}  }	--LV					 --
}					 --
busJob.startMarshrut = function(session,gorod1)					 --
	local marshrutTable = busJob.marshrutNums[gorod1][math.random(1,#busJob.marshrutNums[gorod1])]					 --
	session.roadNum = marshrutTable[1]					 --
	session.road = busJob.roads[session.roadNum]					 --
					 --
	local avtoNum = findClearPlaceIndex(busJob.autos[gorod1])					 --
	if not avtoNum then 					 --
		outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
		return "cancel" 					 --
	end					 --
					 --
	session.avtoCoord = busJob.autos[gorod1][avtoNum]					 --
	session.avto =  createVehicle(session.avtoCoord[1], session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "Bus Ltd")					 --
	session.createAvtoHandler(session.avto)					 --
	session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
						 --
	createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,busJob.autos[gorod1][avtoNum])					 --
						 --
	session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
	session.pointIndex = marshrutTable.start - 1					 --
	session.endPointIndex = marshrutTable.endIndx					 --
	session.pay = marshrutTable.pay					 --
					 --
	busJob.doBusPoint(session)					 --
end					 --
					 --
busJob.nachalo = function(session)					 --
						 --
	--session.roadNum = math.random(1, #busJob.roads)					 --
					 --
	------ LS					 --
		session.LS_nachaloBlibBus = createBlip (1753.1598, -1894.2019, 12.59348+1000, 12, 1, 0, 0, 100, 255, 32767, 16383.0, session.player)					 --
		session.LS_startMarka = addNewMarker(1753.1598, -1894.2019, 12.59348,"cylinder", 2.0, 0, 0, 100, 200, session.player,session,function()					 --
			if zalogDone(session.player, busJob.zalog) then					 --
				if busJob.startMarshrut(session,1) ~= "cancel" then					 --
					session.SF_startMarka.remove(); session.SF_startMarka = nil					 --
					session.LV_startMarka.remove(); session.LV_startMarka = nil					 --
				else					 --
					return "cancel"					 --
				end					 --
			else					 --
				return "cancel"					 --
			end					 --
		end)					 --
	------ SF					 --
		session.SF_nachaloBlibBus = createBlip (-1954.7584, -865.4267, 31.23415+1000, 12, 1, 0, 0, 100, 255, 32767, 16383.0, session.player)					 --
		session.SF_startMarka = addNewMarker(-1954.7584, -865.4267, 31.23415,"cylinder", 2.0, 0, 0, 100, 200, session.player,session,function()					 --
			if zalogDone(session.player, busJob.zalog) then					 --
				if busJob.startMarshrut(session,2) ~= "cancel" then					 --
					session.LV_startMarka.remove(); session.LV_startMarka = nil					 --
					session.LS_startMarka.remove(); session.LS_startMarka = nil					 --
				else					 --
					return "cancel"					 --
				end					 --
			else					 --
				return "cancel"					 --
			end					 --
		end)					 --
	----- LV					 --
		session.LV_nachaloBlibBus = createBlip (2805.9075, 1251.9637, 10.33609+1000, 12, 1, 0, 0, 100, 255, 32767, 16383.0, session.player)					 --
		session.LV_startMarka = addNewMarker(2805.9075, 1251.9637, 10.33609,"cylinder", 2.0, 0, 0, 100, 200, session.player,session,function()					 --
			if zalogDone(session.player, busJob.zalog) then					 --
				if busJob.startMarshrut(session,3) ~= "cancel" then					 --
					session.LS_startMarka.remove(); session.LS_startMarka = nil					 --
					session.SF_startMarka.remove(); session.SF_startMarka = nil					 --
				else					 --
					return "cancel"					 --
				end					 --
			else					 --
				return "cancel"					 --
			end					 --
		end)					 --
					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
busJob.doBusPoint = function(session)					 --
	session.pointIndex = session.pointIndex + 1					 --
	if session.pointIndex > #session.road then session.pointIndex = 1 end					 --
					 --
	-- end of Job					 --
	if session.pointIndex == session.endPointIndex then					 --
		session.blipBusKonec = createBlip(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4]+1000, 56, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
		addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint", 3.0, 0, 0, 100, 200, session.player,session,function()					 --
			busJob.endJob(session)					 --
		end)					 --
		return					 --
	end					 --
	-- end of Job					 --
					 --
	local markerCoord = session.road[session.pointIndex]					 --
	session.blipBus = createBlip(markerCoord[1], markerCoord[2], markerCoord[3]+1000, 56, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	addNewMarker(markerCoord[1], markerCoord[2], markerCoord[3], "checkpoint", 3.0, 0, 0, 100, 150, session.player,session,function()					 --
		destroyElement(session.blipBus); session.blipBus = nil					 --
		busJob.doBusPoint(session)					 --
							 --
		if markerCoord.stop then					 --
			setElementFrozen(session.avto,true)					 --
			session.timer = setTimer(function()					 --
				setElementFrozen(session.avto,false)					 --
			end,10000,1)					 --
		end					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
busJob.endJob = function(session, endCode)					 --
	if not isEror(endCode) then givePlayerMoney(session.player,session.pay) end					 --
	if not isEror(endCode) then givePlayerMoney(session.player,busJob.zalog) end					 --
					 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	busJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа такси-------------------------------------------------------------------------------------------------Работа такси------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа такси-------------------------------------------------------------------------------------------------Работа такси------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--"cylinder"    2158.5942  -1799.8295  12.3528					 --
					 --
local taxiJob = {}					 --
taxiJob.checkAvto = true                                                             -------Нужна ли проверка на авто					 --
taxiJob.zalog = 400					 --
					 --
taxiJob.autos = CoordsTaxiJob.autos					 --
taxiJob.roads = CoordsTaxiJob.roads					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
taxiJob.peds = {1, 2, 7, 9, 10, 11, 12, 13, 14, 15, 17}					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
--    LS       marker        posX="1286.4409"    posY="-1329.2941"      posZ="12.56528"					 --
--    SF       marker        posX="-2220.9539"    posY="100.51549"      posZ="34.3396"					 --
--    LV       marker        posX="1429.8121"    posY="2654.3567"       posZ="10.411"					 --
--local nachaloBlipTaxi = createBlip (2158.5942, -1799.8295, 12.3528, 55, 1, 0, 0, 0, 255, 0, 16383.0)					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
taxiJob.startTaxist = function(session,gorod)					 --
	session.gorod = gorod					 --
					 --
	local avtoPoint = findClearPlaceIndex(taxiJob.autos[gorod])					 --
	if not avtoPoint then 					 --
		outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
		return "cancel" 					 --
	end					 --
					 --
					 --
	session.jobPos = taxiJob.autos[gorod][avtoPoint]					 --
	session.avto = createVehicle(session.jobPos[1], session.jobPos[2], session.jobPos[3], session.jobPos[4], 0, 0, session.jobPos[5], "Taxi Ltd")					 --
	session.createAvtoHandler(session.avto)					 --
	session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
	createPlaceHolder(session.jobPos[2], session.jobPos[3], session.jobPos[4],"checkpoint",12,0,0,0,50,session,nil,session.jobPos)					 --
	session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
					 --
	taxiJob.doFirstTypePoint(session)					 --
end					 --
					 --
taxiJob.nachalo = function(session)					 --
					 --
	session.pedsCompliteRast = 0					 --
					 --
	------ LS					 --
	session.LS_nachaloBlibTaxi = createBlip (1286.4409, -1329.2941, 12.56528+1000, 55, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.LS_startMarka = addNewMarker(1286.4409, -1329.2941, 12.56528,"cylinder", 2.0, 0, 0, 100, 200,session.player,session,function()					 --
		if zalogDone(session.player, taxiJob.zalog) then					 --
			if taxiJob.startTaxist(session,1) ~= "cancel" then					 --
				session.SF_startMarka.remove(); session.SF_startMarka = nil					 --
				session.LV_startMarka.remove(); session.LV_startMarka = nil					 --
			else					 --
				return "cancel"					 --
			end					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
	------ SF					 --
	session.SF_nachaloBlibTaxi = createBlip (-2220.9539, 100.51549, 34.3396+1000, 55, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.SF_startMarka = addNewMarker(-2220.9539, 100.51549, 34.3396,"cylinder", 2.0, 0, 0, 100, 200,session.player,session,function()					 --
		if zalogDone(session.player, taxiJob.zalog) then					 --
			if taxiJob.startTaxist(session,2) ~= "cancel" then					 --
				session.LV_startMarka.remove(); session.LV_startMarka = nil					 --
				session.LS_startMarka.remove(); session.LS_startMarka = nil					 --
			else					 --
				return "cancel"					 --
			end					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
	----- LV					 --
	session.LV_nachaloBlibTaxi = createBlip (1429.8121, 2654.3567, 10.411+1000, 55, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.LV_startMarka = addNewMarker(1429.8121, 2654.3567, 10.411,"cylinder", 2.0, 0, 0, 100, 200,session.player,session,function()					 --
		if zalogDone(session.player, taxiJob.zalog) then					 --
			if taxiJob.startTaxist(session,3) ~= "cancel" then					 --
				session.LS_startMarka.remove(); session.LS_startMarka = nil					 --
				session.SF_startMarka.remove(); session.SF_startMarka = nil					 --
			else					 --
				return "cancel"					 --
			end					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
end					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
taxiJob.doFirstTypePoint = function(session)					 --
					 --
	while true do					 --
		local x,y,z = getElementPosition(session.player)					 --
		local point = math.random(1, #taxiJob.roads[session.gorod])					 --
		session.pickPoint = taxiJob.roads[session.gorod][point]					 --
		local pickRast = ((session.pickPoint[1]-x)^2 + (session.pickPoint[2]-y)^2)^0.5					 --
		if pickRast < 1000 then break end 					 --
	end					 --
					 --
	local rnd = math.random(1, #taxiJob.peds)					 --
	session.ped = createPed(taxiJob.peds[rnd], session.pickPoint[1], session.pickPoint[2], session.pickPoint[3])					 --
					 --
	session.frstTMarkaBlip = createBlip (session.pickPoint[1], session.pickPoint[2], session.pickPoint[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.frstTMarka = addNewMarker(session.pickPoint[1], session.pickPoint[2], session.pickPoint[3], "checkpoint", 5.0, 0, 0, 100, 150, session.player, session, function()					 --
							 --
		destroyElement(session.frstTMarkaBlip); session.frstTMarkaBlip = nil					 --
							 --
							 --
							 --
		----- Ped Veh Enter --------------------------------------------------------------------------					 --
		setElementSyncer (session.ped,false)					 --
		setElementFrozen(session.avto,true)					 --
		setElementSyncer (session.ped, session.player)					 --
					 --
		triggerClientEvent(session.player,"pedEnteredVehicle",session.player,session.ped,session.avto)					 --
		local iter = 0					 --
		local iters = 5					 --
		session.timer = setTimer(function()					 --
			iter = iter + 1					 --
			local enterd = getPedOccupiedVehicle(session.ped)					 --
			if enterd or (iter > iters-1) then					 --
				if not enterd then warpPedIntoVehicle(session.ped, session.avto, 1) end					 --
				setElementFrozen(session.avto,false)					 --
			end					 --
		end,2000,iters)					 --
		----- --- --- ----- --------------------------------------------------------------------------					 --
							 --
		taxiJob.doSecondTypePoint(session)					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
taxiJob.doSecondTypePoint  = function(session)					 --
	if session.endJobMarker then 					 --
		session.endJobMarker.remove() 					 --
		destroyElement(session.endJobBlip); session.endJobBlip = nil					 --
	end					 --
					 --
	local markerCoord					 --
	while true do					 --
		local point = math.random(1, #taxiJob.roads[session.gorod])					 --
		markerCoord = taxiJob.roads[session.gorod][point]					 --
		session.taxiRast = ((session.pickPoint[1]-markerCoord[1])^2 + (session.pickPoint[2]-markerCoord[2])^2)^0.5					 --
		if session.taxiRast > 500 then break end 					 --
	end					 --
					 --
	session.scndTMarkaBlip = createBlip (markerCoord[1], markerCoord[2], markerCoord[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.scndTMarka = addNewMarker(markerCoord[1], markerCoord[2], markerCoord[3], "checkpoint", 5.0, 0, 0, 100, 150, session.player, session, function()					 --
		session.pedsCompliteRast = session.pedsCompliteRast + session.taxiRast					 --
							 --
					 --
		----- Ped Veh Exit --------------------------------------------------------------------------					 --
		setElementSyncer (session.ped, false)					 --
		setElementSyncer (session.ped, session.player)					 --
		triggerClientEvent(session.player,"pedExitedVehicle",session.player,session.ped)					 --
		setElementFrozen(session.avto,true)					 --
					 --
		local peder = session.ped					 --
		session.timer = setTimer(function()					 --
			fadeAlpha(peder,1200)					 --
		end,1500,1)					 --
		session.timer2 = setTimer(function()					 --
			destroyElement(peder)					 --
			setElementFrozen(session.avto,false)					 --
		end,4000,1)					 --
					 --
		destroyElement(session.scndTMarkaBlip); session.scndTMarkaBlip = nil					 --
		taxiJob.doFirstTypePoint(session)					 --
					 --
		session.endJobBlip = createBlip(session.jobPos[2], session.jobPos[3], session.jobPos[4]+1000, 1, 0.5, 255, 0, 0, 255, 32767, 10000, session.player)					 --
		session.endJobMarker = addNewMarker(session.jobPos[2], session.jobPos[3], session.jobPos[4], "checkpoint", 5.0, 0, 0, 100, 150, session.player, session, function()					 --
			destroyElement(session.endJobBlip); session.endJobBlip = nil					 --
			taxiJob.endJob(session)					 --
		end)					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
taxiJob.endJob = function(session)					 --
	givePlayerMoney(session.player,1*session.pedsCompliteRast)					 --
	if not isEror(endCode) then givePlayerMoney(session.player, taxiJob.zalog) end					 --
					 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	taxiJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа шахтера-----------------------------------------------------------------------------------------------Работа шахтера----------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа шахтера-----------------------------------------------------------------------------------------------Работа шахтера----------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local shahtaJob = {}					 --
shahtaJob.roads = CoordsShahtaJob.roads					 --
shahtaJob.sgruz = CoordsShahtaJob.sgruz					 --
					 --
shahtaJob.nachalo = function(session)					 --
					 --
	session.zp = 0					 --
						 --
	session.nachaloBlipShahta = createBlip (819.60175, 857.9079, 11.06057+1000, 46, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	addNewMarker(819.60175, 857.9079, 11.06057, "cylinder", 1.0, 0, 150, 0, 200, session.player, session, function()					 --
		shahtaJob.doShahtaPoint(session)					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
shahtaJob.createKirka = function(session)					 --
	session.kirka = createObject(2228, 0,0,0)					 --
	setElementCollisionsEnabled(session.kirka,false)					 --
	setObjectScale(session.kirka, 0.8)					 --
					 --
	attachElementToBone(session.kirka,session.player,25,0,0,0.1, 0,0,90)					 --
end					 --
shahtaJob.removeKirka = function(session)					 --
	removeElementFromBone(session.kirka)					 --
	destroyElement(session.kirka)					 --
	session.kirka = nil					 --
end					 --
shahtaJob.doShahtaPoint = function(session)					 --
	session.roadNum = math.random(1, #shahtaJob.roads)					 --
	local markerCoord = shahtaJob.roads[session.roadNum]					 --
					 --
	session.playerKirkaClient = createClientElement(session.player, tostring(session.player).."ShahtaKirka", 2228, markerCoord[1], markerCoord[2], markerCoord[3])					 --
					 --
	session.blipDolbit = createBlip (markerCoord[1], markerCoord[2], markerCoord[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.ShahtaPoint = addNewMarker(markerCoord[1], markerCoord[2], markerCoord[3], "checkpoint", 1.5, 200, 0, 0, 20, session.player,session,function()					 --
		destroyElement(session.blipDolbit);session.blipDolbit = nil					 --
							 --
		destroyClientElement(session.player,session.playerKirkaClient); session.playerKirkaClient = nil					 --
 					 --
					 --
		shahtaJob.createKirka(session)					 --
					 --
		session.zpChange = math.random(1, 3)					 --
		local dobivatTime = (3000 * session.zpChange) - (session.zpChange-1)*1000					 --
							 --
					 --
		setElementFrozen(session.player,true)					 --
		setPedAnimation(session.player, "BASEBALL", "BAT_4", nil, true)					 --
							 --
		session.timer = setTimer(function()					 --
			outputChatBox("Вы добыли "..3*session.zpChange.." кг. руды", session.player)						 --
			setElementFrozen(session.player,false)					 --
			clearPlayerAnim(session.player)					 --
					 --
			shahtaJob.removeKirka(session)					 --
		end,dobivatTime,1)					 --
						 --
		shahtaJob.doShahtaItogPoint(session)					 --
								 --
	end)					 --
end					 --
					 --
shahtaJob.doShahtaItogPoint = function(session)					 --
	if session.endJobMarker then 					 --
		session.endJobMarker.remove() 					 --
		destroyElement(session.endJobBlip); session.endJobBlip = nil					 --
	end					 --
					 --
	session.sgruzNum = math.random(1, #shahtaJob.sgruz)					 --
	local markerCoord = shahtaJob.sgruz[session.sgruzNum]					 --
					 --
	session.blipItogPoint = createBlip (markerCoord[1], markerCoord[2], markerCoord[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.ShahtaItogPoint = addNewMarker(markerCoord[1], markerCoord[2], markerCoord[3], "cylinder", 2.0, 200, 0,	 0, 150, session.player,session,function()					 --
		destroyElement(session.blipItogPoint); session.blipItogPoint = nil					 --
					 --
		session.zp = session.zp + session.zpChange					 --
					 --
		shahtaJob.doShahtaPoint(session)					 --
					 --
		session.endJobBlip = createBlip(820.9945, 858.4415, 11.07+1000, 1, 0.5, 255, 0, 0, 255, 32767, 10000, session.player)					 --
		session.endJobMarker = addNewMarker(820.9945, 858.4415, 11.07, "cylinder", 1.0, 200, 0,	 0, 150, session.player,session,function()					 --
			shahtaJob.endJob(session)					 --
		end)					 --
	end)					 --
end					 --
					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
shahtaJob.endJob = function(session)					 --
	givePlayerMoney(session.player, session.zp)						 --
						 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	shahtaJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа грузчика----------------------------------------------------------------------------------------------Работа грузчика---------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа грузчика----------------------------------------------------------------------------------------------Работа грузчика---------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local gruzJob = {}					 --
gruzJob.roads = {					 --
	{2248.5266, -2253.8818, 13.78607, 150},					 --
	{2245.8123, -2258.625, 13.78607, 161},					 --
	{2236.0369, -2271.366, 13.78607, 172},					 --
	{2227.082, -2270.6228, 13.78607, 163},					 --
	{2223.7231, -2274.7976, 13.78607, 194},					 --
	{2238.7217, -2264.8169, 13.78607, 135},					 --
	{2227.8401, -2278.8813, 13.78607, 116},					 --
	{2230.5085, -2274.2051, 13.78607, 167},					 --
	{2252.1511, -2256.116, 13.78607, 158}					 --
}					 --
					 --
gruzJob.nachalo = function(session)					 --
					 --
	session.zp = 0					 --
					 --
						 --
					 --
	session.nachaloBlipGruz = createBlip (2133.1775, -2277.8743, 19.68836+1000, 28, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	addNewMarker(2133.1775, -2277.8743, 19.68836, "cylinder", 1.0, 0, 150, 0, 200, session.player, session, function()					 --
		gruzJob.doGruzPoint(session)					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
addEvent("GruzInAir",true)					 --
gruzJob.addInAirWatcher = function(session, fuc)					 --
	setTimer(function()					 --
		triggerClientEvent(session.player,"addGruzInAirWatcher", session.korob)					 --
		session.hasInAirWatcher = true					 --
		session.inAir = function()					 --
			gruzJob.removeInAirWatcher(session)					 --
			fuc()					 --
			gruzJob.doGruzPoint(session)					 --
		end					 --
		addEventHandler("GruzInAir",session.korob,session.inAir)					 --
	end,1200,1)					 --
end					 --
gruzJob.removeInAirWatcher = function(session)					 --
	if session.hasInAirWatcher then					 --
		triggerClientEvent(session.player,"removeGruzInAirWatcher", session.korob)					 --
		removeEventHandler("GruzInAir",session.korob,session.inAir)					 --
		session.inAir = nil					 --
		session.hasInAirWatcher = false					 --
	end					 --
end					 --
					 --
gruzJob.doGruzPoint = function(session)					 --
	session.roadNum = math.random(1, #gruzJob.roads)					 --
	local markerCoord = gruzJob.roads[session.roadNum]					 --
					 --
	session.zpChange = markerCoord[4]					 --
					 --
	session.playerKorobClient = createClientElement(session.player, tostring(session.player).."GruzKorob", 1271, markerCoord[1], markerCoord[2], markerCoord[3] + 0.4)					 --
					 --
	session.blipGruz = createBlip (markerCoord[1], markerCoord[2], markerCoord[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.GruzPoint = addNewMarker(markerCoord[1], markerCoord[2], markerCoord[3], "cylinder", 1.5, 200, 0, 0, 80, session.player,session,function()					 --
		destroyElement(session.blipGruz); session.blipGruz = nil					 --
		destroyClientElement(session.player, session.playerKorobClient); session.playerKorobClient = nil					 --
					 --
		session.korob = createObject(1271, markerCoord[1], markerCoord[2], markerCoord[3])					 --
		setObjectScale(session.korob, 0.8)					 --
		setElementCollisionsEnabled(session.korob,false)					 --
					 --
		attachElementToBone(session.korob,session.player, 25, 0.03,0.28,-0.28, 0,130,0)					 --
		gruzJob.addInAirWatcher(session,function()					 --
			gruzJob.removeKorob(session)					 --
			gruzJob.removeGruzItogPoint(session)					 --
		end)					 --
							 --
		setPedAnimation(session.player, "CARRY", "liftup", 1, false)					 --
		session.timer = setTimer(function()					 --
			setPedAnimation(session.player, "CARRY", "crry_prtial", 1, false,true,true)					 --
			gruzJob.togglePlayerControls(session,false)					 --
		end,1000,1)					 --
					 --
		gruzJob.doGruzItogPoint(session)					 --
					 --
	end)					 --
end					 --
gruzJob.removeKorob = function(session)					 --
	destroyElement(session.blipItogPoint); session.blipItogPoint = nil					 --
	gruzJob.togglePlayerControls(session,true)					 --
	gruzJob.removeInAirWatcher(session)					 --
	removeElementFromBone(session.korob); destroyElement(session.korob); session.korob = nil					 --
end					 --
					 --
gruzJob.doGruzItogPoint = function(session)					 --
	if session.endJobMarker then 					 --
		session.endJobMarker.remove() 					 --
		destroyElement(session.endJobBlip); session.endJobBlip = nil					 --
	end					 --
					 --
	session.blipItogPoint = createBlip (2162.6577, -2236.9072, 13.29197+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.GruzItogPoint = addNewMarker(2162.6577, -2236.9072, 12.39197, "cylinder", 1.0, 200, 0, 0, 150, session.player,session,function()							 --
		clearPlayerAnim(session.player)					 --
					 --
		gruzJob.removeKorob(session)					 --
					 --
		session.zp = session.zp + session.zpChange					 --
		outputChatBox("Вы заработали "..session.zp.."$.", session.player)					 --
					 --
		gruzJob.doGruzPoint(session)					 --
					 --
		session.endJobBlip = createBlip(2131.8447, -2276.2990, 19.68836+1000, 1, 0.5, 255, 0, 0, 255, 32767, 10000, session.player)					 --
		session.endJobMarker = addNewMarker(2131.8447, -2276.2990, 19.68836, "cylinder", 1.0, 200, 0,	 0, 150, session.player,session,function()					 --
			gruzJob.endJob(session)					 --
		end)					 --
	end)					 --
end					 --
gruzJob.removeGruzItogPoint = function(session)					 --
	session.GruzItogPoint.remove(); session.GruzItogPoint = nil					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
gruzJob.togglePlayerControls = function(session, toggle)					 --
	if session.player then 					 --
		toggleControl(session.player,"jump",toggle)					 --
		toggleControl(session.player,"fire",toggle)					 --
		toggleControl(session.player,"crouch",toggle)					 --
	end					 --
end					 --
gruzJob.endJob = function(session)					 --
	gruzJob.removeInAirWatcher(session)					 --
	givePlayerMoney(session.player, session.zp)						 --
					 --
	gruzJob.togglePlayerControls(session,true)					 --
					 --
	local player,jobName = session.player, session.jobName					 --
	session.endJob()					 --
	gruzJob.nachalo(createSession(player, jobName))					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа пиццерия----------------------------------------------------------------------------------------------Работа пиццерия---------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа пиццерия----------------------------------------------------------------------------------------------Работа пиццерия---------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local pizzaJob = {}					 --
pizzaJob.checkAvto = true                                                             -------Нужна ли проверка на авто					 --
pizzaJob.zalog = 100					 --
					 --
pizzaJob.autos = CoordsPizzaJob.autos					 --
pizzaJob.roads = CoordsPizzaJob.roads 					 --
					 --
pizzaJob.createPizza = function(session)					 --
	session.pizzeBox = createObject (1582, 0,0,0)					 --
    setElementCollisionsEnabled(session.pizzeBox, false)					 --
	setObjectScale(session.pizzeBox, 0.8)					 --
					 --
    attachElementToBone(session.pizzeBox, session.player,25,0,0.03,-0.15, 0,130,0)					 --
end					 --
pizzaJob.removePizza = function(session)					 --
	removeElementFromBone(session.pizzeBox); destroyElement(session.pizzeBox); session.pizzeBox = nil					 --
end					 --
					 --
pizzaJob.startPizzaW = function(session, gorod)					 --
	--if zalogDone(session.player, pizzaJob.zalog) then					 --
		session.gorod = gorod					 --
		local avtoPoint = findClearPlaceIndex(pizzaJob.autos[gorod])					 --
		if not avtoPoint then 					 --
			outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
			return "cancel" 					 --
		end					 --
		session.jobPos = pizzaJob.autos[gorod][avtoPoint]					 --
		session.avto = createVehicle(session.jobPos[1], session.jobPos[2], session.jobPos[3], session.jobPos[4], 0, 0, session.jobPos[5], "Pizza Ltd")					 --
		session.createAvtoHandler(session.avto)					 --
		session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
		session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
		createPlaceHolder(session.jobPos[2], session.jobPos[3], session.jobPos[4],"checkpoint",6,0,0,0,50,session,nil,pizzaJob.autos[gorod][avtoPoint])					 --
						 --
						 --
		setElementFrozen(session.avto, true)					 --
		--выдать на руки пиццу					 --
		pizzaJob.createPizza(session)					 --
						 --
		setPedAnimation(session.player, "CARRY", "crry_prtial", 2, true,true,true)					 --
		toggleControl(session.player,"fire",false)					 --
		toggleControl(session.player,"jump",false)					 --
		session.checkAvto = false					 --
		local avtoMat = getMatrix(session.avto)					 --
		local marPos = avtoMat.position - avtoMat.forward*2					 --
						 --
		addNewMarker(marPos.x,marPos.y,marPos.z-0.4,"cylinder", 1.0, 100,100,100,200,session.player, session, function()					 --
			pizzaJob.removePizza(session)					 --
						 --
			clearPlayerAnim(session.player)					 --
			toggleControl(session.player,"fire",true)					 --
			toggleControl(session.player,"jump",true)					 --
			setElementFrozen(session.avto, false)					 --
			pizzaJob.doPizzaPoint(session)						 --
		end)					 --
	--else					 --
	--	session.LS_startMarka.remove(); session.LS_startMarka = nil					 --
	--	session.SF_startMarka.remove(); session.SF_startMarka = nil					 --
	--	session.LV_startMarka.remove(); session.LV_startMarka = nil					 --
	--	pizzaJob.nachalo(session)					 --
	--end					 --
end					 --
pizzaJob.nachalo = function(session)					 --
	------ LS					 --
	session.LS_nachaloBlibPizza = createBlip (2108.9346, -1822.8944, 12.58246+1000, 29, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.LS_startMarka = addNewMarker(2108.9346, -1822.8944, 12.58246,"cylinder", 1.0, 0, 0, 100, 200, session.player,session,function()					 --
		if zalogDone(session.player, pizzaJob.zalog) then					 --
			if pizzaJob.startPizzaW(session,1) ~= "cancel" then 					 --
				session.SF_startMarka.remove(); session.SF_startMarka = nil					 --
				session.LV_startMarka.remove(); session.LV_startMarka = nil					 --
			else					 --
				return "cancel"					 --
			end					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
	------ SF					 --
	session.SF_nachaloBlibPizza = createBlip (-1720.1617, 1356.5405, 6.2257+1000, 29, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.SF_startMarka = addNewMarker(-1720.1617, 1356.5405, 6.2257,"cylinder", 1.0, 0, 0, 100, 200, session.player,session,function()					 --
		if zalogDone(session.player, pizzaJob.zalog) then					 --
			if pizzaJob.startPizzaW(session,2) ~= "cancel" then 					 --
				session.LV_startMarka.remove(); session.LV_startMarka = nil					 --
				session.LS_startMarka.remove(); session.LS_startMarka = nil					 --
			else					 --
				return "cancel"					 --
			end					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
	----- LV					 --
	session.LV_nachaloBlibPizza = createBlip (2367.2739, 2548.2244, 9.8571+1000, 29, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.LV_startMarka = addNewMarker(2367.2739, 2548.2244, 9.8571,"cylinder", 1.0, 0, 0, 100, 200, session.player,session,function()					 --
		if zalogDone(session.player, pizzaJob.zalog) then					 --
			if pizzaJob.startPizzaW(session,3) ~= "cancel" then 					 --
				session.LS_startMarka.remove(); session.LS_startMarka = nil					 --
				session.SF_startMarka.remove(); session.SF_startMarka = nil					 --
			else					 --
				return "cancel"					 --
			end					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
pizzaJob.doPizzaPoint = function(session)					 --
	session.roadNum = math.random(1, #pizzaJob.roads[session.gorod])					 --
	local markerCoord = pizzaJob.roads[session.gorod][session.roadNum]					 --
	session.markerCoord = markerCoord					 --
	session.checkAvto = true					 --
					 --
	local pizzaPointBlip = createBlip (markerCoord[1], markerCoord[2], markerCoord[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	addNewMarker(markerCoord[1], markerCoord[2], markerCoord[3], "checkpoint", 2.0, 200, 0, 0, 150, session.player,session,function()					 --
		destroyElement(pizzaPointBlip);pizzaPointBlip = nil					 --
		setElementFrozen(session.avto, true)					 --
		local avtoMat = getMatrix(session.avto)					 --
		local marPos = avtoMat.position - avtoMat.forward*2					 --
		session.checkAvto = false					 --
		addNewMarker(marPos.x,marPos.y,marPos.z-0.4, "cylinder", 1.0, 100,100,100,200, session.player,session,function()					 --
			pizzaJob.createPizza(session)					 --
			setPedAnimation(session.player, "CARRY", "crry_prtial", 2, true,true,true)					 --
			toggleControl(session.player,"fire",false)					 --
			toggleControl(session.player,"jump",false)					 --
			addNewMarker(markerCoord[4], markerCoord[5], markerCoord[6],"cylinder", 2.0, 100,100,100,200,session.player,session,function()					 --
				pizzaJob.removePizza(session)					 --
				clearPlayerAnim(session.player)					 --
				toggleControl(session.player,"fire",true)					 --
				toggleControl(session.player,"jump",true)					 --
				setElementFrozen(session.avto, false)					 --
				session.checkAvto = true					 --
				session.endJobBlip = createBlip(session.jobPos[2], session.jobPos[3], session.jobPos[4]+1000, 56, 1,255, 0, 0, 255, 32767, 10000, session.player)					 --
				addNewMarker(session.jobPos[2], session.jobPos[3], session.jobPos[4], "checkpoint", 2.0, 200, 0, 0, 150, session.player,session,function()					 --
					pizzaJob.endJob(session)					 --
				end)					 --
			end)					 --
		end)					 --
	end)					 --
end					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
pizzaJob.endJob = function(session, endCode)					 --
	if not isEror(endCode) then givePlayerMoney(session.player, ((session.jobPos[2]-session.markerCoord[1])^2 + (session.jobPos[3]-session.markerCoord[2])^2)^0.5) end					 --
	if not isEror(endCode) then givePlayerMoney(session.player, pizzaJob.zalog) end					 --
					 --
	toggleControl(session.player,"fire",true)					 --
	toggleControl(session.player,"jump",true)					 --
					 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	pizzaJob.nachalo(newSession)					 --
end					 --
					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа мусор-------------------------------------------------------------------------------------------------Работа мусор------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа мусор-------------------------------------------------------------------------------------------------Работа мусор------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local musorJob = {}					 --
musorJob.checkAvto = true                                                             -------Нужна ли проверка на авто					 --
musorJob.zalog = 500					 --
					 --
musorJob.autos = CoordsMusorJob.autos					 --
musorJob.roads = CoordsMusorJob.roads					 --
					 --
musorJob.togglePlayerControls = function(session, toggle)					 --
	if session.player then 					 --
		toggleControl(session.player,"jump",toggle)					 --
		toggleControl(session.player,"fire",toggle)					 --
		toggleControl(session.player,"sprint",toggle)					 --
	end					 --
end					 --
					 --
musorJob.createMusor = function(session)					 --
	session.MusorInHand = createObject (1265, 0,0,0)					 --
    setElementCollisionsEnabled(session.MusorInHand, false)					 --
    setObjectScale(session.MusorInHand, 0.6)					 --
					 --
    attachElementToBone(session.MusorInHand, session.player, 25, 0, 0, -0.2, 0, 130, 0)					 --
end					 --
musorJob.removeMusor = function(session)					 --
	removeElementFromBone(session.MusorInHand); destroyElement(session.MusorInHand); session.MusorInHand = nil					 --
end					 --
					 --
musorJob.nachalo = function(session)					 --
	session.nachaloBlibMusor = createBlip(-1907.4211, -1702.5035, 20.79589+1000, 51, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	addNewMarker(-1907.4211, -1702.5035, 20.79589, "cylinder", 2.0, 225, 0, 0, 200, session.player,session,function()					 --
		if zalogDone(session.player, musorJob.zalog) then					 --
			local avtoNum = findClearPlaceIndex(musorJob.autos)					 --
			if not avtoNum then 					 --
				outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
				return "cancel" 					 --
			end					 --
			session.avtoCoord = musorJob.autos[avtoNum]					 --
			session.roadNum = math.random(1, #musorJob.roads)					 --
						 --
			session.avto =  createVehicle (session.avtoCoord[1], session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "Mus Ltd")					 --
						 --
			session.avtoOccupancy = 0					 --
			session.zp = 0					 --
						 --
			createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,musorJob.autos[avtoNum])					 --
			session.createAvtoHandler(session.avto)					 --
			session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
			session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
			session.marshrutNum = math.random(1, #musorJob.roads)					 --
						 --
			musorJob.doAvtoCheckPoint(session)					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
end					 --
					 --
musorJob.doAvtoCheckPoint = function(session)					 --
	while true do					 --
		local point = math.random(1, #musorJob.roads[session.marshrutNum])					 --
		session.musorPoint = musorJob.roads[session.marshrutNum][point]					 --
						 --
		if session.sgruzPointBlip ~= nil then 					 --
			local x,y,z = getElementPosition(session.player)					 --
			local pickRast = ((session.musorPoint[1]-x)^2 + (session.musorPoint[2]-y)^2)^0.5					 --
			if pickRast > 50 and pickRast < 400 then break end					 --
		else break end					 --
	end					 --
					 --
-------создать пакет с мусором!!!!!					 --
	session.playerMusor = createClientElement(session.player, tostring(session.player).."Musor", 1265, session.musorPoint[4], session.musorPoint[5], session.musorPoint[6])					 --
					 --
	session.AvtoCheckPointBlip = createBlip (session.musorPoint[1], session.musorPoint[2], session.musorPoint[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.AvtoCheckPoint = addNewMarker(session.musorPoint[1], session.musorPoint[2], session.musorPoint[3], "checkpoint", 3.0, 0, 0, 100, 150, session.player, session, function()					 --
		destroyElement(session.AvtoCheckPointBlip); session.AvtoCheckPointBlip = nil					 --
		musorJob.doPlayerCheckPoint(session)					 --
	end)					 --
end					 --
					 --
musorJob.doPlayerCheckPoint = function(session)					 --
	if session.endJobMarker then 					 --
		session.endJobMarker.remove() 					 --
		destroyElement(session.endJobBlip); session.endJobBlip = nil					 --
	end					 --
					 --
	if session.sgruzPoint then session.sgruzPoint.remove() end					 --
	if session.sgruzPointBlip then destroyElement(session.sgruzPointBlip); session.sgruzPointBlip = nil end					 --
					 --
					 --
	setElementFrozen(session.avto, true)					 --
					 --
	local avtoMat = getMatrix(session.avto)					 --
	local behindPos = avtoMat.position - avtoMat.forward*5					 --
	session.checkAvto = false					 --
	musorJob.togglePlayerControls(session, false)					 --
	addNewMarker(session.musorPoint[4],session.musorPoint[5],session.musorPoint[6]-1, "checkpoint", 1.0, 100,100,100,200, session.player,session,function()					 --
							 --
		-------удалить пакет с мусором!!!!!					 --
		destroyClientElement(session.player, session.playerMusor); session.playerMusor = nil					 --
		-------запихнуть в руки пакет!!!!!					 --
		musorJob.createMusor(session)					 --
							 --
		setPedAnimation(session.player, "BOMBER", "BOM_Plant", 1000,  false, false, true) 					 --
		session.timer = setTimer(function()					 --
			clearPlayerAnim(session.player)					 --
		end,2000,1)					 --
		addNewMarker(behindPos.x, behindPos.y, behindPos.z-1,"cylinder", 2.0, 100,100,100,200,session.player,session,function()					 --
					 --
			-------удалить пакет с мусором из рук!!!!!					 --
			musorJob.removeMusor(session)					 --
					 --
			session.avtoOccupancy = session.avtoOccupancy + 1					 --
			session.zp = session.zp + 1					 --
			clearPlayerAnim(session.player)					 --
			musorJob.togglePlayerControls(session,true)					 --
			setElementFrozen(session.avto, false)					 --
			session.checkAvto = true					 --
					 --
			if session.avtoOccupancy < 20 then					 --
				musorJob.doSgruzPoint(session)					 --
				musorJob.doAvtoCheckPoint(session)					 --
			else					 --
				musorJob.doSgruzPoint(session)					 --
			end								 --
		end)					 --
	end)					 --
end					 --
					 --
musorJob.doSgruzPoint = function(session)					 --
	session.sgruzPointBlip = createBlip(-1880.0088, -1670.1761, 21.75+1000, 1, 1,255, 0, 0, 255, 32767, 10000, session.player)					 --
	session.sgruzPoint = addNewMarker(-1880.0088, -1670.1761, 21.75, "checkpoint", 5.0, 225, 0, 0, 200, session.player,session,function()					 --
		destroyElement(session.sgruzPointBlip); session.sgruzPointBlip = nil					 --
		session.avtoOccupancy = 0					 --
		if session.AvtoCheckPoint then 					 --
			session.AvtoCheckPoint.remove() session.AvtoCheckPoint = nil					 --
			destroyElement(session.AvtoCheckPointBlip) session.AvtoCheckPointBlip = nil					 --
		end					 --
					 --
		musorJob.doAvtoCheckPoint(session)					 --
		session.endJobBlip = createBlip(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4]+1000, 1, 1,255, 0, 0, 255, 32767, 10000, session.player)					 --
		session.endJobMarker = addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], "checkpoint", 3.0, 200, 0, 0, 150, session.player,session,function()					 --
			musorJob.endJob(session)					 --
		end)					 --
	end)					 --
end					 --
					 --
musorJob.endJob = function(session, endCode)					 --
	givePlayerMoney(session.player, session.zp or 0)					 --
	if not isEror(endCode) then givePlayerMoney(session.player, musorJob.zalog) end					 --
					 --
	musorJob.togglePlayerControls(session,true)					 --
					 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	musorJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа инкассации--------------------------------------------------------------------------------------------Работа инкассации-------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа инкассации--------------------------------------------------------------------------------------------Работа инкассации-------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local inkosJob = {}					 --
inkosJob.checkAvto = true                                                             -------Нужна ли проверка на авто					 --
					 --
inkosJob.zalog = 1000					 --
					 --
inkosJob.autos = CoordsInkosJob.autos					 --
inkosJob.roads = CoordsInkosJob.roads					 --
					 --
inkosJob.togglePlayerControls = function(session, toggle)					 --
	if session.player then 					 --
		toggleControl(session.player,"jump",toggle)					 --
		toggleControl(session.player,"fire",toggle)					 --
		toggleControl(session.player,"sprint",toggle)					 --
	end					 --
end					 --
					 --
inkosJob.createPaket = function(session)					 --
	session.PaketInHand = createObject (1265, 0,0,0)					 --
    setElementCollisionsEnabled(session.PaketInHand, false)					 --
    setObjectScale(session.PaketInHand, 0.6)					 --
					 --
    attachElementToBone(session.PaketInHand, session.player, 25, 0, 0, -0.2, 0, 130, 0)					 --
end					 --
inkosJob.removePaket = function(session)					 --
	removeElementFromBone(session.PaketInHand); destroyElement(session.PaketInHand); session.PaketInHand = nil					 --
end					 --
					 --
--<marker id="marker (cylinder) (1)" type="cylinder" color="#0000ffff" size="1" interior="3" dimension="0" 					 --
--alpha="255" posX="159.03583" posY="124.47998" posZ="987.24377" rotX="0" rotY="0" rotZ="0"></marker>					 --
					 --
					 --
					 --
inkosJob.nachalo = function(session)					 --
	--session.nachaloBlibInkos = createBlip(1385.21, -1657.4137, 12.55575+1000, 51, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	local dim = 60					 --
	session.nachaloMarkerInkos = addNewMarker(159.03583, 124.47998, 987.24377, "cylinder", 2.0, 225, 0, 0, 200, session.player,session,function()					 --
		if zalogDone(session.player, inkosJob.zalog) then					 --
			if getElementDimension(session.player) == dim then					 --
				PlayerTransition(session.player, 1385.21, -1657.4137, 12.85575, 0, 0, 0)					 --
						 --
				bindKey(session.player, "h", "down", function()					 --
					if getPedOccupiedVehicle(session.player) == session.avto then					 --
						local x,y,z = getElementPosition(session.player)					 --
						local Rast = ((1386.06372-x)^2 + (-1650.32727-y)^2)^0.5					 --
						if Rast < 10 then 					 --
							moveObject (pravayaVorotinaIkosaWorka, 2000, 1386.06372, -1658.32727, 14.08198)					 --
							moveObject (levayaVorotinaIkosaWorka, 2000, 1386.06372, -1642.36707, 14.08198)					 --
						 --
							session.timerVorot = setTimer(function()					 --
								moveObject (pravayaVorotinaIkosaWorka, 2000, 1386.06372, -1653.32727, 14.08198)					 --
								moveObject (levayaVorotinaIkosaWorka, 2000, 1386.06372, -1645.36707, 14.08198)					 --
							end,6000,1)					 --
						else return end					 --
					else return end					 --
				end)					 --
					 --
				local avtoNum = findClearPlaceIndex(inkosJob.autos)					 --
				if not avtoNum then 					 --
					outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
					return "cancel" 					 --
				end					 --
				session.avtoCoord = inkosJob.autos[avtoNum]					 --
							 --
				session.avto =  createVehicle (session.avtoCoord[1], session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "Ink Ltd")					 --
							 --
				session.avtoOccupancy = 0					 --
				session.zp = 0					 --
							 --
				createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,inkosJob.autos[avtoNum])					 --
				session.createAvtoHandler(session.avto)					 --
				session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
				session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
				session.marshrutNum = math.random(1, #inkosJob.roads)					 --
							 --
				inkosJob.doAvtoCheckPoint(session)					 --
			else return end					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
	setElementInterior(session.nachaloMarkerInkos.localMarker, 3)					 --
	setElementDimension(session.nachaloMarkerInkos.localMarker, dim)					 --
end					 --
					 --
inkosJob.doAvtoCheckPoint = function(session)					 --
	while true do					 --
		local point = math.random(1, #inkosJob.roads[session.marshrutNum])					 --
		session.inkosPoint = inkosJob.roads[session.marshrutNum][point]					 --
						 --
		if session.sgruzPointBlip ~= nil then 					 --
			local x,y,z = getElementPosition(session.player)					 --
			local pickRast = ((session.inkosPoint[1]-x)^2 + (session.inkosPoint[2]-y)^2)^0.5					 --
			if pickRast > 100 then break end					 --
		else break end					 --
	end					 --
					 --
	session.AvtoCheckPointBlip = createBlip (session.inkosPoint[1], session.inkosPoint[2], session.inkosPoint[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.AvtoCheckPoint = addNewMarker(session.inkosPoint[1], session.inkosPoint[2], session.inkosPoint[3], "checkpoint", 3.0, 0, 0, 100, 150, session.player, session, function()					 --
		destroyElement(session.AvtoCheckPointBlip); session.AvtoCheckPointBlip = nil					 --
		inkosJob.doPlayerCheckPoint(session)					 --
	end)					 --
end					 --
					 --
inkosJob.doPlayerCheckPoint = function(session)					 --
	if session.endJobMarker then session.endJobMarker.remove(); session.endJobMarker = nil end					 --
	if session.endJobBlip then destroyElement(session.endJobBlip); session.endJobBlip = nil end					 --
					 --
	if session.sgruzPoint then session.sgruzPoint.remove(); session.sgruzPoint = nil end					 --
	if session.sgruzPointBlip then destroyElement(session.sgruzPointBlip); session.sgruzPointBlip = nil end					 --
					 --
					 --
	setElementFrozen(session.avto, true)					 --
					 --
	local avtoMat = getMatrix(session.avto)					 --
	local behindPos = avtoMat.position - avtoMat.forward*4					 --
	session.checkAvto = false					 --
					 --
	inkosJob.togglePlayerControls(session, false)					 --
	addNewMarker(session.inkosPoint[4],session.inkosPoint[5],session.inkosPoint[6], "cylinder", 1.0, 100,100,100,200, session.player,session,function()					 --
							 --
		inkosJob.createPaket(session)					 --
							 --
		setPedAnimation(session.player, "BOMBER", "BOM_Plant", 1000,  false, false, true) 					 --
		session.timer = setTimer(function()					 --
			clearPlayerAnim(session.player)					 --
		end,2000,1)					 --
		addNewMarker(behindPos.x, behindPos.y, behindPos.z-1,"cylinder", 2.0, 100,100,100,200,session.player,session,function()					 --
					 --
			inkosJob.removePaket(session)					 --
					 --
			session.avtoOccupancy = session.avtoOccupancy + 1					 --
			session.zp = session.zp + 1					 --
			clearPlayerAnim(session.player)					 --
			inkosJob.togglePlayerControls(session,true)					 --
			setElementFrozen(session.avto, false)					 --
			session.checkAvto = true					 --
					 --
			if session.avtoOccupancy < 60 then					 --
				inkosJob.doSgruzPoint(session)					 --
				inkosJob.doAvtoCheckPoint(session)					 --
			else					 --
				inkosJob.doSgruzPoint(session)					 --
			end								 --
		end)					 --
	end)					 --
end					 --
					 --
inkosJob.doSgruzPoint = function(session)					 --
	session.sgruzPointBlip = createBlip(1383.49, -1681.05, 12.55575+1000, 1, 1,255, 0, 0, 255, 32767, 10000, session.player)					 --
	session.sgruzPoint = addNewMarker(1383.49, -1681.05, 12.55575, "checkpoint", 3.0, 225, 0, 0, 200, session.player,session,function()					 --
		destroyElement(session.sgruzPointBlip); session.sgruzPointBlip = nil					 --
		session.avtoOccupancy = 0					 --
		if session.AvtoCheckPoint then session.AvtoCheckPoint.remove(); session.AvtoCheckPoint = nil end					 --
		if session.AvtoCheckPointBlip then destroyElement(session.AvtoCheckPointBlip) session.AvtoCheckPointBlip = nil end					 --
					 --
		inkosJob.doAvtoCheckPoint(session)					 --
					 --
		session.endJobBlip = createBlip(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4]+1000, 1, 1,255, 0, 0, 255, 32767, 10000, session.player)					 --
		session.endJobMarker = addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], "checkpoint", 3.0, 200, 0, 0, 150, session.player,session,function()					 --
			inkosJob.endJob(session)					 --
		end)					 --
	end)					 --
end					 --
					 --
inkosJob.endJob = function(session, endCode)					 --
	givePlayerMoney(session.player, session.zp or 0)					 --
	if not isEror(endCode) then givePlayerMoney(session.player, inkosJob.zalog) end					 --
					 --
	PlayerTransition(session.player, 1388.08, -1653.85, 13.53, 0, 0, 0)					 --
	unbindKey(session.player, "h")					 --
	inkosJob.togglePlayerControls(session,true)					 --
					 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	inkosJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа перевозчика-------------------------------------------------------------------------------------------Работа перевозчика------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа перевозчика-------------------------------------------------------------------------------------------Работа перевозчика------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local perevozJob = {}					 --
perevozJob.checkAvto = true                                                             -------Нужна ли проверка на авто					 --
					 --
perevozJob.zalog = 1000					 --
					 --
perevozJob.autos = CoordsPrevozJob.autos					 --
perevozJob.roads = CoordsPrevozJob.roads					 --
					 --
--(cylinder) (1)       posX="1374.093"  posY="1058.0914" posZ="9.8494"					 --
					 --
perevozJob.nachalo = function(session)					 --
	session.nachaloBlibDalnoboy = createBlip(1374.093, 1058.0914, 9.8494+1000, 51, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	addNewMarker(1374.093, 1058.0914, 9.8494, "cylinder", 2.0, 225, 0, 0, 200, session.player,session,function()					 --
		if zalogDone(session.player, perevozJob.zalog) then					 --
					 --
			session.zp = 0					 --
							 --
			local avtoNum = findClearPlaceIndex(perevozJob.autos)					 --
			if not avtoNum then 					 --
				outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
				return "cancel" 					 --
			end					 --
			session.avtoCoord = perevozJob.autos[avtoNum]					 --
									 --
			session.avto =  createVehicle (session.avtoCoord[1], session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "Pere Ltd")					 --
			createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,perevozJob.autos[avtoNum])					 --
			session.createAvtoHandler(session.avto)					 --
			session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
								 --
			session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
						 --
			perevozJob.enterRoadQueue(session)					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
end					 --
					 --
perevozJob.attachAvto = function(session,avto,top)					 --
	setElementCollisionsEnabled(avto, false)					 --
	if top then					 --
		setElementSyncer(avto, false)					 --
		triggerClientEvent("attachAvtoToPacker",root,session.avto,avto)					 --
		local dester					 --
		dester = function()					 --
			triggerClientEvent("attachAvtoToPackerDestroy", session.avto)					 --
					 --
			removeEventHandler("onElementDestroy",session.avto,dester)					 --
			removeEventHandler("onElementDestroy",avto,dester)								 --
		end					 --
		addEventHandler("onElementDestroy",session.avto,dester)					 --
		addEventHandler("onElementDestroy",avto,dester)					 --
	else					 --
		attachElements(avto, session.avto, 0, -1.5, 0.65)					 --
	end					 --
end					 --
					 --
perevozJob.enterRoadQueue = function(session)					 --
	session.roadNumOneIndex = nil					 --
	session.roadNumTwoIndex = nil					 --
	session.roadQueueTimerFuc = function()					 --
		session.roadNumOneIndex = getRandomClearPlace(perevozJob.roads[1])					 --
							 --
					 --
		local iterat = 0					 --
		while iterat < 10000 do					 --
			session.roadNumTwoIndex = getRandomClearPlace(perevozJob.roads[1])					 --
			if (session.roadNumTwoIndex ~= session.roadNumOneIndex) or (session.roadNumTwoIndex == false) then					 --
				break					 --
			end					 --
					 --
			iterat = iterat + 1					 --
		end					 --
					 --
		outputChatBox(tostring(session.roadNumOneIndex))					 --
		outputChatBox(tostring(session.roadNumTwoIndex))					 --
					 --
		if session.roadNumOneIndex and session.roadNumTwoIndex then					 --
			perevozJob.doAvto(session)					 --
			killTimer(session.roadQueueTimer)					 --
		else					 --
			outputChatBox("В настоящий момент задач нет, ожидайте...")					 --
			session.roadNumOneIndex = nil					 --
			session.roadNumTwoIndex = nil					 --
		end					 --
	end					 --
	session.roadQueueTimer = setTimer(session.roadQueueTimerFuc,5000,0)					 --
	session.roadQueueTimerFuc()					 --
end					 --
					 --
perevozJob.doAvto = function(session)					 --
	session.roadSgruzNum = math.random(1, #perevozJob.roads[2])					 --
	session.roadSgruz = perevozJob.roads[2][session.roadSgruzNum]					 --
					 --
	local avtoMat = getMatrix(session.avto)					 --
	session.behindPos = avtoMat.position					 --
					 --
	session.secondAvtoCoord = perevozJob.roads[1][session.roadNumOneIndex]					 --
	session.thirdAvtoCoord = perevozJob.roads[1][session.roadNumTwoIndex]					 --
					 --
	session.secondAvto = createVehicle (session.secondAvtoCoord[1], session.secondAvtoCoord[2], session.secondAvtoCoord[3], session.secondAvtoCoord[4], 0, 0, session.secondAvtoCoord[5], "Dalno Ltd")					 --
	session.secondAvtoBlip = createBlipAttachedTo(session.secondAvto, 0, 2, 100, 0, 0, 255, 32767, 10000, session.player)					 --
	session.createAvtoHandler(session.secondAvto)					 --
	createPlaceHolder(session.secondAvtoCoord[2], session.secondAvtoCoord[3], session.secondAvtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,perevozJob.roads[1][session.roadNumOneIndex],session.secondAvto)					 --
					 --
	session.thirdAvto = createVehicle (session.thirdAvtoCoord[1], session.thirdAvtoCoord[2], session.thirdAvtoCoord[3], session.thirdAvtoCoord[4], 0, 0, session.thirdAvtoCoord[5], "Dalno Ltd")					 --
	session.createAvtoHandler(session.thirdAvto)					 --
	createPlaceHolder(session.thirdAvtoCoord[2], session.thirdAvtoCoord[3], session.thirdAvtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,perevozJob.roads[1][session.roadNumTwoIndex],session.thirdAvto)					 --
					 --
	perevozJob.checkAvto = false					 --
	session.F_PogruzPoint = addNewMarker(session.behindPos.x, session.behindPos.y, session.behindPos.z + 1, "corona", 2.0, 200, 0, 0, 150, session.secondAvto,session,function()					 --
		destroyElement(session.secondAvtoBlip); session.secondAvtoBlip = nil					 --
		if session.endJobMarker then session.endJobMarker.remove(); session.endJobMarker = nil end					 --
		if session.endJobBlip then destroyElement(session.endJobBlip); session.endJobBlip = nil end					 --
		session.thirdAvtoBlip = createBlipAttachedTo(session.thirdAvto, 0, 2, 100, 0, 0, 255, 32767, 10000, session.player)					 --
					 --
		--закрепить авто					 --
		perevozJob.attachAvto(session,session.secondAvto,"toTop")					 --
					 --
		session.S_PogruzPoint = addNewMarker(session.behindPos.x, session.behindPos.y, session.behindPos.z, "corona", 2.0, 200, 0, 0, 150, session.thirdAvto,session,function()					 --
			destroyElement(session.thirdAvtoBlip); session.thirdAvtoBlip = nil					 --
					 --
			--закрепить авто					 --
			perevozJob.attachAvto(session,session.thirdAvto)					 --
			toggleControl(session.player,"special_control_up", false)					 --
					 --
			perevozJob.checkAvto = true					 --
			perevozJob.doItogos(session)					 --
		end)					 --
		attachElements (session.S_PogruzPoint.localMarker, session.avto, 0, 0, 0.6)					 --
	end)					 --
	attachElements (session.F_PogruzPoint.localMarker, session.avto, 0, 0, 2.9)					 --
end					 --
					 --
perevozJob.doItogos = function(session)					 --
	session.blipItogPoint = createBlip(session.roadSgruz[1], session.roadSgruz[2], session.roadSgruz[3]+1000, 56, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	session.ItogPoint = addNewMarker(session.roadSgruz[1], session.roadSgruz[2], session.roadSgruz[3], "checkpoint", 3.0, 200, 0, 0, 150, session.player,session,function()					 --
		session.zp = session.zp + 1					 --
					 --
		destroyElement(session.blipItogPoint); session.blipItogPoint = nil					 --
							 --
		destroyElement(session.secondAvto); session.secondAvto = nil					 --
		destroyElement(session.thirdAvto); session.thirdAvto = nil					 --
		toggleControl(session.player,"special_control_up", true)					 --
					 --
		perevozJob.enterRoadQueue(session)					 --
					 --
		session.endJobBlip = createBlip(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4]+1000, 56, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
		session.endJobMarker = addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], "checkpoint", 3.0, 200, 0, 0, 150, session.player,session,function()					 --
			destroyElement(session.endJobBlip); session.endJobBlip = nil					 --
			perevozJob.endJob(session)					 --
		end)					 --
	end)					 --
end					 --
					 --
perevozJob.endJob = function(session, endCode)					 --
	toggleControl(session.player,"special_control_up", true)					 --
	givePlayerMoney(session.player,session.zp)					 --
	if not isEror(endCode) then givePlayerMoney(session.player,perevozJob.zalog) end					 --
					 --
					 --
	local player,jobName = session.player, session.jobName					 --
	session.endJob()					 --
	perevozJob.nachalo(createSession(player,jobName))					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа электромонтажа----------------------------------------------------------------------------------------Работа электромонтажа---------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа электромонтажа----------------------------------------------------------------------------------------Работа электромонтажа---------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local elmontajnikJob = {}					 --
elmontajnikJob.checkAvto = true                                                             -------Нужна ли проверка на авто					 --
elmontajnikJob.zalog = 500					 --
					 --
elmontajnikJob.autos = CoordsElmontajnikJob.autos					 --
elmontajnikJob.roads = CoordsElmontajnikJob.roads					 --
					 --
--<marker id="marker (cylinder) (1)" type="cylinder" color="#0000ffff" size="1" interior="0" dimension="0" 					 --
--alpha="255" posX="970.08685" posY="-1519.9657" posZ="12.58122" rotX="0" rotY="0" rotZ="0"></marker>					 --
					 --
elmontajnikJob.nachalo = function(session)					 --
	session.nachaloBlibMonta = createBlip(970.08685, -1519.9657, 12.58122+1000, 51, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	addNewMarker(970.08685, -1519.9657, 12.58122, "cylinder", 2.0, 225, 0, 0, 200, session.player,session,function()					 --
		if zalogDone(session.player, elmontajnikJob.zalog) then					 --
			local avtoNum = findClearPlaceIndex(elmontajnikJob.autos)					 --
			if not avtoNum then 					 --
				outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
				return "cancel" 					 --
			end					 --
			session.avtoCoord = elmontajnikJob.autos[avtoNum]					 --
						 --
			session.avto =  createVehicle (session.avtoCoord[1], session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "Mus Ltd")					 --
						 --
			session.zp = 0					 --
						 --
			createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,elmontajnikJob.autos[avtoNum])					 --
			session.createAvtoHandler(session.avto)					 --
			session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
			session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
			session.marshrutNum = math.random(1, #elmontajnikJob.roads)					 --
						 --
			elmontajnikJob.doAvtoCheckPoint(session)					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
end					 --
					 --
elmontajnikJob.doAvtoCheckPoint = function(session)					 --
	while true do					 --
		local point = math.random(1, #elmontajnikJob.roads[session.marshrutNum])					 --
		session.stolbPoint = elmontajnikJob.roads[session.marshrutNum][point]					 --
						 --
		if session.sgruzPointBlip ~= nil then -----------------------------------------------------------------------					 --
			local x,y,z = getElementPosition(session.player)					 --
			local pickRast = ((session.stolbPoint[1]-x)^2 + (session.stolbPoint[2]-y)^2)^0.5					 --
			if pickRast > 50 and pickRast < 400 then break end					 --
		else break end					 --
	end					 --
					 --
	session.AvtoCheckPointBlip = createBlip (session.stolbPoint[1], session.stolbPoint[2], session.stolbPoint[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.AvtoCheckPoint = addNewMarker(session.stolbPoint[1], session.stolbPoint[2], session.stolbPoint[3], "checkpoint", 3.0, 0, 0, 100, 150, session.player, session, function()					 --
		destroyElement(session.AvtoCheckPointBlip); session.AvtoCheckPointBlip = nil					 --
		elmontajnikJob.doPlayerCheckPoint(session)					 --
	end)					 --
end					 --
					 --
addEvent("endStolbWork_ElMontajnik",true)					 --
					 --
elmontajnikJob.doPlayerCheckPoint = function(session)					 --
	if session.EndJobPoint then session.EndJobPoint.remove(); session.EndJobPoint = nil end					 --
	if session.EndJobPointBlip then destroyElement(session.EndJobPointBlip); session.EndJobPointBlip = nil end					 --
					 --
					 --
	setElementFrozen(session.avto, true)					 --
					 --
	local avtoMat = getMatrix(session.avto)					 --
	local behindPos = avtoMat.position - avtoMat.forward*5					 --
	session.checkAvto = false					 --
					 --
	addNewMarker(behindPos.x, behindPos.y, behindPos.z-1,"cylinder", 2.0, 100,100,100,200,session.player,session,function()					 --
		local px,py,pz = getElementPosition(session.player)					 --
		session.tapki = {}					 --
		session.tapki["r"] = {createObject(3092,px + 1,py, pz),createObject(3011,px + 1,py, pz)}					 --
		session.tapki["l"] = {createObject(3010,px + 2,py, pz),createObject(3009,px + 2,py, pz)}					 --
					 --
		setElementCollisionsEnabled(session.tapki["r"][1],false)					 --
		setElementCollisionsEnabled(session.tapki["r"][2],false)					 --
		setElementCollisionsEnabled(session.tapki["l"][1],false)					 --
		setElementCollisionsEnabled(session.tapki["l"][2],false)					 --
					 --
		attachElements(session.tapki["r"][2], session.tapki["l"][1], 0, 0, 0)					 --
		attachElements(session.tapki["l"][2], session.tapki["r"][1], 0, 0, 0)					 --
					 --
		attachElementToBone(session.tapki["r"][1],session.player,54,0.1 , -0.02, 0, -3.5, 11.15, 0.6)					 --
		attachElementToBone(session.tapki["l"][1],session.player,44,0.1 , -0.02, 0, -3.8, 11.15, 0.6)					 --
					 --
		-- 					старт ползания					 --
		addNewMarker(session.stolbPoint[4],session.stolbPoint[5],session.stolbPoint[6]-1, "checkpoint", 1.0, 100,100,100,200, session.player,session,function()					 --
		triggerClientEvent(session.player,"startClimb_ElMontajnik",root)					 --
					 --
		session.playerEndStolbWorkFucHandled = true					 --
		session.playerEndStolbWorkFuc = function()					 --
			removeEventHandler("endStolbWork_ElMontajnik",session.player,session.playerEndStolbWorkFuc)					 --
			session.playerEndStolbWorkFucHandled = false					 --
					 --
			clearPlayerAnim(session.player)					 --
			addNewMarker(behindPos.x, behindPos.y, behindPos.z-1,"cylinder", 2.0, 100,100,100,200,session.player,session,function()					 --
				session.zp = session.zp + 1					 --
				--clearPlayerAnim(session.player)					 --
				setElementFrozen(session.avto, false)					 --
				--session.checkAvto = true					 --
				elmontajnikJob.doEndJobPoint(session)					 --
				elmontajnikJob.doAvtoCheckPoint(session)						 --
			end)						 --
		end					 --
		addEventHandler("endStolbWork_ElMontajnik",session.player,session.playerEndStolbWorkFuc)					 --
					 --
		end)					 --
	end)					 --
end					 --
					 --
elmontajnikJob.doEndJobPoint = function(session)					 --
	session.checkAvto = true					 --
	session.EndJobPointBlip = createBlip(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4]+1000, 1, 1,255, 0, 0, 255, 32767, 10000, session.player)					 --
	session.EndJobPoint = addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], "checkpoint", 5.0, 225, 0, 0, 200, session.player,session,function()					 --
		destroyElement(session.EndJobPointBlip); session.EndJobPointBlip = nil					 --
		if session.AvtoCheckPoint then session.AvtoCheckPoint.remove(); session.AvtoCheckPoint = nil end					 --
		if session.AvtoCheckPointBlip then destroyElement(session.AvtoCheckPointBlip); session.AvtoCheckPointBlip = nil end					 --
					 --
		elmontajnikJob.endJob(session)					 --
	end)					 --
end					 --
					 --
elmontajnikJob.endJob = function(session, endCode)					 --
	givePlayerMoney(session.player, session.zp or 0)					 --
	if not isEror(endCode) then givePlayerMoney(session.player, elmontajnikJob.zalog) end					 --
					 --
	if session.playerEndStolbWorkFucHandled then					 --
		removeEventHandler("endStolbWork_ElMontajnik",session.player,session.playerEndStolbWorkFuc)					 --
		session.playerEndStolbWorkFucHandled = false					 --
	end					 --
					 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	elmontajnikJob.nachalo(newSession)					 --
end					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа Полиция-----------------------------------------------------------------------------------------------Работа Полиция----------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа Полиция-----------------------------------------------------------------------------------------------Работа Полиция----------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local policeJob = {}					 --
policeJob.checkAvto = true                                                              -------Нужна ли проверка на авто					 --
policeJob.zalog = 800					 --
					 --
policeJob.autos = CoordsPoliceJob.autos					 --
policeJob.roads = CoordsPoliceJob.roads					 --
policeJob.road2nds = CoordsPoliceJob.road2nds					 --
					 --
policeJob.nachalo = function(session)					 --
	session.lspdNachalo = addNewMarker(240.65134, 71.91388, 1004.0674, "cylinder", 1.0, 225, 0, 0, 200, session.player,session,function()					 --
							 --
		local avtoNum = findClearPlaceIndex(policeJob.autos)					 --
		if not avtoNum then 					 --
			outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
			return "cancel" 					 --
		end					 --
		session.avtoCoord = policeJob.autos[avtoNum]					 --
		session.roadNum = math.random(1, #policeJob.roads)					 --
		session.roadCoord = policeJob.roads[session.roadNum]					 --
					 --
		session.avto =  createVehicle (session.avtoCoord[1], session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "LSPD")					 --
		setElementInterior(session.avto, 1)					 --
		setElementDimension(session.avto, 151)					 --
					 --
		createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,policeJob.autos[avtoNum])					 --
		session.createAvtoHandler(session.avto)					 --
		session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
							 --
		session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
							 --
		policeJob.checkAvto = false					 --
		session.lspdAmmo = addNewMarker(314.23053, -188.63576, 999.78418, "cylinder", 2.0, 225, 0, 0, 200, session.player,session,function()					 --
			policeJob.doWorkPoint(session)					 --
			policeJob.checkAvto = true					 --
					 --
			session.JobTimer = setTimer(function()					 --
				if session.workCheckBlip then destroyElement(session.workCheckBlip); session.workCheckBlip = nil end					 --
				if session.workCheck then session.workCheck.remove(); session.workCheck = nil end					 --
				policeJob.doEndWorkPoint(session)					 --
			end,90000,1)					 --
		end)					 --
					 --
		setElementInterior(session.lspdAmmo.localMarker, 6)					 --
		setElementDimension(session.lspdAmmo.localMarker, 154)					 --
	end)					 --
					 --
	setElementInterior(session.lspdNachalo.localMarker, 6)					 --
	setElementDimension(session.lspdNachalo.localMarker, 54)					 --
end					 --
					 --
policeJob.doWorkPoint = function(session)					 --
	session.newWorkCoord = nil					 --
	while true do					 --
		local point = math.random(1, #policeJob.road2nds)					 --
		session.newWorkCoord = policeJob.road2nds[point]					 --
							 --
		local pickRast = ((session.newWorkCoord[1]-session.roadCoord[1])^2 + (session.newWorkCoord[2]-session.roadCoord[2])^2)^0.5					 --
		if pickRast < 200 then break end					 --
							 --
	end					 --
					 --
	session.workCheckBlip = createBlip (session.newWorkCoord[1], session.newWorkCoord[2], session.newWorkCoord[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.workCheck = addNewMarker(session.newWorkCoord[1], session.newWorkCoord[2], session.newWorkCoord[3], "checkpoint", session.newWorkCoord[4], 225, 0, 0, 200, session.player,session,function()					 --
		if session.workCheckBlip then destroyElement(session.workCheckBlip); session.workCheckBlip = nil end					 --
		policeJob.doWorkPoint(session)					 --
	end)					 --
end					 --
					 --
policeJob.doEndWorkPoint = function(session)					 --
	session.AvtoEndworkCheck = addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], "checkpoint", 2, 225, 0, 0, 200, session.player,session,function()					 --
		destroyElement(session.avto); session.avto = nil					 --
					 --
		policeJob.checkAvto = false					 --
		session.AmmoEndworkCheck = addNewMarker(314.23053, -188.63576, 999.78418, "cylinder", 2, 225, 0, 0, 200, session.player,session,function()					 --
			policeJob.endJob(session)					 --
		end)					 --
		setElementInterior(session.AmmoEndworkCheck.localMarker, 6)					 --
		setElementDimension(session.AmmoEndworkCheck.localMarker, 154)					 --
	end)					 --
	setElementInterior(session.AvtoEndworkCheck.localMarker, 1)					 --
	setElementDimension(session.AvtoEndworkCheck.localMarker, 151)					 --
end					 --
					 --
policeJob.endJob = function(session, endCode)					 --
	givePlayerMoney(session.player, session.zp or 1000)					 --
	if not isEror(endCode) then givePlayerMoney(session.player, policeJob.zalog) end					 --
					 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	policeJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа скорая---------------------------------------------------------------------------------------------Работа скорая--------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа скорая---------------------------------------------------------------------------------------------Работа скорая--------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local hospJob = {}					 --
hospJob.checkAvto = true                                                              -------Нужна ли проверка на авто					 --
hospJob.zalog = 800					 --
					 --
hospJob.autos = CoordsHospJob.autos					 --
hospJob.roads = CoordsHospJob.roads					 --
					 --
hospJob.nachalo = function(session)					 --
	session.hospNachalo = addNewMarker(382.79779, 108.82285, 1013.869, "cylinder", 1.0, 225, 0, 0, 200, session.player,session,function()					 --
							 --
		local avtoNum = findClearPlaceIndex(hospJob.autos)					 --
		if not avtoNum then 					 --
			outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
			return "cancel" 					 --
		end					 --
		session.avtoCoord = hospJob.autos[avtoNum]					 --
		--session.cityNum = math.random(1, #hospJob.roads[1])					 --
		--session.city = hospJob.roads[session.roadNum]					 --
					 --
		session.zp = 0					 --
					 --
		session.avto =  createVehicle (session.avtoCoord[1], session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "HOSP")					 --
		setElementInterior(session.avto, 1)					 --
		setElementDimension(session.avto, 160)					 --
					 --
		createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,hospJob.autos[avtoNum])					 --
		session.createAvtoHandler(session.avto)					 --
		session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
							 --
		session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
					 --
		hospJob.doWorkPoint(session)					 --
					 --
		session.JobTimer = setTimer(function()					 --
			if session.workCheckBlip then destroyElement(session.workCheckBlip); session.workCheckBlip = nil end					 --
			if session.workAvtoCheck then session.workAvtoCheck.remove(); session.workAvtoCheck = nil end					 --
			if session.hospCheckBlip then destroyElement(session.hospCheckBlip); session.hospCheckBlip = nil end					 --
			if session.hospCheck then session.hospCheck.remove(); session.hospCheck = nil end					 --
			if session.workPlayerCheck then session.workPlayerCheck.remove(); session.workPlayerCheck = nil end					 --
			if session.ped then destroyElement(session.ped); session.ped = nil end					 --
					 --
			hospJob.doEndWorkPoint(session)					 --
		end,90000,1)					 --
	end)					 --
					 --
	setElementInterior(session.hospNachalo.localMarker, 3)					 --
	setElementDimension(session.hospNachalo.localMarker, 57)					 --
end					 --
					 --
					 --
					 --
hospJob.doWorkPoint = function(session)					 --
	session.roadNum = math.random(1, #hospJob.roads[1])					 --
	session.road = hospJob.roads[1][session.roadNum]					 --
					 --
	session.ped = createPed(34, session.road[4], session.road[5], session.road[6])					 --
	setElementFrozen(session.ped, true)					 --
	setPedAnimation(session.ped, "CRACK", "CRCKIDLE2", -1, true, false)					 --
					 --
	session.workCheckBlip = createBlip (session.road[1], session.road[2], session.road[3]+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.workAvtoCheck = addNewMarker(session.road[1], session.road[2], session.road[3], "checkpoint", 3, 225, 0, 0, 200, session.player,session,function()					 --
		if session.workCheckBlip then destroyElement(session.workCheckBlip); session.workCheckBlip = nil end					 --
		hospJob.checkAvto = false 					 --
		session.workPlayerCheck = addNewMarker(session.road[4], session.road[5], session.road[6], "checkpoint", 1, 225, 0, 0, 200, session.player,session,function()					 --
			setPedAnimation(session.player, "MEDIC", "CPR", 2000, true, false)					 --
			toggleAllControls(session.player, false)					 --
					 --
			setTimer(function()					 --
				toggleAllControls(session.player, true)					 --
				clearPlayerAnim(session.player)					 --
					 --
				destroyElement(session.ped); session.ped = nil					 --
					 --
				hospJob.doHospPoint(session)					 --
			end,2000,1)					 --
		end)					 --
	end)					 --
end					 --
					 --
hospJob.doHospPoint = function(session)					 --
	hospJob.checkAvto = true					 --
					 --
	session.hospCheckBlip = createBlip (1179.7905, -1308.4211, 13.7105+1000, 56, 1, 0, 0, 0, 255, 32767, 16383.0, session.player)					 --
	session.hospCheck = addNewMarker(1179.7905, -1308.4211, 13.7105, "checkpoint", 3, 225, 0, 0, 200, session.player,session,function()					 --
		if session.hospCheckBlip then destroyElement(session.hospCheckBlip); session.hospCheckBlip = nil end					 --
			session.zp = session.zp + ((1179.7905-session.road[1])^2 + (-1308.4211-session.road[2])^2)^0.5					 --
		hospJob.doWorkPoint(session)					 --
	end)					 --
end					 --
					 --
hospJob.doEndWorkPoint = function(session)					 --
	session.AvtoEndworkCheck = addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], "checkpoint", 2, 225, 0, 0, 200, session.player,session,function()					 --
		hospJob.endJob(session)					 --
	end)					 --
	setElementInterior(session.AvtoEndworkCheck.localMarker, 1)					 --
	setElementDimension(session.AvtoEndworkCheck.localMarker, 160)					 --
end					 --
					 --
hospJob.endJob = function(session, endCode)					 --
	givePlayerMoney(session.player, session.zp or 1000)					 --
	if not isEror(endCode) then givePlayerMoney(session.player, hospJob.zalog) end					 --
					 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	hospJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа мафии---------------------------------------------------------------------------------------------Работа мафии--------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа мафии---------------------------------------------------------------------------------------------Работа мафии--------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local narkoJob = {}					 --
narkoJob.roads = CoordsNarkoJob.roads					 --
					 --
narkoJob.nachalo = function(session)					 --
	session.mafNachalo = addNewMarker(2578.1301, -1282.3282, 1064.3888, "cylinder", 1.0, 0, 150, 0, 200, session.player, session, function()					 --
		session.zp = 0					 --
					 --
		narkoJob.doPoint(session)					 --
	end)					 --
	setElementInterior(session.mafNachalo.localMarker, 2)					 --
	setElementDimension(session.mafNachalo.localMarker, 177)					 --
end					 --
					 --
narkoJob.doPoint = function(session)					 --
	session.roadNum = math.random(1, #narkoJob.roads)					 --
	session.markerCoord = narkoJob.roads[session.roadNum]					 --
					 --
	session.skladPoint = addNewMarker(2553.3792, -1291.2985, 1060.0184, "checkpoint", 1, 200, 0, 0, 20, session.player,session,function()					 --
					 --
		session.createPoint = addNewMarker(session.markerCoord[1], session.markerCoord[2], session.markerCoord[3], "checkpoint", 1, 200, 0, 0, 20, session.player,session,function()					 --
			setElementFrozen(session.player,true)					 --
			--setPedAnimation(session.player, "BASEBALL", "BAT_4", nil, true)					 --
								 --
				outputChatBox("--------------------------", session.player)					 --
				outputChatBox("Тут ты ебашишь в мини-игру", session.player)					 --
				outputChatBox("--------------------------", session.player)					 --
					 --
			session.timer = setTimer(function()					 --
				setElementFrozen(session.player,false)					 --
				clearPlayerAnim(session.player)					 --
			end,3000,1)					 --
							 --
			narkoJob.doItogPoint(session)						 --
		end)					 --
		setElementInterior(session.createPoint.localMarker, 2)					 --
		setElementDimension(session.createPoint.localMarker, 177)					 --
	end)					 --
	setElementInterior(session.skladPoint.localMarker, 2)					 --
	setElementDimension(session.skladPoint.localMarker, 177)					 --
end					 --
					 --
narkoJob.doItogPoint = function(session)					 --
	session.skladPoint = addNewMarker(2553.3792, -1291.2985, 1060.0184, "checkpoint", 1, 200, 0, 0, 20, session.player,session,function()					 --
		narkoJob.endJob(session)					 --
	end)					 --
	setElementInterior(session.skladPoint.localMarker, 2)					 --
	setElementDimension(session.skladPoint.localMarker, 177)					 --
end					 --
					 --
narkoJob.endJob = function(session)					 --
	givePlayerMoney(session.player, session.zp)						 --
						 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	narkoJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа банды---------------------------------------------------------------------------------------------Работа банды--------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа банды---------------------------------------------------------------------------------------------Работа банды--------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local ammoJob = {}					 --
ammoJob.roads = CoordsAmmoJob.roads					 --
					 --
ammoJob.nachalo = function(session)					 --
	session.gangNachalo = addNewMarker(2226.8203, 1597.3933, 998.99927, "cylinder", 1.0, 0, 150, 0, 200, session.player, session, function()					 --
		session.zp = 0					 --
					 --
		ammoJob.doPoint(session)					 --
	end)					 --
	setElementInterior(session.gangNachalo.localMarker, 1)					 --
	setElementDimension(session.gangNachalo.localMarker, 181)					 --
end					 --
					 --
ammoJob.doPoint = function(session)					 --
	session.roadNum = math.random(1, #ammoJob.roads)					 --
	session.markerCoord = ammoJob.roads[session.roadNum]					 --
					 --
	session.skladPoint = addNewMarker(2215.9448, 1590.6552, 999.02155, "checkpoint", 1, 200, 0, 0, 20, session.player,session,function()					 --
					 --
		session.createPoint = addNewMarker(session.markerCoord[1], session.markerCoord[2], session.markerCoord[3], "checkpoint", 1, 200, 0, 0, 20, session.player,session,function()					 --
			setElementFrozen(session.player,true)					 --
			--setPedAnimation(session.player, "BASEBALL", "BAT_4", nil, true)					 --
								 --
				outputChatBox("--------------------------", session.player)					 --
				outputChatBox("Тут ты ебашишь в мини-игру", session.player)					 --
				outputChatBox("--------------------------", session.player)					 --
					 --
			session.timer = setTimer(function()					 --
				setElementFrozen(session.player,false)					 --
				clearPlayerAnim(session.player)					 --
			end,3000,1)					 --
							 --
			ammoJob.doItogPoint(session)						 --
		end)					 --
		setElementInterior(session.createPoint.localMarker, 1)					 --
		setElementDimension(session.createPoint.localMarker, 181)					 --
	end)					 --
	setElementInterior(session.skladPoint.localMarker, 1)					 --
	setElementDimension(session.skladPoint.localMarker, 181)					 --
end					 --
					 --
ammoJob.doItogPoint = function(session)					 --
	session.skladPoint = addNewMarker(2215.9448, 1590.6552, 999.02155, "checkpoint", 1, 200, 0, 0, 20, session.player,session,function()					 --
		ammoJob.endJob(session)					 --
	end)					 --
	setElementInterior(session.skladPoint.localMarker, 1)					 --
	setElementDimension(session.skladPoint.localMarker, 181)					 --
end					 --
					 --
ammoJob.endJob = function(session)					 --
	givePlayerMoney(session.player, session.zp)						 --
						 --
	local newSession = createSession(session.player, session.jobName) 					 --
	session.endJob()					 --
	ammoJob.nachalo(newSession)					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа дальнобой---------------------------------------------------------------------------------------------Работа дальнобой--------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа дальнобой---------------------------------------------------------------------------------------------Работа дальнобой--------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local dalnoboyJob = {}					 --
dalnoboyJob.checkAvto = true                                                             -------Нужна ли проверка на авто					 --
dalnoboyJob.zalog = 1000					 --
					 --
dalnoboyJob.autos = CoordsDalnoboyJob.autos					 --
dalnoboyJob.autoTipe = {515, 514, 403}					 --
dalnoboyJob.roads = CoordsDalnoboyJob.roads					 --
					 --
--<marker id="marker (cylinder) (1)" type="cylinder" color="#0000ffff" size="1" interior="0" dimension="0" 					 --
--alpha="255" posX="2330.0225" posY="-2315.5493" posZ="12.56687" rotX="0" rotY="0" rotZ="0"></marker>					 --
					 --
dalnoboyJob.nachalo = function(session)					 --
	session.nachaloBlibDalnoboy = createBlip(2330.0225, -2315.5493, 12.56687+1000, 51, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
	addNewMarker(2330.0225, -2315.5493, 12.56687, "cylinder", 2.0, 225, 0, 0, 200, session.player,session,function()					 --
		if zalogDone(session.player, dalnoboyJob.zalog) then					 --
					 --
			session.zp = 0					 --
							 --
			local avtoNum = findClearPlaceIndex(dalnoboyJob.autos)					 --
			if not avtoNum then 					 --
				outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже")					 --
				return "cancel" 					 --
			end					 --
			session.avtoCoord = dalnoboyJob.autos[avtoNum]					 --
			local TipeAvtoNum = math.random(1, #dalnoboyJob.autoTipe)					 --
			session.TipeAvto = dalnoboyJob.autoTipe[TipeAvtoNum]					 --
					 --
								 --
						 --
			session.avto =  createVehicle (session.TipeAvto, session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], 0, 0, session.avtoCoord[5], "Dalno Ltd")					 --
			createPlaceHolder(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4],"checkpoint",12,0,0,0,50,session,nil,dalnoboyJob.autos[avtoNum])					 --
			session.createAvtoHandler(session.avto)					 --
			session.enableAvtoTimer(_,_,avtoTimer30secsBakedFuc())					 --
								 --
			session.avtoBlip = createBlipAttachedTo(session.avto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
						 --
			dalnoboyJob.doPricep(session)					 --
		else					 --
			return "cancel"					 --
		end					 --
	end)					 --
end					 --
					 --
dalnoboyJob.doPricep = function(session)					 --
	session.roadNum = math.random(1, #dalnoboyJob.roads)					 --
	session.roadSgruz = math.random(1, #dalnoboyJob.roads[session.roadNum][2])					 --
	local pricepNum = math.random(1, #dalnoboyJob.roads[session.roadNum][1])					 --
	session.secondAvtoCoord = dalnoboyJob.roads[session.roadNum][1][pricepNum]					 --
					 --
	session.secondAvto = createVehicle (session.secondAvtoCoord[1], session.secondAvtoCoord[2], session.secondAvtoCoord[3], session.secondAvtoCoord[4], 0, 0, session.secondAvtoCoord[5], "Dalno Ltd")					 --
	session.secondAvtoBlip = createBlipAttachedTo(session.secondAvto, 0, 1, 100, 0, 0, 255, 32767, 10000, session.player)					 --
	session.createAvtoHandler(session.secondAvto)					 --
					 --
	-------------					 --
	session.atachFuc = function()					 --
		session.markerCoord = dalnoboyJob.roads[session.roadNum][2][session.roadSgruz]					 --
					 --
		if session.endJobMarker then session.endJobMarker.remove(); session.endJobMarker = nil end					 --
		if session.blipKonca then destroyElement(session.blipKonca); session.blipKonca = nil end					 --
					 --
		session.blipDalnoboy = createBlip(session.markerCoord[1], session.markerCoord[2], session.markerCoord[3]+1000, 56, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
							 --
		session.DalnoboyPoint = addNewMarker(session.markerCoord[1], session.markerCoord[2], session.markerCoord[3], "checkpoint", 3.0, 200, 0, 0, 150, session.secondAvto,session,function()					 --
								 --
			session.zp = session.zp + ((session.avtoCoord[2]-session.markerCoord[1])^2 + (session.avtoCoord[3]-session.markerCoord[2])^2)^0.5					 --
					 --
			destroyElement(session.blipDalnoboy); session.blipDalnoboy = nil					 --
					 --
			dalnoboyJob.removeHandlers(session)					 --
			destroyElement(session.secondAvto); session.secondAvto = nil					 --
			destroyElement(session.secondAvtoBlip); session.secondAvtoBlip = nil					 --
						 --
			dalnoboyJob.doPricep(session)					 --
					 --
			session.blipKonca = createBlip(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4]+1000, 56, 1, 255, 0, 0, 255, 32767, 10000, session.player)					 --
			session.endJobMarker = addNewMarker(session.avtoCoord[2], session.avtoCoord[3], session.avtoCoord[4], "checkpoint", 3.0, 200, 0, 0, 150, session.player,session,function()					 --
				destroyElement(session.blipKonca); session.blipKonca = nil					 --
				dalnoboyJob.endJob(session)					 --
			end)					 --
		end)					 --
					 --
		--- Плеер долбаеб проебал груз... ну не придурок ли? Минуту блять шоб все исправить или все уже					 --
		if session.trailerDetached then					 --
			outputChatBox("Прицеплено")					 --
			session.trailerDetached = false								 --
			killTimer(session.alertTimer);session.alertTimer = nil					 --
			killTimer(session.detachTimer);session.detachTimer = nil					 --
		end					 --
	end					 --
	addEventHandler("onTrailerAttach", session.secondAvto, session.atachFuc)					 --
	session.atachFucHandled = true					 --
					 --
	session.detachFuc = function()					 --
		destroyElement(session.blipDalnoboy); session.blipDalnoboy = nil					 --
		session.DalnoboyPoint.remove(); session.DalnoboyPoint = nil					 --
							 --
		--- Плеер долбаеб проебал груз... ну не придурок ли? Минуту блять шоб все исправить или все уже					 --
		session.trailerDetached = true					 --
		session.alertTimer = setTimer(function()					 --
			outputChatBox("Ебать! Ты шо без груза долбаеб?! Нука выключай свою эту и иди спать. все!")					 --
		end,30000,1)					 --
		session.detachTimer = setTimer(function()					 --
			outputChatBox("Так все доигрался! Я все выключаю!")					 --
			dalnoboyJob.endJob(session)						 --
		end,60000,1)					 --
		-----					 --
	end					 --
	addEventHandler("onTrailerDetach", session.secondAvto, session.detachFuc)					 --
	session.detachFucHandled = true					 --
					 --
end					 --
					 --
dalnoboyJob.removeHandlers = function(session)					 --
	if session.atachFucHandled then removeEventHandler("onTrailerAttach", session.secondAvto, session.atachFuc); session.atachFucHandled = false end					 --
	if session.detachFucHandled then removeEventHandler("onTrailerDetach", session.secondAvto, session.detachFuc); session.detachFucHandled = false end					 --
end					 --
					 --
dalnoboyJob.endJob = function(session, endCode)					 --
	givePlayerMoney(session.player,session.zp)					 --
	if not isEror(endCode) then givePlayerMoney(session.player,dalnoboyJob.zalog) end					 --
					 --
	dalnoboyJob.removeHandlers(session)					 --
					 --
	local player,jobName = session.player, session.jobName					 --
	session.endJob()					 --
	dalnoboyJob.nachalo(createSession(player,jobName))					 --
end					 --
					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа ферма-------------------------------------------------------------------------------------------------Работа ферма------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Работа ферма-------------------------------------------------------------------------------------------------Работа ферма------------------------------------------------					 --
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
					 --
local fermaJob = {}					 --
fermaJob.checkAvto = true					 --
fermaJob.roads = CoordsFermaJob.roads					 --
					 --
fermaJob.nachalo = function(session)					 --
	session.uSkin = getElementModel(session.player)					 --
	addNewMarker(-381.42969,-1421.8281,24.716,"cylinder", 2.0, 0, 0, 100, 200, session.player,session,function()					 --
		setElementModel(session.player, 158)					 --
		session.avto = createVehicle(478,-376.68164,-1429.2363,25.8066)					 --
		fermaJob.doFermaAvtoPoint(session)					 --
	end)					 --
end					 --
					 --
fermaJob.doFermaAvtoPoint = function(session)					 --
session.roadNum = math.random(1, #fermaJob.roads)					 --
session.road = fermaJob.roads[session.roadNum]					 --
session.avtoPoint = session.road[1]					 --
	addNewMarker(session.avtoPoint[1],session.avtoPoint[2],session.avtoPoint[3],"checkpoint", 15.0, 0, 0, 100, 200, session.player,session,function()					 --
		setElementFrozen(session.avto, true)					 --
		session.fermaCount = 0					 --
		fermaJob.doFermaPedPoint(session)							 --
	 end)					 --
end					 --
					 --
fermaJob.doFermaPedPoint = function(session)					 --
	session.pedRoadNum = math.random(2, #session.road)					 --
	session.pedRoad = session.road[session.pedRoadNum]					 --
	session.checkAvto = false					 --
	addNewMarker(session.pedRoad[1],session.pedRoad[2],session.pedRoad[3]-1,"cylinder", 2.0, 0, 0, 100, 200, session.player,session,function()					 --
		setElementFrozen(session.player, true)					 --
		setPedAnimation(session.player, "BOMBER", "BOM_Plant", 1000, false)					 --
		toggleControl(session.player,"fire",false)					 --
		toggleControl(session.player,"jump",false)					 --
		toggleControl(session.player,"sprint",false)					 --
		session.timer = setTimer(function()					 --
			setPedAnimation(session.player)					 --
			setElementFrozen(session.player, false)					 --
			toggleControl(session.player,"fire",true)					 --
			toggleControl(session.player,"jump",true)					 --
			toggleControl(session.player,"sprint",true)					 --
			clearPlayerAnim(session.player)					 --
		end,3000,1)					 --
		session.fermaCount = session.fermaCount + 1					 --
		outputConsole(session.fermaCount)					 --
		local avtoMat = getMatrix(session.avto)					 --
		local marPos = avtoMat.position - avtoMat.forward*5					 --
		addNewMarker(marPos.x,marPos.y,marPos.z-1.1--[[матрица авто]],"cylinder", 2.0, 0, 0, 100, 200, session.player,session,function()					 --
			--вы собрали кучу дерьма"***"					 --
			if session.fermaCount < 20 then					 --
				fermaJob.doFermaPedPoint(session)					 --
			else					 --
				setElementFrozen(session.avto, false)					 --
				session.checkAvto = true					 --
				addNewMarker(-376.1,-1422.1,24,"checkpoint", 5.0, 0, 0, 100, 200, session.player,session,function()					 --
					fermaJob.endJob(session)					 --
				end)					 --
			end					 --
		end)					 --
	end)					 --
end					 --
					 --
fermaJob.endJob = function(session)					 --
	session.endJob()					 --
					 --
	setElementModel(session.player, session.uSkin)					 --
	givePlayerMoney(session.player, 1)					 --
	if session.avto then destroyElement(session.avto); session.avto = nil end					 --
					 --
	session = createSession(session.player, session.jobName)					 --
	fermaJob.nachalo(session)					 --
end					 --
					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Блипы работ-------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
--local nachaloBlibDost = createBlip (2501.665, -1667.1405, 12.5516, 51, 1, 0, 0, 0, 255, 0, 16383.0)					 --
--local LS_nachaloBlibBus = createBlip (2000.3126, -1130.0684, 24.5301, 12, 1, 0, 0, 100, 255, 0, 16383.0)					 --
--local nachaloBlipTaxi = createBlip (2158.5942, -1799.8295, 12.3528, 55, 1, 0, 0, 0, 255, 0, 16383.0)					 --
--local nachaloBlipShahta = createBlip (2128.519, -1948.6575, 12.5365, 46, 1, 0, 0, 0, 255, 0, 16383.0)					 --
--local nachaloBlipGruz = createBlip (2283.3887, -2024.9329, 12.5411, 28, 1, 0, 0, 0, 255, 0, 16383.0)					 --
--local nachaloBpipPizza = createBlip(2106.7058, -1787.9159, 13.5547, 29, 1, 0, 0, 0, 255, 0, 16383.0)					 --
--local nachaloBpipFerma = createBlip(-381.42969,-1421.8281,24.716, 40, 1, 0, 0, 0, 255, 0, 16383.0)					 --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
--------------------------------------------Начало работы (после найма на бирже труда)-----------------------					 --
-------------------------------------------------(Фреймворк)-------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
endJobErrors = {["playerDieOrQuit"] = true,["vehDestroy"] = true ,["vehTimerEnd"] = true}					 --
function isEror(endCode)					 --
	if not endCode then return false end					 --
	if endJobErrors[endCode] then return true end					 --
end					 --
function createSession(thePlayer,jobName)					 --
	local job = JobsContent[jobName]					 --
	local session = {}					 --
		session.player = thePlayer					 --
		session.jobName = jobName					 --
		session.markers = {}					 --
					 --
	------Handlers					 --
					 --
	session.createPlayerHandler = function()					 --
 		session.PlayerHandler = function()					 --
 			outputDebugString("Плеер (mp3) досрочно вс..")					 --
 			outputChatBox("Плеер (mp3) досрочно вс..")					 --
 			job.endJob(session,"playerDieOrQuit")					 --
 		end					 --
 		addEventHandler("onPlayerWasted",session.player,session.PlayerHandler)					 --
 		addEventHandler("onPlayerQuit",session.player,session.PlayerHandler)					 --
 	end					 --
 	session.createAvtoHandler = function(avto)					 --
 		session.avtoHandler = function()					 --
 			outputChatBox("Ваш казенный трансорт был ПОТРАЧЕНО, было оъявлено нерабоче время с сохранением заработной платы (вам нихуя не заплатят)",session.player)					 --
 			job.endJob(session,"vehDestroy")					 --
 		end					 --
		addEventHandler("onVehicleExplode",avto,session.avtoHandler) 							 --
 	end					 --
					 --
 	-----AvtoTimer					 --
	session.avtoTimerEnabled = false					 --
	session.haveAvtoTimer = false					 --
					 --
 	session.enableAvtoTimer = function(avtoTimerTime,iterations,func,endFuc)					 --
		session.haveAvtoTimer = true					 --
					 --
		session.avtoTimerTime = avtoTimerTime or 120000					 --
		iterations = iterations or 12							 --
		if session.avtoTimerTime/iterations <= 60 then					 --
			iterations = session.avtoTimerTime / 60					 --
		end					 --
					 --
		session.startAvtoTimerFunction = function()					 --
 			if not session.avtoTimerEnabled then					 --
				session.avtoTimerEnabled = true					 --
 									 --
 				outputChatBox("ЗАПУЩЕНА СИСТЕМА ЛИВИДАЦИИ АВТО!!!")					 --
 				local iter = 0					 --
 									 --
 				session.avtoTimerTimer = setTimer(function()					 --
 					iter = iter + 1					 --
 										 --
 					local secsToEnd = (session.avtoTimerTime - (session.avtoTimerTime/iterations)*iter)/1000					 --
 					local timeMinSec = {["min"] = math.floor(secsToEnd / 60),["sec"] = math.floor(secsToEnd % 60),["fullsec"] = secsToEnd}					 --
 					if func then func(iter,timeMinSec) end					 --
					 --
 					if iter >= iterations then					 --
						outputChatBox("Время вышло")					 --
						session.disableAvtoTimer()					 --
						if endFuc then					 --
							endFuc()					 --
						else					 --
							job.endJob(session,"vehTimerEnd")					 --
						end					 --
 					end					 --
 				end,session.avtoTimerTime/iterations,iterations)					 --
 			end					 --
		end					 --
		if (getPedOccupiedVehicleSeat(session.player) ~= 0) or (getPedOccupiedVehicle(session.player) ~= session.avto) then					 --
			session.startAvtoTimerFunction()					 --
		end					 --
		addEventHandler("onPlayerVehicleExit",session.player,session.startAvtoTimerFunction)					 --
		session.killAvtoTimerFunction = function()					 --
			if session.avtoTimerEnabled and ((getPedOccupiedVehicleSeat(session.player) == 0) and (getPedOccupiedVehicle(session.player) == session.avto)) then					 --
				session.disableAvtoTimer()						 --
			end 					 --
		end					 --
		addEventHandler("onPlayerVehicleEnter",session.player,session.killAvtoTimerFunction)					 --
 	end					 --
 	session.disableAvtoTimer = function()					 --
 		if session.avtoTimerEnabled then					 --
 			session.avtoTimerEnabled = false					 --
 				outputChatBox("СИСТЕМА ОТКЛЮЧЮНА")					 --
 				killTimer(session.avtoTimerTimer)					 --
 		end					 --
 	end					 --
 	session.deleteAvtoTimer = function()					 --
 		if session.haveAvtoTimer then					 --
 			session.haveAvtoTimer = false					 --
 								 --
 			session.disableAvtoTimer()					 --
 			removeEventHandler("onPlayerVehicleExit",session.player,session.startAvtoTimerFunction)					 --
 			removeEventHandler("onPlayerVehicleEnter",session.player,session.disableAvtoTimer)					 --
 		end					 --
 	end					 --
					 --
 	-----EndJob ------ 					 --
	session.endJob = function()					 --
		outputChatBox("endJob")					 --
					 --
	  ----- Killing Hndlers						 --
		if session.avtoHandler then					 --
			removeEventHandler("onVehicleDamaged",session.avto,session.avtoHandler) 							 --
			session.avtoHandler = nil					 --
		end					 --
		session.deleteAvtoTimer()					 --
		removeEventHandler("onPlayerWasted",session.player,session.PlayerHandler)					 --
 		removeEventHandler("onPlayerQuit",session.player,session.PlayerHandler)					 --
					 --
 	  ----- Remove unlinked markers ----					 --
		for k,v in pairs(session.markers) do					 --
			v.remove()					 --
		end					 --
		session.markers = nil					 --
					 --
 	  ----- Destroy created elements ----					 --
		for k,v in pairs(session) do					 --
	 		if isElement(v) then destroyElement(v)					 --
	 		elseif isTimer(v) then killTimer(v)					 --
	 		elseif type(v) == "table" then					 --
	 			if v.tag == "marka" then					 --
	 				v.remove()					 --
	 			end					 --
	 			if v.tag == "clientElement" then					 --
	 				destroyClientElement(session.player, v)					 --
	 			end					 --
	 		end					 --
	 		session[k] = nil					 --
	 	end					 --
 	end					 --
					 --
 	session.createPlayerHandler()					 --
					 --
	return session					 --
end					 --
					 --
					 --
--thePlayer,jobName,eventName,rootElement					 --
function startNewJob(thePlayer,comandName,jobName)					 --
	local job = JobsContent[jobName]					 --
	if job == nil then 					 --
		outputConsole("WARING! Trying starting doesn't existed job ("..jobName.."), check job name!!!!")					 --
		return					 --
	end					 --
	if not getPlayerName(thePlayer) then outputConsole("WARING! Trying starting job ("..jobName..") for incorrect player!!!!") end					 --
					 --
	--"" debuh					 --
	--setPlayerMoney (thePlayer,0)					 --
	--"" debuh					 --
					 --
					 --
	outputConsole("Starting "..jobName.." for "..getPlayerName(thePlayer))					 --
 					 --
 	local session = createSession(thePlayer,jobName)					 --
					 --
	job.nachalo(session)					 --
					 --
	local dismiss					 --
	dismiss = function()					 --
		outputChatBox("Вы отпарвлены в дикретную отставку",thePlayer)					 --
					 --
		job.endJob(session,"playerdismissed")					 --
		removeEventHandler("dismissPlayerFromJob",thePlayer,dismiss)					 --
	end					 --
	addEventHandler("dismissPlayerFromJob",thePlayer,dismiss)					 --
					 --
end					 --
					 --
addEvent("dismissPlayerFromJob",true)					 --
addEvent("startNewJob",true)					 --
					 --
addEventHandler("startNewJob",root,function(thePlayer,jobName)					 --
	outputChatBox("Poka")					 --
	triggerEvent("dismissPlayerFromJob",thePlayer)					 --
	startNewJob(thePlayer,_,jobName)					 --
end)					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------Названия работ----------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
JobsContent = {}					 --
JobsContent["busWork"] = busJob					 --
JobsContent["dostavWork"] = dostJob					 --
JobsContent["taxiWork"] = taxiJob					 --
JobsContent["shahtaWork"] = shahtaJob					 --
JobsContent["gruzWork"] = gruzJob					 --
JobsContent["pizzaWork"] = pizzaJob					 --
JobsContent["musorWork"] = musorJob					 --
JobsContent["inkosWork"] = inkosJob					 --
JobsContent["pereWork"] = perevozJob					 --
JobsContent["montaWork"] = elmontajnikJob					 --
					 --
JobsContent["policeWork"] = policeJob					 --
JobsContent["hospWork"] = hospJob					 --
JobsContent["mafiaWork"] = narkoJob					 --
JobsContent["gangWork"] = ammoJob					 --
					 --
					 --
--JobsContent["dalnoWork"] = dalnoboyJob					 --
--JobsContent["fermaWork"] = fermaJob					 --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
-------------------------------------------------------------------------------------------------------------					 --
					 --
local birjesMarkerParent = createElement("flag","birjesMarker")					 --
local markeraBirj = {					 --
	{x = 242.31003, y = 118.4281, z = 1002.2513},					 --
	{x = 246.41838, y = 118.4281, z = 1002.2513},					 --
	{x = 250.61072, y = 118.4281, z = 1002.2513}					 --
}					 --
for k,v in pairs(markeraBirj) do					 --
	local mem = createMarker (v.x, v.y, v.z,"cylinder",1, 15, 170, 220, 180)					 --
	setElementParent(mem, birjesMarkerParent)					 --
	setElementDimension(mem,50)					 --
	setElementInterior(mem,10)					 --
end					 --
addEventHandler("onMarkerHit",birjesMarkerParent,function(thelm)					 --
	if getElementType(thelm) ~= "player" then return end					 --
					 --
	triggerClientEvent(thelm,"openBirjaTruda",root,JobsContent)					 --
end)					 --
					 --
					 --
addCommandHandler("startNewJob", startNewJob)					 --
					 --
					 --
outputChatBox("money in loking gmMoney")					 --
addCommandHandler("gmMoney", function(thePlayer)					 --
	outputChatBox("loking gmMoney 909090")					 --
	givePlayerMoney(thePlayer,909090)					 --
end)					 --
					 --
					 --
					 --
------ birja Bind					 --
addCommandHandler("birjaBind",function(thePlayer)					 --
	bindKey(thePlayer,"k","down",function()					 --
		outputChatBox("birja Bind loking.lua")					 --
		triggerClientEvent(thePlayer,"openBirjaTruda",root,JobsContent)					 --
	end)					 --
end)					 --
