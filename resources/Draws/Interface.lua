function Interface()					 --
----------------------------------------------------------------						 --
----- import Animations					 --
loadstring(exports.importer:load())()					 --
import('Draws/Animations.lua')()					 --
import('Draws/Standarts.lua')()					 --
----  polsa -------------------------					 --
function extended (child, parent)					 --
    setmetatable(child,{__index = parent}) 					 --
end					 --
function shallowcopy(orig)					 --
    if not orig then return {} end					 --
    local orig_type = type(orig)					 --
    local copy					 --
    if orig_type == 'table' then					 --
        copy = {}					 --
        for orig_key, orig_value in pairs(orig) do					 --
            copy[orig_key] = orig_value					 --
        end					 --
    else -- number, string, boolean, etc					 --
        copy = orig					 --
    end					 --
    return copy					 --
end					 --
function repalceValues(tab,tabWithReplaces)					 --
    for k,v in pairs(tabWithReplaces) do					 --
    	tab[k] = v					 --
    end					 --
end					 --
function floorTable(tab)					 --
	if not tab then return end					 --
	for k,v in pairs(tab) do					 --
		if type(v) == "number" then					 --
			tab[k] = math.floor(v)					 --
		end					 --
	end					 --
	return tab					 --
end					 --
					 --
function isPointInQuad(x,y,qx,qy,qw,qh)					 --
	if x > qx and x < qx + qw and y > qy and y < qy + qh then return true end					 --
end					 --
					 --
function drawInBlendMode(mode,funct)					 --
	local save = dxGetBlendMode()					 --
	dxSetBlendMode(mode)					 --
		funct()					 --
	dxSetBlendMode(save)					 --
end					 --
function createTexFucFromDraws(w,h,drawsFunction,rendMode)					 --
	local process = function(render,obj)					 --
		local TexRT = render or dxCreateRenderTarget(w,h,true)					 --
							 --
		dxSetRenderTarget(TexRT,true)					 --
		drawInBlendMode(rendMode or "add",function()					 --
		---					 --
			drawsFunction(render,obj)						 --
		---					 --
		end)					 --
		dxSetRenderTarget()					 --
					 --
		return TexRT					 --
	end					 --
	return process					 --
end					 --
					 --
function bakeFont(textP,tab)					 --
	tab = tab or {}					 --
	textP.font = tab.font or "default"					 --
	if tab.scaleFont then					 --
		textP.scaleXY = tab.scaleXY					 --
		textP.scaleY = tab.scaleY					 --
	end					 --
	return textP					 --
end					 --
					 --
function applyToLowestElements(element,funct)					 --
	if #element.elements > 0 then					 --
		for k,v in pairs(element.elements) do					 --
			applyToLowestElements(v,funct)						 --
		end					 --
	else					 --
		funct(element)					 --
	end					 --
end					 --
					 --
-------------------------------------------------------------------------					 --
------------- Blur shader ----------------------------------------------------------------					 --
blurBuffer = dxCreateRenderTarget(screenW,screenH,true)					 --
					 --
screenSource = dxCreateScreenSource(screenW,screenH)					 --
function razmit(texture,shaderChar)	--S = Simple ; G = Gaus					 --
	dxSetRenderTarget(blurBuffer,false)							-- выставлем рендер таргет ( -> буфер)					 --
					 --
	local shader = _shaderBlurSim					 --
	if shaderChar == "G" then					 --
		shader = _shaderBlurGaus					 --
						 --
		dxSetShaderValue(shader,"texel_radius",0,1/screenH,10)	-- ставим параметр под вертикал размытие					 --
		dxSetShaderValue(shader,"screen",blurBuffer)			-- вставляем буфер во 2й проход					 --
		dxDrawImage(0,0,screenW,screenH,shader)					--  рендер 2го прохода в буфер					 --
	end					 --
						 --
	dxSetShaderValue(shader,"texel_radius",1/screenW,0,10)  -- ставим параметр под горизонтал размытие					 --
	dxSetShaderValue(shader,"screen",texture); 				-- вставляем текстуру в 1й проход					 --
	dxDrawImage(0,0,screenW,screenH,shader)					--  рендер 1го прохода в буфер					 --
						 --
	dxSetRenderTarget()										-- возврат RT ( -> exitRT)					 --
