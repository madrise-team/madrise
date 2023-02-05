---------------------Config------------------------
local DistToPlayer = 5 --Должно быть меньше чем глубина сканирования чтоб не тупило
local ScanDepth = 10
local width, height = 0 ,10 -- расположение текста на курсоре
---------------------------------------------------

local bool = false
local bool1 = false

bindKey("e","down",function ()
	bool1 = true
end)

 function TypeDetector()
 	local xp,yp,zp = getCameraMatrix()
	local w, h = getCursorPosition()
	 w = screenW * w
	 h = screenH * h
	local x,y,z = getWorldFromScreenPosition(w,h,ScanDepth)
	local hit, xn,yn,zn, elementHit = processLineOfSight(xp,yp,zp,  x,y,z,false,true,true)
	return(elementHit)
 end

function PlayerDetected()
	if not isCursorShowing(localPlayer) then return end
	local PlayerP = TypeDetector()
	local Type = getElementType(PlayerP)
	if Type == "player" then Distance(PlayerP) end
end

function Distance(elementPlayer)
	local xp,yp,zp =getElementPosition(localPlayer)
	local xn,yn,zn =getElementPosition(elementPlayer)
	local distance = getDistanceBetweenPoints3D(xp,yp,zp, xn,yn,zn)
	if distance < DistToPlayer then InteractionButton(elementPlayer) end
end

function InteractionButton(elementPlayer)
	local w,h = getCursorPosition()
	 w = screenW * w
	 h = screenH * h
	if elementPlayer ~= localPlayer then 
		dxDrawText("<e>",w + width,h + height)
		Key()
	end
end

function Key()
	if bool1 and isCursorShowing(localPlayer) then
		bool = true
		Interaction()
		bool1 = false
	else 
		bool = false
	end 	
end

function Interaction()
	if not bool then  return end
		local w,h = guiGetScreenSize()
		outputChatBox('ebala')
		dxDrawRectangle(w/2,h/2,300,300)
	


end


addEventHandler("onClientRender",root,PlayerDetected)




--[[
ОТРУБЛЕНА АФК СИСТЕМА !!!!! НЕ ЗАБЫТЬ ВЕРНУТЬ КАК БЫДЛО!!!!
работает получение типа объекта путем наведения на него курсора мыши
не понимаю как получить сам объект или хотябы его точные статические корды а не
ебаный поток циферек или хоть что нибудь блять информативное а не просто тупо тип 
объекта как ему подсветку пилить тогда??? а про остальное вщ молчу
 но работает корректно проверил на реальном человеке
--]]








 
--[[
создать GetCursorPosition который будет передавать координаты в 
getWorldFromSkreenPosition где будет указаана глубина взаимодействия ориентировочно 3-4 метра
и через processLineOfSight получаться елемент на который наведен курсор и если этот элемент 
плеером то начинается рендер 
(processLineOfSight пускает луч до объекта в поле взаимодействия персонажа соответственно нужно чтобы 
этот луч шел от курсора на выбранного плеера при этом нужно чтобы плеер как то выделялся для понимания работает 
ли это вообще)
предлагается сделать каркас типа api в который будут подключаться функции
При клике пкм должено открываться меню взаимодействия 

 --]]