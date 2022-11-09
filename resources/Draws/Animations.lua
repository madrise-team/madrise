function Animations()
----------------------------------------------------------------------------------------

pendingAnimations = {}  -- Эти блоки будут добавлены после прогона всех анимаций в кадре (шоб не ломать форыча внезапными вставками)
activeAnimations = {}
addEventHandler("onClientRender",root,function()
	for elmName,animBlock in pairs(activeAnimations) do
		if animBlock.inProgress then
			if animBlock.elm.destoyed then animBlock.destroy()
			else animBlock.frame(animBlock) end
		end
	end
	for k,v in pairs(pendingAnimations) do
		activeAnimations[k] = v
		pendingAnimations[k] = nil
	end
end)



function animate(elm,animationT,args,endCall,AutoStart)
	local autoStart = true
	if AutoStart == false then autoStart = false end

	local animBlock = {}

	local key = tostring(elm.name.."_"..animationT.name)

	if activeAnimations[key] then
		activeAnimations[key].destroy()
	end

	animBlock.elm = elm
	animBlock.frame = animationT.frame
	animBlock.destroyer = animationT.destroyer
	animBlock.args = copyTable(args); if type(args) ~= 'table' then animBlock.args = {} end
	animBlock.endCall = endCall

	animBlock.destroy = function()
		if animBlock.destroyer then animBlock.destroyer(animBlock) end
		activeAnimations[key] = nil
		if endCall then 
			endCall(animBlock) 
		end
	end

	animationT.init(animBlock)
	
	animBlock.inProgress = false
	if autoStart then animBlock.inProgress = true end

	pendingAnimations[key] = animBlock
	return {key = key,start = function()
		animBlock.inProgress = true
	end,destroy = function()
		animBlock.destroy()
	end}

end




