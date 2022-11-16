--[[--loadstring(exports.importer:load())()					 --
--import('Zad_mastera/zadNica_Zadaniya.lua')()					 --
					 --
					 --
winCorder = {x = 100,y = 200,w = 250,h = 400,color = tocolor(30,30,30,225),textColor1 = tocolor(225,225,255,225),					 --
			headerOtstup = 40					 --
}					 --
butParams = {color = tocolor(100,100,100,225),selectedColor = tocolor(255,150,100,255)}					 --
					 --
ButsDrawed = 0					 --
selectedBut = 1 					 --
					 --
butBLock = false					 --
function addBBLock()					 --
	butBLock = true					 --
end					 --
					 --
function getKeyStateWithBlock(keyName)					 --
	if getKeyState(keyName) and (not butBLock) then					 --
		return true					 --
	end					 --
end					 --
					 --
function getDrawedButS()					 --
	ButsDrawed = ButsDrawed + 1					 --
	return ButsDrawed					 --
end					 --
					 --
function drawButton(args,callFuc)					 --
	local butS = getDrawedButS()					 --
						 --
	local colocer = butParams.color					 --
	local butSelected = false					 --
						 --
	if butS == selectedBut then 					 --
		colocer = butParams.selectedColor					 --
		butSelected = true					 --
		if getKeyStateWithBlock("arrow_d") then					 --
			callFuc()					 --
			return					 --
		end					 --
	end					 --
	dxDrawRectangle(args.x,args.y,args.w,args.h,colocer)					 --
	dxDrawText(args.text, args.x, args.y, args.x + args.w, args.y + args.h, winCorder.textColor1, 1, "arial", "center", "center")					 --
end					 --
					 --
function initZadanie(zadanieK)					 --
	outputChatBox("initiruю zadnicu "..zadanieK)					 --
	selectedZad = zadanieK					 --
	pos = "zad"					 --
					 --
	Zadaniya[zadanieK].init()					 --
end					 --
					 --
function drawZadaniyaList()					 --
	local x = winCorder.x + 30					 --
						 --
	local iter = 0					 --
	for k,v in pairs(Zadaniya) do					 --
		local y = winCorder.y + winCorder.headerOtstup + 40 + 50*iter					 --
					 --
		local zadK = k					 --
		drawButton(					 --
			{x = winCorder.x, y = y, w = winCorder.w - 60, h = 40, text = zadK},					 --
		function()					 --
			initZadanie(zadK)					 --
		end)					 --
					 --
		iter = iter + 1					 --
	end					 --
end					 --
					 --
selectedZad = nil					 --
pos = 'main'					 --
function renderZad()					 --
	local Header = "Zad -- < master (v.0.0.0.0.0.0)"					 --
	local p = 1					 --
	if pos == "main" then					 --
		--						 --
	elseif pos == "zad" then					 --
		Header = selectedZad or "noZad...?"					 --
		p = 2					 --
	end					 --
					 --
	local wc = winCorder					 --
	dxDrawRectangle(wc.x,wc.y,wc.w,wc.h,wc.color)					 --
	dxDrawText(Header, wc.x, wc.y, wc.x + wc.w, wc.y + 40, wc.textColor1, 1, "arial", "center", "center")					 --
	dxDrawLine(wc.x,wc.y + wc.headerOtstup,wc.x + wc.w ,wc.y + wc.headerOtstup)					 --
							 --
	if p == 1 then drawZadaniyaList() end					 --
end					 --
					 --
allowBlock = false					 --
controlButs = {"arrow_r","arrow_l","arrow_d"}					 --
addEventHandler('onClientRender',root,function()					 --
	ButsDrawed = 0					 --
	renderZad()					 --
					 --
	if not butBLock then					 --
		if getKeyStateWithBlock("arrow_r") then selectedBut = selectedBut + 1 end					 --
		if getKeyStateWithBlock("arrow_l") then selectedBut = selectedBut - 1 end					 --
	end					 --
					 --
	if selectedBut > ButsDrawed then selectedBut = ButsDrawed end					 --
	if selectedBut < 1 then selectedBut = 1 end					 --
					 --
					 --
	if butBLock then					 --
		local kek = false					 --
		for k,v in pairs(controlButs) do					 --
			if getKeyState(v) then					 --
				kek = true					 --
			end					 --
		end					 --
		if not kek then					 --
			allowBlock = false					 --
			butBLock = false					 --
		end					 --
	end					 --
	if allowBlock then					 --
		addBBLock()					 --
	end					 --
end)					 --
					 --
					 --
for k,v in pairs(controlButs) do					 --
	bindKey(v,"down",function()					 --
		allowBlock = true					 --
	end)					 --
end					 --
--]]					 --
					 --
					 --
					 --
