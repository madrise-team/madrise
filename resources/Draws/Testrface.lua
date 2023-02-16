----- import Draws
loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()
------------------------------------------------------------------------
outputDebugString("-*-------- TesterFace --------*-")
------------------------------------------------------------------------
--_DoWinDubugDraw()  - испльзование _DWDD
----- FPS calc ---------------------------------------------------------
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
		dxDrawText(math.floor(getCurrentFPS()),screenW-50,20,nil,nil,nil,2,"default","left","top",false,false,true)
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

framt = 0
local randColRecter = function(_,obj)
	framt = framt+1

	local colR = 	((math.sin(framt/100) + 1)/2)*255
	local colG = 	((math.cos(framt/50) + 1)/2)*255
	local colB = 	((math.sin(framt/28) + 1)/2)*255

	local lS = obj.locSize
	dxDrawRectangle(lS.cutX,lS.cutY,lS.cutW,lS.cutH,tocolor(colR,colG,colB,obj.imgP.color.a))
end

bindKey("6","up",function()	
	do return end
	local scrollAreaName = "scrollыч"


	local slidersTable =  {}
	local scrollZone = scrollTIV:create({x = 500,y = 400,w = 300,h = 350},scrollAreaName,nil)
	scrollZone.slidersT[2] = {x = scrollZone.locSize.w/2 - 30, 	w = 40, h  = 10, img = randColRecter,frame = true}
	scrollZone.slidersT[3] = {x = scrollZone.locSize.w - 4, 	w = 4, h  = 8,  img = createTexFucFromDraws(6,8,function()
		outputChatBox("kok")
		dxDrawLine(0,0,3,0)
		dxDrawLine(3,0,3,7)
		dxDrawLine(3,7,0,7)
		dxDrawLine(0,7,0,0)
	end)}
	scrollZone:createSliders()
	
	for i=0,9 do
		local liker = TIV:create({x = 20,y = 10 + SButton.button1small.h*i,w = SButton.button1small.w,h = SButton.button1small.h},
			{img = SButton.button1small.imgN},nil,"clickTiv"..i,scrollAreaName)
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






bindKey(".","up",function()
	do return end
	
	


	local butT =  {
		imgN = "Elements/BS/Button1/Button1_norm.png",
    	imgD = "Elements/BS/Button1/Button1_down.png",
    	imgH = "Elements/BS/Button1/Button1_hover.png"}

	createButton(butT,400,500,200,100,{text = "knopka"},nil,nil,function()
		outputChatBox("cliker")
	end)
end)




threeangleTexPath = ":Draws/Elements/Pattern/threeangle.png"
threeangleTex = dxCreateTexture(threeangleTexPath,"dxt1")

--threeangle2TexPath = ":Draws/Elements/Pattern/threeangle2.png"
--threeangle2Tex = dxCreateTexture(threeangle2TexPath,"dxt3")
--linerTexPath = ":Draws/Elements/Pattern/liner.png"
--linerTex = dxCreateTexture(linerTexPath,"dxt3")

local frameT = 0

local _ptrnOrigR = 20
local _ptrnOrigG = 160
local _ptrnOrigB = 200

local _ptrnEfxR = 0  -- now rgb State
local _ptrnEfxG = 0
local _ptrnEfxB = 0

local _ptrnEfx1R = 125	-- col efx 1 should be rgb
local _ptrnEfx1G = 225
local _ptrnEfx1B = 225

local _ptrnEfx2R = -250 * 3 -- col efx 2 should be rgb
local _ptrnEfx2G = 0
local _ptrnEfx2B = 180

local _ptrnEfxWaitTime = 1000
local _ptrnLinesWaitTime = 400

local _ptrnEfx_str = 40
local _ptrnEfx_clm = 100-1


local _ptrnLines = {}

local _ptrnEfx = 0
	local _ptrnEfxArray = {}
	for str=0,_ptrnEfx_str do
		_ptrnEfxArray[str] = {}
		_ptrnLines[str] = {}

		for clm=0,_ptrnEfx_clm do
			_ptrnEfxArray[str][clm] = {}
			_ptrnEfxArray[str][clm].whiteRandom = math.random(-1,1)
		end
	end




function PatternEDBAder()
	frameT = frameT + 0.5
	dxDrawRectangle(0,0,screenW,screenH,tocolor(0,0,0,255))

	local i = 0
	for i=1,12 do
		_ptrnEfxArray[math.random(0,_ptrnEfx_str)][math.random(0,_ptrnEfx_clm)].whiteRandom = math.random(-3,3)
	end

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
			
			local sK = (kef*kef*kef*kef)/1.4 + 0.23
			local size = 80 * sK
			local otstup = (1 - sK)*80
			
			local tR = _ptrnOrigR * kef/2
			local tG = _ptrnOrigG * kef/2
			local tB = _ptrnOrigB * kef*1.2

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
						tR = tR + ((_ptrnEfxR - tR)*ptrnEfxer*ptrnprestartEfxer)%50
						tG = tG + (_ptrnEfxG - tG)*ptrnEfxer*ptrnprestartEfxer
						tB = tB + (_ptrnEfxB - tB)*ptrnEfxer*ptrnprestartEfxer

						_ptrnEfxArray[str][clm].ptrnEfx = _ptrnEfxArray[str][clm].ptrnEfx/1.01
					end
					if _ptrnEfxArray[str][clm].ptrnEfx < 0.01 then
						_ptrnEfxArray[str][clm].ptrnEfx = 0
					end
				end
			end
			tR = tR + _ptrnEfxArray[str][clm].whiteRandom
			tG = tG + _ptrnEfxArray[str][clm].whiteRandom
			tB = tB + _ptrnEfxArray[str][clm].whiteRandom
			dxDrawImage(-38 +clm*20 - 19*(str%2) + (otstup*1.2)/2,
						-30 +90*(clm%2)  + str*30 + otstup/1.6 * inv,

						size,
						size -size*2*(clm%2),
						threeangleTex,
						0,0,0,
						tocolor(tR,tG,tB,210 + _ptrnEfxArray[str][clm].whiteRandom))				
		end
	end

	if frameT % _ptrnEfxWaitTime == 0 then
			_ptrnEfxWaitTime = _ptrnEfxWaitTime + math.random(800,1600)
			_ptrnEfxType = math.random(100)
			if _ptrnEfxType > 70 then
				_ptrnEfxType = 1
			else
				_ptrnEfxType = 2
			end

			_ptrnEfx = math.random(100)
			if _ptrnEfx > 90 then
				_ptrnEfx = 2
			else
				_ptrnEfx = 1
			end

			if _ptrnEfx == 1 then
				_ptrnEfxR = _ptrnEfx1R
				_ptrnEfxG = _ptrnEfx1G
				_ptrnEfxB = _ptrnEfx1B
			elseif _ptrnEfx == 2 then
				_ptrnEfxR = _ptrnEfx2R
				_ptrnEfxG = _ptrnEfx2G
				_ptrnEfxB = _ptrnEfx2B
			end

			if _ptrnEfxType == 1 then
				for str=0,_ptrnEfx_str do
					for clm=0,_ptrnEfx_clm do
						_ptrnEfxArray[str][clm] = {ptrnEfx = math.random(6,10)/10,prestart = 0.8,delay = 50 - 50*(clm/_ptrnEfx_clm) + str/3 + math.random(0,5),prestart = 0,whiteRandom = _ptrnEfxArray[str][clm].whiteRandom/1.1}
					end
				end
			else
				for str=0,_ptrnEfx_str do
					for clm=0,_ptrnEfx_clm do
						_ptrnEfxArray[str][clm] = {ptrnEfx = math.random(2,10)/10,delay = math.random(0,600)/10,prestart = 0.4,whiteRandom = _ptrnEfxArray[str][clm].whiteRandom/1.1}
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
--adderPatterner()







----------------------------------------- BRAIN STORM FACE -------------------------------------------------------------------------------------------------------------------------------------------------------------
function BS()
	if topAlign then topAlign:Destroy() end

	topAlign = createAligner(1,0.5,"alignerBS")
	local wiwer = createWindow(SWins.miniwin2,"theWin",topAlign.name,SWins.miniwin2.offset.x,0,SWins.miniwin2.w,SWins.miniwin2.h)
	local wiwer2 = createWindow(SWins.BS.miniwin,"theWin2",wiwer.name,20,19,SWins.BS.miniwin.w,SWins.BS.miniwin.h)

	function vetkiAdd(array,y)
		addLinePoint(array, 21.5, y, 	8, y/2)

		local paramWhiteWetki = createLinesArray(5)
				addLinePoint(	paramWhiteWetki,46,		y	)
				addLinePoint(	paramWhiteWetki,46,		y -8)
				addLinePoint(	paramWhiteWetki,46 + 16,y -8)
				addLinePoint(	paramWhiteWetki,46 + 16,y +8)
				addLinePoint(	paramWhiteWetki,46,		y +8)
				addLinePoint(	paramWhiteWetki,46,		y 	)
			addLineArray(array,paramWhiteWetki)

		local paramVetki = createLinesInheritedArray(array)
				addLinePoint(				paramVetki,21.5,	y		,8, y/2)
				local _,ya2 = addLinePoint(	paramVetki,46,		y	)
				local xa,ya = addLinePoint(	paramVetki,46,		y -8)
				local ea = addLinePoint(	paramVetki,46 + 16, y -8)
				addLinePoint(				paramVetki,46 + 16, y +8)
				addLinePoint(				paramVetki,46,		y +8)
				addLinePoint(				paramVetki,46,		y 	)
			addLineArray(array,paramVetki)

		return xa,ya,ea,ya2
	end

	animate(wiwer2,Animations.buildupStack,_,function()
		wiwer2.BSFonlines = {}
		animate(wiwer2,Animations.maskedLayerDraw,{frame = function()
			BSLinesHandler(wiwer2.BSFonlines,50,wiwer2.locSize.cpx,wiwer2.locSize.cpy,wiwer2.locSize.cutW,wiwer2.locSize.cutH)
		end})

		local colorer = fromColor(S_BS.darkGray1)
		local BSLines = createLinesArray(3,colorer.r,colorer.g,colorer.b)
		addLinePoint(BSLines,334, 20.5		,160, 8)
		addLinePoint(BSLines,48, 20.5		,37, 8)
		addLinePoint(BSLines,21.5, 47		,8, 37)

		function paramAdd(y,text,filledW)
			local xa,ya,ea,ya2 = vetkiAdd(BSLines,y)
			local parametr = {createRectangle(xa + 3,ya + 3,ea - xa - 3,(ya2 - ya)*2-3,S_BS.darkGray1,'paramRect_'..text,wiwer2.name,{adapt = false}),
							  createLabel(SFonts.medium10,ea + 6,ya2 - 7,100,13,{text = text,color = tocolor(0,0,0,255),alignY = "center"},"label_"..text,wiwer2.name,{adaptPos = false}),
							  createRectFiller(ea+110*msw,ya2-4,142*msw,8,"fillREcter"..text,wiwer2.name,{fillW = filledW,maxW = 1000,adaptPos = false,colFill = S_BS.darkGray1,colIn = S_BS.gray2}),
							}
			return parametr
		end
		local params = {}
			params[1] = paramAdd(213,"ПОВРЕЖДЕНИЯ",600)
			params[2] = paramAdd(251,"ТОЧНОСТЬ",400)
			params[3] = paramAdd(286,"ТЕМП СТРЕЛЬБЫ",400)
			params[4] = paramAdd(321,"ЕМК. МАГАЗИНА",300)
		addLinePoint(BSLines,21.5, 358		,8, 179)

		addLinePoint(BSLines,21.5, 608		,8, 302)
		addLinePoint(BSLines,218.5, 608		,65, 302)

		linerer = createArea(0,0,SWins.BS.miniwin.w,SWins.BS.miniwin.h,"linesArea",wiwer2.name,"liner",{frameCount = 100,lines = BSLines}).show()

		local IcoPan = createPanel(S_BS.panel,46,42,S_BS.panel.w,S_BS.panel.h,"IcoPan",wiwer2.name)
		local WeaponIco = createArea(27,26,214,67,"wepIco",IcoPan.name,nil,{imgP = {img = ":Draws/Elements/BS/WeaponIcons/AK-47.png",originalSize = {w = 214,h = 67}}})
		local WepName = createLabel(SFonts.medium12,8,S_BS.panel.th - 26,300,26,{text = "AK-47",alignY = "center",color = S_BS.gray1},"weponIco_name",IcoPan.name)
		
		local descrLabel = createLabel(SFonts.medium12,48,350,267,173,{text = "Легендарное советское оружие, разработанное в 1947 году и до сих пор стоящее на вооружении в нескольких десятках стран.\nКак правило в представлении не нуждается...",alignY = "center",color = blackCol},"weponDescript",wiwer2.name)

		local buyCount = 1
		local cost = 1400
		local buyBut = createButton(S_BS.button1,47,544,nil,nil,{text = "КУПИТЬ"},'buyButton',wiwer2.name,function()
			outputChatBox("POKUPKA WEPONSA")
		end)

		local costLabel = createLabel(SFonts.semiBold18,203,543,96,38,{text = "$"..cost,alignY = "center",alignX = "center",color = blackCol},"totalCost",wiwer2.name)

		local updateCount = function(def)
			buyCount = buyCount + def
			if buyCount < 1 then buyCount = 1 end
			if buyCount > 10 then buyCount = 10 end

			local pristavka = " X"..buyCount
			if buyCount == 1 then pristavka = "" end
			buyBut.textP.text = "КУПИТЬ"..pristavka
			costLabel.textP.text = "$"..cost*buyCount

		end

		local addbut = createButton(S_BS.operButs.AddBut,300,547,nil,nil,nil,'addCountButton',wiwer2.name,function()
			updateCount(1)
		end)
		local subBut = createButton(S_BS.operButs.SubBut,300,564,nil,nil,nil,'subCountButton',wiwer2.name,function()
			updateCount(-1)
		end)

		------------- fade anim ------------------------------------------------------
		local orderedFadeAnimElements = {IcoPan,WeaponIco, WepName,
								params[1][1],params[1][2],{params[1][3], params[1][3].start },
								params[2][1],params[2][2],{params[2][3], params[2][3].start },
								params[3][1],params[3][2],{params[3][3], params[3][3].start },
								params[4][1],params[4][2],{params[4][3], params[4][3].start },
								descrLabel,buyBut,costLabel,addbut,subBut
							}
		animateOrderedElements(orderedFadeAnimElements,Animations.simpleFade,{frameCount = 8})
		------------- /fade anim ------------------------------------------------------

	end)
end
bindKey("7","down",function()
	BS()	
end)
----------------------------------------- BRAIN STORM FACE -------------------------------------------------------------------------------------------------------------------------------------------------------------






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
--addDrawFpseser()
--------------------------------------------------------------------- 
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





_linesZdeth = (screenH*2)
_linesConnectDistance = 110
_linesDelMatrixDist = _linesConnectDistance/2.5
logLinesArray = {}
_logLinesDistMatrix = {}
_logLinesSerials = 0
_logLinesArrayVertexCount = 200
_logLinesArrayVertexCreateChance = 150
_logLinesVertexLiveTime = 2000
_logLinesDrevoPlace = {45,65,100,dist = 120}
mistCol = {	70, 16,	220}
mistCol_inv = {255- mistCol[1],255- mistCol[2],255- mistCol[3]}
coreCol = {14,143,255}
--coreCol = {	255, 0, 0}
coreCol_inv = {255- coreCol[1],255- coreCol[2],255- coreCol[3]}

wtTex = dxCreateTexture("win/winTest.png","dxt5")


logFogBackTex = dxCreateTexture("Elements/log/FogBack.png","dxt5")
logFogTex = dxCreateTexture("Elements/log/logFog.png","dxt5")
logLine1Tex = dxCreateTexture("Elements/log/logliner.png","dxt3")
logSvetTex = dxCreateTexture("Elements/log/logSvet.png","dxt5")
logC = dxCreateTexture("Elements/log/logC.png","dxt5")
logGlow = dxCreateTexture("Elements/log/logGlow.png","dxt5")
logDrevoGlow = dxCreateTexture("Elements/log/logDrevoGlow.png","dxt5")
logDrevo = dxCreateTexture("Elements/log/logDrevo.png","dxt5")
logDrevoFruit = dxCreateTexture("Elements/log/logDrevoFruit.png","dxt5")



function zCompareFunct(p1,p2)
	if p2.z > p1.z then return true end
end
function zCompareFunctN(p1,p2)
	if p2.z < p1.z then return true end
end
function calcPlaceKey(tab)
	return {math.floor(tab.x/_linesDelMatrixDist), math.floor(tab.y/_linesDelMatrixDist), math.floor(tab.z/_linesDelMatrixDist)}
end
function getClosestBlockKeys(placekey)
	return {
		{placekey[1]-1, placekey[2]-1, placekey[3]-1},
		{placekey[1], placekey[2]-1, placekey[3]-1},
		{placekey[1]+1, placekey[2]-1, placekey[3]-1},
			{placekey[1]-1, placekey[2], placekey[3]-1},
			{placekey[1], placekey[2], placekey[3]-1},
			{placekey[1]+1, placekey[2], placekey[3]-1},
				{placekey[1]-1, placekey[2]+1, placekey[3]-1},
				{placekey[1], placekey[2]+1, placekey[3]-1},
				{placekey[1]+1, placekey[2]+1, placekey[3]-1},

		{placekey[1]-1, placekey[2]-1, placekey[3]},
		{placekey[1], placekey[2]-1, placekey[3]},
		{placekey[1]+1, placekey[2]-1, placekey[3]},
			{placekey[1]-1, placekey[2], placekey[3]},
			{placekey[1], placekey[2], placekey[3]},
			{placekey[1]+1, placekey[2], placekey[3]},
				{placekey[1]-1, placekey[2]+1, placekey[3]},
				{placekey[1], placekey[2]+1, placekey[3]},
				{placekey[1]+1, placekey[2]+1, placekey[3]},

		{placekey[1]-1, placekey[2]-1, placekey[3]+1},
		{placekey[1], placekey[2]-1, placekey[3]+1},
		{placekey[1]+1, placekey[2]-1, placekey[3]+1},
			{placekey[1]-1, placekey[2], placekey[3]+1},
			{placekey[1], placekey[2], placekey[3]+1},
			{placekey[1]+1, placekey[2], placekey[3]+1},
				{placekey[1]-1, placekey[2]+1, placekey[3]+1},
				{placekey[1], placekey[2]+1, placekey[3]+1},
				{placekey[1]+1, placekey[2]+1, placekey[3]+1},
	}
end
function findClosest(tab)
	for k,blockKey in pairs(getClosestBlockKeys(tab.placekey)) do		
		for k,cls in pairs(_logLinesDistMatrix[blockKey[1]][blockKey[2]][blockKey[3]]) do
			if not cls.closest[tab.serial] then
				if cls.serial ~= tab.serial then
					tab.closest[cls.serial] = cls
				end
			end
		end
	end
end

local cx = screenW/2
local cy = screenH/2
local czt = ((1 + 1/1.4)^2)

logLfarme = -400
logLfarmeYA = 0


function logLines()
	logLfarme = logLfarme + 1
	logLfarmeYA = (logLfarme-200)/600

	if logLfarmeYA > 1 then logLfarmeYA = 1 end
	if logLfarmeYA < 0 then logLfarmeYA = 0 end
	if logLfarme > 10000 then logLfarme = 1000 end

	dxDrawRectangle(0,0,screenW,screenW,tocolor(0,0,0,255))
	dxDrawImage(0,0,screenW,screenW,logFogBackTex,0,0,0,tocolor(145,255,175,255*logLfarmeYA))
	dxDrawText(#logLinesArray,40,20)

	-- Particles update
	local randomDirChange = math.random(0,5000)
	for k,v in pairs(logLinesArray) do
		if v.typ ~= "img" then
			local Ztotal = v.z/200
			
			local razm = 10 + (math.abs(v.z/20)^1.18)

			local alf = 15 + 205*Ztotal
				if alf > 255 then alf = 255 end
				if alf < 0 then alf = 0 end

			local xZsmes = (1 + Ztotal/1.4)^2
			local yZsmes = (1 + Ztotal/1.8)^2

			local zx = getNumberSign(v.x)
			local zy = getNumberSign(v.y)

			v.razm = razm
			v.centerX = cx + (((math.abs(v.x)*xZsmes)*zx))
			v.centerY = cy + (((math.abs(v.y)*yZsmes)*zy))

			v.drawX = v.centerX -razm/2
			v.drawY = v.centerY -razm/2

			if v.typ == "v" then
				------------------------------- dinamic Vertex ------------------------------------
				v.deather = 0
				if v.timer > _logLinesVertexLiveTime then
					v.deather = (v.timer - _logLinesVertexLiveTime)/280
				end
				if v.deather > 1 then v.deather = 1 end		

				v.alfa = (alf-alf*v.deather)*v.createTimer

				 v.x = v.x + v.vx/35
				 v.y = v.y + v.vy/35
				 v.z = v.z + v.vz/35


				 local mFx = false
				 local mfxZn
				 local cursX,cursY = getCursorPosition()	
				 if getKeyState("mouse2") then
				 	mfxZn = 1  ; mFx = true
				 elseif getKeyState("mouse1") then
				 	mfxZn = -1 ; mFx = true
				 end

				 if mFx and cursX then
				 	cursX = ((cursX*screenW)-cx)/xZsmes
				 	cursY = ((cursY*screenH)-cy)/yZsmes
				 	
				 	local mD = getDistanceBetweenPoints2D(v.x,v.y,cursX,cursY)
				 	if mD < 150 then
				 		v.vx = v.vx + mfxZn*((cursX - v.x)/200)
				 		v.vy = v.vy + mfxZn*((cursY - v.y)/200)
				 		v.vz = v.vz + mfxZn*((100 - v.z)/200)
				 	end
				 end

				 for i=0,1 do
					 local cD = getDistanceBetweenPoints3D(v.x,v.y,v.z,_logLinesDrevoPlace[1],_logLinesDrevoPlace[2] + i*30,_logLinesDrevoPlace[3])
					 if cD < _logLinesDrevoPlace.dist then
					 	local lx = _logLinesDrevoPlace.dist - (5 - v.x)
					 	local ly = _logLinesDrevoPlace.dist - (55 - v.y)
					 	local lz = _logLinesDrevoPlace.dist - (100 - v.z)

					 	v.vx = v.vx + lx/12000
					 	v.vy = v.vy + ly/12000
					 	v.vz = v.vz + lz/12000
					 end
				end


				v.timer = v.timer + 1
				if v.createTimer < 1  then
					v.createTimer = v.createTimer + 1/200
				end
			

				--randomDirChange
				if randomDirChange < 1 then
					v.vx = math.random(-11,11)
					v.vy = math.random(-11,11)
					v.vz = math.random(-11,11)
				end

				if v.drawX < -screenW-200 then v.oOfBDeather = true end
				if v.drawX >  screenW+200 then v.oOfBDeather = true end
				if v.drawY < -screenH-200 then v.oOfBDeather = true end
				if v.drawY >  screenH+200 then v.oOfBDeather = true end
					if v.drawY < -screenH-400 then v.needtoremove = true end
					if v.drawY >  screenH+400 then v.needtoremove = true end
				if v.z < 1    then v.oOfBDeather = true end
				if v.z > 3500 then v.oOfBDeather = true end
				if v.oOfBDeather and (v.timer < _logLinesVertexLiveTime) then 
					v.timer = _logLinesVertexLiveTime 
				end

				if (v.deather >= 1) then v.needtoremove = true end

				if not v.needtoremove then placeKeyOparate(v) end

				--13,24,66
				local mistPower = 0
				if v.y > 165 then
					mistPower = maxer((v.y - 165)/180,1)
				end

				local vocol = maxer(v.col*1.2,1)
				v.color[1] = 255- (coreCol_inv[1])*vocol
				v.color[2] = 255- (coreCol_inv[2])*vocol
				v.color[3] = 255- (coreCol_inv[3])*vocol

				v.col = v.col - 1/40
				if v.col < 0 then v.col = 0 end

				v.color[1] = v.color[1]- (v.color[1] - mistCol[1])*mistPower
				v.color[2] = v.color[2]- (v.color[2] - mistCol[2])*mistPower
				v.color[3] = v.color[3]- (v.color[3] - mistCol[3])*mistPower
				

				------------------------------- dinamic Vertex ------------------------------------
				dxDrawImage(v.drawX,
						v.drawY,
						razm,razm,logSvetTex,v.timer*2*v.rSpeed,0,0,tocolor(v.color[1],v.color[2],v.color[3],maxer(v.alfa+v.alfa*v.col,255)),true)

				local glowRazm = (razm^2)/6
				dxDrawImage(v.centerX-glowRazm/2,
							v.centerY-glowRazm/2,
							glowRazm,glowRazm,logGlow,0,0,0,tocolor(v.color[1],v.color[2],v.color[3],maxer((v.alfa/5.5)+(v.alfa*mistPower)+(v.alfa*v.col),255)),true)
				------------------------------- dinamic Vertex Draw ------------------------------------
			elseif v.typ == "sv" then
				------------------------------- static Vertex Draw ------------------------------------
				if logLfarme % 30 == 0 then
					v.gcA = math.random(-40,10)
				end
				if v.gncA ~= v.gcA then
					v.gncA = v.gncA + (getNumberSign(v.gcA - v.gncA)/2)
				end

				local lAlfa = maxMiner((logLfarmeYA+0.2*logLfarme/600)*8,0,1)

				dxDrawImage(v.drawX+razm/2 - (razm*v.imgr)/2,
							v.drawY+razm/2 - (razm*v.imgr)/2,
						razm*v.imgr,razm*v.imgr,logDrevoFruit,v.rot,0,0,tocolor(v.color[1],v.color[2],v.color[3]-10 + v.gncA,v.color[4]*lAlfa),true)

				local glowRazm = (razm^2)/6
				dxDrawImage(v.centerX-glowRazm/2,
							v.centerY-glowRazm/2,
							glowRazm,glowRazm,logGlow,v.rot,0,0,tocolor(v.color[1],v.color[2],v.color[3]-10 + v.gncA,(v.color[4]-40 + v.gncA*4)*lAlfa),true)
				------------------------------- static Vertex Draw ------------------------------------
			end
		else
			------------------------------- image Draw ------------------------------------
			local Ztotal = v.z/200
			
			local razm = 600 + (math.abs(v.z/20)^1.5)

			local xZsmes = (1 + Ztotal/2)^2
			local yZsmes = (1 + Ztotal/3)^2

			local zx = getNumberSign(v.x)
			local zy = getNumberSign(v.y)

			local centerX = cx + (((v.x*xZsmes)*zx)-razm/2)
			local centerY = cy + (((v.y*yZsmes)*zy)-razm/2)

			v.drawX = centerX
			v.drawY = centerY

			if logLfarme % 30 == 0 then
				v.gcA = math.random(-40,10)
			end
			if v.gncA ~= v.gcA then
				v.gncA = v.gncA + (getNumberSign(v.gcA - v.gncA))
			end

			dxDrawImage(v.drawX,
						v.drawY,
						600,750,logDrevoGlow,0,0,0,tocolor(255,
															255,
															255,
															(245 + v.gncA)*maxer(logLfarmeYA*2,1)
															),true)
			dxDrawImage(v.drawX,
						v.drawY,
						600,750,logDrevo,0,0,0,tocolor(235 + v.gncA*2,
														215 - v.gncA,
														255,
														255*maxer(logLfarmeYA*4,1)
														),true)
		end
		------------------------------- image Draw ------------------------------------
	end

	-- Draw Connections
	for key1,pnt in pairs(logLinesArray) do
		if (pnt.typ == "v") or (pnt.typ == "sv") then		
			for key2,cls in pairs(pnt.closest) do
				if cls.typ == "v" then
					cls[pnt.serial] = cls[pnt.serial] or {connect = 1}
					local clsCt = cls[pnt.serial]

					local distA = getDistanceBetweenPoints3D(pnt.x,pnt.y,pnt.z,cls.x,cls.y,cls.z)
					if distA < _linesConnectDistance then
						clsCt.connect = maxer(clsCt.connect + 10,100)

						local px1 = pnt.centerX
						local py1 = pnt.centerY

						local px2 = cls.centerX
						local py2 = cls.centerY

						local x1,y1,z1 = getWorldFromScreenPosition (px1,py1,1/(pnt.razm/500))
						local x2,y2,z2 = getWorldFromScreenPosition(px2,py2,1/(cls.razm/500))
						
						local linePower = (1-(distA/_linesConnectDistance))*(1-cls.deather)*(1-pnt.deather)*(clsCt.connect/100)
						linePower = linePower*linePower


						local colPow = 0.9 - ((distA/_linesConnectDistance)/4)
						local cls_s = cls.col*colPow
						local pnt_s = pnt.col*colPow
						if cls_s > pnt.col then
							pnt.col = pnt.col+0.05
						elseif pnt_s > cls.col then
							cls.col = cls.col+0.05
						end

						dxDrawMaterialLine3D(x1,y1,z1, x2,y2,z2,true,logLine1Tex, 0.1, tocolor(pnt.color[1],pnt.color[2],pnt.color[3],(pnt.alfa*linePower)*1.5),true)
						dxDrawMaterialLine3D(x2,y2,z2, x1,y1,z1,true,logLine1Tex, 0.1, tocolor(cls.color[1],cls.color[2],cls.color[3],(cls.alfa*linePower)*1.5),true)
					else
						clsCt.connect = clsCt.connect - 10
						if clsCt.connect < 1 then
							pnt.closest[key2] = nil
							cls[pnt.serial] = nil
							clsCt = nil
						end
					end
				end
			end

			-- Update Close Vertexes
			if pnt.closeCheck > 12 then
				findClosest(pnt)
				pnt.closeCheck = -1
			end
			pnt.closeCheck = pnt.closeCheck + 1
		end
	end

	-- Creating Vetexes
	if #logLinesArray < _logLinesArrayVertexCount then
		local randomCreatingChance = math.random(0,1000)
		if randomCreatingChance < _logLinesArrayVertexCreateChance then
			createVertex()
		end
	end

	-- REMOVE Died Vertexes
	for k,v in pairs(logLinesArray) do
		if v.needtoremove then
			_logLinesDistMatrix[v.placekey[1]][v.placekey[2]][v.placekey[3]][v.serial] = nil
			table.remove(logLinesArray,k)
		end	
	end
	table.sort(logLinesArray,zCompareFunct)
end
function placeKeyOparate(tab) 
	_logLinesDistMatrix[tab.placekey[1]][tab.placekey[2]][tab.placekey[3]][tab.serial] = nil
	tab.placekey = calcPlaceKey(tab)
	_logLinesDistMatrix[tab.placekey[1]][tab.placekey[2]][tab.placekey[3]][tab.serial] = tab
end
function createVertex()
	if not (logLfarme > 700) then return end
	local klk = #logLinesArray + 1
	while(true) do
		logLinesArray[klk] = {
				typ = "v",		--vertex
				x = math.random(-300,300),
				y = math.random(-250,250),
				z = math.random(0,150),
				vx = math.random(-4,4),
				vy = math.random(-4,4),
				vz = math.random(-4,4),
				rSpeed = math.random(-40,40)/10,
				oOfBDeather = false,
				createTimer = 0,
				timer = math.random(-200,200),
				closest = {},
				closeCheck = 0,
				serial = _logLinesSerials + 1,
				color = {255,255,255},
				col = 0
			}
		local distToC = getDistanceBetweenPoints3D(logLinesArray[klk].x,
										logLinesArray[klk].y,
										logLinesArray[klk].z,
										_logLinesDrevoPlace[1],
										_logLinesDrevoPlace[2],
										_logLinesDrevoPlace[3])
		if distToC > _logLinesDrevoPlace.dist/2 then
			break
		end
	end
	logLinesArray[klk].placekey = calcPlaceKey(logLinesArray[klk])
	placeKeyOparate(logLinesArray[klk])

	_logLinesSerials = _logLinesSerials + 1
	if _logLinesSerials > 10000 then
		_logLinesSerials = 0
	end
end

function initLogLines()
	logLinesRender = true
	logLinesArray = {}
	_logLinesDistMatrix = {}

	for i=-50,50 do
		_logLinesDistMatrix[i] = {}
		for j=-50,50 do
			_logLinesDistMatrix[i][j] = {}
			for k=-50,50 do
				_logLinesDistMatrix[i][j][k] = {}
			end
		end
	end

	table.insert(logLinesArray,{
		typ = "img",	--static image
		x= _logLinesDrevoPlace[1],
		y= _logLinesDrevoPlace[2],
		z= _logLinesDrevoPlace[3],
		gcA = 0,
		gncA = 0
	})

	local fruitsCords = {
		{_logLinesDrevoPlace[1]-7,_logLinesDrevoPlace[2]-18,_logLinesDrevoPlace[3]+1, 0,  {126-40,183-40,255-40,245}, 0.8},
		 {_logLinesDrevoPlace[1]-49.5,_logLinesDrevoPlace[2]+2,_logLinesDrevoPlace[3]+1, 40, {146,203,255,255}, 0.6},
		 {_logLinesDrevoPlace[1]-19.8,_logLinesDrevoPlace[2]+46,_logLinesDrevoPlace[3]+1, 160, {126-30,183-30,255-30,255}, 0.6},
		 {_logLinesDrevoPlace[1]-4.5,_logLinesDrevoPlace[2]-77.7,_logLinesDrevoPlace[3]+1, 1354,  {156,223,255,255}, 0.7},
		 {_logLinesDrevoPlace[1]-40.5,_logLinesDrevoPlace[2]-54,_logLinesDrevoPlace[3]+1, 1982,  {146,183,255,255}, 0.8},
		 {_logLinesDrevoPlace[1]-37.5,_logLinesDrevoPlace[2]-64,_logLinesDrevoPlace[3]+1, 1982,  {176,123,235,255}, 0.5},
		 {_logLinesDrevoPlace[1]+11,_logLinesDrevoPlace[2]-55,_logLinesDrevoPlace[3]+1, 1982,  {166,123,235,255}, 0.4},
		 {_logLinesDrevoPlace[1]+12,_logLinesDrevoPlace[2]-50,_logLinesDrevoPlace[3]+1, 1982,  {156,123,235,255}, 0.3},
		 {_logLinesDrevoPlace[1]-66,_logLinesDrevoPlace[2]+1,_logLinesDrevoPlace[3]+1, 1982,  {126,103,225,255}, 0.35},
		 {_logLinesDrevoPlace[1]+4.6,_logLinesDrevoPlace[2]-13,_logLinesDrevoPlace[3]+1, 1454,  {215,215,255,255}, 0.9},
		 {_logLinesDrevoPlace[1]+43	,_logLinesDrevoPlace[2]-28,_logLinesDrevoPlace[3]+1, 13543,  {126-60,183-60,255-60,245}, 0.5},
	}

	for k,v in pairs(fruitsCords) do
		local kkk = #logLinesArray + 1
		logLinesArray[kkk] = {
			typ = "sv",	--static vertex
			x=v[1],
			y=v[2],
			z=v[3],
			imgr = v[6],
			rot = v[4],
			gcA = 0,
			gncA = 0,
			serial = "sv"..k,
			color = v[5],
			alfa = 150,
			closeCheck = 0,
			deather = 0,
			closest = {},
			col = 1,
		}
		logLinesArray[kkk].placekey = calcPlaceKey(logLinesArray[kkk])
		placeKeyOparate(logLinesArray[kkk])
	end
	addEventHandler("onClientRender",root,logLines)
end
function killLogLines()
	removeEventHandler("onClientRender",root,logLines)
	logLinesRender = false
	_logLinesDistMatrix = nil
end

logLinesRender = false
bindKey("r","up",function()
	if not logLinesRender then
		initLogLines()
	else
		killLogLines()
	end
end)

addCommandHandler("logLines",function()
	initLogLines()	
end)



--- Deb reset block ---- <<<
showCursor(false)
setCameraTarget(localPlayer)
--- <<<<<<<<<<<<<<< ---- <<<
------------------------------------------------------------------------------------- Wawes
perlinNoise = dxCreateTexture("sampleMaps/perlin0.png","argb")

local replaceSoup = 11401
engineReplaceModel (engineLoadDFF("fx/soupdiv.dff") , replaceSoup, true)

local wawesShader = dxCreateShader("fx/wawes.fx")
dxSetShaderValue(wawesShader,"noiseTex", perlinNoise)
dxSetShaderValue(wawesShader,"RT", _scrRT2)
-------------------------------------------------------------------------------------
------------------------------------------------------------------------------------- Grid
local gridShader = dxCreateShader(":Draws/fx/grid.fx")

local scale = 1 
local minScale = 0.2
local maxScale = 1

local scaleSpd = 0
local scaleSpdInc = 10

local mPosSave = false
local offset = {0,0}
local offsetLim = { x = {-4,4} , y ={-4,4}  }
local savedOffset = {0,0}

local grdSize = 250
dxSetShaderValue(gridShader, "gridSize", grdSize)
dxSetShaderValue(gridShader, "screenSize", screenW, screenH)
-------------------------------------------------------------------------------------
------------------------------------------------------------------------------------- Model
local mdel = createObject(replaceSoup,0,0,0)
setElementCollisionsEnabled(mdel,false)
setObjectScale(mdel,2,3.6)
engineApplyShaderToWorldTexture(wawesShader,"*",mdel)

local mdl_Smes = {0,0}

local frame = 0
local totalIntense = 0
local initFrames = 25
-------------------------------------------------------------------------------------

function createFace()
	local eventer = -10
	
	
	local posX,posY,posZ, lookAtX,lookAtY,lookAtZ = getCameraMatrix()

	addEventHandler("onClientRender",root,function()
		frame = frame + 1
		dxDrawText("frame"..frame, 50, 50)
		if frame < initFrames*1.1 then			
			totalIntense = frame/initFrames
			if totalIntense > 1 then totalIntense = 1 end
			dxSetShaderValue(gridShader,"intense",totalIntense)
			dxSetShaderValue(wawesShader,"intense",totalIntense)

			dxDrawText("intense: "..totalIntense, 50, 75)
		end

		local scaleRl = (scale/maxScale - minScale) * maxScale/(maxScale-minScale)

		local fov = 60 + 20* (1- scaleRl)
		local offsetMod = 1/scale

		local camM = getMatrix(getCamera())
		local ofsX = offset[1]/offsetMod*7
		local ofsY = offset[2]/offsetMod*1.5

		local pointer = camM.position + camM.forward*50 - camM.up*2 - camM.up*ofsY + camM.right*ofsX
		setElementPosition(mdel,pointer.x,pointer.y,pointer.z)
		setElementRotation(mdel, camM.rotation.y,-camM.rotation.x - 15,camM.rotation.z + 90)
		

		setCameraMatrix(posX,posY,posZ + 1050, lookAtX,lookAtY,lookAtZ + 1050, 0, fov)

		eventer = eventer - 0.01
		dxSetShaderValue(wawesShader,"efxPos",eventer)

		razmit(_scrRT2,"S",2)
		razmit(blurBuffer,"S",2)
		razmit(blurBuffer,"G",2)

		dxDrawImage(-20,-20,screenW+40,screenH+40,blurBuffer)
		
		dxSetRenderTarget(_scrRT2,true)
		dxDrawImage(0,0,screenW,screenH,":Draws/Elements/Pattern/f1Grad.png",0,0,0,tocolor(0,0,0,255*totalIntense))
		dxSetRenderTarget()

		gridProcess()
		dxDrawImage(0,0,screenW,screenH, gridShader)

		dxDrawText(" Scale : "..scale, 50,100)
		dxDrawText(" scaleRl : "..scaleRl, 50,115)
		dxDrawText("offsetX: "..offset[1], 50,135)
		dxDrawText("offsetY: "..offset[2], 50,150)
		dxDrawText("offsetMod: "..offsetMod, 50,170)
	end)

	bindKey('num_add',"down",function()
		fov = fov + 1
	end)
	bindKey('num_sub',"down",function()
		fov = fov - 1
	end)


	function eventGenerate()
		local efxColType = 1
		if math.random(0,100) > 90 then efxColType = 0 end
		dxSetShaderValue(wawesShader,"efxColType",efxColType)

		eventer = 1.6
	end
	bindKey("0","down",eventGenerate)

end

function initFace()
	showCursor(true)
	CameraFadingAnimation(100,600, nil,nil,nil, function()
		createFace()	
	end)

end
cretetFacer = false
bindKey("0","down",function()
	if not cretetFacer then
		initFace()
		cretetFacer = true
	end
end)



------------------------------------------------------------------------------------- Process
function setOffset(x,y)
	offset = {x,y}

	local xLlim = offsetLim.x[2]*scale
	local xRLim = offsetLim.x[1]*scale + 1
	if offset[1] > xLlim then offset[1] = xLlim end
	if offset[1] < xRLim then offset[1] = xRLim end

	local yLlim = offsetLim.y[2]*scale
	local yRLim = offsetLim.y[1]*scale + 1
	if offset[2] > yLlim then offset[2] = yLlim end
	if offset[2] < yRLim then offset[2] = yRLim end

end
function saveOffset()
	savedOffset[1] = offset[1]
	savedOffset[2] = offset[2]
end

function gridProcess()
	local cx,cy = getCursorPosition()

	if cx then
		local offCx = (cx - offset[1])*screenW
		local offCy = (cy - offset[2])*screenH

		if math.abs(scaleSpd) > 0 then
			
			local gsX = offCx*scale
			local gsY = offCy*scale

			local change = scaleSpd/1000
			scale = scale + change
			scaleSpd = scaleSpd - getNumberSign(scaleSpd)
			if scale < minScale then scale = minScale end
			if scale > maxScale then scale = maxScale end

			local rznX = gsX - offCx*scale
			local rznY = gsY - offCy*scale
			setOffset(offset[1] + rznX/scale/screenW, offset[2] + rznY/scale/screenH)

			dxSetShaderValue(gridShader, "scale", scale)
			dxSetShaderValue(gridShader,"offset",offset[1],offset[2])
			saveOffset()
		end 

		
		
		if mPosSave then
			setOffset(cx - mPosSave[1] + savedOffset[1], cy - mPosSave[2] + savedOffset[2])

			dxSetShaderValue(gridShader,"offset",offset[1],offset[2])
		end
	end
end
------------------------------------------------------------------------------------- Controls	

function bindOffset()
	mPosSave = {getCursorPosition()}
	saveOffset()
end
function releaseOffset()
	mPosSave = false
end



bindKey("mouse_wheel_up","down",function()
	scaleSpd = scaleSpd + scaleSpdInc
end)
bindKey("mouse_wheel_down","down",function()
	scaleSpd = scaleSpd - scaleSpdInc
end)
bindKey("mouse1","down",bindOffset)
bindKey("mouse2","down",bindOffset)
bindKey("mouse1","up",releaseOffset)
bindKey("mouse2","up",releaseOffset)
-------------------------------------------------------------------------------------






------------------------------------------------------------------------------------------
	--  zone writer  --
------------------------------------------------------------------------------------------

function zoneWrite(layout,smbls)
	
	local font = "default"
	local inx = 1

	for i,zone in ipairs(layout) do

		local x = zone.x
		local dst = (zone.dst or 1) + zone.w
		zone.smbCount = zone.smbCount or 1
		font = zone.font or font


		for i=1,zone.count do
			dxDrawRectangle(x, zone.y,zone.w,zone.h, tocolor(150,150,150,255))
			dxDrawText(string.sub(smbls,inx,inx + (zone.smbCount - 1) ),
				x, zone.y,x+zone.w,zone.y+zone.h, 
				tocolor(0,0,0,255), 
				zone.scale or 1, zone.scaleY or zone.scale or 1, 
				font, "center", "center")	

			x = x + dst
			inx = inx + zone.smbCount
		end
	end
end
local layout_ru = {  
	{x=33,y=33,w=54,h=64, 	count = 1},
	{x=92,y=17,w=47,h=80, 	count = 3, dst = 9},
	{x=256,y=33,w=54,h=64, 	count = 2, dst = 5},
	{x=396,y=17,w=97,h=47, 	count = 1, smbCount = 3, scale = 1}
}

addEventHandler("onClientRender",root,function()
	zoneWrite(layout_ru, "m976mm134")
end)

------------------------------------------------------------------------------------------
--_DoWinDubugDraw()