end					 --
					 --
bluredSreenPrepared = false					 --
addEventHandler("onClientPreRender",root,function()					 --
	bluredSreenPrepared = false					 --
	dxSetRenderTarget(blurBuffer,true)					 --
	dxSetRenderTarget()					 --
end)					 --
function prepareBlurScreen()					 --
	if bluredSreenPrepared then return end					 --
	bluredSreenPrepared = true					 --
					 --
	dxUpdateScreenSource(screenSource)							-- Получаем экран					 --
					 --
	razmit(screenSource,"S")					 --
	razmit(blurBuffer,"S")					 --
	razmit(blurBuffer,"G")					 --
end					 --
------------- Blur shader ----------------------------------------------------------------					 --
					 --
function createArea(x,y,w,h,name,parent,typer,argi)					 --
	argi = argi or {}					 --
	if typer == "align" then					 --
		return TIV:create({adapt = argi.adapt,x = x,y = y,w = w,h = h,anchor = {alignX = argi.ax,alignY = argi.ay}},nil,nil,name,parent)					 --
	elseif typer == "scroll" then					 --
		return scrollTIV:create({x = x,y = y,w = w,h = h,slidersT = argi.slidersT},name,parent)					 --
	elseif typer == "liner" then					 --
		argi.lines = argi.lines or {}					 --
		argi.frameCount = argi.frameCount or 200					 --
					 --
		local frame = 0					 --
		local dir = 0					 --
		local liner					 --
		liner = TIV:create({x = x,y = y,w = w,h = h},{frame = true,img = function()					 --
			if dir == 0 then return end					 --
					 --
			argi.lines.progress = frame/argi.frameCount					 --
					 --
			drawArray(liner,argi.lines)					 --
			frame = frame + 1*dir					 --
					 --
			if frame > argi.frameCount then frame = argi.frameCount end					 --
			if frame < 0 then frame = 0 end					 --
		end},nil,name,parent)					 --
					 --
		liner.show = function()					 --
			frame = 0					 --
			dir = 1					 --
		end					 --
		liner.hide = function()					 --
			frame = argi.frameCount					 --
			dir = -1					 --
		end					 --
		return liner					 --
	else 					 --
		local imp = argi.imgP					 --
		return TIV:create({x = x,y = y,w = w,h = h},imp,nil,name,parent)					 --
	end					 --
end					 --
function createAligner(ax,ay,name)					 --
	return createArea(0,0,screenW,screenH,name,nil,"align",{["ax"] = ax,["ay"] = ay,adapt = false})					 --
end					 --
function createAlignArea(x,y,w,h,name,parent,ax,ay)					 --
	return createArea(x,y,w,h,name,parent,"align",{["ax"] = ax,["ay"] = ay})					 --
end					 --
function createDynamicAlignArea(x,y,w,h,name,parent,ax,ay)					 --
	local alignAreaName = "AlignArea_"..name					 --
	local tehTop = createAlignArea(x,y,w,h,alignAreaName,parent,ax,ay)					 --
	local pod = TIV:create({["x"] = 1,["y"] = 1,["w"] = 0,["h"] = 0,["sizeType"] = "dynamic"},nil,nil,name,alignAreaName)					 --
					 --
					 --
						 --
	pod.destruction = function()					 --
		pod.destruction = nil					 --
		tehTop:Destroy()					 --
	end					 --
	return pod					 --
end					 --
					 --
					 --
function createBlurer(x,y,w,h,parent)					 --
	local tiver					 --
	tiver = TIV:create({x = x,y = y,w = w,h = h},{frame = true,img = function(render,obj)					 --
		prepareBlurScreen()					 --
		dxDrawImageSection(obj.locSize.cutX, obj.locSize.cutY, obj.locSize.cutW, obj.locSize.cutH,					 --
                      		obj.locSize.cutX,obj.locSize.cutY, obj.locSize.cutW, obj.locSize.cutH, blurBuffer)					 --
	end},nil,"Blurer",parent)					 --
					 --
	return tiver					 --
