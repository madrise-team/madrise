----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server

SQLStorage = exports.DB:MSC()
------------------------------------

addCommandHandler("convertMoneyToBeznal",function(player,_,count)
	if not tonumber(count) then return end
	local nickname = getPlayerNickName(player)
	swapAccountMoney(nickname,count,"money","beznal")
end)
addCommandHandler("convertBeznalToMoney",function(player,_,count)
	if not tonumber(count) then return end
	local nickname = getPlayerNickName(player)
	swapAccountMoney(nickname,count,"beznal","money")
end)
addCommandHandler("convertBeznalToVklad",function(player,_,count)
	if not tonumber(count) then return end
	local nickname = getPlayerNickName(player)
	swapAccountMoney(nickname,count,"beznal","vklad")
end)
addCommandHandler("convertVkladToBeznal",function(player,_,count)
	if not tonumber(count) then return end
	local nickname = getPlayerNickName(player)
	swapAccountMoney(nickname,count,"vklad","beznal")
end)


---------------UpdateVklady---------------------------------------
function chargeVklad(money)
	local chargedMoney = 0

	if money <= 500000 then
		chargedMoney = money*0.01 + money
	elseif (money > 500000) and (money <= 1000000) then
		chargedMoney = money*0.0075 + money
	elseif (money > 1000000) and (money <= 10000000) then
		chargedMoney = distaer(money)
	elseif money > 1000000 then
		chargedMoney = money + 20000
	end

	return chargedMoney
end

maxProc = 0.55
minProc = 0.2
ubivatDoSummi = 9000000
function distaer(a)
	return ((((maxProc - (maxProc - minProc)*math.sqrt((a-1000000)/ubivatDoSummi)))/100)*a) + a
end

function updateLastUpdateTime()
	local relTime = getRealTime()
	setDbColumnValueByColumnSearch('spec','K','lastVkladyAccrual','V',toJSON({year = relTime.year,yearday = relTime.yearday},true))
end

-------update on start------------
get1DbColumnData('spec','K','lastVkladyAccrual','V',function(data)
	local relTime = getRealTime()

	local lastUpdate = fromJSON(data.V)

	if type(lastUpdate) ~= "table" then
		lastUpdate = {year = relTime.year,yearday = relTime.yearday}
	end

	local updateTimes = getYeardaysDiff(lastUpdate,relTime)
	outputDebugString("-<bnk>-")
	outputDebugString("updateVklady "..updateTimes.." times")

	if updateTimes < 1 then
		updateLastUpdateTime()
		outputDebugString("-</bnk>-")
		return
	end
	getTableRowsCount('accounts',function(rowsCount)
		local rowsBy1cycle = 500
		local cyckles = math.ceil(rowsCount/rowsBy1cycle)

		for i=1,cyckles do
			outputDebugString(">-- cycle "..i.." <------------------------------------------------------")
			getLimitedDbRows('accounts',rowsBy1cycle * (i-1),rowsBy1cycle,function(data)
				for k,acc in pairs(data) do
					local doVklad = acc.vklad
					for i=1,updateTimes do
						acc.vklad = chargeVklad(acc.vklad)
					end
					local posleVklad = math.floor(acc.vklad)
					local ras = (posleVklad - doVklad)
					outputDebugString("updating "..acc.nickname..": do = ["..doVklad.."] posle = ["..posleVklad.."], viplata = <"..ras..">")
					setAccountMoney(acc.nickname,posleVklad,"vklad")
				end
			end)
		end
		updateLastUpdateTime()
		outputDebugString("-</bnk>-")
	end)




end)
------------------------------------------------------------------