 function TypeDetector()
 	local xp,yp,zp = getCameraMatrix()
	local w, h = getCursorPosition()
	 w = screenW * w
	 h = screenH * h
	local x,y,z = getWorldFromScreenPosition(w,h,50)
	local hit, xn,yn,zn, elementHit = processLineOfSight(xp,yp,zp,  x,y,z,false,false,true)
	local Type = getElementType(elementHit)
	outputChatBox(tostring(Type))
	return(Type)
 end

function PlayerDetected()
	if not isCursorShowing(localPlayer) then return end
	local PlayerP = TypeDetector()
	if isElement(PlayerP) == "player" then 
		PP()
	end
end

function PP()
	createLight(0)
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