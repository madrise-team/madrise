----- import Draws
loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()
------------------------------------------------------------------------
outputDebugString("-*-------- TesterFace --------*-")
------------------------------------------------------------------------
----- FPS ---------------------------------------------------------
fps = 0
nextTick = 0
function getCurrentFPS() -- Setup the useful function
    return fps
end
local function updateFPS(msSinceLastFrame)
    local now = getTickCount()
    if (now >= nextTick) then
        fps = (1 / msSinceLastFrame) * 1000
        nextTick = now + 1000
    end

end
addEventHandler("onClientPreRender", root, updateFPS)

bindKey('n','down',function()
	addEventHandler("onClientRender",root,function()
		dxDrawText(math.floor(getCurrentFPS()),screenW-50,screenH/2)	
	end)
	outputChatBox("Draws/TesterFace: fps show")
end)

--------------------------------------------------------------------

---------- Text hight -----------------------------------------------

--[[
ttCreated = false
bindKey("u","up",function()
	showCursor(true)
	if true then return end

	local winN = "fonTT"
	if ttCreated then
		searchByName(GElements,winN):Destroy()
		ttCreated = not ttCreated
		showCursor(false)
		return	
	end
	ttCreated = not ttCreated


	outputChatBox(":Draws/TesterFace: tesding dynamic TIV`s")

	local cuci = {}
	local fonLocSize = {["x"] = 200,["y"] = screenH/2 - 200,["w"] = 500,["h"] = 0,["sizeType"] = 'dynamic'}
	TIV:create(fonLocSize,{["img"] = "win/centr.png",["color"] = tocolor(40,40,40,245)},nil,winN)

	

	local textLocSize = {["x"] = 2,["x2"] = 2,["y"] = 5,["y2"] = 5,["w"] = 100,["h"] = 10,["sizeType"] = "dynamic"}
	local textTextP = {}
		textTextP.text = "asdas dfghrtynhrtyntynyrfnmyfnmtyntyjhtyjhy  dg"
		textTextP.alignX = "center"
	
	cuci[1] = TIV:create(textLocSize,nil,textTextP,nil,"Fuker")
	cuci[2] = TIV:create(textLocSize,nil,textTextP,nil,winN)
	cuci[3] = TIV:create(textLocSize,nil,textTextP,nil,winN)


	local fonLocSize = {["x"] = 0,["y"] = 0,["w"] = 400,["h"] = 100}
	--TIV:create(fonLocSize,{["img"] = "win/centr.png",["color"] = tocolor(200,225,245,200)},nil,nil,winN)

	bindKey("b","down",function()
		for i,v in ipairs(cuci) do
			v.textP.text = v.textP.text.."dasd"
		end
	end)

end)]]--
--[[bindKey("u","up",function()
	for i=1,1 do
		local textLocSize = {x = 500,x2 = 2,y =100+ 5 + (i-1)*33,y2 = 5,w = 100,h = 33}
		local textTextP = {}
		textTextP.text = "asdas asdfasdf asdfasdf s "..i
		textTextP.alignX = "center"
		local lopnulLoh = TIV:create(textLocSize,{a = 0},textTextP,"padla",nil)
		animate(lopnulLoh,Animations.simpleFade,function()
			lopnulLoh:Destroy()
		end,{dir = -10,startA = 255})
	end
end)]]
--[[bindKey("u","up",function()
	createArea(300,0,200,500,'theScrollArea',"gd","scroll",{})

	cuci = {}
	for i=1,17 do
		local etoDrugoe = {x = 50,y = 4 + (i-1)*44,y2 = 4,w = 100,h = 40}	
		--local etoDrugoe = {x = 50,y = 4,y2 = 4,w = 100,h = 40}
		cuci[i] = TIV:create(etoDrugoe,{img = "win/winTest.png",color = {r = 80,g = 80,b = 64,a = 200}},{text = i,alignX = "center",alignY = "bottom",color = tocolor(255,255,255,255)},i,"theScrollArea")
	end
end)]]

