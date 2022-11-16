function getElementSpeed(element)					 --
	speedx, speedy, speedz = getElementVelocity(element)					 --
	actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 					 --
	kmh = actualspeed * 1.61 * 100					 --
	return kmh					 --
end					 --
					 --
local oldX, oldY, oldZ = getElementPosition(getPedOccupiedVehicle(localPlayer))					 --
local odometr = 0					 --
local fuel = 100					 --
					 --
function odoM(rast, vehicle)					 --
	if isVehicleOnGround(vehicle) then					 --
		odometr = odometr + rast					 --
		if getElementSpeed(vehicle) < 100 then					 --
			fuel = fuel - rast/2000					 --
		elseif getElementSpeed(vehicle) > 100 and getElementSpeed(vehicle) < 200 then					 --
			fuel = fuel - rast/1000					 --
		elseif getElementSpeed(vehicle) > 200 then					 --
			fuel = fuel - rast/500					 --
		end					 --
						 --
		--[[if fuel <= 0 then					 --
			if getVehicleEngineState(vehicle) == true then 					 --
				setVehicleEngineState(vehicle, false)					 --
			end					 --
		end]]					 --
	end					 --
					 --
	dxDrawText(math.ceil(odometr*0.9).." Метров", 1000, 615)					 --
	dxDrawText(fuel.." литров", 1000, 630)					 --
end					 --
					 --
					 --
					 --
addEventHandler("onClientRender", root, function()					 --
					 --
local vehicle = getPedOccupiedVehicle(localPlayer) 					 --
if not vehicle or getVehicleOccupant(vehicle) ~= localPlayer then return end					 --
					 --
					 --
local speed = getElementSpeed(vehicle)					 --
					 --
local newX, newY, newZ = getElementPosition(vehicle)					 --
local rast = getDistanceBetweenPoints3D(oldX, oldY, oldZ, newX, newY, newZ)					 --
oldX, oldY, oldZ = newX, newY, newZ					 --
odoM(rast, vehicle)					 --
					 --
dxDrawText(math.ceil(speed*0.9).." км/ч", 1000, 600)					 --
--dxDrawText(rast*0.9, 1000, 610)					 --
end)					 --
