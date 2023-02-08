localPlayer = getLocalPlayer()
setDevelopmentMode(true)
setBlurLevel (0)

speedRadar = {}
-----------------------------------------------------------------------------------------
speedRadar.LSLV =      {createColCuboid (1770, 820, 9, 50, 47, 10), 80, 100, 120, 100} -- x  y  z  xh  yh  zh 1st 2st 3st
speedRadar.LSavto =    {createColPolygon (580,-1242,   580,-1242,     562,-1250,     541,-1263,     525,-1244,     555,-1224,     574,-1217  ),      10,     100,     120,     25} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_RusM =   {createColPolygon (937,-958,    937,-958,      910,-965,      882,-975,      893,-998,      916,-989,      946,-983   ),      10,     100,     120,     43} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_RusM =   {createColPolygon (1690,-683,   1690,-683,     1685,-709,     1680,-739,     1713,-743,     1717,-713,     1721,-692  ),      10,     100,     120,     56} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_Most =   {createColPolygon (70,-1549,    70,-1549,      98,-1553,      114,-1560,     125,-1532,     104,-1523,     72,-1518   ),      10,     100,     120,     18} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_meri_1 = {createColPolygon (1537,-1584,  1537,-1584,    1521,-1584,    1521,-1600,    1537,-1600                               ),      10,     100,     120,     18} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_meri_2 = {createColPolygon (1438,-1584,  1438,-1584,    1416,-1584,    1416,-1601,    1438,-1601                               ),      10,     100,     120,     18} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_meri_3 = {createColPolygon (1438,-1722,  1438,-1722,    1416,-1722,    1416,-1742,    1438,-1740                               ),      10,     100,     120,     18} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_meri_4 = {createColPolygon (1579,-1722,  1579,-1722,    1558,-1722,    1558,-1742,    1579,-1740                               ),      10,     100,     120,     18} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_Plazh =  {createColPolygon (1059,-1819,  1059,-1819,    1034,-1833,    1038,-1843,    1038,-1865,    1069,-1866,    1069,-1842 ),      10,     100,     120,     18} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_Pravo =  {createColPolygon (2744,184,    2744,184,      2749,143,      2787,141,      2784,179                                 ),      10,     100,     120,     34} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LS_Zigzag = {createColPolygon (1144,570,    1144,570,      1119,581,      1098,582,      1097,567,      1119,565,      1144,554   ),      10,     100,     120,     34} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LV_Razvaz = {createColPolygon (983,732,     983,732,       967,766,       915,746,       926,712                                  ),      10,     100,     120,     20} -- x  y   x  y   x  y   x  y) 1st 2st 3st height
speedRadar.LV_Avto =   {createColPolygon (2087,1368,   2087,1368,     2087,1377,     2037,1377,     2037,1368                                ),      10,     100,     120,     22} -- x  y   x  y   x  y   x  y) 1st 2st 3st height


-----------------------------------------------------------------------------------------

function getElementSpeed(element)
	speedx, speedy, speedz = getElementVelocity(element)
	actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
	kmh = actualspeed * 1.61 * 100
	return kmh
end


local hadled = false
local actualSpdX,actualSpdY,actualSpdZ, actualSpdMaxHeight;

function spdCheckHandle(hadle)
	if (not hadled) and (not hadle) then return end

	local f = removeEventHandler
	if hadle then f = addEventHandler end

	f("onClientRender", root, speedCheker)

	hadled = hadle
end

function speedCheker()

	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle or getVehicleOccupant(vehicle) ~= localPlayer then return end
	local _,_,height = getElementPosition(localPlayer)
	if height > actualSpdMaxHeight then return end


	if (getElementSpeed(vehicle) > (actualSpdX/0.9)) and getElementSpeed(vehicle) < (actualSpdY/0.9) then
		outputChatBox("sosi 40-70", 255,0,0)
		spdCheckHandle(false)
	end

	if (getElementSpeed(vehicle) > (actualSpdY/0.9)) and getElementSpeed(vehicle) < (actualSpdZ/0.9) then
		outputChatBox("sosi 70-100", 255,0,0)
		spdCheckHandle(false)
	end

	if (getElementSpeed(vehicle) > (actualSpdZ/0.9)) then
		outputChatBox("sosi 100+", 255,0,0)
		spdCheckHandle(false)
	end
end

function checkSpeed (element,args)
	if (element == localPlayer) then
		outputChatBox("ty tam")
		actualSpdX = args[1]
		actualSpdY = args[2] 
		actualSpdZ = args[3]
		actualSpdMaxHeight = args.height
		spdCheckHandle(true)
		return speedChekerFuc
	end
end

function stopCheckSpeed(element, speedChekerFuc)
	if (element == localPlayer) then
		outputChatBox("ty ne tam")
		spdCheckHandle(false)
	end
end



-----------------------------------------------------------------------------------------
for k,v in pairs(speedRadar) do
	addEventHandler("onClientColShapeHit", v[1], function(element)
		checkSpeed(element, {v[2],v[3],v[4], height = v[5]})
	end)
	addEventHandler("onClientColShapeLeave", v[1], stopCheckSpeed)
end

