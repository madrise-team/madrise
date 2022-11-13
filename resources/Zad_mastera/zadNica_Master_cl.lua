--[[--loadstring(exports.importer:load())()
--import('Zad_mastera/zadNica_Zadaniya.lua')()


winCorder = {x = 100,y = 200,w = 250,h = 400,color = tocolor(30,30,30,225),textColor1 = tocolor(225,225,255,225),
			headerOtstup = 40
}
butParams = {color = tocolor(100,100,100,225),selectedColor = tocolor(255,150,100,255)}

ButsDrawed = 0
selectedBut = 1 

butBLock = false
function addBBLock()
	butBLock = true
end

function getKeyStateWithBlock(keyName)
	if getKeyState(keyName) and (not butBLock) then
		return true
	end
end

function getDrawedButS()
	ButsDrawed = ButsDrawed + 1
	return ButsDrawed
end

function drawButton(args,callFuc)
	local butS = getDrawedButS()
	
	local colocer = butParams.color
	local butSelected = false
	
	if butS == selectedBut then 
		colocer = butParams.selectedColor
		butSelected = true
		if getKeyStateWithBlock("arrow_d") then
			callFuc()
			return
		end
	end
	dxDrawRectangle(args.x,args.y,args.w,args.h,colocer)
	dxDrawText(args.text, args.x, args.y, args.x + args.w, args.y + args.h, winCorder.textColor1, 1, "arial", "center", "center")
end

function initZadanie(zadanieK)
	outputChatBox("initiruю zadnicu "..zadanieK)
	selectedZad = zadanieK
	pos = "zad"

	Zadaniya[zadanieK].init()
end

function drawZadaniyaList()
	local x = winCorder.x + 30
	
	local iter = 0
	for k,v in pairs(Zadaniya) do
		local y = winCorder.y + winCorder.headerOtstup + 40 + 50*iter

		local zadK = k
		drawButton(
			{x = winCorder.x, y = y, w = winCorder.w - 60, h = 40, text = zadK},
		function()
			initZadanie(zadK)
		end)

		iter = iter + 1
	end
end

selectedZad = nil
pos = 'main'
function renderZad()
	local Header = "Zad -- < master (v.0.0.0.0.0.0)"
	local p = 1
	if pos == "main" then
		--	
	elseif pos == "zad" then
		Header = selectedZad or "noZad...?"
		p = 2
	end

	local wc = winCorder
	dxDrawRectangle(wc.x,wc.y,wc.w,wc.h,wc.color)
	dxDrawText(Header, wc.x, wc.y, wc.x + wc.w, wc.y + 40, wc.textColor1, 1, "arial", "center", "center")
	dxDrawLine(wc.x,wc.y + wc.headerOtstup,wc.x + wc.w ,wc.y + wc.headerOtstup)
		
	if p == 1 then drawZadaniyaList() end
end

allowBlock = false
controlButs = {"arrow_r","arrow_l","arrow_d"}
addEventHandler('onClientRender',root,function()
	ButsDrawed = 0
	renderZad()

	if not butBLock then
		if getKeyStateWithBlock("arrow_r") then selectedBut = selectedBut + 1 end
		if getKeyStateWithBlock("arrow_l") then selectedBut = selectedBut - 1 end
	end

	if selectedBut > ButsDrawed then selectedBut = ButsDrawed end
	if selectedBut < 1 then selectedBut = 1 end


	if butBLock then
		local kek = false
		for k,v in pairs(controlButs) do
			if getKeyState(v) then
				kek = true
			end
		end
		if not kek then
			allowBlock = false
			butBLock = false
		end
	end
	if allowBlock then
		addBBLock()
	end
end)


for k,v in pairs(controlButs) do
	bindKey(v,"down",function()
		allowBlock = true
	end)
end
--]]



local nadpisRT = dxCreateRenderTarget(600,400, true)

local p1 = {2501.4538574219, -1687.1776123047, 13.523121833801}
local p2 = {2486.3640136719, -1687.5388183594, 13.509897232056}
local frame = 0
addEventHandler("onClientRender",root,function()
	frame = frame + 1/50

	local colR = maxer(((math.sin(frame) + 1)/2)*255*3,255)
	local colG = maxer(((math.sin(frame*2) + 1)/2)*255*3,255)
	local colB = maxer(((math.sin(frame*3) + 1)/2)*255*3,255)


	dxSetRenderTarget(nadpisRT,true)
	dxDrawText ("Грув сосать!\n Харе тут залупаться) Вип зону накой пилили? (toHome команда)", 0, 0, 600, 400, tocolor(colR,colG,colB,255), 1.2, 1.2,
                  "default", "center","center", false)
	dxSetRenderTarget()

	dxDrawMaterialLine3D (p1[1], p1[2], p1[3] + 4 + math.sin(frame)/2 + math.sin(frame/1.5), p2[1], p2[2], p2[3]  + 4 + math.sin(frame)/2 - math.sin(frame/1.5), true, nadpisRT, 10)

end)