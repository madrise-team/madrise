----- import Draws					 --
loadstring(exports.importer:load())()					 --
import('Draws/drawsCore.lua')()					 --
------------------------------------------------------------------------					 --
outputDebugString("-*-------- TesterFace --------*-")					 --
------------------------------------------------------------------------					 --
----- FPS ---------------------------------------------------------					 --
fps = 0					 --
nextTick = 0					 --
function getCurrentFPS() -- Setup the useful function					 --
    return fps					 --
end					 --
local function updateFPS(msSinceLastFrame)					 --
    local now = getTickCount()					 --
    if (now >= nextTick) then					 --
        fps = (1 / msSinceLastFrame) * 1000					 --
        nextTick = now + 1000					 --
    end					 --
					 --
end					 --
addEventHandler("onClientPreRender", root, updateFPS)					 --
					 --
bindKey('n','down',function()					 --
	addEventHandler("onClientRender",root,function()					 --
		dxDrawText(math.floor(getCurrentFPS()),screenW-50,screenH/2)						 --
	end)					 --
	outputChatBox("Draws/TesterFace: fps show")					 --
end)					 --
					 --
---------- Text hight -----------------------------------------------					 --
					 --
--[[					 --
ttCreated = false					 --
bindKey("u","up",function()					 --
	showCursor(true)					 --
	if true then return end					 --
					 --
	local winN = "fonTT"					 --
	if ttCreated then					 --
		searchByName(GElements,winN):Destroy()					 --
		ttCreated = not ttCreated					 --
		showCursor(false)					 --
		return						 --
	end					 --
	ttCreated = not ttCreated					 --
					 --
					 --
	outputChatBox(":Draws/TesterFace: tesding dynamic TIV`s")					 --
					 --
	local cuci = {}					 --
	local fonLocSize = {["x"] = 200,["y"] = screenH/2 - 200,["w"] = 500,["h"] = 0,["sizeType"] = 'dynamic'}					 --
	TIV:create(fonLocSize,{["img"] = "win/centr.png",["color"] = tocolor(40,40,40,245)},nil,winN)					 --
					 --
						 --
					 --
	local textLocSize = {["x"] = 2,["x2"] = 2,["y"] = 5,["y2"] = 5,["w"] = 100,["h"] = 10,["sizeType"] = "dynamic"}					 --
	local textTextP = {}					 --
		textTextP.text = "asdas dfghrtynhrtyntynyrfnmyfnmtyntyjhtyjhy  dg"					 --
		textTextP.alignX = "center"					 --
						 --
	cuci[1] = TIV:create(textLocSize,nil,textTextP,nil,"Fuker")					 --
	cuci[2] = TIV:create(textLocSize,nil,textTextP,nil,winN)					 --
	cuci[3] = TIV:create(textLocSize,nil,textTextP,nil,winN)					 --
					 --
					 --
	local fonLocSize = {["x"] = 0,["y"] = 0,["w"] = 400,["h"] = 100}					 --
	--TIV:create(fonLocSize,{["img"] = "win/centr.png",["color"] = tocolor(200,225,245,200)},nil,nil,winN)					 --
					 --
	bindKey("b","down",function()					 --
		for i,v in ipairs(cuci) do					 --
			v.textP.text = v.textP.text.."dasd"					 --
		end					 --
	end)					 --
					 --
end)]]--					 --
--[[bindKey("u","up",function()					 --
	for i=1,1 do					 --
		local textLocSize = {x = 500,x2 = 2,y =100+ 5 + (i-1)*33,y2 = 5,w = 100,h = 33}					 --
		local textTextP = {}					 --
		textTextP.text = "asdas asdfasdf asdfasdf s "..i					 --
		textTextP.alignX = "center"					 --
		local lopnulLoh = TIV:create(textLocSize,{a = 0},textTextP,"padla",nil)					 --
		animate(lopnulLoh,Animations.simpleFade,function()					 --
			lopnulLoh:Destroy()					 --
		end,{dir = -10,startA = 255})					 --
	end					 --
end)]]					 --
--[[bindKey("u","up",function()					 --
	createArea(300,0,200,500,'theScrollArea',"gd","scroll",{})					 --
					 --
	cuci = {}					 --
	for i=1,17 do					 --
		local etoDrugoe = {x = 50,y = 4 + (i-1)*44,y2 = 4,w = 100,h = 40}						 --
		--local etoDrugoe = {x = 50,y = 4,y2 = 4,w = 100,h = 40}					 --
		cuci[i] = TIV:create(etoDrugoe,{img = "win/winTest.png",color = {r = 80,g = 80,b = 64,a = 200}},{text = i,alignX = "center",alignY = "bottom",color = tocolor(255,255,255,255)},i,"theScrollArea")					 --
	end					 --
end)]]					 --
--[[					 --
framer = 0					 --
created = false					 --
bindKey("u","up",function()					 --
  if created then					 --
	local glaver = searchByName(GElements,"glav")					 --
	if glaver then glaver:Destroy() end 					 --
	created = false					 --
	destroyElement(rectr)					 --
  else					 --
  	rectr = createTexFucFromDraws(25,25,function()					 --
		dxDrawRectangle(0,10,25,5,tocolor(16,220,169,255))					 --
	end)()					 --
					 --
  	created = true					 --
	local etoDrugoe = TIV:create({x = 1010 + SButton.button1small.w,y = 800,y2 = 4,w = SButton.button1small.w*2,h = SButton.button1small.h*2},{img = "win/winTest.png",color = {r = 180,g=150,b=60,a = 220}},{w = 120,h = 1000},"glav")					 --
					 --
	createBlurer(700,800,200,120,parent)					 --
					 --
					 --
	local etoDrugoe3Crototen = TIV:create({x = 100,y = 40,w = 50,h = 50},{img = createTexFucFromDraws(50,50,function()						 --
		framer = framer + 1					 --
		dxDrawImage (0, 0, 50,50,rectr,math.floor(framer*300.12341342513),0,0)					 --
		--dxDrawImage (0,0, 25,25,rectr)					 --
	end),frame = true},nil,"podglav","glav")					 --
					 --
	local etoDrugoe2 = TIV:create({x = -160,y = -60,w = SButton.button1small.w,h = SButton.button1small.h},{img = SButton.button1small.imgN},{text = "blDoL",alignX = "center",scaleXY = 2,alignY = "center"},"podglav","glav")					 --
	local sus = 0					 --
	addEventHandler("onClientRender",root,function()					 --
		sus = sus + 1					 --
					 --
		etoDrugoe2.locSize.y1 = etoDrugoe2.locSize.y1 + math.sin(sus/15)*6					 --
		etoDrugoe2.locSize.x1 = etoDrugoe2.locSize.x1 + math.sin(sus/60)*5					 --
					 --
	end)					 --
  end					 --
end)]]					 --
credet = false					 --
--[[bindKey("u","up",function()					 --
	if credet then					 --
		searchByName(GElements,"glav"):Destroy()					 --
		credet = false					 --
		return					 --
	end					 --
	credet = true					 --
					 --
	local etoDrugoe = TIV:create({x = 220,y = 100,y2 = 4,w = 1000,h = 400},{img = "win/winTest.png",originalSize = {w = 200,h = 100},color = {r = 180,g=150,b=60,a = 120}},nil,"glav")					 --
						 --
	elmy = {}					 --
	for i=1,4 do					 --
		for j=1,4 do					 --
			elmy[#elmy + 1] = TIV:create({x = 0 + (j-1)*244,y = (i-1)*SButton.button1small.h*1.1 + 2,w = SButton.button1small.w,h = SButton.button1small.h},{img = SButton.button1small.imgN},{text = "blDoL",alignX = "center",scaleXY = 2,alignY = "center"},"podglav","glav")					 --
		end					 --
	end 					 --
					 --
	local sus = 0					 --
	addEventHandler("onClientRender",root,function()					 --
		sus = sus + 1					 --
					 --
		for k,v in pairs(elmy) do					 --
			v.locSize.y1 = (v.locSize.y1 + math.sin(sus/15/2)*3*math.random(-3,3))					 --
			v.locSize.x1 = (v.locSize.x1 + math.sin(sus/60/2)*2.5*math.random(-3,3))					 --
		end					 --
		dxDrawText(tostring(dxGetStatus().VideoMemoryFreeForMTA),500,100)					 --
							 --
	end)					 --
					 --
end)]]					 --
--[[					 --
bindKey("u","up",function()					 --
	if credet then					 --
		searchByName(GElements,"glav"):Destroy()					 --
		credet = false					 --
		return					 --
	end					 --
	credet = true					 --
					 --
	TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1")					 --
		TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1","l1")					 --
			cTIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1-1","l1-1")					 --
			cTIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1-2","l1-1")					 --
				cTIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1-2-1","l1-1-2")					 --
				cTIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1-2-2","l1-1-2")					 --
				cTIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1-2-3","l1-1-2")					 --
				cTIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1-2-4","l1-1-2")					 --
			cTIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1-3","l1-1")					 --
			cTIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-1-4","l1-1")					 --
		TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-2","l1")					 --
			TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-2-1","l1-2")					 --
			TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-2-2","l1-2")					 --
			TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-2-3","l1-2")					 --
				TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-2-3-1","l1-2-3")					 --
					TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-2-3-1-1","l1-2-3-1")					 --
				TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-2-3-2","l1-2-3")					 --
			TIV:create({x = 10,y = 5,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l1-2-4","l1-2")					 --
					 --
	TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l2")					 --
	TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l3")					 --
	TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l4")					 --
	TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l5")					 --
		TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},"l5-1","l5")					 --
		TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},"l5-2","l5")					 --
		TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},"l5-3","l5")					 --
			TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},"l5-3-1","l5-3")					 --
			TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},"l5-3-2","l5-3")					 --
	TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l6")					 --
	TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l7")					 --
	TIV:create({x = 620,y = 500,y2 = 4,w = 1000,h = 600},{img = "win/winTest.png"},nil,"l8")					 --
						 --
