function usfulDB()
-------------------------------------------------------------------------------------------------------------------------------------
SQLStorage = exports.DB:MSC()


function stringFromArayDbFormatt(array)
    local str = "("	
    for k,v in pairs(array) do
        str = str..v..","
    end
    str = str:sub(1,#str - 1)
    str = str..")"

    return str
end

--////////////////////////////////////////////////////////////////////////////////////////////////////
--  classic data 
--////////////////////////////////////////////////////////////////////////////////////////////////////


function getCustomSqlQuery(query, callback, ...)

	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,query, unpack({...}) )
end


-- return {1:{row}, 2:{row}}
function getDbDataFromArray(aTable,serachColumn,valuesArray,callback)			--- Поиск по массиву совпадений (Where in array)
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??` WHERE `??` IN ??",aTable,serachColumn,stringFromArayDbFormatt(valuesArray))

end


function setDbData(aTable,serachColumn,serachColumnValue,column,value)
	dbExec(SQLStorage,"UPDATE `??` SET `??` = ?  WHERE (`??` = ?)",aTable,column,value,serachColumn,serachColumnValue)
end


-- return {1:{column}, 2:{column}}
function getDbColumnData(aTable,serachColumn,serachColumnValue,column,callback) -- 1 столбец вместо всех строки
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT `??` FROM `??` WHERE (`??` = ?)",column,aTable,serachColumn,serachColumnValue)
end

-- return {column}
function get1DbColumnData(aTable,serachColumn,serachColumnValue,column,callback)
	getDbColumnData(aTable,serachColumn,serachColumnValue,column,function(data)
		data = data or {}
		callback(data[1])
	end)
end

-- return {1:{row}, 2:{row}}
function getDbData(aTable,serachColumn,value,callback) -- вся строка всех встрок
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??` WHERE (`??` = ?)",aTable,serachColumn,value)
end

-- return {row}
function get1DbData(aTable,serachColumn,value,callback)
	getDbData(aTable,serachColumn,value,function(data)
		data = data or {}
		callback(data[1])
	end)
end

-- return {row1,row2,row3}
function getDbRows(aTable,callback) -- все строки таблицы
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??`",aTable)
end


--////////////////////////////////////////////////////////////////////////////////////////////////////
--  Limited data 
--////////////////////////////////////////////////////////////////////////////////////////////////////

-- return { rowFrom:{column} -- (rowFrom+rowCount):{column} }
function getLimitedDbColumnRows(aTable,column,rowFrom,rowCount,callback) 
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT `??` FROM `??` LIMIT ?, ?",column,aTable,rowFrom,rowCount)
end

-- return { rowFrom:{row} -- (rowFrom+rowCount):{row} }
function getLimitedDbRows(aTable,rowFrom,rowCount,callback) -- все строки от до
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??` LIMIT ?, ?",aTable,rowFrom,rowCount)
end

-- return { rowFrom:{column} -- (rowFrom+rowCount):{column} }
function getLimitedDbColumnData(aTable,column,serachColumn,value,rowFrom,rowCount,callback) -- столбцы строк от до с условием
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT `??` FROM `??` WHERE (`??` = ?) LIMIT ?, ?",column,aTable,serachColumn,value,rowFrom,rowCount)
end

-- return { rowFrom:{row} -- (rowFrom+rowCount):{row} }
function getLimitedDbData(aTable,serachColumn,value,rowFrom,rowCount,callback) -- строки от до
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,"SELECT * FROM `??` WHERE (`??` = ?) LIMIT ?, ?",aTable,serachColumn,value,rowFrom,rowCount)
end


function setDbColumnValueByColumnSearch(aTable,serachColumn,serachColumnValue,updateColumn,updateColumnValue)
	dbExec(SQLStorage,"UPDATE `??` SET `??` = ? WHERE `??` = ?",aTable,updateColumn,updateColumnValue,serachColumn,serachColumnValue)
end


-- return rowsCount
function getTableRowsCount(aTable,callback)
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)[1]["COUNT(*)"]) end
	end,SQLStorage,"SELECT COUNT(*) FROM `??`",aTable)
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
------------------------------------------------------------------------------------------------------------------


--////////////////////////////////////////////////////////////////////////////////////////////////////
--    Join Data 
--//

function getDbJoinedData(aTable, columns, jonTable,joinCondition,whereCondition, callback)
	local qh
	qh = dbQuery(function()
		if type(callback)=='function' then callback(dbPoll(qh,0)) end
	end,SQLStorage,[[
		SELECT 
    		??
    	FROM
    		??
		INNER JOIN 
			??
		ON ]]..joinCondition
		.." WHERE "..whereCondition
		,column,aTable,jonTable)
end

-------------------------------------------------------------------------------------------------------------------------------------
end
return usfulDB