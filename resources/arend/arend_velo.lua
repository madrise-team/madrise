outputChatBox("arend restarted")					 --
-------------------------------------------------					 --
bycicles = {}					 --
veloMarkers = {}					 --
veloSdacha = {}					 --
					 --
					 --
function createNewBycicle(thePlayer)					 --
	if getElementType(thePlayer) ~= "player" then return end					 --
	if isPedInVehicle(thePlayer) then return end					 --
					 --
	local time = getRealTime()					 --
					 --
	local newBike = {}					 --
	newBike.name = "bike"..tostring(getPlayerName(thePlayer))..tostring(time.hour)..tostring(time.minute)..tostring(time.second)					 --
	newBike.bike = createVehicle(510, 1693, -1877, 13.5, 0, 0, 0)					 --
					 --
	setElementData(newBike.bike, "name", newBike.name)					 --
					 --
	table.insert(bycicles, newBike)					 --
end					 --
					 --
function deleteBycicle(thePlayer)					 --
	if getElementType(thePlayer) ~= "player" then return end					 --
	if isPedInVehicle(thePlayer) then 					 --
		if getElementModel(getPedOccupiedVehicle(thePlayer)) == 510 then					 --
					 --
			--getElementData(getPedOccupiedVehicle(thePlayer), "name")					 --
					 --
			for k,v in pairs(bycicles) do					 --
				if v.name == getElementData(getPedOccupiedVehicle(thePlayer), "name") then					 --
					setTimer(function()					 --
						destroyElement(v.bike)					 --
						table.remove(bycicles, k) 					 --
					end, 50, 1)					 --
					--destroyElement(v.bike)					 --
					--table.remove(bycicles, k)					 --
				end					 --
			end					 --
					 --
		end 					 --
	end					 --
end					 --
					 --
					 --
					 --
veloMarkers.spawnLosSantos = createMarker(1697, -1872, 13,"cylinder", 1, 200, 0, 0, 200)					 --
					 --
veloSdacha.spawnLosSantos = createMarker(1692, -1872, 13,"checkpoint", 2, 200, 0, 0, 200)					 --
					 --
					 --
for k,v in pairs(veloMarkers) do					 --
	addEventHandler("onMarkerHit", v, createNewBycicle)					 --
end					 --
					 --
for k,v in pairs(veloSdacha) do					 --
	addEventHandler("onMarkerHit", v, deleteBycicle)					 --
end					 --
