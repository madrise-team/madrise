----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
------------------------------------
--/////////////////////////////////////////////////
--    config
--//

local ScanDepth = 15 --Должно быть меньше чем глубина сканирования чтоб не тупило
local _ScanDepth_powed = ScanDepth*ScanDepth
local crs_offsetX, crs_offsetY = 15 ,15 -- смещение текста отн. курсора
local win_offsetX, win_offsetY = 50 ,-150 -- смещение окна отн. плеера

local alfa = 150




--/////////////////////////////////////////////////
--    interaction
--//

function detectPlayer()
	cx, cy = getCursorPosition()
	if not cx then return end
	
	 cx = cx * screenW
	 cy = cy * screenH

	local x1,y1,z1 = getWorldFromScreenPosition(cx,cy,0.01)
	local x2,y2,z2 = getWorldFromScreenPosition(cx,cy,ScanDepth)
	local hit, hitX,hitY,hitZ, elementHit = processLineOfSight(x1,y1,z1,  x2,y2,z2,false,true,true)
	if elementHit then
		if getElementType(elementHit) ~= "player" then return false end
		if elementHit == localPlayer then return end

		local dst = math.pow(hitX - x1,2) + math.pow(hitY - y1,2) + math.pow(hitZ - z1,2)
		if dst <= _ScanDepth_powed then
			return elementHit
		end
	end
	return false
end



--/////////////////////////////////////////////////
--    functional
--//

function addContactRequest(contactType)
	if not interactPlayer then return end
	if not iteractPlnick then return end
	if (contactType ~= 1) and (contactType ~= 2) then return end
	if (contactType == 1) and knowPeople[iteractPlnick] then return end
	if (contactType == 2) and friends[iteractPlnick] then return end

 	triggerLatentServerEvent("addContactRequest", 2000, false,  localPlayer, interactPlayer, contactType)
 	
 	swapInteraction()
 	showCursor(false)
end



--/////////////////////////////////////////////////
--    face
--// 

interaction = false

local mouse1Up = false

function swapInteraction()
	interaction = not interaction
	if not interaction then
		interactPlayer = nil
	end
end
bindKey("e","down",swapInteraction)


iteractPlnick = false
addEventHandler("onClientRender",root,function()
	local detected = detectPlayer()
	if not cx then 
		interactPlayer = nil	
		interaction = false		
		return
	end

	if not interaction then interactPlayer = detected end
	if not interactPlayer then 
		iteractPlnick = false
		return 
	end

	iteractPlnick = iteractPlnick or getPlayerNickName(interactPlayer)

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
		

		--** Окно **************************************
		dxDrawRectangle(sx,sy, winW,winH, col)	

		dxDrawLine(sx,sy,sx,sy+winH, tocolor(100,100,100,100),2)
		dxDrawLine(sx+ winW,sy,sx + winW,sy+winH, tocolor(100,100,100,100),2)
		
		dxDrawLine(sx,sy,sx + winW,sy, tocolor(255,255,255,75),2)
		dxDrawLine(sx,sy+winH,sx + winW,sy+winH, tocolor(90,90,90,100),2)
		--********************************************

		local know = false
		local friend = false

		--** Ник и статус *******************
		local statusStr = ""
		local statusCol = tocolor(255,255,255,255)
		if friends[iteractPlnick] then
			statusStr = "Ваш кореш"
			statusCol = tocolor(150,255,150,255)

			friend = true
			know = true
		elseif knowPeople[iteractPlnick] then
			statusStr = "Ваш кент"
			statusCol = tocolor(150,150,255,255)

			know = true
		end

		dxDrawText(iteractPlnick, sx + 10,sy + 5, sx+winW,sy+winH, statusCol, 1.5, 1.5, "default","left","top")
		dxDrawLine(sx,sy+30,sx + winW,sy+30, tocolor(200,200,200,100),1)

		dxDrawText(statusStr, sx + 12,sy + 36, sx+winW,sy+winH, statusCol, 1, 1, "default","left","top")
		--*********************************

		--** Функционал *********************************
		local ofsY = 56

		--- Контакты
		if contactsLoaded and (not comm_recRequests[iteractPlnick]) then
			if not know then
				renderButton(mouse1Up,"Добавить в кенты" ,sx+1,sy+1 + ofsY, winW-2, 30-2, addContactRequest, 1)
				ofsY = ofsY+ 32
			end
			if not friend then
				renderButton(mouse1Up,"Добавить в кореша",sx+1,sy+1 + ofsY, winW-2, 30-2, addContactRequest, 2)
				ofsY = ofsY+ 32
			end
		end


		mouse1Up = false
		--*********************************

	end
end)

bindKey("mouse1","up",function()
	mouse1Up = true
end)