end					 --
BlackoutImg = dxCreateTexture(":Draws/Elements/Blackout/Blackout.png", "dxt5")					 --
function Blackout(parent)					 --
	local blacker = TIV:create({["x"] = 0,["y"] = 0,["w"] = screenW,["h"] = screenH},{frame = true,['img'] = function(_,obj)					 --
		dxSetRenderTarget(_scrRT,true)					 --
		drawInBlendMode("add",function()					 --
			dxDrawImage(-1,-1,screenW+2,screenH+2,BlackoutImg,0,0,0,tocolor(0,2,4,124))						 --
		end)					 --
		drawInBlendMode("overwrite",function()					 --
			if obj.imgP.black then					 --
				dxDrawRectangle(obj.imgP.black.x,obj.imgP.black.y,obj.imgP.black.w,obj.imgP.black.h,tocolor(255,255,255,obj.imgP.blackout or 0))					 --
			end					 --
		end)					 --
		dxSetRenderTarget()					 --
		dxDrawImage(0,0,screenW,screenH,_scrRT,0,0,0,tocolor(obj.imgP.color.r,obj.imgP.color.g,obj.imgP.color.b,obj.imgP.color.a))					 --
	end},nil,"Blackout",parent)					 --
					 --
	blacker.setVoid = function(x,y,w,h)					 --
		blacker.imgP.black = {x=x,y=y,w=w,h=h}					 --
		if not x then					 --
			blacker.imgP.black = false					 --
		end					 --
	end					 --
	return blacker					 --
end					 --
					 --
function createWindow(tab,name,parent,x,y,w,h)					 --
	local winLocSize = {["x"] = tab.x,["y"] = tab.y,["w"] = tab.w,["h"] = tab.h}					 --
	if x then					 --
		winLocSize.x = x					 --
		winLocSize.y = y					 --
	end					 --
	if w then					 --
		winLocSize.w = w					 --
		winLocSize.h = h					 --
	end					 --
		local winImgP = {}					 --
			winImgP.img =  {}					 --
			winImgP.img.tl = tab.tl					 --
			winImgP.img.tr = tab.tr					 --
			winImgP.img.bl = tab.bl					 --
			winImgP.img.br = tab.br					 --
					 --
			winImgP.img.t = tab.t					 --
			winImgP.img.l = tab.l					 --
			winImgP.img.r = tab.r					 --
			winImgP.img.b = tab.b					 --
					 --
			winImgP.img.size = tab.size					 --
			winImgP.img.img = tab.img					 --
								 --
	return TIV:create(winLocSize,winImgP,nil,name or "Win",parent)					 --
end					 --
					 --
					 --
function createLoader(x,y,wh,parenter)					 --
	local loader =  TIV:create({x=x,y=y,w=w or 50,h=h or 50},{frame = true,["img"] = function(render,obj)					 --
		local x = obj.locSize.cpx					 --
		local y = obj.locSize.cpy					 --
		local wh = obj.locSize.w					 --
					 --
		local triangle = triangleTex					 --
		local framer = obj._framer					 --
					 --
		local _reder = 7*4					 --
		local _greener = 32*4.4					 --
		local _bluer = 48*5					 --
							 --
		dxDrawImage(x-((wh/2)/10),y+(wh/2),(wh/2),(wh/2),triangle,0,0,0,tocolor(_reder*(((framer+170)%300)/300),_greener*(((framer+170)%300)/300),_bluer*(((framer+170)%300)/300),(framer+170)/(framer+170)*150))					 --
		dxDrawImage(x+(wh/2)/2,y,(wh/2),(wh/2),triangle,0,0,0,tocolor(_reder*(((framer+85)%300)/300),_greener*(((framer+85)%300)/300),_bluer*(((framer+85)%300)/300),(framer+85)/(framer+85)*150))					 --
		dxDrawImage(x+(wh/2)+((wh/2)/10),y+(wh/2),(wh/2),(wh/2),triangle,0,0,0,tocolor(_reder*((framer%300)/300),_greener*((framer%300)/300),_bluer*((framer%300)/300),framer/framer*150))					 --
							 --
		dxDrawImage(x+(wh/2)/2,y+(wh/2)-((wh/2)/10),(wh/2),(wh/2),triangle,180,0,0,tocolor(_reder*(((framer+40)%300)/300),_greener*(((framer+40)%300)/300),_bluer*(((framer+40)%300)/300),(framer+40)/(framer+40)*105))					 --
									 --
		local _ccrt = wh/20					 --
		local _otstp = wh/(300/5)					 --
		local topPx = x+wh/2					 --
		local topPy = y - _otstp - _ccrt/2					 --
		local rightPx = x+wh + _otstp*2 + _ccrt*2					 --
		local leftPx = x - _otstp*2 - _ccrt*2					 --
		local bottmPy = y+wh + _otstp/2 - _ccrt/2					 --
					 --
		local pl = {{x0 = topPx, y0 = topPy, x1 = rightPx, y1 = bottmPy},					 --
					{x0 = leftPx, y0 = bottmPy, x1 = topPx, y1 =  topPy},					 --
					{x0 = rightPx, y0 = bottmPy, x1 = leftPx, y1 =  bottmPy},					 --
				}					 --
					 --
		local localFrame = framer%600					 --
		for k,v in pairs(pl) do					 --
			local ex = (v.x1 - v.x0)/570*localFrame + v.x0					 --
			local ey = (v.y1 - v.y0)/570*localFrame + v.y0					 --
					 --
			local nx = (v.x1 - v.x0)/900*localFrame + v.x0					 --
			local ny = (v.y1 - v.y0)/900*localFrame + v.y0					 --
					 --
			dxDrawLine(nx,ny,ex,ey,tocolor(255,255,255,255),wh/50)						 --
		end					 --
		obj._framer = obj._framer + 40					 --
					 --
	end},nil,'loader',parenter)					 --
	loader._framer = 0					 --
