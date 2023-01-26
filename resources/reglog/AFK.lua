local XC,YC,ZC
local radius = 10

function PlyPos1 ()
	local x,y,z = getElementPosition(localPlayer) -- Позиция игрока до начала проверки нахождения его в радиусе афк
	XC,YC,ZC = x,y,z
end

function PlyPos2 ()
	local x1,y1,z1 = getElementPosition(localPlayer) -- Позиция игрока в момент проверки
	return x1,y1,z1
end	

function Check1 ()
	local xc,yc,zc = XC,YC,ZC --центр окружности 
	local xn,yn,zn = PlyPos2()
	local dst = getDistanceBetweenPoints3D(xc,yc,zc,xn,yn,zn)
	if dst < radius then
		afk = true
	else
		afk = false
	end	
	return afk
end

function Check ()
	local afk = Check1()	
	if afk then 
		print("ты тут?") -- Меняется на нужные компоненты 
	else
		print("я живой") -- Меняется на нужные компоненты
		PlyPos1()
	end	
end

PlyPos1()
setTimer(Check,10000,0)

--[[
скелет готов осталось накинуть конечный функционал и добавит фронты 
так же отрегулировать время проверки и расстояние
--]]
--[[
пробовал сделать переключалку чтобы не происходило проверок если плеер двигается но видимо похуй на 
оперативку игроков
--]]