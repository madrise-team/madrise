
local afk = false
local def = false
local bool = false
local mas = {}

function time(bool)
	local x,y,z = getElementPosition(localPlayer)
	local sum = x + y + z
	mas[1] = sum
end

function ff ()
	local x1,y1,z1 = getElementPosition(localPlayer)
	local sum1 = mas[1]
	local sum2 = x1 + y1 + z1
	if sum2 == sum1 then
		afk = true
	else
		print("я живой")
	end	
	return afk
end	

function oo ()
	local def = ff()	
	if def then 
		print("ты тут?")
		afk = false
		def = false
		mas[1] = nil
	end	
end

function timer()
	setTimer(time,3000,1)
	setTimer(oo,5000,1)
end

setTimer(timer, 6000, 0)	

--[[
Есть точка где встал плеер вокруг него очерчивается круг радиусом 5 метров 
проводится проверка положения плеера если плеер находится внутри куруга ? минут 
то ему приходит сообщение что он гей он игнорит его кикает или если плеер съебывает из круга 
то круг обновляется система хуйня но сделать надо
--]]