end					 --
					 --
function createPattern(tab,parent)					 --
	local patternLocSize = {["x"] = tab.x,["y"] = tab.y,["w"] = tab.w,["h"] = tab.h}					 --
	TIV:create(patternLocSize,{["img"] = tab.img,originalSize=tab.originalSize,["color"] = tab.color},nil,"pattern",parent)					 --
end					 --
function createLabel(tabWithFont,x,y,w,h,textP,name,parent,argi)					 --
	local args = argi or {}					 --
	textP = bakeFont(textP,tabWithFont)					 --
					 --
	return TIV:create({["x"] = x,["y"] = y,["w"] = w,["h"] = h,["sizeType"] = args.sizeType,["adapt"] = args.adapt,["adapt"] = args.adaptPos},nil,textP,name,parent)					 --
end					 --
					 --
function createButton(tab,x,y,w,h,textP,name,parent,functsci)					 --
	tab = tab or {}					 --
	w = w or tab.w					 --
	h = h or tab.h					 --
	local buttnlocSize = {x = x,y = y,w = w,h = h}					 --
							 --
	if textP then					 --
		textP.x = textP.x or tab.tx or 0					 --
		textP.y = textP.y or tab.ty or 0					 --
		textP.w = textP.w or tab.tw or w					 --
		textP.h = textP.h or tab.th or h					 --
					 --
		textP.alignX = textP.alignX or tab.textAlignX or "center"					 --
		textP.alignY = textP.alignY or tab.textAlignY or "center"					 --
					 --
		textP = bakeFont(textP,tab.font)					 --
	end					 --
					 --
	local functsc = functsci or {}					 --
	if type(functsc) == 'function' then functsc = {cursorClick = functsci} end					 --
	local functsPlus = {}					 --
					 --
	local Btn					 --
	local normTextP					 --
					 --
	local retext = function(textTaber)					 --
		local textTab = textTaber or normTextP					 --
		Btn.textP.color = textTab.color					 --
	end					 --
					 --
	functsPlus.cursorEnter = function()					 --
		Btn.imgP.img = tab.imgH					 --
		retext(tab.textPHover)					 --
					 --
		if functsc.cursorEnter then functsc.cursorEnter() end					 --
	end					 --
	functsPlus.cursorExit = function()					 --
		Btn.imgP.img = tab.imgN					 --
		retext()					 --
					 --
		if functsc.cursorExit then functsc.cursorExit() end					 --
	end					 --
	functsPlus.cursorDown = function()					 --
		Btn.imgP.img = tab.imgD					 --
		retext(tab.textPDown)					 --
					 --
		if functsc.cursorDown then functsc.cursorDown() end					 --
	end					 --
	functsPlus.cursorClick = functsc.cursorClick					 --
					 --
	Btn = cTIV:create(buttnlocSize,{img = tab.imgN,originalSize=tab.originalSize},textP,name,parent,functsPlus)					 --
	normTextP = copyTable(Btn.textP)					 --
	return Btn					 --
