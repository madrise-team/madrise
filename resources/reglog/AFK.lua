---// config /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
local checkInterval = 1000  -- как часто проверять позицию игрока 		//
local totalChecks = 60*10 	-- кол-во проверок до появления интерфейса 	//
local faceTime = 30000 		-- время показа интерфейса 					//
local radius = 5 			-- радиус бездействия 						//
---///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

local failAttmpts = 0
local savedPos
local checkTimer = false
local toKickTimer = false

function PlyPos1 ()
	local x,y,z = getElementPosition(localPlayer) -- Позиция игрока до начала проверки нахождения его в радиусе афк
	savedPos = {x=x,y=y,z=z}
end

function CheckInAFKrad ()
	local xn,yn,zn = getElementPosition(localPlayer)
	local dst = getDistanceBetweenPoints3D(savedPos.x,savedPos.y,savedPos.z,  xn,yn,zn) -- сохраненная : Текущая позиция
	return dst < radius
end

function Check ()
	local afk = CheckInAFKrad()	
	if afk then 
		failAttmpts = failAttmpts + 1
		if failAttmpts > totalChecks then
			initAfk()
			failAttmpts = 0
			recreateCheckTimer(true)
		end
	else 
		failAttmpts = 0
		resetAfk() 
	end	
end

function doKickTriiger() 
	outputChatBox("Ну все кик нахуй...")
	triggerServerEvent("AFK_KickMe",root,localPlayer) 
end

function initAfk()
	outputChatBox("Вы долго бездействуете, Вы тут?")
	outputChatBox("Напишите команду 'yes' иначе кик")
 	toKickTimer = setTimer(doKickTriiger,faceTime,1)
end

function resetAfk()
	print("я живой (двигался)")
	PlyPos1()
end

function recreateCheckTimer(dontRecreate)
 	failAttmpts = 0
 	if checkTimer then 
 		killTimer(checkTimer)
 		checkTimer = false
 	end
 	if --[[not--]] dontRecreate then checkTimer = setTimer(Check,checkInterval,0) end	
end

addCommandHandler("yes",function()
	if toKickTimer then 
		killTimer(toKickTimer)
		toKickTimer = false
	end
	recreateCheckTimer()  -- пересоздание таймера проверки *(чтобы типо сбросить время до след проверки)
	outputChatBox("хорошо, вы тут.")
end)

addCommandHandler("AFK",function(_,enabled)
	recreateCheckTimer(not enabled)
end)
-- debDraw
addEventHandler("onClientRender",root,function()
	local debStr = failAttmpts
	if not checkTimer then debStr = "disabled" end
	dxDrawText("AFK: "..debStr, 400,0)
end)

PlyPos1()
recreateCheckTimer()
--  👍
-- ждем систему (usful) статистики && систему уведомлений