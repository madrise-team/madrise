----- import Draws					 --
loadstring(exports.importer:load())()					 --
import('Draws/drawsCore.lua')()					 --
rlsc = exports.RRL_Scripts					 --
------------------------------------------------------------------------					 --
					 --
JobsContent = {}					 --
JobsContent["busWork"] = {					 --
	name = "Водитель автобуса",					 --
	jobText = [[А вот это описание будет в разы длинне чем остальные но это позволит проверить работает ли динамический размер и выравнивание. Давно выяснено, что <Водитель автобуса> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["dostavWork"] = {					 --
	name = "Грузопереозчик",					 --
	jobText = [[Давно выяснено, что <Грузопереозчик> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["taxiWork"] = {					 --
	name = "Водитель такси",					 --
	jobText = [[Давно выяснено, что <Водитель такси> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["shahtaWork"] = {					 --
	name = "Шахтер",					 --
	jobText = [[Давно выяснено, что <Шахтер> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["gruzWork"] = {					 --
	name = "Грузчик",					 --
	jobText = [[Давно выяснено, что <Грузчик> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["pizzaWork"] = {					 --
	name = "Развочик пиццы",					 --
	jobText = [[Давно выяснено, что <Развочик пиццы> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["musorWork"] = {					 --
	name = "Сборщик мусора",					 --
	jobText = [[Давно выяснено, что <Сборщик мусора> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["inkosWork"] = {					 --
	name = "Инкассатор",					 --
	jobText = [[Давно выяснено, что <Инкассатор> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["pereWork"] = {					 --
	name = "Перевозчик авто",					 --
	jobText = [[Давно выяснено, что <Транспартировщик авто> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["montaWork"] = {					 --
	name = "Электромонтажник",					 --
	jobText = [[Давно выяснено, что <Электромонтажник> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
					 --
					 --
JobsContent["policeWork"] = {					 --
	name = "Мусор",					 --
	jobText = [[Давно выяснено, что мусора сосать.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["hospWork"] = {					 --
	name = "Медик",					 --
	jobText = [[Давно выяснено, что <Педик> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["mafiaWork"] = {					 --
	name = "Электромонтажник",					 --
	jobText = [[Давно выяснено, что <Зубенко М.П> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
JobsContent["gangWork"] = {					 --
	name = "Преступник",					 --
	jobText = [[Давно выяснено, что <GangDoner> при оценке дизайна и композиции мешает сосредоточиться.Lorem Ipsum используют потому, что тот обеспечивает более или менее стандартное заполнение шаблона, а также реальное распределение букв и пробелов в]]					 --
}					 --
					 --
					 --
					 --
					 --
--------- BirZha Trude ----------------------------------------------					 --
local birjaTrudaWinName = "birZha Trude"    					 --
function openBirjaTruda(jobs)					 --
	--createECSskipper(closeBirjaTrude)					 --
						 --
    					 --
    birjaTopWin = "BirjaAlignWin"					 --
    birjaWinArea = "BirjaWinArea"					 --
					 --
    topWin = createAligner(0,0.5,birjaTopWin)					 --
    local black = Blackout(birjaTopWin)					 --
						 --
					 --
    local areaW = createArea(0,SWins.big1.y,screenW,SWins.big1.h,birjaWinArea,birjaTopWin)					 --
	createBlurer(SWins.big1.x,SWins.big1.y,SWins.big1.noShadow.w,SWins.big1.noShadow.h,birjaWinArea)						 --
					 --
    local win = createWindow(SWins.big1,birjaTrudaWinName,birjaWinArea)					 --
    createPattern(SPattern.EDBA,birjaTrudaWinName)					 --
    createButton(SButton.close1,1292,0,  nil , nil , nil,"close",birjaTrudaWinName,{["cursorClick"] = function()					 --
		animate(win,Animations.displayTurningArray,{startF = 1,frameCount = 20,mode = "self"},function()					 --
			black.setVoid()					 --
			areaW:Destroy()					 --
		end)					 --
		animate(black,Animations.simpleFade,{startA = 255,endA = 0,framesCount = 60},function()					 --
			closeBirjaTrude()					 --
		end)					 --
	end})					 --
					 --
  	createSeparatorWinBlock(birjaTrudaWinName)					 --
  	createLabel(SFonts.ebda.h1,52,30,800,400,{["text"] = "БИРЖА ТРУДА"},birjaTrudaWinName.."-header",birjaTrudaWinName)					 --
  	createSeparatorVert(451,215,387,birjaTrudaWinName)					 --
					 --
  	local JobsAreaName = "JobsListArea"					 --
  	local jobsScroll = createArea(39,145,400,600,JobsAreaName,birjaTrudaWinName,"scroll",{slidersT = {{x = 392,w = 8, h = 16, color = tocolor(110,140,225,100)}}})					 --
					 --
  	local jobDescriptionArea = birjaTrudaWinName.."-JobDescriptionArea"					 --
  	local desrcAreaTIV					 --
					 --
  	JobsListbutsArray = {}					 --
  	local i = 0					 --
  	for k,j in pairs(jobs) do					 --
  		i = i + 1					 --
					 --
  		JobsListbutsArray[i] = createListButton(SListButton.list1,0,(74 + 5)*(i-1),  nil , nil ,{["text"] = JobsContent[k].name},birjaTrudaWinName.."-JobsListButton"..i,JobsAreaName,function()					 --
			if desrcAreaTIV then 					 --
				desrcAreaTIV:Destroy()					 --
			end					 --
					 --
		  	desrcAreaTIV = createDynamicAlignArea(482,62,900,690,jobDescriptionArea,birjaTrudaWinName,0,0.5)  					 --
			createLabel(SFonts.ebda.h2,0,0,500,40,{["text"] = JobsContent[k].name},birjaTrudaWinName.."-jobDescriptionHeader",jobDescriptionArea)					 --
			local jobText = JobsContent[k].jobText					 --
			local bubt = createLabel(SFonts.ebda.text,0,40,500,400,{["text"] = jobText},birjaTrudaWinName.."-jobDescription",jobDescriptionArea,{sizeType = 'dynamic'})					 --
			createButton(SButton.button1small,0,40,  nil , nil ,{["text"] = "Начать"},"startNewSelectedJob",jobDescriptionArea,{["cursorClick"] = function()					 --
				triggerServerEvent("startNewJob",root,localPlayer,k)					 --
			end})					 --
			animate(desrcAreaTIV,Animations.moveAndFade,{startPos = 100})					 --
  		end,JobsListbutsArray)					 --
  	end 					 --
					 --
  	win.toggle = false					 --
  	animate(black,Animations.simpleFade,{framesCount = 60})					 --
	local displayA = animate(win,Animations.displayTurningArray,_,function()					 --
		win.toggle = true					 --
	end,false)					 --
	local patternA = animate(areaW,Animations.theresholdPattern,_,function()					 --
		black.setVoid(win.locSize.x,areaW.locSize.y,SWins.big1.noShadow.w,SWins.big1.noShadow.h)					 --
	end,false)					 --
	frameWait(22,function() 					 --
		displayA.start()					 --
	end,win.name.."displayA")					 --
	frameWait(30,function() 					 --
		patternA.start()					 --
	end,win.name.."patternA")					 --
						 --
					 --
  	rlsc:showCursorS(true)					 --
  	rlsc:hideInterface()					 --
  	win.destruction = function()					 --
  		rlsc:hideCursorS()					 --
  	end					 --
  	black.destruction = function()					 --
  		rlsc:showInterface()					 --
  	end					 --
					 --
end					 --
function closeBirjaTrude()					 --
	--deleteECSskipper()					 --
	if topWin then topWin:Destroy() end					 --
end					 --
					 --
					 --
addEvent("updateBirjaTruda",true)					 --
addEvent("openBirjaTruda",true)					 --
addEventHandler("openBirjaTruda",root,function(jobs)					 --
	closeBirjaTrude()					 --
	openBirjaTruda(jobs)					 --
end)					 --
addEventHandler("updateBirjaTruda",root,function(jobs)					 --
	closeBirjaTrude()					 --
	openBirjaTruda(jobs)					 --
end)    					 --
---------------------------------------------------------------------					 --
					 --
_DoWinDubugDraw()					 --
