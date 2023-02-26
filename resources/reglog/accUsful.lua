function usfulAcc()
------------------------------------------------------------------------------------------------------------
function getAccountInfoByNickName(nick,callback) 
	getDbData('accounts','nickname',nick,function(data)
		callback(data[1])
	end)
end

function setAccountColumnByID(id,clumn,value)
	setDbColumnValueByColumnSearch('accounts','id',id,  clumn,value)
end
function setAccountColumn(nick,clumn,value)
	setDbColumnValueByColumnSearch('accounts','nickname',nick,  clumn,value)
end
function getAccountColumn(nick,clumn,callback)
	get1DbColumnData('accounts','nickname',nick, clumn, callback)
end

function setAccountMoney(nickname,mony,type)
	type = type or 'money'  -- Если не указано то просто валюта а не вклад
	if not checkArgs({nickname,mony,type},"setAccountMoney") then return end
	
	setAccountColumn(nickname, type,mony)

	if type ~= "money" then return end -- Если это просто деньги а не вклад или еще шо то надо и на клиенте обновить
	local player = exports.reglog:getPlayerByNickName(nickname)
	if player then
		setPlayerMoney(player,mony)
	end
end
function takeAccountMoney(nickname,count,type)
	type = type or 'money'
	if not checkArgs({nickname,count,type},"takeAccMony") then return end
	local acc = getAccountColumn(nickname,type,function(data)
		local accMoney = data[type]
		accMoney = accMoney - count
		setAccountMoney(nickname,accMoney,type)
	end)
end
function giveAccountMoney(nickname,mony,type)
	type = type or 'money'
	if not checkArgs({nickname,mony,type},"giveAccMony") then return end
	local acc = getAccountColumn(nickname,type,function(data)
		local accMoney = data[type]
		accMoney = accMoney + mony
		setAccountMoney(nickname,accMoney,type)
	end)
end
function swapAccountMoney(nickname,count,fromType1,toType2)
	takeAccountMoney(nickname,count,fromType1)
	giveAccountMoney(nickname,count,toType2)
end


function addToAccountAvtoLink(nickname,avtoID)
	addElmByValueToColumnArray('accounts','nickname',nickname,'vehicles',avtoID)
end
function removeFromAccountAvtoLink(nickname,avtoID)
	removeElmByValueFromColumnArray('accounts','nickname',nickname,'vehicles',avtoID)
end
function addToAccountBizLink(nickname,bizKey)
	addElmByValueToColumnArray('accounts','nickname',nickname,'buzy',bizKey)
end
function removeFromAccountBizLink(nickname,bizKey)
	removeElmByValueFromColumnArray('accounts','nickname',nickname,'buzy',bizKey)
end



function getAccountRoots(nick,callback)
	getAccountColumn(nick,'roots',function(data)
		callback(fromJSON(data.roots) or {})
	end)
end


function setPlayerGroupData(player,groupS)
	setElementData(player,"gruop",groupS)
end
function getPlayerGroupData(player)
	return getElementData(player,"gruop")
end

------------------------------------------------------------------------------------------------------------
end
return usfulAcc