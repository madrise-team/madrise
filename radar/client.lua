localPlayer = getLocalPlayer()
setDevelopmentMode(true)

speedRadar = {}
-----------------------------------------------------------------------------------------
speedRadar.LSLV = createColCuboid (1777, 790, 9, 40, 35, 10)


-----------------------------------------------------------------------------------------

function getElementSpeed(element)
	speedx, speedy, speedz = getElementVelocity(element)
	actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
	kmh = actualspeed * 1.61 * 100
	return kmh
end

function speedCheker()

	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle or getVehicleOccupant(vehicle) ~= localPlayer then return end

	if (getElementSpeed(vehicle) > (40/0.9)) and getElementSpeed(vehicle) < (70/0.9) then
		outputChatBox("sosi 40-70", 255,0,0)
		removeEventHandler("onClientRender", root, speedCheker)
	end

	if (getElementSpeed(vehicle) > (70/0.9)) and getElementSpeed(vehicle) < (100/0.9) then
		outputChatBox("sosi 70-100", 255,0,0)
		removeEventHandler("onClientRender", root, speedCheker)
	end

	if (getElementSpeed(vehicle) > (100/0.9)) then
		outputChatBox("sosi 100+", 255,0,0)
		removeEventHandler("onClientRender", root, speedCheker)
	end
end

function checkSpeed (element)
	 if (element == localPlayer) then
		outputChatBox("ty tam")
		addEventHandler("onClientRender", root, speedCheker)
	end
end


function stopCheckSpeed(element)
	if (element == localPlayer) then
		outputChatBox("ty ne tam")
		removeEventHandler("onClientRender", root, speedCheker)
	end
end

-----------------------------------------------------------------------------------------

for k,v in pairs(speedRadar) do
	addEventHandler("onClientColShapeHit", v, checkSpeed)
	addEventHandler("onClientColShapeLeave", v, stopCheckSpeed)
end

-----------------------------------------------------------------------------------------

setTrafficLightState("auto")
--setTrafficLightsLocked(true)

trafficRadar = {}
-----------------------------------------------------------------------------------------
trafficRadar.LSLV = {common = createColCuboid (1772, 820, 9, 50, 48, 20), south_north = createColCuboid (1775, 824, 9, 44, 2, 20), 
																			north_south = createColCuboid (1775, 861, 9, 44, 2, 20),
																			east_west = createColCuboid (1815, 824, 9, 2, 45, 20),
																			west_east = createColCuboid (1775, 824, 9, 2, 45, 20)
																			}
-----------------------------------------------------------------------------------------

function SNTLightCheker(element,_,v)
	if (element == localPlayer) then
		outputChatBox("smotri")
		if (getTrafficLightState() == 2) or (getTrafficLightState() == 3) or (getTrafficLightState() == 4) then
			outputChatBox("suka ty pozornaya", 255,0,0)
			removeEventHandler("onClientColShapeHit", v.south_north, SNTLightCheker)
			removeEventHandler("onClientColShapeHit", v.north_south, SNTLightCheker)
			removeEventHandler("onClientColShapeHit", v.east_west, EWTLightCheker)
			removeEventHandler("onClientColShapeHit", v.west_east, EWTLightCheker)
		else
			outputChatBox("molodec", 0,255,0)
			removeEventHandler("onClientColShapeHit", v.south_north, SNTLightCheker)
			removeEventHandler("onClientColShapeHit", v.north_south, SNTLightCheker)
			removeEventHandler("onClientColShapeHit", v.east_west, EWTLightCheker)
			removeEventHandler("onClientColShapeHit", v.west_east, EWTLightCheker)
		end 
	end
end

function EWTLightCheker(element,_,v)
	if (element == localPlayer) then
		outputChatBox("smotri")
		if (getTrafficLightState() == 0) or (getTrafficLightState() == 1) or (getTrafficLightState() == 2) then
			outputChatBox("suka ty pozornaya", 255,0,0)
			removeEventHandler("onClientColShapeHit", v.south_north, SNTLightCheker)
			removeEventHandler("onClientColShapeHit", v.north_south, SNTLightCheker)
			removeEventHandler("onClientColShapeHit", v.east_west, EWTLightCheker)
			removeEventHandler("onClientColShapeHit", v.west_east, EWTLightCheker)
		else
			outputChatBox("molodec", 0,255,0)
			removeEventHandler("onClientColShapeHit", v.south_north, SNTLightCheker)
			removeEventHandler("onClientColShapeHit", v.north_south, SNTLightCheker)
			removeEventHandler("onClientColShapeHit", v.east_west, EWTLightCheker)
			removeEventHandler("onClientColShapeHit", v.west_east, EWTLightCheker)
		end 
	end
end

function checkTrafficLight(element,_,v)
	if (element == localPlayer) then
		outputChatBox("ne narushay")
		addEventHandler("onClientColShapeHit", v.south_north, function(theElement, matchingDimension, v)
			SNTLightCheker(theElement, matchingDimension, v)
		end)
		addEventHandler("onClientColShapeHit", v.north_south, function(theElement, matchingDimension, v)
			SNTLightCheker(theElement, matchingDimension, v)
		end)
		addEventHandler("onClientColShapeHit", v.east_west, function(theElement, matchingDimension, v)
			EWTLightCheker(theElement, matchingDimension, v)
		end)
		addEventHandler("onClientColShapeHit", v.west_east, function(theElement, matchingDimension, v)
			EWTLightCheker(theElement, matchingDimension, v)
		end)
	end
end

function stopTrafficLight(element,_,v)
	if (element == localPlayer) then
		outputChatBox("ty ne narushil")
		removeEventHandler("onClientColShapeLeave", trafficRadar.LSLV.common, checkTrafficLight)
	end
end

-----------------------------------------------------------------------------------------

for k,v in pairs(trafficRadar) do
	addEventHandler("onClientColShapeHit", v.common, function(theElement, matchingDimension, v)
		checkTrafficLight(theElement, matchingDimension, v)
	end)
	addEventHandler("onClientColShapeLeave", v.common, function(theElement, matchingDimension, v)
		stopTrafficLight(theElement, matchingDimension, v)
	end)
end
--addEventHandler("onClientColShapeHit", trafficRadar.LSLV.common, checkTrafficLight)
--addEventHandler("onClientColShapeLeave", trafficRadar.LSLV.common, stopTrafficLight)

-----------------------------------------------------------------------------------------