----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server

SQLStorage = exports.DB:MSC()
rglg = exports.reglog
------------------------------------

--///////////////////////////////////////////////////////////////
--  Оперативаная инфа о кеше плееров

playersMoneys = {}

addEvent("playerLogin",true)
addEventHandler("playerLogin",root,function(bdAccount)
	playersMoneys[bdAccount.id] = {
		money = bdAccount.money,
		beznal = bdAccount.beznal,
		vklad = bdAccount.vklad
	}
end)

addEvent("onPlayerQuit",true)
addEventHandler("onPlayerQuit",root,function()
	local id = getPlayerID(source)
	if id then
		playersMoneys[id] = nil
	end
end)

function updateLocalMoneyOPeration(id, monyType, money)
	if playersMoneys[id] then
		playersMoneys[id][monyType] = playersMoneys[id][monyType] + money
		if moneyType == 'money' then
			local player = getPlayerByID(id)
			if not player then return end
			setPlayerMoney(player, playersMoneys[id].money)
		end
	end
end
function setLocalMoney(id, monyType, money)
	if playersMoneys[id] then
		playersMoneys[id][monyType] = 0
		updateLocalMoneyOPeration(id, monyType, money)
	end
end


--///////////////////////////////////////////////////////////////

taxTypes = {} 
taxTypes.incomeTax = {percent = 0.13, title = "Налог на прибыль"} -- [def] Налог на прибыль

function deductTax(money, taxType)
	taxType = taxType or "incomeTax"
	local taxValue = money * taxTypes[taxType].percent
	money = money - taxValue
	return money, taxValue
end


moneyTypes = {'money','beznal','vklad'}
--[[
types:
	1- в налик [def]
	2- на безнал
	3- на счет вклада лучше не переводить, т.к. там есть огран на макс. кол-во денег 
--]]

--выдать деньги игроку с вычетом налога
function payPlayerMoney(id, monyType, taxType, money)
	moneyType = moneyType or moneyTypes[1] 

	local recalculatedMoney, taxMoney = deductTax(money, taxType)

	dbExec(SQLStorage,[[
		UPDATE accounts SET 
			?? = ?? + ?,
			totalMoneyEarned = totalMoneyEarned + ?,
			totalTaxPaid = totalTaxPaid + ?
		WHERE id = ?]],
		moneyType,moneyType, recalculatedMoney,
		recalculatedMoney,
		taxMoney,
		id)

	updateLocalMoneyOPeration(id, monyType, money)
end

-- Забрать деньги у игрока
function takePlayerMoney(id, type, money)
	moneyType = moneyType or moneyTypes[1] 

	dbExec(SQLStorage,[[
		UPDATE accounts SET 
			?? = ?? - ?,
			totalMoneySpent = totalMoneySpent + ?
		WHERE id = ?]],
		monyType,monyType, money,
		money,
		id)

	updateLocalMoneyOPeration(id, monyType, -money)
end


-- информация о деньгах на аккаунте
function getAccountMoneyInfo(id, callback)
	getAccountColumnByID(id, callback, separatePack(moneyTypes[1],moneyTypes[2],moneyTypes[3]))
end

-- информация о деньгах игрока на сервере
function getPlayerMoneyQuickInfo(id,monyType)
	if playersMoneys[id] then return playersMoneys[id] end
end