function usfulDB()
-------------------------------------------------------------------------------------------------------------------------------------
SQLStorage = exports.DB:MSC()


function stringFromArayDbFormatt(array)
    local str = "("	
    for k,v in pairs(array) do
        str = str..v..","
    end
    return str:sub(1,#str - 1) .. ")"
end

function getLim(lmtFrom,lmtTo)
	local lmt = ""
	if lmtFrom then lmt = "LIMIT "..lmtFrom..","..lmtTo end
	return lmt 
end

--////////////////////////////////////////////////////////////////////////////////////////////////////
--  helper functs 
--////////////////////////////////////////////////////////////////////////////////////////////////////

-- Установить значение updateColumn у строк где serachColumn == serachColumnValue 
function setDbColumnValueByColumnSearch(aTable,serachColumn,serachColumnValue,updateColumn,...)
	local clms = strsplit(updateColumn,",")
	local values = {...}
	local updateStr = ""
	for i,v in ipairs(clms) do
		updateStr = updateStr.."`"..v.. "`='"..tostring(values[i]).."',"
	end
	updateStr = string.sub(updateStr,0,#updateStr-1)

	dbExec(SQLStorage,"UPDATE ?? SET "..updateStr.." WHERE `??` = ?",
		aTable, serachColumn,serachColumnValue)
end

-- return rowsCount
function getTableRowsCount(aTable,callback)
	getCustomSqlQuery("SELECT COUNT(*) FROM `??`", function(data)
		callback(data[1]["COUNT(*)"])
	end, aTable)
end

function dropRow(aTable,serachColumn,serachColumnValue)
	dbExec(SQLStorage,"DROP FROM ?? WHERE ?? = ?",aTable,serachColumn,serachColumnValue)
end
function insertRow(aTable, clmns, values)
	dbExec(SQLStorage,"INSERT INTO ?? (??) VALUES (??) ",aTable, clmns, values)
end

--////////////////////////////////////////////////////////////////////////////////////////////////////
--  classic data get 
--////////////////////////////////////////////////////////////////////////////////////////////////////

function getCustomSqlQuery(query, callback, ...) --  ... список столбцов выбоки 
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,query, unpack({...}) )
end

-- return {1:{columns}, 2:{columns}}
function getDbColumnData(aTable,serachColumn,serachColumnValue,column,callback, lmtFrom,lmtTo)
	getCustomSqlQuery("SELECT ?? FROM `??` WHERE `??` = ? "..getLim(lmtFrom,lmtTo),
		callback, column, aTable, serachColumn, serachColumnValue)
end
-- return {columns}
function get1DbColumnData(aTable,serachColumn,serachColumnValue,column,callback)
	getDbColumnData(aTable,serachColumn,serachColumnValue,column,function(data)
		callback(data[1])
	end)
end

-- return {1:{row}, 2:{row}}
function getDbData(aTable,serachColumn,serachColumnValue,callback)
	getDbColumnData(aTable,serachColumn,serachColumnValue,"*",callback, lmtFrom,lmtTo)
end
-- return {row}
function get1DbData(aTable,serachColumn,serachColumnValue,callback)
	get1DbColumnData(aTable,serachColumn,serachColumnValue,"*",callback)
end

-- return {table rows}
function getDbRows(aTable,callback, lmtFrom, lmtTo) -- все строки таблицы
	getCustomSqlQuery("SELECT * FROM ?? "..getLim(lmtFrom, lmtTo), callback, aTable)
end

--- Поиск по массиву совпадений (Where in array)
-- return {1:{row}, 2:{row}}
function getDbDataFromArray(aTable,serachColumn,valuesArray,callback) 
	getCustomSqlQuery("SELECT * FROM `??` WHERE `??` IN ??", callback,
	 	aTable, serachColumn, stringFromArayDbFormatt(valuesArray))
end

--////////////////////////////////////////////////////////////////////////////////////////////////////
--    Array clumns 
--//

function elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,operation)
	get1DbColumnData(aTable,serachColumn,serachColumnValue,updateColumn,function(data)
		local theTable
		local colval = data[updateColumn]
		if colval then theTable = tonumberIdnx(fromJSON(colval)) end
		if type(theTable) ~= "table" then theTable = {} end
		theTable = operation(theTable)

		local theTableString = toJSON(theTable,true)
		setDbColumnValueByColumnSearch(aTable,serachColumn,serachColumnValue,updateColumn,theTableString)
	end)
end
function addElmToColumnArray(aTable,serachColumn,serachColumnValue,updateColumn,arrayElmKey,arrayElmValue)
	elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,function(theTable)
		theTable[arrayElmKey] = arrayElmValue
		return theTable
	end)
end
function removeElmFromColumnArray(aTable,serachColumn,serachColumnValue,updateColumn,arrayElmKey)
	elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,function(theTable)
		theTable[arrayElmKey] = nil
		return theTable
	end)
end
function addElmByValueToColumnArray(aTable,serachColumn,serachColumnValue,updateColumn,arrayElmValue)
	elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,function(theTable)
		theTable[#theTable + 1] = arrayElmValue
		return theTable
	end)
end
function removeElmByValueFromColumnArray(aTable,serachColumn,serachColumnValue,updateColumn,arrayElmValue)
	elmColumnArrayOperation(aTable,serachColumn,serachColumnValue,updateColumn,function(theTable)
		for k,v in pairs(theTable) do
			if v == arrayElmValue then
				theTable[k] = nil
				return theTable
			end
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------------
end
return usfulDB