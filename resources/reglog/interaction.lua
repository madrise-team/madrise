---------------------Config------------------------
local ScanDepth = 5 --Должно быть меньше чем глубина сканирования чтоб не тупило
local _ScanDepth_powed = ScanDepth*ScanDepth
local crs_offsetX, crs_offsetY = 15 ,15 -- смещение текста отн. курсора
local win_offsetX, win_offsetY = 50 ,-150 -- смещение окна отн. плеера

local alfa = 150
---------------------------------------------------

local bool = false
local def = false


function detectPlayer()
	cx, cy = getCursorPosition()
	if not cx then return end
	
	 cx = cx * screenW
	 cy = cy * screenH

	local x1,y1,z1 = getWorldFromScreenPosition(cx,cy,0.01)
	local x2,y2,z2 = getWorldFromScreenPosition(cx,cy,ScanDepth)
	local hit, hitX,hitY,hitZ, elementHit = processLineOfSight(x1,y1,z1,  x2,y2,z2,false,true,true)
	if hit then
		if getElementType(elementHit) ~= "player" then return false end
		if elementHit == localPlayer then return end

		local dst = math.pow(hitX - x1,2) + math.pow(hitY - y1,2) + math.pow(hitZ - z1,2)
		if dst <= _ScanDepth_powed then
			return elementHit
		end
	end
	return false
 end

--------------------------------------------------------------------------------

interaction = false
bindKey("e","down",function()
	interaction = not interaction
	if not interaction then
		interactPlayer = nil	
	end
end)

addEventHandler("onClientRender",root,function()
	local detected = detectPlayer()
	if not interaction then interactPlayer = detected end
	if not interactPlayer then return end

	if not cx then 
		interactPlayer = nil	
		interaction = false		
		return
	end
	if not interaction then
		local textX = cx + crs_offsetX
		local textY = cy + crs_offsetY
		dxDrawText("Взаимводействовать [e]", textX, textY, textX +500, textY +500 , tocolor(255,255,255,alfa) )
	end

	if interaction then
		local ipx,ipy,ipz = getElementPosition(interactPlayer)
		local sx,sy = getScreenFromWorldPosition(ipx,ipy,ipz + 0.3)
		if not sx then return end

		sx = sx + win_offsetX
		sy = sy + win_offsetY

		local winW = 150
		local winH = 300
		local col = tocolor(40,40,40,200)
		
		dxDrawRectangle(sx,sy, winW,winH, col)	

		dxDrawLine(sx,sy,sx,sy+winH, tocolor(100,100,100,100),2)
		dxDrawLine(sx+ winW,sy,sx + winW,sy+winH, tocolor(100,100,100,100),2)
		
		dxDrawLine(sx,sy,sx + winW,sy, tocolor(255,255,255,75),2)
		dxDrawLine(sx,sy+winH,sx + winW,sy+winH, tocolor(0,0,0,100),2)

	end
end)

--------------------------------------------------------------------------------
do return end 


bindKey("e","down",function() bool = not bool def = not def Defer() end)
function PlayerDetected()
	if not isCursorShowing(localPlayer) then return end
	local PlayerP = detectPlayer()
	local Type = getElementType(PlayerP)
	if Type == "player" then Distance(PlayerP) end
end

function Distance(elementPlayer)
	local xp,yp,zp = getElementPosition(localPlayer)
	local xn,yn,zn = getElementPosition(elementPlayer)
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

