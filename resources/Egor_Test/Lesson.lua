					 --
local teksture = dxCreateTexture("Picture/deth/wall.png")					 --
					 --
addEvent("pedDied",true)					 --
					 --
function RandPictureOnPed ()					 --
	local framer = 0					 --
	local savedPed = source					 --
	function Rend()					 --
		framer = framer + 1					 --
		dxDrawImageOnElement(savedPed,teksture)						 --
		if framer == 350 then 					 --
			removeEventHandler("onClientPreRender",root,Rend)					 --
		end					 --
	end					 --
	addEventHandler("onClientPreRender",root,Rend)						 --
end					 --
addEventHandler("pedDied",root,RandPictureOnPed)					 --
					 --
					 --
function dxDrawImageOnElement(TheElement,Image,distance,height,width,R,G,B,alpha)					 --
	local x, y, z = getElementPosition(TheElement)					 --
	local x2, y2, z2 = getElementPosition(localPlayer)					 --
	local distance = distance or 20					 --
	local height = height or 1					 --
	local width = width or 1					 --
	local checkBuildings = checkBuildings or true					 --
	local checkVehicles = checkVehicles or false					 --
	local checkPeds = checkPeds or false					 --
	local checkObjects = checkObjects or true					 --
	local checkDummies = checkDummies or true					 --
	local seeThroughStuff = seeThroughStuff or false					 --
	local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false					 --
	local ignoredElement = ignoredElement or nil					 --
	if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then					 --
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)					 --
		if(sx) and (sy) then					 --
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)					 --
			if(distanceBetweenPoints < distance) then					 --
				dxDrawMaterialLine3D(x, y, z+1+height-(distanceBetweenPoints/distance), x, y, z+height, Image, width-(distanceBetweenPoints/distance), tocolor(R or 255, G or 255, B or 255, alpha or 255))					 --
			end					 --
		end					 --
	end					 --
end					 --
					 --
local ps1 = dxCreateTexture("Picture/Car_position/Car_position_ps1.png")					 --
local ps2 = dxCreateTexture("Picture/Car_position/Car_position_ps2.png")					 --
local ps3 = dxCreateTexture("Picture/Car_position/Car_position_ps3.png")					 --
local psDriver = dxCreateTexture("Picture/Car_position/Car_position_driver.png")					 --
					 --
local screenWidth,screenHeight = guiGetScreenSize()  					 --
					 --
local car_picture					 --
local frame = 0					 --
function renderDisplay ()					 --
    PlayerCarPos()					 --
	if car_picture then						 --
		local seconds = getTickCount() / 1000					 --
		local angle = math.sin(seconds) * 80					 --
		dxDrawImage ( screenWidth/2 - 50, 500, 100, 240, car_picture, angle, 0, -120 )						 --
		frame = frame + 1					 --
		if frame == 350 then removeEventHandler("onClientRender",root,renderDisplay) end						 --
	end						 --
end						 --
addEventHandler("onClientRender", root, renderDisplay) 					 --
					 --
function PlayerCarPos ()					 --
	local seat = getPedOccupiedVehicleSeat(localPlayer)					 --
	if not seat then car_picture = nil end					 --
					 --
	if (seat == 0) then	car_picture = psDriver end 					 --
	if (seat == 1) then	car_picture = ps1 end 					 --
	if (seat == 2) then	car_picture = ps2 end 					 --
	if (seat == 3) then	car_picture = ps3 end 					 --
end					 --
					 --
addEventHandler("onClientVehicleStartEnter",root,PlayerCarPos) 					 --
					 --
					 --
addEvent("pedAdd",true)					 --
addEventHandler("pedAdd",root,function(pedr)					 --
local ped = pedr					 --
bindKey( "i", "down",function()  					 --
	    if isElementSyncer (ped) then					 --
	    	if getPedOccupiedVehicle (ped) == false then					 --
	    		setPedEnterVehicle(ped,nil,false)					 --
	        else					 --
	        	setPedExitVehicle (ped)					 --
	        end					 --
	    end					 --
	end)					 --
end)					 --
					 --
					 --
addEventHandler("pedAdd",root,function(pedr)					 --
	local animation = {}					 --
	local ped = pedr					 --
	local i = 0					 --
	addCommandHandler("A",function()					 --
		if not animation[ped] then					 --
			setPedAnimation(ped,"ped","woman_walksexy", -1, false, false,false,false)					 --
			animation[ped] = true					 --
		else					 --
			setPedAnimation(ped)					 --
			animation[ped] = nil					 --
		end						 --
	end)					 --
end)					 --
					 --
-----------------------------zad_mastera------------------------------------					 --
					 --
					 --
					 --
					 --
