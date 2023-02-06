---------------------Config------------------------
local DistToPlayer = 5 --Должно быть меньше чем глубина сканирования чтоб не тупило
local ScanDepth = 10
local width, height = 0 ,10 -- расположение текста на курсоре
---------------------------------------------------

local bool = false
local def = false

bindKey("e","down",function() bool = not bool def = not def Defer() end)

function TypeDetector()
 	local xp,yp,zp = getCameraMatrix()
	local w, h = getCursorPosition()
	 w = screenW * w
	 h = screenH * h
	local x,y,z = getWorldFromScreenPosition(w,h,ScanDepth)
	local hit, xn,yn,zn, elementHit = processLineOfSight(xp,yp,zp,  x,y,z,false,true,true)
	return(elementHit)
 end

function PlayerDetected()
	if not isCursorShowing(localPlayer) then return end
	local PlayerP = TypeDetector()
	local Type = getElementType(PlayerP)
	if Type == "player" then Distance(PlayerP) end
end

function Distance(elementPlayer)
	local xp,yp,zp =getElementPosition(localPlayer)
	local xn,yn,zn =getElementPosition(elementPlayer)
	local distance = getDistanceBetweenPoints3D(xp,yp,zp, xn,yn,zn)
	if distance < DistToPlayer then InteractionButton(elementPlayer) end
end

function InteractionButton(elementPlayer)
	local w,h = getCursorPosition()
	 w = screenW * w
	 h = screenH * h
	if elementPlayer ~= localPlayer then 
		dxDrawText("<e>",w + width,h + height)
		Key()
	end
end

function Key()
	if bool and isCursorShowing(localPlayer) then 
		removeEventHandler("onClientRender",root, PlayerDetected)
	else 
		removeEventHandler("onClientRender",root, Interaction)
	end 
end

function Defer()
	if def and isCursorShowing(localPlayer) then
		addEventHandler("onClientRender",root, Interaction)
	else
		addEventHandler("onClientRender",root, PlayerDetected)
	end
end

function Interaction()
	local w,h = guiGetScreenSize()
	dxDrawRectangle(w/2,h/2,300,300)
end

addEventHandler("onClientRender",root, PlayerDetected)

--[[
ОТРУБЛЕНА АФК СИСТЕМА !!!!! НЕ ЗАБЫТЬ ВЕРНУТЬ КАК БЫДЛО!!!!
--]]
--[[
Забаганное дерьмо надо фиксить с начала думал что я бог оказалось не так
--]]