end)]]					 --
					 --
--[[					 --
local objejer					 --
bindKey('u','down',function()					 --
	if objejer then objejer:Destroy() end					 --
	objejer = TIV:create({x = 620,y = 500,w = 500,h = 300},{img = "win/winTest.png",color = tocolor(100,200,210,160)},nil,"l-1")					 --
			TIV:create({x = 0,y = 0,w = 500,h = 300},nil,nil,"l0","l-1")					 --
			TIV:create({x = 0,y = 0,w = 500,h = 300},nil,nil,"l1","l0")					 --
		TIV:create({x = 50,y = 20,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-1","l1")					 --
		TIV:create({x = 50,y = 50,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-2","l1")					 --
		TIV:create({x = 50,y = 80,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-3","l1")					 --
		TIV:create({x = 50,y = 120,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-4","l1")					 --
		TIV:create({x = 50,y = 150,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-1","l1")					 --
		TIV:create({x = 50,y = 190,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-2","l1")					 --
		TIV:create({x = 50,y = 230,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-3","l1")					 --
		TIV:create({x = 50,y = 270,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-4","l1")					 --
					 --
		TIV:create({x = 170,y = 20,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-1","l1")					 --
		TIV:create({x = 170,y = 50,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-2","l1")					 --
		TIV:create({x = 170,y = 80,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-3","l1")					 --
		TIV:create({x = 170,y = 120,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-4","l1")					 --
		TIV:create({x = 170,y = 150,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-1","l1")					 --
		TIV:create({x = 170,y = 190,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-2","l1")					 --
		TIV:create({x = 170,y = 230,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-3","l1")					 --
		TIV:create({x = 170,y = 270,w = 100,h = 20},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-4","l1")					 --
					 --
	animate(objejer,Animations.displayTurningArray)					 --
end)]]					 --
--[[					 --
local objejer					 --
bindKey('u','down',function()					 --
	if objejer then objejer:Destroy() end					 --
	objejer = TIV:create({x = 620,y = 500,w = 500,h = 300},{img = "win/winTest.png",color = tocolor(100,200,210,160)},nil,"l1")					 --
		local poder = TIV:create({x = 0,y = 0,w = 300,h = 70},{img = "win/winTest.png",color = tocolor(200,100,110,255)},nil,"l1-1","l1")					 --
		--TIV:create({x = 50,y = 50,w = 300,h = 70},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-2","l1")					 --
	animate(poder,Animations.moveAndFade,{startPos = -500})					 --
end)]]					 --
--[[					 --
local objejer					 --
bindKey('u','down',function()					 --
	if objejer then objejer:Destroy() end					 --
	objejer = TIV:create({x = 620,y = 500,w = 500,h = 300},{img = "win/winTest.png",color = tocolor(100,200,210,160)},nil,"l1")					 --
		TIV:create({x = 50,y = 120,w = 200,h = 330},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-1","l1")					 --
		TIV:create({x = 260,y = -110,w = 200,h = 300},{img = "win/winTest.png",color = tocolor(200,100,210,160)},nil,"l1-2","l1")					 --
	animate(objejer,Animations.displayTurningArray)					 --
end)]]					 --
					 --
					 --
---------------------------------------------------------------------					 --
--[[					 --
bindKey("u","down",function()					 --
	createArea(0,0,0,0,"ddw",nil)					 --
					 --
	local lines = createLinesArray(4.5)					 --
					 --
	lines2_1 = createLinesInheritedArray(lines)					 --
		addLinePoint(lines2_1,400,500)					 --
		addLinePoint(lines2_1,500,560)					 --
		addLinePoint(lines2_1,300,600)					 --
		addLinePoint(lines2_1,300,800)					 --
	lines2_2 = createLinesInheritedArray(lines)					 --
		addLinePoint(lines2_2,400,500)					 --
		addLinePoint(lines2_2,300,540)					 --
		addLinePoint(lines2_2,200,440)					 --
		addLinePoint(lines2_2,200,800)					 --
					 --
					 --
	addLinePoint(lines,400,400)					 --
	addLinePoint(lines,500,450)					 --
		addLineArray(lines,lines2_1)					 --
		addLineArray(lines,lines2_2)					 --
	addLinePoint(lines,600,400)					 --
	addLinePoint(lines,600,500)					 --
	addLinePoint(lines,400,500)					 --
					 --
	linerer = createArea(0,0,screenW,screenH,"linerTIV","ddw","liner",{lines = lines}).show()					 --
end)]]					 --
					 --
					 --
function BS()					 --
	if topAlign then topAlign:Destroy() end					 --
					 --
	topAlign = createAligner(1,0.5,"aligner")					 --
	local wiwer = createWindow(SWins.miniwin2,"theWin",topAlign.name,SWins.miniwin2.offset.x,0,SWins.miniwin2.w,SWins.miniwin2.h)					 --
	local wiwer2 = createWindow(SWins.BS.miniwin,"theWin2",wiwer.name,20,19,SWins.BS.miniwin.w,SWins.BS.miniwin.h)					 --
					 --
	function vetkiAdd(array,y)					 --
		addLinePoint(array, 21.5, y, 	8, y/2)					 --
					 --
		local BSvetki = createLinesArray(5)					 --
				local _,ya2 = addLinePoint(	BSvetki,46,		y	)					 --
				local xa,ya = addLinePoint(	BSvetki,46,		y -8)					 --
				local ea = addLinePoint(	BSvetki,46 + 16,y -8)					 --
				addLinePoint(				BSvetki,46 + 16,y +8)					 --
				addLinePoint(				BSvetki,46,		y +8)					 --
				addLinePoint(				BSvetki,46,		y 	)					 --
			addLineArray(array,BSvetki)					 --
					 --
					 --
		local BSvetki = createLinesInheritedArray(array)					 --
				addLinePoint(				BSvetki,21.5,	y		,8, 		y/2)					 --
				local _,ya2 = addLinePoint(	BSvetki,46,		y	)					 --
				local xa,ya = addLinePoint(	BSvetki,46,		y -8)					 --
				local ea = addLinePoint(	BSvetki,46 + 16,y -8)					 --
				addLinePoint(				BSvetki,46 + 16,y +8)					 --
				addLinePoint(				BSvetki,46,		y +8)					 --
				addLinePoint(				BSvetki,46,		y 	)					 --
			addLineArray(array,BSvetki)					 --
					 --
					 --
		return xa,ya,ea,ya2					 --
	end					 --
					 --
	animate(wiwer2,Animations.buildupStack,_,function()					 --
		local lines = {}					 --
		animate(wiwer2,Animations.maskedLayerDraw,{frame = function()					 --
			BSLinesHandler(lines,50,wiwer2.locSize.cpx,wiwer2.locSize.cpy,wiwer2.locSize.cutW,wiwer2.locSize.cutH)					 --
		end})					 --
					 --
		local colorer = fromColor(S_BS.darkGray1)					 --
		local BSLines = createLinesArray(3,colorer.r,colorer.g,colorer.b)					 --
			addLinePoint(BSLines,334, 20.5		,160, 8)					 --
			addLinePoint(BSLines,48, 20.5		,37, 8)					 --
			addLinePoint(BSLines,21.5, 47		,8, 37)					 --
					 --
			function shitPost(y,text,fillWer)					 --
				local xa,ya,ea,ya2 = vetkiAdd(BSLines,y)					 --
					local parametr = {createRectangle(xa + 3,ya + 3,ea - xa - 3,(ya2 - ya)*2-3,S_BS.darkGray1,'paramRect_'..text,wiwer2.name,{adapt = false}),					 --
									 createLabel(SFonts.medium10,ea + 6,ya2 - 7,100,13,{text = text,color = tocolor(0,0,0,255),alignY = "center"},"label_"..text,wiwer2.name,{adaptPos = false}),					 --
									 createRectFiller(ea+110*msw,ya2-4,142*msw,8,"fillREcter"..text,wiwer2.name,{fillW = fillWer,maxW = 1000,adaptPos = false,colFill = S_BS.darkGray1,colIn = S_BS.gray2}),					 --
									}					 --
				return parametr					 --
			end					 --
					 --
			local params = {}					 --
				params[1] = shitPost(213,"ПОВРЕЖДЕНИЯ",600)					 --
				params[2] = shitPost(251,"ТОЧНОСТЬ",400)					 --
				params[3] = shitPost(286,"ТЕМП СТРЕЛЬБЫ",400)					 --
				params[4] = shitPost(321,"ЕМК. МАГАЗИНА",300)					 --
			addLinePoint(BSLines,21.5, 358		,8, 179)					 --
					 --
			addLinePoint(BSLines,21.5, 608		,8, 302)					 --
			addLinePoint(BSLines,218.5, 608		,65, 302)					 --
					 --
							 --
		local BSUgolok = createLinesInheritedArray(BSLines)					 --
			addLinePoint(BSUgolok,358 - 23 - 1 - 25,636 - 17 - 8 - 3 - 15 - 25 + 25)					 --
			addLinePoint(BSUgolok,358 - 23 - 1,636 - 17 - 8 - 3 - 15 - 25)					 --
			addLinePoint(BSUgolok,358 - 23 - 1,636 - 17 - 8 - 3 - 15 - 60)					 --
		--addLineArray(BSLines,BSUgolok)					 --
					 --
		linerer = createArea(0,0,SWins.BS.miniwin.w,SWins.BS.miniwin.h,"linesArea",wiwer2.name,"liner",{frameCount = 100,lines = BSLines}).show()					 --
					 --
		local IcoPan = createPanel(S_BS.panel,46,42,S_BS.panel.w,S_BS.panel.h,"IcoPan",wiwer2.name)					 --
		local WeaponIco = createArea(27,26,214,67,"wepIco",IcoPan.name,nil,{imgP = {img = ":Draws/Elements/BS/WeaponIcons/AK-47.png",originalSize = {w = 214,h = 67}}})					 --
		createLabel(SFonts.medium12,8,S_BS.panel.th - 26,300,26,{text = "AK-47",alignY = "center",color = S_BS.gray1},"weponIco_name",IcoPan.name)					 --
							 --
		local descrLabel = createLabel(SFonts.medium12,48,350,267,173,{text = "Легендарное советское оружие, разработанное в 1947 году и до сих пор стоящее на вооружении в нескольких десятках стран.\nКак правило в представлении не нуждается...",alignY = "center",color = blackCol},"weponDescript",wiwer2.name)					 --
					 --
		local buyCount = 1					 --
		local cost = 1400					 --
		local buyBut = createButton(S_BS.button1,47,544,nil,nil,{text = "КУПИТЬ"},'buyButton',wiwer2.name,function()					 --
			outputChatBox("POKUPKA WEPONSA")					 --
		end)					 --
					 --
		local costLabel = createLabel(SFonts.semiBold18,203,543,96,38,{text = "$"..cost,alignY = "center",alignX = "center",color = blackCol},"totalCost",wiwer2.name)					 --
					 --
		local updateCount = function(def)					 --
			buyCount = buyCount + def					 --
			if buyCount < 1 then buyCount = 1 end					 --
			if buyCount > 10 then buyCount = 10 end					 --
					 --
			local pristavka = " X"..buyCount					 --
			if buyCount == 1 then pristavka = "" end					 --
			buyBut.textP.text = "КУПИТЬ"..pristavka					 --
			costLabel.textP.text = "$"..cost*buyCount					 --
					 --
		end					 --
					 --
		local addbut = createButton(S_BS.operButs.AddBut,300,547,nil,nil,nil,'addCountButton',wiwer2.name,function()					 --
			updateCount(1)					 --
		end)					 --
		local subBut = createButton(S_BS.operButs.SubBut,300,564,nil,nil,nil,'subCountButton',wiwer2.name,function()					 --
			updateCount(-1)					 --
		end)					 --
					 --
		local aE = {} -- animated Elements					 --
		local fadeFrames = 5					 --
		aE[#aE+1] = animate(IcoPan,Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		aE[#aE+1] = animate(WeaponIco,Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		 aE[#aE+1] = animate(params[1][1],Animations.simpleFade,{frameCount = fadeFrames},nil,false)--					 --
		 aE[#aE+1] = animate(params[1][2],Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		 aE[#aE+1] = animate(params[1][3],Animations.simpleFade,{frameCount = fadeFrames},function()					 --
		 																					  params[1][3].start() end,false)					 --
					 --
		  aE[#aE+1] = animate(params[2][1],Animations.simpleFade,{frameCount = fadeFrames},nil,false)--					 --
		  aE[#aE+1] = animate(params[2][2],Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		  aE[#aE+1] = animate(params[2][3],Animations.simpleFade,{frameCount = fadeFrames},function()					 --
		  																					   params[2][3].start() end,false)					 --
					 --
		   aE[#aE+1] = animate(params[3][1],Animations.simpleFade,{frameCount = fadeFrames},nil,false)--					 --
		   aE[#aE+1] = animate(params[3][2],Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		   aE[#aE+1] = animate(params[3][3],Animations.simpleFade,{frameCount = fadeFrames},function()					 --
		   																						params[3][3].start() end,false)					 --
					 --
		   	aE[#aE+1] = animate(params[4][1],Animations.simpleFade,{frameCount = fadeFrames},nil,false)--					 --
		   	aE[#aE+1] = animate(params[4][2],Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		   	aE[#aE+1] = animate(params[4][3],Animations.simpleFade,{frameCount = fadeFrames},function()					 --
		   																						 params[4][3].start() end,false)					 --
		aE[#aE+1] = animate(descrLabel,Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		aE[#aE+1] = animate(buyBut,Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		aE[#aE+1] = animate(costLabel,Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		aE[#aE+1] = animate(addbut,Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
		aE[#aE+1] = animate(subBut,Animations.simpleFade,{frameCount = fadeFrames},nil,false)					 --
					 --
		for i,v in ipairs(aE) do					 --
			frameWait(2*i,function() 					 --
				v.start()					 --
			end,"wiwer2_anmElms_"..i)					 --
		end					 --
					 --
	end)					 --
end					 --
bindKey("u","down",function()					 --
	BS()						 --
end)					 --
					 --
					 --
curso = false					 --
bindKey("mouse3","up",function()					 --
	if not curso then					 --
		outputChatBox("cursor showed by :Draws/Testerface [mouse3]")					 --
		showCursor(true)					 --
		curso = true					 --
	else					 --
		outputChatBox("cursor hided by :Draws/Testerface [mouse3]")					 --
		showCursor(false)					 --
		curso = false					 --
	end					 --
end)					 --
					 --
					 --
function zCompareFunct(p1,p2)					 --
	if p2.z > p1.z then return true end					 --
end					 --
function findClosest(x,y,z)					 --
	local closestArr = {}					 --
	for k,v in pairs(logLinesArray) do					 --
		local dist = getDistanceBetweenPoints3D(x,y,z,v.x,v.y,v.z)					 --
		if dist < _linesConnectDistance then					 --
			closestArr[#closestArr + 1] = {k = k,dist = dist}					 --
		end					 --
	end					 --
	return closestArr					 --
end					 --
					 --
					 --
_linesZdeth = (screenH*2)					 --
_linesConnectDistance = 300					 --
logLinesArray = {}					 --
function logLines()					 --
	dxDrawRectangle(0,0,screenW,screenW,tocolor(6,12,16,255))					 --
						 --
	for k,v in pairs(logLinesArray) do					 --
		v.x = v.x + v.vx/10					 --
		v.y = v.y + v.vy/10					 --
		v.z = v.z + v.vz/10					 --
					 --
		local zDeth = maxMiner(v.z/_linesZdeth,0,1)					 --
		local razm = zDeth*15					 --
		local deather = 0					 --
		if v.timer > 500 then					 --
			deather = (v.timer - 500)/120					 --
		end					 --
					 --
					 --
		local a = ((zDeth*255)) - (deather*255)					 --
		v.a = maxMiner(a,0,255)					 --
		if v.createTimer <= 70 then					 --
			v.a = v.a*(v.createTimer/70)					 --
		end					 --
					 --
		v.zSmes = (zDeth)*screenH/6					 --
		dxDrawImage(v.x-razm/2,(v.y-razm/2)-v.zSmes,razm,razm,"win/winTest.png",0,0,0,tocolor(255,255,255,v.a))					 --
					 --
		for k,cls in pairs(findClosest(v.x,v.y,v.z)) do					 --
			local distA = 55					 --
			distA = maxMiner(distA,0,255)					 --
			local x1 = v.x					 --
			local y1 = v.y-v.zSmes					 --
			local x2 = logLinesArray[cls.k].x					 --
			local y2 = logLinesArray[cls.k].y - logLinesArray[cls.k].zSmes					 --
					 --
			x1 = x1 + (x2-x1)/10					 --
			x2 = x2 - (x2-x1)/10					 --
					 --
			y1 = y1 + (y2-y1)/10					 --
			y2 = y2 - (y2-y1)/10					 --
					 --
			dxDrawLine(x1,y1,x2,y2,tocolor(255,255,255,distA),1)					 --
		end					 --
					 --
		--randomDirChange					 --
		local randomDirChange = math.random(0,4000)					 --
		if randomDirChange < 1 then					 --
			v.vx = math.random(-10,10)					 --
			v.vy = math.random(-5,5)					 --
			v.vz = math.random(-40,40)					 --
		end					 --
					 --
					 --
		v.timer = v.timer + 2					 --
		v.createTimer = v.createTimer + 2					 --
					 --
		local outOfscreen = false					 --
		if v.x < -300 then outOfscreen = true end					 --
		if v.x > screenW+300 then outOfscreen = true end					 --
		if v.y < -200 then outOfscreen = true end					 --
		if v.y > screenH+400 then outOfscreen = true end					 --
		if v.z < 0 then outOfscreen = true end					 --
					 --
		if (deather > 1) or (outOfscreen) then					 --
			table.remove(logLinesArray,k)					 --
		end					 --
	end					 --
	if #logLinesArray < 500 then					 --
		local randomCreating = math.random(0,1000)					 --
		if randomCreating < 200 then					 --
			createVertex()					 --
		end					 --
	end					 --
	table.sort(logLinesArray,zCompareFunct)					 --
end					 --
					 --
function createVertex()					 --
	logLinesArray[#logLinesArray + 1] = {					 --
			x = math.random(100,screenW-100),					 --
			y = math.random(screenH/15 + 200,screenH - screenH/15),					 --
			z = math.random(200,_linesZdeth),					 --
			vx = math.random(-10,10),					 --
			vy = math.random(-5,5),					 --
			vz = math.random(-40,40),					 --
			a = 0,					 --
			zSmes = 0,					 --
			createTimer = 0,					 --
			timer = math.random(-200,300),					 --
		}					 --
end					 --
					 --
function initLogLines()					 --
	logLinesArray = {}					 --
end					 --
					 --
					 --
logLinesRender = false					 --
bindKey("u","up",function()					 --
	if not logLinesRender then					 --
		initLogLines()					 --
		addEventHandler("onClientRender",root,logLines)					 --
		logLinesRender = true					 --
	else					 --
		removeEventHandler("onClientRender",root,logLines)					 --
		logLinesRender = false					 --
	end					 --
end)					 --
					 --
					 --
					 --
					 --
---------------------------------------------------------------------					 --
