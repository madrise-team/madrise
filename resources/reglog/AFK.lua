local XC,YC,ZC
local radius = 10
local Giga={}

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
		Giga.AFK.init()
	else
		Giga.noAFK.init()
	end	
end

function DELETE() print("БАН") end -- если ты получил бан то следующее предупреждение тебе не понадобится уже
--вместе с баном можно ремувать евент но не знаю нахуя?

function Helper() triggerEvent("TrashDeleter",root) end

Giga.AFK = {
	init = function()
		outputChatBox("Вы долго бездействуете, Вы тут?")
		outputChatBox("Напишите 'yes' в чат иначе кик")
		setTimer(Helper,10000,1)

		addCommandHandler("yes",function()
			removeEventHandler("TrashDeleter",root,DELETE)
			print("сработал анти бан")
			addEventHandler("TrashDeleter",root,DELETE)
		end)
	end
}

Giga.noAFK = {
	init = function()
		print("я живой")
		PlyPos1()
	end
}

addEvent("TrashDeleter",true)
addEventHandler("TrashDeleter",root,DELETE)

PlyPos1()
setTimer(Check,30000,0)

--[[
скелет готов осталось накинуть конечный функционал и добавит фронты 
так же отрегулировать время проверки и расстояние
--]]
--[[
пробовал сделать переключалку чтобы не происходило проверок если плеер двигается но видимо похуй на 
оперативку игроков
--]]
--[[Готова бан система выглядит уебански но при условии того что тебя не кикает пока что 
все работает как надо 
--]]