framer = 0
created = false
bindKey("u","up",function()
  if true then return end

  if created then
	local glaver = searchByName(GElements,"glav")
	if glaver then glaver:Destroy() end 
	created = false
	destroyElement(rectr)
  else
  	rectr = createTexFucFromDraws(25,25,function()
		dxDrawRectangle(0,10,25,5,tocolor(16,220,169,255))
	end)()

  	created = true
	local etoDrugoe = TIV:create({x = 1010 + SButton.button1small.w,y = 800,y2 = 4,w = SButton.button1small.w*2,h = SButton.button1small.h*2},{img = "win/winTest.png",color = {r = 180,g=150,b=60,a = 220}},{w = 120,h = 1000},"glav")


	createBlurer(700,800,200,120,parent)


	local etoDrugoe3Crototen = TIV:create({x = 100,y = 40,w = 50,h = 50},{img = createTexFucFromDraws(50,50,function()	
		framer = framer + 1
		dxDrawImage (0, 0, 50,50,rectr,math.floor(framer*300.12341342513),0,0)
		--dxDrawImage (0,0, 25,25,rectr)
	end),frame = true},nil,"podglav","glav")

	--[[local etoDrugoe2 = TIV:create({x = -160,y = -60,w = SButton.button1small.w,h = SButton.button1small.h},{img = SButton.button1small.imgN},{text = "blDoL",alignX = "center",scaleXY = 2,alignY = "center"},"podglav","glav")
	local sus = 0
	addEventHandler("onClientRender",root,function()
		sus = sus + 1

		etoDrugoe2.locSize.y1 = etoDrugoe2.locSize.y1 + math.sin(sus/15)*6
		etoDrugoe2.locSize.x1 = etoDrugoe2.locSize.x1 + math.sin(sus/60)*5

	end)]]
  end
end)
credet = false
--[[bindKey("u","up",function()
	if credet then
		searchByName(GElements,"glav"):Destroy()
		credet = false
		return
	end
	credet = true

	local etoDrugoe = TIV:create({x = 220,y = 100,y2 = 4,w = 1000,h = 400},{img = "win/winTest.png",originalSize = {w = 200,h = 100},color = {r = 180,g=150,b=60,a = 120}},nil,"glav")
	
	elmy = {}
	for i=1,4 do
		for j=1,4 do
			elmy[#elmy + 1] = TIV:create({x = 0 + (j-1)*244,y = (i-1)*SButton.button1small.h*1.1 + 2,w = SButton.button1small.w,h = SButton.button1small.h},{img = SButton.button1small.imgN},{text = "blDoL",alignX = "center",scaleXY = 2,alignY = "center"},"podglav","glav")
		end
	end 

	local sus = 0
	addEventHandler("onClientRender",root,function()
		sus = sus + 1

		for k,v in pairs(elmy) do
			v.locSize.y1 = (v.locSize.y1 + math.sin(sus/15/2)*3*math.random(-3,3))
			v.locSize.x1 = (v.locSize.x1 + math.sin(sus/60/2)*2.5*math.random(-3,3))
		end
		dxDrawText(tostring(dxGetStatus().VideoMemoryFreeForMTA),500,100)
		
	end)

end)]]
--[[bindKey("u","up",function()
	if credet then
		searchByName(GElements,"glav"):Destroy()
		credet = false
		return
	end
	credet = true

	local etoDrugoe = TIV:create({x = 220,y = 100,y2 = 4,w = 1000,h = 400,anchor = {alignX = 1,alignY = 0.5}},{img = "win/winTest.png",originalSize = {w = 200,h = 100},color = {r = 180,g=150,b=60,a = 120}},nil,"glav")
	
	createButton(SButton.button1small,40,0,SButton.button1small.w,SButton.button1small.h,{text = "bidl"},"knopka","glav",function()
		outputChatBox("clicking")
	end)
end)]]


local b = -170  +255

local frameT = 1300
treeangleTexPath = ":Draws/Elements/Pattern/threeangle.png"
treeangleTex = dxCreateTexture(treeangleTexPath,"dxt5")



local origR = 20
local origG = 160
local origB = 200

local ptrnEfxR = 0
local ptrnEfxG = 0
local ptrnEfxB = 0

local ptrnEfx1R = 125
local ptrnEfx1G = 225
local ptrnEfx1B = 225

local ptrnEfx2R = -250 * 200
local ptrnEfx2G = 0
local ptrnEfx2B = 130


local _ptrnEfx = 0
	local _ptrnEfxArray = {}


local _ptrnEfx_str = 40
local _ptrnEfx_clm = 100-1

function PatternEDBAder()
	frameT = frameT + 1
	dxDrawRectangle(0,0,screenW,screenH,tocolor(0,0,0,255))


	local i = 0
	for str=0,_ptrnEfx_str do
		for clm=0,_ptrnEfx_clm do
			i=i+1

			local inv = 1
			if (clm%2) == 1 then inv = -1 end

			local x = (clm/2 - str/3)/40 + (frameT/320)
			local kef = math.sin(math.sin(x - math.cos(x*4)))
			
			kef = (kef + 1)/2 			-- to 0   - 1
			kef = kef*0.7 + 0.3  		-- to 0.2 - 1
			--kef2 = 1 - kef2
			
			local sK = kef*(1-0.6) + 0.6
			local size = 32 * sK
			local otstup = (1 - sK)*32
			
			local tR = origR * kef/2
			local tG = origG * kef/2
			local tB = origB * kef*1.2

			if _ptrnEfx ~= 0 then
				if _ptrnEfx == 1 or _ptrnEfx == 2 then
					if _ptrnEfxArray[str][clm].delay > 0 then
						_ptrnEfxArray[str][clm].delay = _ptrnEfxArray[str][clm].delay - 1
					else
						local ptrnEfxer = _ptrnEfxArray[str][clm].ptrnEfx
						local ptrnprestartEfxer = 1
						if _ptrnEfxArray[str][clm].prestart < 1 then
							ptrnprestartEfxer = _ptrnEfxArray[str][clm].prestart
							_ptrnEfxArray[str][clm].prestart = _ptrnEfxArray[str][clm].prestart + 0.2
						end						
						tR = tR + ((ptrnEfxR - tR)*ptrnEfxer*ptrnprestartEfxer)%50
						tG = tG + (ptrnEfxG - tG)*ptrnEfxer*ptrnprestartEfxer
						tB = tB + (ptrnEfxB - tB)*ptrnEfxer*ptrnprestartEfxer

						_ptrnEfxArray[str][clm].ptrnEfx = _ptrnEfxArray[str][clm].ptrnEfx/1.01
					end
					if _ptrnEfxArray[str][clm].ptrnEfx < 0.01 then
						_ptrnEfxArray[str][clm].ptrnEfx = 0
					end
				end
			end
			dxDrawImage(clm*18 - 18*(str%2) + (otstup*1.2)/2,
						30*(clm%2)  + str*30 + otstup/3 * inv,

						size,
						size -size*2*(clm%2),
						treeangleTex,
						0,0,0,
						tocolor(tR,tG,tB,235))
		end
		dxDrawText(frameT,40,10)
		if frameT % 1400 == 0 then
			_ptrnEfxType = math.random(100)
			if _ptrnEfxType > 70 then
				_ptrnEfxType = 1
			else
				_ptrnEfxType = 2
			end

			_ptrnEfx = math.random(100)
			if _ptrnEfx > 80 then
				_ptrnEfx = 2
			else
				_ptrnEfx = 1
			end

			if _ptrnEfx == 1 then
				ptrnEfxR = ptrnEfx1R
				ptrnEfxG = ptrnEfx1G
				ptrnEfxB = ptrnEfx1B
			elseif _ptrnEfx == 2 then
				ptrnEfxR = ptrnEfx2R
				ptrnEfxG = ptrnEfx2G
				ptrnEfxB = ptrnEfx2B
			end

			if _ptrnEfxType == 1 then
				for str=0,_ptrnEfx_str do
					_ptrnEfxArray[str] = {}
					for clm=0,_ptrnEfx_clm do
						_ptrnEfxArray[str][clm] = {ptrnEfx = math.random(6,10)/10,delay = 50 - 50*(clm/_ptrnEfx_clm) + str/3 + math.random(0,5),prestart = 0}
					end
				end
			else
				for str=0,_ptrnEfx_str do
					_ptrnEfxArray[str] = {}
					for clm=0,_ptrnEfx_clm do
						_ptrnEfxArray[str][clm] = {ptrnEfx = math.random(2,10)/10,delay = math.random(0,250)/10,prestart = 0.5}
					end
				end
			end			
		end
	end
end
paterenerRerLel_eee = false
function adderPatterner()
	if not paterenerRerLel_eee then addEventHandler("onClientPedsProcessed",root,PatternEDBAder)
	else removeEventHandler("onClientPedsProcessed",root,PatternEDBAder) end
	paterenerRerLel_eee =  not paterenerRerLel_eee
end
bindKey("u","down",adderPatterner)
adderPatterner()



function drawFpasseerers()
	dxDrawText(math.floor(getCurrentFPS()),screenW - 50,40,40,40)
end
_fpsSer = false
function addDrawFpseser()
	if not _fpsSer then addEventHandler("onClientRender",root,drawFpasseerers)
	else removeEventHandler("onClientRender",root,drawFpasseerers) end
	_fpsSer =  not _fpsSer
end
bindKey("o","up",addDrawFpseser)
addDrawFpseser()
---------------------------------------------------------------------
local testRT = dxCreateRenderTarget(400,400,true)
dxSetRenderTarget(testRT,true)
dxDrawImage(0,0,400,400,":Draws/win/winTest.png")
dxSetRenderTarget()

 
curso = false
bindKey("mouse3","up",function()
	if not curso then
		outputChatBox("cursor showed by :Draws/Testerface [mouse3]")
		showCursor(true)
		curso = true
	else
		outputChatBox("cursor hided by :Draws/Testerface [mouse3]")
		showCursor(false)
		curso = false
	end
end)
---------------------------------------------------------------------