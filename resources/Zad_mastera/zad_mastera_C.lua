loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()
local screenWidth,screenHeight = guiGetScreenSize()

local Text = {			---Index
	"Ebuchie Chest",	--1
	"Tablica Eblica",   --2
	"My Name",          --3
	"Mta Menu",         --4
}

local notCreated = true
local a = true
local B1 = {}
bindKey("0","down",function ()
	notCreated = not notCreated
	if not notCreated then B1 = Buttonizer(screenWidth/2 - 650,350) end	
end)

function Draw_Name(T)
	dxDrawText(T, screenWidth/2 - 650, 25, screenWidth/2 - 410, 440, tocolor(255,255,255,255), 2, "arial","center",	"center", false, true, false, false, false)	
end
function Remove()
	for _, val in pairs(B1) do val:Destroy() end
	B1 = {}	
end
function Ebuchie_Chest()
	Remove()	
	Draw_Name(Text[1])	
end

function Rekursive_Table()
	Remove()
	Draw_Name(Text[2])
end

function My_Name()
	Remove()			
	Draw_Name(Text[3])
end

function Mta_Menu()
	Remove()		
	Draw_Name(Text[4])
end

function Distributor (iterator) 
	if iterator == 1 then a = not a return addEventHandler("onClientRender", root, Ebuchie_Chest) end	
	if iterator == 2 then a = not a return addEventHandler("onClientRender", root, Rekursive_Table) end	
	if iterator == 3 then a = not a return addEventHandler("onClientRender", root, My_Name) end	
	if iterator == 4 then a = not a return addEventHandler("onClientRender", root, Mta_Menu) end		
end	


local Button_list = {}
local i = 1
function Buttonizer(xb,yb)
	i = 1
	while i < 5 do 
		local iterator = i
		Button_list[i] = createButton(nil,xb,yb,200,90,{text = Text[i]},nil,nil,function()
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
		if a then Draw_Name("Zadanie Mastera") end
	else
		removeEventHandler("onClientRender", root, Ebuchie_Chest)
		removeEventHandler("onClientRender", root, Rekursive_Table)
		removeEventHandler("onClientRender", root, My_Name)
		removeEventHandler("onClientRender", root, Mta_Menu)
		Remove()	
		a = true	
	end						
end
addEventHandler("onClientRender", root, Render_Zad)
--- Gor loh