--[[local nadpisRT = dxCreateRenderTarget(600,400, true)					 --
					 --
local p1 = {2501.4538574219, -1687.1776123047, 13.523121833801}					 --
local p2 = {2486.3640136719, -1687.5388183594, 13.509897232056}					 --
local frame = 0					 --
addEventHandler("onClientRender",root,function()					 --
	frame = frame + 1/50					 --
					 --
	local colR = maxer(((math.sin(frame) + 1)/2)*255*3,255)					 --
	local colG = maxer(((math.sin(frame*2) + 1)/2)*255*3,255)					 --
	local colB = maxer(((math.sin(frame*3) + 1)/2)*255*3,255)					 --
					 --
					 --
	dxSetRenderTarget(nadpisRT,true)					 --
	dxDrawText ("Грув сосать!\n Харе тут залупаться) Вип зону накой пилили? (toHome команда)", 0, 0, 600, 400, tocolor(colR,colG,colB,255), 1.2, 1.2,					 --
                  "default", "center","center", false)					 --
	dxSetRenderTarget()					 --
					 --
	dxDrawMaterialLine3D (p1[1], p1[2], p1[3] + 4 + math.sin(frame)/2 + math.sin(frame/1.5), p2[1], p2[2], p2[3]  + 4 + math.sin(frame)/2 - math.sin(frame/1.5), true, nadpisRT, 10)					 --
					 --
end)					 --
--]]					 --
--[[					 --
local pal = dxCreateTexture("Picture_mastera/Plase/palec.png")					 --
local gra = dxCreateTexture("Picture_mastera/Plase/grafity.png")					 --
local pi = dxCreateTexture("Picture_mastera/Plase/chlen.png")					 --
local screenWidth,screenHeight = guiGetScreenSize()					 --
function GOVNApopei ()						 --
	local seconds = getTickCount() / 1000					 --
	local angle = math.sin(seconds) * 80					 --
	dxDrawImage ( screenWidth - 500,screenHeight - 300, 100, 240, pal, angle, 0, -120 )					 --
	dxDrawImage ( screenWidth - 1000,screenHeight - 300, 100, 240, gra, nil, 0, -120 )					 --
	dxDrawText ("Випка для лохов\n Грув для пацанов\n Пососи мой миниган (sosatb команда)",screenWidth/2 ,screenHeight - 200, 600, 400, tocolor(255,255,255,255), 1.2, 1.2,					 --
                  "default", "center","center", false)					 --
					 --
end						 --
addEvent("Marker",true)					 --
addEventHandler( "Marker", localPlayer, function()					 --
	addEventHandler("onClientRender", root, GOVNApopei)					 --
end)						 --
					 --
addCommandHandler("sosatb",function()					 --
	removeEventHandler("onClientRender", root, GOVNApopei)					 --
	addEventHandler("onClientRender", root, function()					 --
		dxDrawImage ( screenWidth-1350,screenHeight-750, screenWidth, screenHeight, pi, nil, 0, -120 )					 --
	end)					 --
end)					 --
--]]					 --
					 --
					 --
					 --
setTimer(function()					 --
	gitlerVernulsa()					 --
end,1000,1)					 --
					 --
text1 = "Грув Стрит! Я Гитлер! Я Вернулся!"					 --
text2 = "Вам всем Пиздец!"					 --
					 --
weps = {"colt 45","silenced","uzi","mp5","ak-47","m4","tec-9","rifle"}					 --
					 --
col = createColCircle(2487.02783,-1665.55371, 45)					 --
GitlerMode = false					 --
					 --
