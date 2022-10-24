loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()

local notCreated = true
local B1 = {}
bindKey("0","down",function ()
	notCreated = not notCreated
	if not notCreated then B1 = Buttonizer(400,500) end
end)

local Button_list = {}
function Buttonizer(xb,yb)
	local i = 0
	while i < 3 do 
		Button_list[i] = createButton(nil,xb,yb,200,90,{text = "knopka"},nil,nil,function()
			button1()
		end)
		yb = yb + 50
		i = i + 1
	end
	return Button_list
end

local screenWidth,screenHeight = guiGetScreenSize()
local text = "Zadanie Mastera"
local framer = 0
function Render_Zad()
	if not notCreated then 
		dxDrawRectangle(screenWidth/2 - 650, 200, 240, 300, tocolor(0,0,0,100), false , false)
		dxDrawText(text, screenWidth/2 - 650, 25, 240 + screenWidth/2 - 650, 240+200,tocolor(255,255,255,255), 2, "arial","center",	"center", false, true, false, false, false)	
		framer = framer + 1	
	else
		framer = 0
		for _, val in pairs(B1) do
			val:Destroy()
		end
		B1 = {}		
	end						
end
addEventHandler("onClientRender", root, Render_Zad)

function button1 ()
	outputChatBox("oleg")
end	

		--[[можно сделать в таблице текст на тексте ползунок который меняет положение по 
		зафиксированным кордам если кнопка вверх то ползунок удаляется из нынешней строчки и появляется в верхней строчке аналогично для кнопки
		вниз забиндить ентер который будет сопоставлять нынешние корды ползунка с уже выставленными и если 
		есть совпадение начинается ивент так же есть текстовый пункт "больше заданий" который выводит на экран большую таблицу 
		с заданиями и кнопка которая закрывает таблицу

		можно сделать кнопки которые сопоставляются и тригерят ивент так же кнопка больше заданий--]]

--[[createButton(nil,400,500,90,20,{text = "misha"},nil,nil,function()
        outputChatBox("cliker")
        znac = 1
        return znac
    end)--]]

			