Animations = {}
	--------------------------------
	Animations.simpleFade = {
		name = "simpleFade",
		-- ARGS:
			-- startA		[0-255] (0)
			-- childsA		[T;F]	(true)
			-- endA 		[255-0] (elm.imgP.color.a)
			-- frameCount 	____	(100)

	init = function(ab)
		ab.args.startA = ab.args.startA or 0
		
		ab.args.endA = ab.args.endA or ab.elm.imgP.color.a
		if ab.args.childsA == nil then ab.args.childsA = true end

		ab.args.frameCount = ab.args.frameCount or 100
		ab.args.frameDif = (ab.args.endA - ab.args.startA)/ab.args.frameCount
		ab.args.frameN = 0

		ab.args.sign = math.abs(ab.args.frameDif)/ab.args.frameDif
		ab.elm.imgP.color.a = ab.args.startA
	end,
	destroyer = function(ab)
		ab.elm.imgP.color.a = ab.args.endA
		if ab.args.childsA then ab.elm.imgP.color.childA = ab.elm.imgP.color.a end
	end,
	frame = function(ab)
		ab.elm.imgP.color.a = ab.elm.imgP.color.a + ab.args.frameDif
		if ab.args.childsA then ab.elm.imgP.color.childA = ab.elm.imgP.color.a end

		ab.args.frameN = ab.args.frameN + 1
		if ab.args.frameN > ab.args.frameCount then 
			ab.destroy()
			return
		end

		local endCheck = false
		if ab.args.sign < 0 then
			if (ab.elm.imgP.color.a < ab.args.endA) then endCheck = true end
		else
			if (ab.elm.imgP.color.a > ab.args.endA) then endCheck = false end
		end

		if endCheck then
			ab.destroy()
		end
	end }
	-------------------------------- simpleFade //\\

	--------------------------------------------------------------------------------------------------------------------------------
	Animations.moveAndFade = {
		name = "moveAndFade",
		-- ARGS:
			-- startPos		____	(-100)
			-- startA		[0-255] (0)
			-- childsA		[T;F]	(true)
			-- endA 		[255-0] (elm.imgP.color.a)
			-- frameCount 	____	(10)

	init = function(ab)
		ab.args.frameCount = ab.args.frameCount or 10

		ab.args.startPos = ab.args.startPos or -100
		ab.args.endPos = ab.elm.locSize.x1

		Animations.simpleFade.init(ab)

		ab.elm.locSize.x1 = ab.elm.locSize.x1 + ab.args.startPos


		ab.args.frameDifPos = (ab.args.endPos - ab.elm.locSize.x1)/ab.args.frameCount
	end,
	destroyer = function(ab)
		Animations.simpleFade.destroyer(ab)		
		ab.elm.locSize.x1 = ab.args.endPos 
	end,
	frame = function(ab)
		ab.elm.locSize.x1 = ab.elm.locSize.x1 + ab.args.frameDifPos
		Animations.simpleFade.frame(ab)
	end }
	-------------------------------- moveAndFade //\\
	
	--------------------------------------------------------------------------------------------------------------------------------
	Animations.theresholdPattern = {
		name = "theresholdPattern",
		-- ARGS:
			-- startTh		[0;1] 			(0)
			-- pattern  	[EBDA1; EBDA2] 	(EBDA1)
			-- frameCount	 ____			(100)

			--Возможный алгоритм паттерна работающего с childs (которые также анимированы через theresholdPattern):
				-- Очистка _scrRT на onClientPreRender
				-- Перехватываем draws, редрим его вместе c childs на _scrRT без очистки при переключении
				-- Полученный RT пропускаем через Threshold
						--Проблема: для рендера нового элемента требуется его передовать в шейдер как текстуру
						--Возможное решение: использование вспомогательного _scrRT, предварительный рендер элемента на _scrRT2, рендер чилдренов отдельно!

	init = function(ab)
		if not ab.elm.imgP then
			outputDebugString("Creating Pattern Shader for 'no img TIV'!")
			return
		end
		
		ab.theresholdPatternShader = dxCreateShader(":Draws/fx/TheresholdPattern.fx")

		ab.Th = 0
		ab.args.frameCount = ab.args.frameCount or 100
		ab.args.pattern = ab.args.pattern or "EBDA1"
		ab.args.frameN = 0

		local patternTex = patternEbdTex
		if ab.args.pattern == "EBDA1" then
			ab.endTh = 500 + 50
			patternTex = patternEbdTex
		elseif ab.args.pattern == "EBDA2" then
			ab.endTh = 755 + 50
			patternTex = patternEbdTex2
		end

		if ab.args.startTh == 1 then 
			ab.Th = ab.endTh
			ab.endTh = 0
		end

		ab.args.frameDif = (ab.endTh - ab.Th)/ab.args.frameCount
		
		ab.elm._savedOrigDraw = ab.elm.Draw

		dxSetShaderValue(ab.theresholdPatternShader,"pattern",patternTex)
		dxSetShaderValue(ab.theresholdPatternShader,"threshold",ab.Th)

		ab.elm.Draw = function(doDraw)
			
			
			enterToRT(_scrRT,true)
			local savedBM = dxGetBlendMode()
			dxSetBlendMode("modulate_add")
			ab.elm:_savedOrigDraw()
			escapeRT()
			dxSetBlendMode(savedBM)
			
			dxSetShaderValue(ab.theresholdPatternShader,"textura",_scrRT)
			dxDrawImage(0,0,screenW,screenH,ab.theresholdPatternShader)

			--ab.originalDraw(doDraw,true,false)
		end

	end,
	destroyer = function(ab)
		ab.elm.Draw = ab.originalDraw
		destroyElement(ab.theresholdPatternShader)
	end,
	frame = function(ab)
		ab.Th = ab.Th + ab.args.frameDif
		dxSetShaderValue(ab.theresholdPatternShader,"threshold",ab.Th)

		ab.args.frameN = ab.args.frameN + 1
		if ab.args.frameN > ab.args.frameCount then	ab.destroy() end
	end }
	-------------------------------- Thereshold pattern //\\

	--------------------------------------------------------------------------------------------------------------------------------
	Animations.displayTurningArray = {
		name = "displayTurningArray",
		-- ARGS:
			-- startF		[0;1] 			(0)
			-- phases		 ___ 			(0.2,0.2,0.3)
												-- 1: not draw
												-- 2: drawRect
												-- 3: drawGlitch
			-- frameCount 	 ___ 			(80)
			-- mode 		[childs;self] 	(childs)

	init = function(ab)
		ab.args.frameCount = ab.args.frameCount or 80
		ab.args.frameN = 0

		ab.args.startF = ab.args.startF or 0
		ab.args.sign = 1
		if ab.args.startF == 1 then ab.args.sign = -1 end

		ab.args.applyModeFuc = applyToLowestElements

		local applyFuc = function(elm)
			local chelm = elm
			chelm._savedOrigDraw = chelm.Draw
			
			chelm._da_phases = ab.args.phases or {0.2,0.2,0.3}
			for i=1,#chelm._da_phases do
				local rander = math.random(-20,20)/100.0
				chelm._da_phases[i] = chelm._da_phases[i] + rander
			end

			chelm._da_phase = 1
			if ab.args.startF == 1 then chelm._da_phase = 3 end

			chelm._da_phaseFrame = 0
			chelm._da_random1 = math.random(chelm.locSize.cutW/20,chelm.locSize.cutW/8)
			chelm._da_random2 = math.random(-chelm.locSize.cutW/20,chelm.locSize.cutW/20)
			chelm._da_radomCol = math.random(-20,20)

			chelm.Draw = function(doDraw)
				if chelm._da_phase < 2 then
					return
				elseif chelm._da_phase == 2 then
					dxDrawRectangle(chelm.locSize.cutX - chelm._da_random1/2,chelm.locSize.cutY - chelm._da_random1/2,chelm.locSize.cutW + chelm._da_random1,elm.locSize.cutH + chelm._da_random1,tocolor(125,200,210,75))
				elseif chelm._da_phase == 3 then
					
					dxDrawRectangle(chelm.locSize.cutX - chelm._da_random2/2,chelm.locSize.cutY - chelm._da_random2/2,chelm.locSize.cutW + chelm._da_random2,elm.locSize.cutH + chelm._da_random2,tocolor(175,240,250,125))
					local depex = chelm.locSize.cutX - chelm._da_random2
					local depey = chelm.locSize.cutY - chelm._da_random2
					local depew = chelm.locSize.cutW + chelm._da_random2
					local depeh = chelm.locSize.cutH + chelm._da_random2
					local r = math.random(-2,2)
					local p = (chelm._da_random2 + math.random(-10,10))/10
					local decol = tocolor(maxer(175 + chelm._da_radomCol,250)/4,maxer(240 + chelm._da_radomCol,250),maxer(245 + chelm._da_radomCol,250),maxer(200 + chelm._da_radomCol/2,255))
					dxDrawLine(depex+p,depey+p,depex + depew+p,depey+p,decol+p,1 + r)
					p = (chelm._da_random2 + math.random(-10,10))/10
					dxDrawLine(depex + depew+p,depey+p,depex + depew+p,depeh + depey+p,decol,1 + r)
					p = (chelm._da_random2 + math.random(-10,10))/10
					dxDrawLine(depex + depew+p,depeh + depey+p,depex+p,depeh + depey+p,decol,1 + r)
					p = (chelm._da_random2 + math.random(-10,10))/10
					dxDrawLine(depex+p,depey + depeh+p,depex+p,depey+p,decol,1 + r)
				else
					chelm:_savedOrigDraw(true,false,true)
				end
			end
		end
		if ab.args.mode == "self" then applyFuc(ab.elm)
		else ab.args.applyModeFuc(ab.elm,applyFuc) end  -- раскидываем анимку по нижним элементам, минуя технические.
		
	end,
	destroyer = function(ab)
		local applyFuc = function(chelm)
			chelm.Draw = chelm._savedOrigDraw
		end
		if ab.args.mode == "self" then applyFuc(ab.elm)
		else ab.args.applyModeFuc(ab.elm,applyFuc) end
	end,
	frame = function(ab)
		ab.args.frameN = ab.args.frameN + 1
		if ab.args.frameN > ab.args.frameCount then	ab.destroy() end


		local applyFuc = function(chelm)
			chelm._da_phaseFrame = chelm._da_phaseFrame + 1
			
			local phkof = chelm._da_phases[chelm._da_phase] or 0
			if chelm._da_phaseFrame > ab.args.frameCount*phkof then
				chelm._da_phase = chelm._da_phase + 1*ab.args.sign
				chelm._da_phaseFrame = 0
			end
		end
		if ab.args.mode == "self" then applyFuc(ab.elm)
		else ab.args.applyModeFuc(ab.elm,applyFuc) end
	end }
	-------------------------------- displayTurningArray //\\

	--------------------------------------------------------------------------------------------------------------------------------
	Animations.buildupStack = {
		name = "buildupStack",
		-- ARGS:
			-- startF		[0;1] 	(0)
			-- stackCount	___		(2)
			-- stackSmesX 	___		(4)
			-- stackSmesY 	___		(4)
			-- frameCountFor1	___	(10)
			-- startPos		____	(60)
			-- childsA		[T;F]	(true)
			-- reduceA		[T;F]	(true)
			-- reduceColor	[T;F]	(true)
			-- reduceKoef	___		(1.5)

	init = function(ab)
		ab.args.stackCount = ab.args.stackCount or 2
		ab.args.stackSmesX  = ab.args.tackSmesX	or 4
		ab.args.stackSmesY  = ab.args.tackSmesY  or 4
		ab.args.frameCountFor1 = ab.args.frameCountFor1 or 10
		ab.args.frameCount = ab.args.frameCountFor1
		ab.args.startPos = ab.args.startPos or 60
		ab.args.childsA	= ab.args.childsA
		if ab.args.childsA == nil then ab.args.childsA = true end
		ab.args.reduceA = ab.args.reduceA
		if ab.args.reduceA == nil then ab.args.reduceA = true end
		ab.args.reduceColor = ab.args.reduceColor
		if ab.args.reduceColor == nil then ab.args.reduceColor = true end

		ab.args.reduceKoef = ab.args.reduceKoef or 1.5

		ab.elm._stackChilds = {}

		local reducer = 255
		local reducerStep = 255/(ab.args.stackCount+1)

		local savePAdapt = ab.elm.locSize.adapt
		ab.elm.locSize.adapt = false
		for i=1,ab.args.stackCount do
			local elemel = TIV:create(ab.elm.locSize,ab.elm.imgP,ab.elm.textP,ab.elm.name.."_stackChildren"..i,ab.elm.parent.name)
			elemel.hierarchyDraw = false
			elemel.toggle = false
			
			elemel.locSize.x1 = elemel.locSize.x1 + ab.args.stackSmesX*i
			elemel.locSize.y1 = elemel.locSize.y1 + ab.args.stackSmesY*i

			reducer = reducer - reducerStep/ab.args.reduceKoef
			if ab.args.reduceA then
				elemel.imgP.color.a = reducer
			end
			if ab.args.reduceColor then				
				elemel.imgP.color.r = elemel.imgP.color.r*(reducer/255)
				elemel.imgP.color.g = elemel.imgP.color.g*(reducer/255)
				elemel.imgP.color.b = elemel.imgP.color.b*(reducer/255)
			end

			ab.elm._stackChilds[i] = elemel
		end
		ab.elm.locSize.adapt = savePAdapt

		ab.elm._stackBUp_innerDraw = ab.elm.Draw
		ab.elm.Draw = function(_,doDraw,dodrawChilds,dodrawSelf)
			for k,v in rpairs(ab.elm._stackChilds) do
				if dodrawSelf ~= false then
					v:Draw(doDraw,dodrawChilds,drawSelf)
				end
			end
			ab.elm:_stackBUp_innerDraw(doDraw,dodrawChilds,dodrawSelf)
		end


		local innerDestruction = ab.elm.destruction
		ab.elm.destruction = function(doD)
			for k,v in pairs(ab.elm._stackChilds) do
				v:Destroy()
			end
			if innerDestruction then innerDestruction() end
		end


		local anims = {}
		anims[1] = animate(ab.elm,Animations.moveAndFade,ab.args,function()
			ab.destroy()
		end,false)
		for i,stckChElm in pairs(ab.elm._stackChilds) do
			local k = i
			anims[k+1] = animate(stckChElm,Animations.moveAndFade,{startPos = ab.args.startPos,frameCount = ab.args.frameCount},function()
				anims[k].start()
			end,false)
		end
		anims[#anims].start()
		
	end,
	destroyer = function(ab)
	end,
	frame = function(ab)
	end 
}
	-------------------------------- buildupStack //\\

	--------------------------------------------------------------------------------------------------------------------------------
	Animations.maskedLayerDraw = {
		name = "maskedLayerDraw",
			-- ARGS:
			-- frame  (function) (required)

	init = function(ab)
		ab.elm._maskedLayerDraw_innerDraw = ab.elm.Draw
		--if true then return end
	
		if not ab.args.frame then
			outputDebugString("no frame arg in maskedLayerDraw animation! >"..ab.elm.name)
		end

		ab.layerMaskShader = dxCreateShader(":Draws/fx/LayerMask.fx")

		ab.elm.Draw = function()
			-------
			enterToRT(_scrRT,true)
			local savedBM = dxGetBlendMode()
			dxSetBlendMode("modulate_add")

			ab.elm:_maskedLayerDraw_innerDraw(true,false,true)

			escapeRT()
			dxSetBlendMode(savedBM)
			
			
			local savedBM = dxGetBlendMode()
			dxSetBlendMode("add")
			dxDrawImage(0,0,screenW,screenH,_scrRT)
			dxSetBlendMode(savedBM)
			
			-------
			enterToRT(_scrRT2,true)

			ab.args.frame()

			escapeRT()
			-------

			dxSetShaderValue(ab.layerMaskShader,"mask",_scrRT)
			dxSetShaderValue(ab.layerMaskShader,"textura",_scrRT2)

			dxDrawImage(0,0,screenW,screenH,ab.layerMaskShader)

			ab.elm:_maskedLayerDraw_innerDraw(true,true,false)
		end
	end,
	destroyer = function(ab)
		
	end,
	frame = function(ab)
	end}
	-------------------------------- maskedLayerDraw //\\

----------------------------------------------------------------------------------------
end
return Animations