function createWep()					 --
	for k,v in pairs(weps) do					 --
		addEventHandler("onClientRender",root,function()					 --
			if colCheker then ifIsInCol() else return end					 --
			setTimer(function()					 --
				playSound(":Draws/scena/hello.mp3")					 --
					 --
				datas = {}					 --
					 --
				for k,v in pairs(weps) do					 --
					local x,y,z = getElelementPosition(localPlayer)					 --
					datas[#datas+1] = createWeapon(v,0,0,0)					 --
				end						 --
			end)					 --
								 --
		end)							 --
	end					 --
end					 --
					 --
createwCol = false					 --
soundElement = nil					 --
					 --
					 --
function isInCol()					 --
	local x,y,z = getElelementPosition(localPlayer)					 --
	getDistanceBerwwnPoints3d(getDistanceBetweenPoints3D)					 --
end					 --
					 --
function draLines(x,y,z,x1,y1,z1)					 --
	dxDrawLine(x,y,z,x1,y1,z1,1)					 --
	dxDrawLine(z1,y,z,x1,y,z,1)					 --
	dxDrawLine(x,y,z1,x1,z,y1,1)					 --
	dxDrawLine(x1,y1,x,y,z,x1,1)					 --
					 --
	dxDrawRectangle(600,400,800,400,tocolor(200,200,200,24))					 --
end					 --
					 --
					 --
function placeCoords()					 --
	local dataarray = getWeapons()					 --
						 --
	local colocer = butParams.color					 --
	local butSelected = false					 --
						 --
	if butS == selectedBut then 					 --
		colocer = butParams.selectedColor					 --
		butSelected = true					 --
		if getKeyStateWithBlock("arrow_d") then					 --
			callFuc()					 --
			return					 --
		end					 --
	end					 --
	dxDrawRectangle(args.x,args.y,args.w,args.h,colocer)					 --
	dxDrawText(args.text, args.x, args.y, args.x + args.w, args.y + args.h, winCorder.textColor1, 1, "arial", "center", "center")					 --
end					 --
					 --
frame = 0					 --
function gitlerVernulsa()					 --
	createWep()					 --
					 --
	addEventHandler("onClientPreRender",root,function()					 --
		triggerEvent("resetCannon",root)					 --
		if not GitlerMode then return end					 --
		createGitlerVidelka()					 --
		if mta_getKeyState("lshift") then					 --
			lshifterKey = true					 --
		else					 --
			lshifterKey = false					 --
		end					 --
		if mta_getKeyState("lctrl") then					 --
			lctrlerKey = true					 --
		else					 --
			lctrlerKey = false					 --
		end					 --
					 --
		for i=1,#colors do					 --
			if mta_getKeyState("num_"..(i+3)) then					 --
				chooseGitlerI(i)				-- keys					 --
			end					 --
			if mta_getKeyState(i) then					 --
				--chooseGitlerI(i)			-- keys02					 --
			end					 --
		end					 --
					 --
		local cX,cY,cZ = getWorldFromScreenPosition(screenWid/2,screenHeh/2,0.01)					 --
		local clX,clY,clZ = getWorldFromScreenPosition(screenWid/2,screenHeh/2,60)						 --
		local hit, hitX, hitY, hitZ, hitElement = processLineOfSight ( cX, cY, cZ, 					 --
	                                       									clX,	clY,	clZ, 					 --
	                                       									true,true,false,false,false)					 --
		if hitElement then					 --
			if getElementType(hitElement) == Types["Gitlericle"] then					 --
				lookAtGitler = hitElement					 --
			end					 --
		else					 --
			lookAtGitler = nil					 --
		end					 --
		if ChoosedGitlersShowing then					 --
			dxDrawRectangle(screenWid/2-2,screenHeh/2-2,4,4,tocolor(255,255,255,225))					 --
			dxDrawRectangle(screenWid/2-1,screenHeh/2-1,2,2,tocolor(30,30,30,225))					 --
			if lookAtGitler then					 --
				local lavX,lavY,lavZ = getElementPosition(lookAtGitler)					 --
				local sx,sy = getScreenFromWorldPosition(lavX,lavY,lavZ)					 --
				if sx and sy then 					 --
					sx = sx - 30					 --
					sy = sy - 30					 --
					dxDrawImage(sx,sy,60,60,GitlerVidelkaTex) 					 --
				end					 --
			end					 --
					 --
			for i=1,#colors do					 --
				local Gitler = ChoosedGitlers[i]					 --
				if Gitler then					 --
					local lavX,lavY,lavZ = getElementPosition(Gitler)					 --
					local sx,sy = getScreenFromWorldPosition(lavX,lavY,lavZ)					 --
					if sx and sy then 					 --
						sx = sx - 15					 --
						sy = sy - 15					 --
						dxDrawRectangle(sx,sy,30,30,colors[i]) 					 --
					end					 --
					 --
					dxDrawRectangle(400 + (i-1)*40,screenHeh - 50,30,30,colors[i])					 --
				else					 --
					ChoosedGitlers[i] = nil					 --
					GitlerMode = true					 --
				end					 --
					 --
				if followGitlerI == i then					 --
					dxDrawImage((400 + (i-1)*40) - 5,screenHeh - 50 - 5,40,40,GitlerVidelkaTex)						 --
				end					 --
			end					 --
		end					 --
	end)					 --
end					 --
