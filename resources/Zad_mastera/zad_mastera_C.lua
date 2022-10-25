loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()
local screenWidth,screenHeight = guiGetScreenSize()

local notCreated = true
local B1 = {}
bindKey("0","down",function ()
	notCreated = not notCreated
	if not notCreated then B1 = Buttonizer(screenWidth/2 - 650,350) end
end)

local Text = {			---Index
	"Zadanie Mastera",  --1
	"Ebuchie Chest",	--2
}
function Draw(T)
	dxDrawRectangle(screenWidth/2 - 650, 200, 240, 300, tocolor(0,0,0,100), false , false)
	dxDrawText(T, screenWidth/2 - 650, 25, screenWidth/2 - 410, 440, tocolor(255,255,255,255), 2, "arial","center",	"center", false, true, false, false, false)	
--[[затрах следующий нужно что нибудь придумать с дравнером так чтобы он был отдельной функцией
для того чтобы вызывалась стартовая панель с заданиями нажал на задание и появилось название и описание задания 
описание заданий отдельно в каждом блоке заданий так же надо что то придумать с одинаковыми полями в блоках заданий
--]]
	end

function Ebuchie_Chest()
	removeEventHandler("onClientRender", root, Render_Zad)
	for _, val in pairs(B1) do val:Destroy() end
	B1 = {}		
	Draw(Text[2])
end
function Rekursive_Table()
	removeEventHandler("onClientRender", root, Render_Zad)
	for _, val in pairs(B1) do val:Destroy() end
	B1 = {}		
	Draw()
end
function My_Name()
	removeEventHandler("onClientRender", root, Render_Zad)
	for _, val in pairs(B1) do val:Destroy() end
	B1 = {}		
	Draw()
end
function Mta_Menu()
	removeEventHandler("onClientRender", root, Render_Zad)
	for _, val in pairs(B1) do val:Destroy() end
	B1 = {}		
	Draw()
end

function Distributor (iterator) 
	if iterator == 1 then return Ebuchie_Chest() end	
	if iterator == 2 then return Rekursive_Table() end	
	if iterator == 3 then return My_Name() end	
	if iterator == 4 then return Mta_Menu() end		
end	

local Name = {
	"Ebuchie_Chest",
	"Rekursive_Table",
	"My_Name",
	"Mta_Menu",
}
local Button_list = {}
local i = 1
function Buttonizer(xb,yb)
	i = 1
	while i < 5 do 
		local iterator = i
		Button_list[i] = createButton(nil,xb,yb,200,90,{text = Name[i]},nil,nil,function()
			Distributor(iterator)
		end)
		yb = yb + 80
		i = i + 1
	end
	return Button_list
end

function Render_Zad()
	if not notCreated then 
		dxDrawRectangle(screenWidth/2 - 650, 200, 240, 300, tocolor(0,0,0,100), false , false)
		dxDrawText(Text[1], screenWidth/2 - 650, 25, screenWidth/2 - 410, 440, tocolor(255,255,255,255), 2, "arial","center",	"center", false, true, false, false, false)	
	else
		for _, val in pairs(B1) do val:Destroy() end
		B1 = {}		
	end						
end
addEventHandler("onClientRender", root, Render_Zad)


		--[[можно сделать в таблице текст на тексте ползунок который меняет положение по 
		зафиксированным кордам если кнопка вверх то ползунок удаляется из нынешней строчки и появляется в верхней строчке аналогично для кнопки
		вниз забиндить ентер который будет сопоставлять нынешние корды ползунка с уже выставленными и если 
		есть совпадение начинается ивент так же есть текстовый пункт "больше заданий" который выводит на экран большую таблицу 
		с заданиями и кнопка которая закрывает таблицу

		можно сделать кнопки которые сопоставляются и тригерят ивент так же кнопка больше заданий--]]

			
--- Gor loh