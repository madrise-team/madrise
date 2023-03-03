playersStats = {}

-- сохраняемая статистика
dbStats = {  
	"creationDate", 	-- UNIX таймстамп создания
	"timeAtServer", 	-- минут на сервере
	"lastSession", 		-- UNIX таймстамп последней завершенной сессии (выхода) 
	"totalMoneyEarned", -- всего заработано денег    (с вычтиным налогом)
	"totalTaxPaid", 	-- всго денег ушло на налоги 
	"totalMoneySpent", 	-- всего заработано потрачено (с учетом налогов и коммисий)
	"rating", 			-- репутация игрока
	"policeSearch", 	-- розыск игрока
	"achievements", 	-- достижения
	"promos" 			-- активированные промо коды
}
dbStatsColumns = separateItable(dbStats) -- 1й строкой через ,



-- ////////////////////////////////////////////////////////////////////////////////////////////////
-- // Сброс аккуунта  ⚠⚠⚠
-- ////////////////////////////////////////////////////////////////////////////////////////////////
statsToSave = [[
id, login, password, nickname, gender, creationDate, timeAtServer, achievements, promos
]]
	
function resetAccountInfo(id)
	dropRow('accounts','accounts',serachColumnValue)
	
	dbExec(SQLStorage,"DROP ")
end


-- ////////////////////////////////////////////////////////////////////////////////////////////////
-- // Кэширование статистики игроков
-- ////////////////////////////////////////////////////////////////////////////////////////////////

addEvent('playerLogin',true)
addEventHandler('playerLogin',root,function(bdAccount)
	local pS = playersStats[bdAccount.id]
	pS = {
		sessionTime = 0,
		enterTime = getRealTime().timestamp -- для отсчета времени на сервере
	}
	for k,v in pairs(dbStats) do
		pS[v] = bdAccount[v]
	end
end)

-- обновить время на сервере и таймстамп посл. сесии при выходе
addEventHandler("onPlayerQuit",root,function()
	local id = getPlayerID(source)
	updateLastSessionAndTimeAtServer(id,playersStats[id])
	playersStats[id] = nil
end)

-- ////////////////////////////////////////////////////////////////////////////////////////////////
-- // Получение статистики
-- ////////////////////////////////////////////////////////////////////////////////////////////////

function getQuickPlayerStats(id)
	if playersStats[id] then return playersStats[id] end
end
function getPlayerStats(id,callback, stat)
	local stats = getQuickPlayerStats(id)
	if stats then callback(stats) 
	else
		getAccountColumn(id,stat or dbStatsColumns,callback)
	end
end

-- ////////////////////////////////////////////////////////////////////////////////////////////////
-- // Посдсчет времени проведенного на сервере
-- ////////////////////////////////////////////////////////////////////////////////////////////////

function updateLastSessionAndTimeAtServer(id,playerStat)
	setDbColumnValueByColumnSearch('accounts','id',id,'timeAtServer,lastSession', 
		playerStat.timeAtServer + playerStat.sessionTime,
		timestampToSqlFormatt( getRealTime().timestamp))

end

function updateTotalTimeAtServer(id,playerStat)
	setAccountColumnByID(id,'timeAtServer',playerStat.timeAtServer + playerStat.sessionTime)
end

setTimer(function()
	local nowTs = getRealTime().timestamp
	for id,pS in pairs(playersStats) do
		if nowTs - pS.enterTime >= 60 then
			pS.sessionTime = pS.sessionTime + 1

			-- каждые 10 минут обновлять всего времени на сервере в бд
			if pS.sessionTime % 10 == 0 then
				updateTotalTimeAtServer(id,pS)
			end
		end
	end
end,60000,0)


-- ////////////////////////////////////////////////////////////////////////////////////////////////
-- // Достижения
-- ////////////////////////////////////////////////////////////////////////////////////////////////

function addAchievment(id, achivment)
	getPlayerStats(id,function(stats)
		local playerAchievments = fromJSON(stats.achievements)
		for i,v in ipairs(playerAchievments) do
			if v == achivment then
				return  -- Очивка уже есть
			end
		end

		table.insert(playerAchievments, achivment)
		setAccountColumn(id,'achievements', value, toJSON(playerAchievments) )
	end, 'achievements')
end











------------ Deb stats
addCommandHandler('stats',function(player)
	local id  = getPlayerID(player)
	if not id then
		outputDebugString("ERR >> player with no id!!! [stats get commnd]")
		return
	end

	local stats = playersStats[id]
	if not stats then
		outputDebugString("ERR >> player with stats. [stats get commnd]")
		return
	end

	local statsStr = "\n"	
	for k,v in pairs(stats) do
		statsStr = statsStr .. k.." : ".. tostring(v) .. "\n"
	end
	outputChatBox(statsStr, player)
end)