end					 --
function createListButton(tab,x,y,w,h,textP,name,parent,functsci,ArrayOfList)					 --
	local lBut = createButton(tab,x,y,w,h,textP,name,parent,functsci)					 --
	local butFuncts = lBut.functs					 --
	local ListArray = ArrayOfList					 --
					 --
	local functsPlusPlus = {}					 --
					 --
	functsPlusPlus.cursorEnter = function()					 --
		if lBut.selected then return end					 --
					 --
		if butFuncts.cursorEnter then butFuncts.cursorEnter() end					 --
	end					 --
	functsPlusPlus.cursorExit = function()					 --
		if lBut.selected then return end					 --
					 --
		if butFuncts.cursorExit then butFuncts.cursorExit() end					 --
	end					 --
	functsPlusPlus.cursorDown = function()					 --
		if lBut.selected then return end					 --
					 --
		if butFuncts.cursorDown then butFuncts.cursorDown() end					 --
	end					 --
	functsPlusPlus.cursorClick = function()							 --
		if lBut.selected then return end					 --
					 --
		for k,v in pairs(ListArray) do					 --
			if v ~= lBut then					 --
				v.selected = false					 --
				v:cursorExit()					 --
			end					 --
		end					 --
		lBut.selected = true					 --
		lBut.imgP.img = tab.imgS					 --
		if butFuncts.cursorClick then 					 --
			butFuncts.cursorClick()					 --
		end					 --
	end					 --
	lBut.functs = functsPlusPlus					 --
					 --
					 --
	return lBut					 --
end					 --
					 --
function createSeparatorVert(x,y,h,parent)					 --
	local w = 3					 --
	local detH = 6					 --
	local centH = (h - detH*2)					 --
					 --
	local path = ":Draws/Elements/SeparatorVert/SeparatorVert.png"					 --
					 --
	local topTex = createTexFucFromDraws(w,detH,function()						 --
		dxDrawImageSection(0,0,				w,detH,		0,0,			w,detH,	path) 							-- top					 --
		dxDrawImageSection(0,detH,			w,centH,	0,detH, 		w,centH,path) 							-- centr					 --
		dxDrawImageSection(0,detH + centH,	w,detH,		0,detH + centH,	w,detH,	path) 							-- bottom					 --
	end)					 --
	TIV:create({["x"] = x, ["y"] = y,["w"] = 3,	["h"] = h},{["img"] = path},	nil,nil,parent)					 --
end					 --
					 --
					 --
--[[function createSeparatorWinBlock(parent)					 --
	local x = x or 0					 --
	local y = y or 0					 --
						 --
	local w1 = 407					 --
	local w2 = 763					 --
					 --
	local h = 128					 --
					 --
	local cAt = 451					 --
	local w2At = 513					 --
	local eAt = 1276					 --
					 --
	local s = 44					 --
	local c = 62					 --
	local e = 14					 --
					 --
						 --
	local sepHTex = createTexFucFromDraws(s+w1+c+w2+e,h,function()							 --
		dxDrawImageSection(0,0,s,h,0,0,s,128,":Draws/Elements/SeparatorHeader/SeparatorHeader.png")					 --
		dxDrawImageSection(s,0,w1,h,s,0,w1,128,":Draws/Elements/SeparatorHeader/SeparatorHeader.png")					 --
		dxDrawImageSection(s+w1,0,c,h,cAt,0,c,128,":Draws/Elements/SeparatorHeader/SeparatorHeader.png")					 --
		dxDrawImageSection(s+w1+c,0,w2,h,w2At,0,w2,128,":Draws/Elements/SeparatorHeader/SeparatorHeader.png")					 --
		dxDrawImageSection(s+w1+c+w2,0,e,h,eAt,0,e,128,":Draws/Elements/SeparatorHeader/SeparatorHeader.png")					 --
	end,"overwrite") 					 --
	TIV:create({["x"] = x, ["y"] = y, ["w"] = s + w1 + c + w2 + e, ["h"] = h},{["img"] = sepHTex},	nil,nil,parent)					 --
end]]					 --
						 --
