loadstring(exports.importer:load())()					 --
import('Draws/drawsCore.lua')()					 --
local screenWidth,screenHeight = guiGetScreenSize()					 --
					 --
local Created = true					 --
local Access = true					 --
local B1 = {}					 --
bindKey("0","down",function ()					 --
	Created = not Created					 --
	if not Created then B1 = Buttonizer(screenWidth/2 - 650,350) end						 --
end)					 --
					 --
function Draw_Name(T)					 --
	dxDrawText(T, screenWidth/2 - 650, 25, screenWidth/2 - 410, 440, tocolor(255,255,255,255), 2, "arial","center",	"center", false, true, false, false, false)						 --
end					 --
					 --
function Remove()					 --
	for _, val in pairs(B1) do val:Destroy() end					 --
	B1 = {}	  --< крассавчик шо избавился от ссылок на убитые кнопки, респект					 --
end					 --
					 --
function Generator_Zadanii(zadanieK)					 --
	Access = false					 --
	Remove()					 --
	Zadaniya[zadanieK].init()					 --
end					 --
					 --
local Button_list = {}					 --
local i = 1					 --
function Buttonizer(xb,yb)					 --
	i = 1					 --
	for k,v in pairs(Zadaniya)do 					 --
		Button_list[i] = createButton(nil,xb,yb,200,90,{text = k},nil,nil,function()					 --
			Generator_Zadanii(k)					 --
		end)					 --
		yb = yb + 80					 --
		i = i + 1					 --
	end					 --
	return Button_list					 --
end					 --
					 --
function Render_Zad()					 --
	if not Created then 					 --
		dxDrawRectangle(screenWidth/2 - 650, 200, 240, 300, tocolor(0,0,0,100), false , false)					 --
		if Access then Draw_Name("Zadanie Mastera") end					 --
	else					 --
		Remove()					 --
		Access = true							 --
		-- не оч хорошо, что ремув будет высираться каждый кадр, когда его нужно вызвать всего раз					 --
		-- хотя массив и пустой, в эталоне, перенести бы ремув в биндКей("0"), и вызвать его только при непосредственном перекл на Created = true (крч как батонайзер, ток при другом условии)					 --
	end											 --
end					 --
addEventHandler("onClientRender", root, Render_Zad)					 --
					 --
---------- functions for API zadNica_Zadaniya ----------------					 --
					 --
function Header(Head)					 --
	local Head_Text = Head					 --
	function Draw_Header()					 --
		if not Access then 					 --
			Draw_Name(Head_Text) 						 --
		else					 --
			removeEventHandler("onClientRender", root, Draw_Header)					 --
		end						 --
	end						 --
	addEventHandler("onClientRender", root, Draw_Header)	---------- Сейчас в натуре код чистый и сАсный. Тем не менее, на отрисовку заголовка его выделено оч много.					 --
															-- У тебя уже есть 1 обработчик кадра, которым ты рисуешь главное окно, и название "Zad Mastera". 					 --
															-- Во первых, зачем создавать под заголовок задания ЕЩЕ 1 обработчик? Тем более что еще и пришлось поебаться с его биндом и очисткой...					 --
															-- во вторых, реще было бы просто поменять надпись Zad Mastera на название задания и опять таки не ебать себе мозги. 					 --
end					 --
--- Gor molodec)					 --
