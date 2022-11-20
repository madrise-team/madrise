----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
------------------------------------



-- Дим-Инт обработчик
---В основном юзается для клиентских элементов
elmDimIntHandlers = {}
function addElementDimIntHandler(element)
 	local handler = function()
 		local dim = getElementDimension(element)
 		local int = getElementInterior(element)

 		triggerClientEvent('elmDimIntChanged', element, dim, int)
 		triggerEvent('elmDimIntChanged', element, dim, int)

 	end
 	elmDimIntHandlers[tostring(element)] = {["handler"] = handler}
 	addEventHandler("onElementDimensionChange",element,handler)
 	addEventHandler("onElementInteriorChange",element,handler)
end
function reomveElementDimIntHandler(element)
	local handler = elmDimIntHandlers[tostring(element)]["handler"]
	removeEventHandler("onElementDimensionChange",element,handler)
 	removeEventHandler("onElementInteriorChange",element,handler)
 	handler = nil
 	elmDimIntHandlers[tostring(element)] = nil

end


addEventHandler("onPlayerLogin",root,function()
	addElementDimIntHandler(source)
end)
addEventHandler("onPlayerQuit",root,function()
	reomveElementDimIntHandler(source)
end)
------for all players already on server -----
for k,player in pairs(getElementsByType("player")) do
	addElementDimIntHandler(player)
end
---------------------------------------------

addEvent("elmDimIntChanged",true)


veles = {}
addEvent("dayVeleg",true)
addEventHandler("dayVeleg",root,function(booler)
	local key = tostring(source)
	if not veles[key] then
		if booler then
			local x,y,z = getElementPosition(source)
			local rx,ry,rz = getElementRotation(source)

			veles[key] = createVehicle(481,x,y,z,rx,ry,rz)
			warpPedIntoVehicle(source,veles[key])	
		end
	else
		destroyElement(veles[key])
		veles[key] = nil
	end
end)

--[[
setTimer(function()
	for k,v in pairs(getElementsByType("ped")) do
		if not isPedDead(v) then
			local elm = createObject(1550,0,0,0)
			setObjectScale(elm,1.04)
			setElementCollisionsEnabled (elm, false) 
			setElementDoubleSided(elm,true)
			attachElementToBone(elm, v, 3, 0.14, -0.36, 0, 120, 0, 0)
			outputChatBox("vidano")
		else
			outputChatBox("ded")
		end
	end
	for k,v in pairs(getElementsByType("player")) do
		if not isPedDead(v) then
			--getPlayerNametagText(v)
			local elm = createObject(1550,0,0,0)
			setObjectScale(elm,1.04)
			setElementCollisionsEnabled (elm, false) 
			setElementDoubleSided(elm,true)
			attachElementToBone(elm, v, 3, 0.14, -0.36, 0, 120, 0, 0)
			outputChatBox("vidano")
		else
			outputChatBox("ded")
		end
	end
end,100,1)]]

setTimer(function()
	for k,v in pairs(getElementsByType("ped")) do
		local veh = getPedOccupiedVehicle(v)
		if veh then
			setElementHealth(veh,1000)
			fixVehicle (veh)
		end
	end
end,1000,0)

for k,v in pairs(getElementsByType("vehicle")) do
	setElementFrozen(v,false)
end

addEvent("searchLightCreate",true)
addEventHandler("searchLightCreate",root,function(key)
	triggerLatentClientEvent("searchLightCreate",root,key)
end)

addEvent("searchLightUpdate",true)
addEventHandler("searchLightUpdate",root,function(key,helic,endPoint)
	triggerLatentClientEvent("searchLightUpdate",100*1024*1024,root,key,helic,endPoint)
end)


addCommandHandler("velomaker",function(player)
	local tim 
	bindKey(player,"mouse5","down",function()
		local state = false
		if tim then killTimer(tim); tim = nil end
		tim = setTimer(function()
			state = not state
			setControlState(player,"accelerate",state)
		end,50,0)	
	end)
	bindKey(player,"mouse5","up",function()
		setTimer(function()
			killTimer(tim)
			tim = nil
		end,100,1)
	end)
end)

addCommandHandler("veh",function(ps,_,model,n1,n2)
	local x,y,z = getElementPosition(ps)
	for i=1,n1 do
		for j=1,n2 do
			createVehicle(model,x+5+5*i,y+5+10*j,z+2)
		end
	end
end)