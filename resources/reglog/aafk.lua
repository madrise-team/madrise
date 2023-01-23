----- imports
loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()    -- drawsCore
outputDebugString("reglog/aafk enabled />/>/>")
------------------------------------
--//////////////////////////////////////////////////////
-- Config //////////////////////////////////////////////
timeLimit = {mins = 10} --- last minute - face show
radius = 5
interfaceRemainingTime = 60  --в секнудах

--//////////////////////////////////////////////////////
--//////////////////////////////////////////////////////
timeLimitInSecs = convertToSecs(timeLimit)
powedRadius = radius*radius
faceShow = true
reseting = 0
processing = true

function facer(bool)
	faceShow = bool
	showCursor(bool)
end
function resetAafkTracking()
	reseting = 120
	facer(false)

	local sx,sy,sz = getElementPosition(localPlayer)
	savedPoint = {x = sx,y = sy,z = sz}
	afkTargetTime = getRealTime().timestamp + timeLimitInSecs
end
resetAafkTracking()

function doAfkTrigger()
	facer(false)
	processing = false

	outputChatBox("Перевод в спящий режим(Кик нахуй!)")
	triggerServerEvent("afkKickMe",root,getLocalPlayer())

	setTimer(function()
		switchToSleep = true	
	end,500,1)
end


addEventHandler("onClientRender",root,function()
	local tstamp = getRealTime().timestamp
	local secsToEnd = afkTargetTime - tstamp

	----///// Deb
	local debStr = secsToEnd.."с"
	if reseting > 0 then debStr = "not tracked"; reseting = reseting - 1 end
	if not processing then debStr = "disabled" end
	if switchToSleep then debStr = "switching to sleep..." end
	dxDrawText("AFK: "..debStr,700,0)
	----///// 

	-- Processing
	if processing then
		local x,y,z = getElementPosition(localPlayer)
		local powedDst = math.pow(x - savedPoint.x,2) + math.pow(y - savedPoint.y,2) + math.pow(z - savedPoint.z,2)

		if powedDst > powedRadius then
			resetAafkTracking()
		else
			if (secsToEnd < interfaceRemainingTime) and (not faceShow) then
				facer(true)		
			end

			if tstamp > afkTargetTime then
				doAfkTrigger()
			end
		end
	end

	--- Face
	if faceShow then
		local i_w = 460
		local i_h = 180
		local i_x = screenW/2 - i_w/2
		local i_y = 25

		dxDrawRectangle(i_x,i_y,i_w,i_h,tocolor(4,10,25,180))
		dText("Мы заметили, что вы долго бездействуете.", i_x+20, i_y, i_w-40, 68, 1.2)
		dText("В связи с этим,\n через #FEFE88"..secsToEnd.."с #FFFFFFустройство будет переведено в спяший режим.", i_x+20, i_y, i_w-40, 150, 1.2)
		
		local bw = i_w/2.3
		local bh = i_h/4
		local by = i_y + i_h - i_h/4*1.5
		dButton("Да, я не активен",i_x + 20, 			by, bw, bh, doAfkTrigger)
		dButton("Отмена, я активен",i_x + i_w - bw - 20, 	by, bw, bh, resetAafkTracking)
	end
	mClick = false


	--switchToSleep anim
	if switchToSleep then
		dxDrawRectangle(0,0,screenW,screenH,tocolor(5,5,10,200))
		local dotsCount = tstamp%3
		local dots = ""
		for i=1,dotsCount + 1 do
			dots = dots.."."
		end
		dText("Переход в спящий режим"..dots, 0,0,screenW,screenH,2)
	end
end)

function dText(text, x,y,w,h, scale)
	dxDrawText (text, x, y, x+w, y+h, tocolor(255,255,255,255), scale, scale, "default", "center", "center", true, true, true, true)
end

function dButton(text,x,y,w,h,callback)
	local col = tocolor(3,0,10,225)
	
	local curx,cury = getCursorPosition()
	if curx then
		curx = curx*screenW
		cury = cury*screenH
		if isPointInQuad(curx,cury, x,y,w,h) then
			col = tocolor(3,160,180,225)
			if mClick then callback() end
		end
	end

	dxDrawRectangle(x,y,w,h, col)
	dText(text, x,y,w,h, 1)
end
bindKey("mouse1","up",function()
	mClick = true
end)
--// face deb Show
bindKey("6","down",function()
	facer(true)
end)


addCommandHandler("AAAFK",function()
	processing = false
	outputConsole("AAFK disabled")
end)