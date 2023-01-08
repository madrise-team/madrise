function usfulDB()
-------------------------------------------------------------------------------------------------------------------------------------

function stringFromArayDbFormatt(array)
    local str = "("	
    for k,v in pairs(array) do
        str = str..v..","
    end
    str = str:sub(1,#str - 1)
    str = str..")"

    return str
end

function isRowExists(aTable,serachColumn,serachColumnValue,callback)
	local qh
	qh = dbQuery(function()
		local dat = dbPoll(qh,0)
		for k,v in pairs(dat[1]) do
			if type(callback)=='function' then callback(v) end
			return	
		end
	end,SQLStorage,"SELECT EXISTS(SELECT ?? FROM ?? WHERE ?? = ??)", serachColumn,aTable,serachColumn,serachColumnValue)
end

function getDbDataFromArray(aTable,serachColumn,valuesArray,callback)			--- Поиск по массиву совпадений (Where in array)
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??` WHERE `??` IN ??",aTable,serachColumn,stringFromArayDbFormatt(valuesArray))
end

function getDbColumnData(aTable,serachColumn,serachColumnValue,column,callback) -- только 1 столбец вместо всей строки
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT `??` FROM `??` WHERE (`??` = ?)",column,aTable,serachColumn,serachColumnValue)
end
function get1DbColumnData(aTable,serachColumn,serachColumnValue,column,callback)
	getDbColumnData(aTable,serachColumn,serachColumnValue,column,function(data)
		data = data or {}
		callback(data[1])
	end)
end
function getDbData(aTable,serachColumn,value,callback) -- вся строка всех встрок
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??` WHERE (`??` = ?)",aTable,serachColumn,value)
end
function get1DbData(aTable,serachColumn,value,callback)
	getDbData(aTable,serachColumn,value,function(data)
		data = data or {}
		callback(data[1])
	end)
end
function getDbRows(aTable,callback) -- все строки таблицы
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??`",aTable)
end

function removeDbDataByColumnSearch(aTable,serachColumn,value)
	dbExec(SQLStorage,"DELETE FROM `??` WHERE (`??` = ?)",aTable,serachColumn,value)
end



function getLimitedDbColumnRows(aTable,column,rowFrom,rowCount,callback) -- все столбцы строк от до
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT `??` FROM `??` LIMIT ?, ?",column,aTable,rowFrom,rowCount)
end
function getLimitedDbRows(aTable,rowFrom,rowCount,callback) -- все строки от до
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??` LIMIT ?, ?",aTable,rowFrom,rowCount)
end
function getLimitedDbColumnData(aTable,column,serachColumn,value,rowFrom,rowCount,callback) -- столбцы строк от до с условием
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT `??` FROM `??` WHERE (`??` = ?) LIMIT ?, ?",column,aTable,serachColumn,value,rowFrom,rowCount)
end
function getLimitedDbData(aTable,serachColumn,value,rowFrom,rowCount,callback) -- строки от до
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??` WHERE (`??` = ?) LIMIT ?, ?",aTable,serachColumn,value,rowFrom,rowCount)
end





function setDbColumnValueByColumnSearch(aTable,serachColumn,serachColumnValue,updateColumn,updateColumnValue)
	dbExec(SQLStorage,"UPDATE `??` SET `??` = ? WHERE `??` = ?",aTable,updateColumn,updateColumnValue,serachColumn,serachColumnValue)
end

function getTableRowsCount(aTable,callback)
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)[1]["COUNT(*)"]) end
	end,SQLStorage,"SELECT COUNT(*) FROM `??`",aTable)
end



----------------------------------------------------------------------------------Array clumns -------------------
function elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,operation)
	get1DbData(aTable,serachColumn,serachColumnValue,function(data)
		local theTable
		local colval = data[updateColumn]
		if colval then theTable = tonumberIdnx(fromJSON(colval)) end
		theTable = operation(theTable)

		local theTableString = toJSON(theTable,true)
		setDbColumnValueByColumnSearch(aTable,serachColumn,serachColumnValue,updateColumn,theTableString)
	end)
end
function addElmToColumnArray(aTable,serachColumn,serachColumnValue,updateColumn,arrayElmKey,arrayElmValue)
	elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,function(theTable)
		if type(theTable) ~= "table" then theTable = {} end
		theTable[arrayElmKey] = arrayElmValue
		return theTable
	end)
end
function removeElmFromColumnArray(aTable,serachColumn,serachColumnValue,updateColumn,arrayElmKey)
	elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,function(theTable)
		if type(theTable) ~= "table" then return end
		theTable[arrayElmKey] = nil
		return theTable
	end)
end
function addElmByValueToColumnArray(aTable,serachColumn,serachColumnValue,updateColumn,arrayElmValue)
	elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,function(theTable)
		if type(theTable) ~= "table" then theTable = {} end

		theTable[#theTable + 1] = arrayElmValue

		return theTable
	end)
end
function removeElmByValueFromColumnArray(aTable,serachColumn,serachColumnValue,updateColumn,arrayElmValue)
	elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,function(theTable)
		if type(theTable) ~= "table" then return end
		for k,v in pairs(theTable) do
			if v == arrayElmValue then
				theTable[k] = nil
				return theTable
			end
		end
	end)
end
------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------
end
return usfulDB