function createSeparatorWinBlock(parent,x,y)					 --
	local x = x or 0					 --
	local y = y or 0					 --
					 --
	local ow = 1290					 --
	local oh = 128					 --
					 --
	local w = ow					 --
	local h = oh						 --
						 --
	TIV:create({["x"] = x, ["y"] = y, ["w"] = w, ["h"] = h},{["img"] = ":Draws/Elements/SeparatorHeader/SeparatorHeader.png",originalSize={w=ow,h=oh}},	nil,"headerSeparator",parent)					 --
end					 --
function createPanel(tab,x,y,w,h,name,parent,argi)					 --
	local args = argi or {}					 --
	local panelImgP = {}					 --
		panelImgP.img = args.img or tab.img					 --
	if tab.tl then					 --
			panelImgP.img = {}					 --
			panelImgP.img.tl = tab.tl					 --
			panelImgP.img.tr = tab.tr					 --
			panelImgP.img.bl = tab.bl					 --
			panelImgP.img.br = tab.br					 --
					 --
			panelImgP.img.t = tab.t					 --
			panelImgP.img.l = tab.l					 --
			panelImgP.img.r = tab.r					 --
			panelImgP.img.b = tab.b					 --
					 --
			panelImgP.img.size = tab.size					 --
			panelImgP.img.img = tab.img					 --
			panelImgP.img.img = tab.img					 --
	end					 --
					 --
	return TIV:create({x=x,y=y,w=w,h=h,adapt = args.adapt},panelImgP,nil,name,parent)					 --
end					 --
function createRectangle(x,y,w,h,colorer,name,parent,argi)					 --
	local args = argi or {}					 --
	return TIV:create({x=x,y=y,w=w,h=h,adapt = args.adapt,adaptPos = args.adaptPos},{color = colorer,frame = true,img = function(_,obj)					 --
		dxDrawRectangle(obj.locSize.cutX,obj.locSize.cutY,obj.locSize.cutW,obj.locSize.cutH,tocolor(obj.imgP.color.r,obj.imgP.color.g,obj.imgP.color.b,obj.imgP.color.a))					 --
	end},nil,name,parent)					 --
end					 --
					 --
					 --
function BSLinesHandler(lines,msl,lefter,uper,wider,heher)					 --
	heher = heher*1.12					 --
	if #lines < msl then					 --
		local deep = math.random(0,150)					 --
		deep = deep + (60-60*(deep/150))					 --
					 --
					 --
		local pos1 = Vector2(math.random(lefter - wider/2,lefter + wider*2),math.random(uper - heher*0.3,uper + (heher/1.5 - heher/1.5/2.4*(deep/150))))					 --
		local posPluser = math.random(10,10 + wider - wider*((deep/1.2)/150))					 --
					 --
		local w = 6 - ((4.5)*(deep/150))					 --
		local a = 200 - 180*(deep/150)					 --
					 --
		vel1 = math.random(1*3,8*3)/3					 --
		vel1 = vel1* 4*(deep/150)					 --
		lines[#lines + 1] = {na = 0,					 --
					yMax = uper+ (heher - (heher*0.4)*(deep/1.5/150)),					 --
					deep = deep,					 --
					w = 1.5,					 --
					a = maxer(a*1.2,255),					 --
					x1 = pos1.x,					 --
					y1 = pos1.y,					 --
					x2 = pos1.x - posPluser,					 --
					y2 = pos1.y + posPluser,					 --
					vel1 = vel1/7,					 --
					vel2 = (vel1 + math.random(0,5))/7}					 --
	end					 --
	for k,l in pairs(lines) do					 --
		local p1 = false					 --
		local p2 = true					 --
					 --
		if l.y1 + l.vel1 < l.yMax then					 --
			l.x1 = l.x1 - l.vel1					 --
			l.y1 = l.y1 + l.vel1					 --
			l.sila = 0					 --
		else					 --
			local deff = l.yMax - l.y1					 --
			l.x1 = l.x1 - deff					 --
			l.y1 = l.y1 + deff					 --
					 --
			l.sila = 1					 --
		end					 --
					 --
		if l.y2 + l.vel2 < l.yMax then					 --
			l.x2 = l.x2 - l.vel2					 --
			l.y2 = l.y2 + l.vel2					 --
		else					 --
			l.a = l.a - (1 + l.sila*4) 					 --
		end					 --
					 --
		if l.a <= 0 then					 --
			l.a = 0					 --
			l.destr = true					 --
		end					 --
					 --
		l.na = maxer(l.na + 0.02,1)					 --
		dxDrawLine(l.x1,l.y1,l.x2,l.y2,tocolor(0,0,0,(l.a*l.na)/1.5),l.w)					 --
					 --
		if (l.x1 < lefter or l.y1 > uper + heher) and (l.x2 < lefter or l.y2 > uper + heher) then					 --
			lines[k] = nil					 --
		end					 --
		if l.destr then lines[k] = nil end					 --
	end					 --
