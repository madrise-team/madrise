
local afk = false
local def = false
local remember = {}

function PlyPos1 ()
	local x,y,z = getElementPosition(localPlayer)
	local sum1 = x + y + z
	remember[1] = sum1
end

function PlyPos2 ()
	local x1,y1,z1 = getElementPosition(localPlayer)
	local sum2 = x1 + y1 + z1
	return sum2
end	

function Check1 ()
	local plyPos1 = remember[1]
	local plyPos2 = PlyPos2()
	if plyPos1 == plyPos2 then
		afk = true
	else
		print("я живой")
	end	
	return afk
end

function Check ()
	local def = Check1()	
	if def then 
		print("ты тут?")
		afk = false
		def = false
		remember[1] = nil
	end	
end

function timer()
	setTimer(PlyPos1,3000,1)
	setTimer(Check,5000,1)
end

setTimer(timer, 6000, 0)	

--[[
Происходит проверка шевеления игрока каждые 11 секунд 
Если игрок стоит в течении 11 секунд то ему пишется что он стоит 
если он шевелится во время проверки то пишется что он живой и проверка обновляется 
ТРЕБУЕТСЯ ОТЛАЖИВАНИЕ И НАСТРОЙКА А ЕЩЕ КОД ГРЯЗНЫЙ ШО ПИЗДЕЦ!!!!
--]]







--[[
Есть точка где встал плеер вокруг него очерчивается круг радиусом 5 метров 
проводится проверка положения плеера если плеер находится внутри куруга ? минут 
то ему приходит сообщение что он гей он игнорит его кикает или если плеер съебывает из круга 
то круг обновляется система хуйня но сделать надо
--]]