-----------------------------------------------------------------------------------------

setTrafficLightState("auto")
--setTrafficLightsLocked(true)

trafficRadar = {}
-----------------------------------------------------------------------------------------
--trafficRadar.LSLV = {common = createColCuboid (1772, 820, 9, 50, 48, 20), south_north = createColCuboid (1775, 824, 9, 44, 2, 20), 
--																			north_south = createColCuboid (1775, 861, 9, 44, 2, 20),
--																			east_west = createColCuboid (1815, 824, 9, 2, 45, 20),
--																			west_east = createColCuboid (1775, 824, 9, 2, 45, 20)
--																			}
-----------------------------------------------------------------------------------------

function SNTLightCheker(element,trafficT)
	if (element == localPlayer) then
		outputChatBox("smotri")
		if (getTrafficLightState() == 2) or (getTrafficLightState() == 3) or (getTrafficLightState() == 4) then
			outputChatBox("suka ty pozornaya", 255,0,0)
			removeEventHandler("onClientColShapeHit", trafficT.south_north, trafficT[tostring(trafficT.south_north)])
			removeEventHandler("onClientColShapeHit", trafficT.north_south, trafficT[tostring(trafficT.north_south)])
			removeEventHandler("onClientColShapeHit", trafficT.east_west, trafficT[tostring(trafficT.east_west)])
			removeEventHandler("onClientColShapeHit", trafficT.west_east, trafficT[tostring(trafficT.west_east)])
		else
			outputChatBox("molodec", 0,255,0)
			removeEventHandler("onClientColShapeHit", trafficT.south_north, trafficT[tostring(trafficT.south_north)])
			removeEventHandler("onClientColShapeHit", trafficT.north_south, trafficT[tostring(trafficT.north_south)])
			removeEventHandler("onClientColShapeHit", trafficT.east_west, trafficT[tostring(trafficT.east_west)])
			removeEventHandler("onClientColShapeHit", trafficT.west_east, trafficT[tostring(trafficT.west_east)])
		end 
	end
end

function EWTLightCheker(element,trafficT)
	if (element == localPlayer) then
		outputChatBox("smotri")
		if (getTrafficLightState() == 0) or (getTrafficLightState() == 1) or (getTrafficLightState() == 2) then
			outputChatBox("suka ty pozornaya", 255,0,0)
			removeEventHandler("onClientColShapeHit", trafficT.south_north, trafficT[tostring(trafficT.south_north)])
			removeEventHandler("onClientColShapeHit", trafficT.north_south, trafficT[tostring(trafficT.north_south)])
			removeEventHandler("onClientColShapeHit", trafficT.east_west, trafficT[tostring(trafficT.east_west)])
			removeEventHandler("onClientColShapeHit", trafficT.west_east, trafficT[tostring(trafficT.west_east)])
		else
			outputChatBox("molodec", 0,255,0)
			removeEventHandler("onClientColShapeHit", trafficT.south_north, trafficT[tostring(trafficT.south_north)])
			removeEventHandler("onClientColShapeHit", trafficT.north_south, trafficT[tostring(trafficT.north_south)])
			removeEventHandler("onClientColShapeHit", trafficT.east_west, trafficT[tostring(trafficT.east_west)])
			removeEventHandler("onClientColShapeHit", trafficT.west_east, trafficT[tostring(trafficT.west_east)])
		end 
	end
end

function checkTrafficLight(element,_,trafficT)

	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle or getVehicleOccupant(vehicle) ~= localPlayer then return end

	if (element == localPlayer) then
		outputChatBox("ne narushay")

		function addTrafficColHandler(traficCol,needFuk)
			local keyString = tostring(traficCol)
			trafficT[keyString] = function(theElement)
				needFuk(theElement, trafficT)
			end
			addEventHandler("onClientColShapeHit", traficCol, trafficT[keyString])
		end
		addTrafficColHandler(trafficT.south_north,	SNTLightCheker)
		addTrafficColHandler(trafficT.north_south,	SNTLightCheker)
		addTrafficColHandler(trafficT.east_west,	EWTLightCheker)
		addTrafficColHandler(trafficT.west_east,	EWTLightCheker)
	end
end

function stopTrafficLight(element,_,v)

	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle or getVehicleOccupant(vehicle) ~= localPlayer then return end
	
	if (element == localPlayer) then
		outputChatBox("ty ne narushil")
		removeEventHandler("onClientColShapeLeave", trafficRadar.LSLV.common, checkTrafficLight)
	end
end

-----------------------------------------------------------------------------------------

for k,v in pairs(trafficRadar) do
	addEventHandler("onClientColShapeHit", v.common, function(theElement, matchingDimension)
		checkTrafficLight(theElement, matchingDimension, v)
	end)
	addEventHandler("onClientColShapeLeave", v.common, function(theElement, matchingDimension)
		stopTrafficLight(theElement, matchingDimension, v)
	end)
end
--addEventHandler("onClientColShapeHit", trafficRadar.LSLV.common, checkTrafficLight)
--addEventHandler("onClientColShapeLeave", trafficRadar.LSLV.common, stopTrafficLight)

-----------------------------------------------------------------------------------------