end					 --
					 --
					 --
function calcLinerArrayLenght(lines)					 --
	local MaxLen = 0					 --
	local len = 0					 --
	for i,elm in ipairs(lines) do					 --
		if elm.lineArray then					 --
			inLen = calcLinerArrayLenght(elm)					 --
			if (inLen + len) > MaxLen then MaxLen = inLen + len end					 --
		else					 --
			if lines[i].nextPoint then					 --
				len = len + getDistanceBetweenPoints2D(lines[i].x,lines[i].y,lines[i].nextPoint.x,lines[i].nextPoint.y)					 --
				if len > MaxLen then MaxLen = len end					 --
			end					 --
		end					 --
	end					 --
	return MaxLen					 --
end					 --
function findLastLinePoint(array)					 --
	local lastPoint					 --
	for i,v in ipairs(array) do					 --
		if v then					 --
			if v.point then					 --
				lastPoint = v					 --
			end					 --
		end					 --
	end					 --
	return lastPoint					 --
end					 --
					 --
function addLinePoint(array,x,y,x05,y05)					 --
	local x_a = x					 --
	local y_a = y					 --
	if array.adapt then					 --
		if x05 and y05 then					 --
			local defAx = x - x05					 --
			local defAy = y - y05					 --
					 --
			defAx = defAx * ((1 - msw)/0.5)					 --
			defAy = defAy * ((1 - msw)/0.5)					 --
					 --
			x_a = x_a - defAx					 --
			y_a = y_a - defAy					 --
		else					 --
			x_a = x_a * msw					 --
			y_a = y_a * msw					 --
		end					 --
	end					 --
					 --
	local lastPoint = findLastLinePoint(array)					 --
	array[#array+1] = {point = true,x=x_a,y=y_a}					 --
	if lastPoint then lastPoint.nextPoint = array[#array] end					 --
	array.len = calcLinerArrayLenght(array)						 --
					 --
	return x_a,y_a					 --
end					 --
					 --
function createLinesArray(w,r,g,b,a)					 --
	local lines = {}					 --
	lines.lineArray = true					 --
	lines.color = {r = r or 255,g = g or 255,b = b or 255,a = a or 255}					 --
	lines.w = w or 1					 --
					 --
	--lines.w = lines.w * (1-(1 - msw)*0.05) -- line w low adapt					 --
					 --
	lines.adapt = true					 --
					 --
	lines.progress = 0					 --
					 --
	return lines					 --
end					 --
function createLinesInheritedArray(array)					 --
	local inhArray = createLinesArray(array.w,array.color.r,array.color.g,array.color.b,array.color.a)					 --
	inhArray.adapt = array.adapt					 --
	return inhArray					 --
end					 --
					 --
					 --
function addLineArray(array,insert)					 --
	array[#array+1] = insert					 --
	array.len = calcLinerArrayLenght(array)					 --
end					 --
					 --
function drawArray(parent,lines,ProcessedLen)					 --
	local progressLen = ProcessedLen or lines.len*lines.progress					 --
					 --
	for i,elm in ipairs(lines) do					 --
		if progressLen > 0 then					 --
			if elm.lineArray then					 --
				drawArray(parent,elm,progressLen)					 --
			else					 --
				if lines[i].nextPoint then					 --
					local sx = lines[i].x + parent.locSize.cpx					 --
					local sy = lines[i].y + parent.locSize.cpy					 --
					local ex = lines[i].nextPoint.x + parent.locSize.cpx					 --
					local ey = lines[i].nextPoint.y + parent.locSize.cpy					 --
					 --
					local dist = getDistanceBetweenPoints2D(sx,sy,ex,ey)					 --
					if dist > progressLen then					 --
						local dex = ex - sx					 --
						local dey = ey - sy					 --
					 --
						local koef = progressLen/dist					 --
						dex = dex*koef					 --
						dey = dey*koef					 --
					 --
						ex = sx + dex					 --
						ey = sy + dey					 --
					end					 --
					 --
					dxDrawLine(sx,sy,ex,ey,tocolor(lines.color.r,lines.color.g,lines.color.b,lines.color.a),lines.w)					 --
					 --
					progressLen = progressLen - dist					 --
				end					 --
			end					 --
		end					 --
	end					 --
end					 --
					 --
function createRectFiller(x,y,w,h,name,parent,argi,AutoStart)					 --
	local args = argi or {}					 --
	local lw = args.lw or 2					 --
	args.fillW = args.fillW or 500					 --
	args.maxW = args.maxW or 1000					 --
					 --
	args.showK = 0					 --
	args.showDif = 0					 --
	args.frameCount = args.frameCount or 40					 --
	if AutoStart then 					 --
		args.showDif = 1/args.frameCount					 --
	end					 --
					 --
	local colFill = fromColor(args.colFill or blackCol)					 --
	local colIn = fromColor(args.colIn or whiteCol)					 --
					 --
	local fillrecter = TIV:create({x=x,y=y,w=w,h=h,adapt = args.adapt,adaptPos = args.adaptPos},{frame = true,img = function(_,obj)					 --
	local alf = obj.imgP.color.a					 --
		local colFiller = tocolor(colFill.r,colFill.g,colFill.b,alf)					 --
		local colIner = tocolor(colIn.r,colIn.g,colIn.b,alf)					 --
					 --
		dxDrawRectangle(obj.locSize.cpx-lw,obj.locSize.cpy-lw,obj.locSize.w+lw*2,obj.locSize.h+lw*2,colFiller)					 --
		--drawInBlendMode("overwrite",function()						 --
			dxDrawRectangle(obj.locSize.cpx,obj.locSize.cpy,obj.locSize.w,obj.locSize.h,colIner)					 --
		--end)					 --
					 --
		local wew = maxer(obj.locSize.w*((args.fillW/args.maxW)*args.showK),obj.locSize.cutW)					 --
		dxDrawRectangle(obj.locSize.cutX,obj.locSize.cutY,wew,obj.locSize.cutH,colFiller)					 --
					 --
		args.showK = maxer(args.showK + args.showDif,1)					 --
					 --
	end},nil,name,parent)					 --
	fillrecter.start = function()					 --
		args.showDif = 1/args.frameCount					 --
	end					 --
					 --
	return fillrecter					 --
end					 --
					 --
function animateOrderedElements(orederedAnimatingElements,anim,animArgs,animInterval)					 --
	local aE = {}					 --
					 --
	for indx=1,#orederedAnimatingElements do					 --
		local elmnt = orederedAnimatingElements[indx]					 --
		local callbackFuc					 --
		if elmnt[2] then					 --
			callbackFuc = elmnt[2]					 --
			elmnt = elmnt[1]					 --
		end					 --
					 --
		aE[#aE+1] = {aBlock = animate(elmnt,anim,animArgs,callbackFuc,false), name = elmnt.name.."orderedAnimationWaiter"}							 --
	end					 --
	local animInterval = animInterval or 3					 --
	for index,animInf in ipairs(aE) do					 --
		local animInfo = animInf					 --
		frameWait(animInterval*index,function()					 --
			animInfo.aBlock.start()					 --
		end,animInfo.name.." "..index)					 --
	end					 --
end					 --
					 --
--------------------------					 --
end					 --
return Interface					 --
