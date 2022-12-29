function usfulSh()
------------------------------------------------------------------------------------------------------------


function tocolorT(colT,r,g,b,a)
    return tocolor(maxer(r or colT.r,255),maxer(g or colT.g,255),maxer(b or colT.b,255),maxer(a or colT.a,255))
end

function maxerColor(colT)
    colT.r = maxer(colT.r or 0,255)
    colT.g = maxer(colT.g or 0,255)
    colT.b = maxer(colT.b or 0,255)
    colT.a = maxer(colT.a or 0,255)

    return colT
end

function insertInTabOrCreate(tab,value,index)
    tab = tab or {}
    index = index or (#tab + 1)
    tab[index] = value
    return tab
end

function getTimeToEnd(endTime)
    local nowTime = getRealTime().timestamp


    local res = {
        hours = 0,
        mins = 0,
        secs = 0
    }

    if nowTime > endTime then
        return res
    end

    local diif = endTime - nowTime

    
    res.hours = math.floor(diif / 3600)
    res.mins = math.floor((diif % 3600)/60)
    res.secs =  diif % 60

    return res
end


function timerDebTrigger()
    local name = getResourceName(getThisResource())
    if triggerClientEvent then triggerClientEvent("tat",root,createdTimers,name) end
end

local createdTimersCount = 0
local createdTimers = {}
local needToRemoveTimers = {}
setTimer(function()                                 --- кастомные таймеры    
    if createdTimersCount < 1 then return end

    local curtime = getRealTime().timestamp

    for crtIndx,v in pairs(createdTimers) do
        if not v.deleted then
            if curtime >= (v.timerEndTime) then
                removeTimer(crtIndx)
                if v.callback then v.callback() end
            end
        end
    end

    local helpArray = {}
    for k,indx in pairs(needToRemoveTimers) do
        createdTimers[ indx ] = nil
        table.insert(helpArray,k)
        createdTimersCount = createdTimersCount - 1 
        
        --timerDebTrigger()
    end
    for k,v in pairs(helpArray) do
        needToRemoveTimers[v] = nil    
    end

end,1900,0)

function createTimer(hours,mins,secs,callback)
    local starTime = getRealTime()
    hours = hours or 0
    mins = mins or 0
    secs = secs or 0

    local totalMins = mins + hours*60
    local totalSecs = secs + totalMins*60

    local timerIndex = #createdTimers + 1

    createdTimers[timerIndex] = {timerEndTime = starTime.timestamp + totalSecs,callback = callback}
    createdTimersCount = createdTimersCount + 1

    --timerDebTrigger()

    return timerIndex, createdTimers[timerIndex], createdTimers[timerIndex].timerEndTime
end
function removeTimer(timerIndex)
    createdTimers[timerIndex].deleted = true
    table.insert(needToRemoveTimers,timerIndex)
end


function isInPolygon(poly,point)
    local inPol = false

    for i=1,#poly do
        local nexp = i+1
        if i == #poly then nexp = 1 end
    
        slp = {x = poly[i].x,y = poly[i].y}
        elp = {x = poly[nexp].x,y = poly[nexp].y}


        local minXp = slp; local maxXp = elp
        local minYp = slp; local maxYp = elp

        if elp.x < slp.x then
            minXp = elp
            maxXp = slp
        end
        if elp.y < slp.y then
            minYp = elp
            maxYp = slp
        end

        local xR = maxXp.x - minXp.x

        local yRotn = (point.y - minYp.y)/(maxYp.y - minYp.y)
        if(maxYp.x < minYp.x) then
            yRotn = 1-yRotn
        end

        local needX = minXp.x + xR*yRotn
        if (point.x > needX) and (point.y > minYp.y) and (point.y < maxYp.y) then       
            inPol = not inPol
        end
    end 
    return inPol
end

function randomSort(origt)           --///// randomise index table
    local result = {}

    local allowedIndexes = {}

    for k,_ in pairs(origt) do
        allowedIndexes[#allowedIndexes + 1] = k
    end

    for k,origtV in pairs(origt) do
        local rnd = math.random(1,#allowedIndexes)
        local randIndex = allowedIndexes[rnd]
        result[randIndex] = origtV
        table.remove(allowedIndexes,rnd)
    end

    return result
end

function strsplit(inputstr, sep)
        if not inputstr then return end
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function fadeAlpha(element, time, dir)
	local time = time or 5000
	local dir = dir or 1
	local deltaTime = 60

	local steps =  math.ceil(time/deltaTime)
	local changeAlpha = math.floor(255/steps)
	setTimer(function()
		local newAlpha = getElementAlpha(element) - changeAlpha*dir
		if newAlpha < 0 then newAlpha = 0 end
		setElementAlpha(element, newAlpha)
	end, deltaTime, steps)
end

function getMatrix(elm)
	return Matrix(Vector3(getElementPosition(elm)),Vector3(getElementRotation(elm)))
end

function getNumberSign(number)
	return (number / math.abs(number) )
end

function shallowcopy(orig)
    if not orig then return {} end
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function rpairs(t)
    return function(t, i)
        i = i - 1
        if i ~= 0 then
            return i, t[i]
        end
    end, t, #t + 1
end

function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end
function copyTable(obj, seen)
    if not obj then return {} end
    
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

function findClosestElmInArray(array,pointVec3_or_x,y,z)
    if not pointVec3_or_x then return end

    local point = pointVec3_or_x
    if pointVec3_or_x and y and z then
        point = Vector3(pointVec3_or_x,y,z)
    end

    local closestK
    local closestDist = 100000
    for k,v in pairs(array) do
        local elmPos = Vector3(getElementPosition(v))
        local checkDist = getDistanceBetweenPoints3D(point.x, point.y, point.z, elmPos.x, elmPos.y, elmPos.z)

        if checkDist < closestDist then
            closestDist = checkDist
            closestK = k
        end
    end

    if closestK then 
        return array[closestK]
    else return false end
end

function resetPedAnim(ped)
   setPedAnimation(ped,"BSKTBALL","BBALL_idle_O",-1,false,false,false,true)
end

function createMaxerFuc(maxNumn)
  local maxerBakedFuc = function(chislo)
    local afterMaxer = chislo
    if chislo > maxNumn then
      afterMaxer = maxNumn
    end
    return afterMaxer
  end
  return maxerBakedFuc
end
function maxer(ch,maxCh)
    local chech = ch
    if ch == nil then 
        outputDebugString("WAR: nil ch in Maxer usfulSh")
        return 
    end
    if maxCh == nil then 
        outputDebugString("WAR: nil maxCh in Maxer usfulSh")
        return 
    end
    if ch > maxCh then
        chech = maxCh
    end
    return chech
end
function miner(ch,minCh)
    local chech = ch
    if ch == nil then 
        outputDebugString("WAR: nil ch in Miner usfulSh")
        return 
    end
    if minCh == nil then 
        outputDebugString("WAR: nil minCh in Miner usfulSh")
        return 
    end
    if ch < minCh then
        chech = minCh
    end
    return chech
end
function maxMiner(ch,minCh,maxCh)
    local chech = ch

    chech = miner(chech,minCh)
    if chech == nil then outputDebugString("AAA") end
    chech = maxer(chech,maxCh)
    return chech
end

function getVehicleNearestToElementAtRange(element,range)
    local positX,positY,positZ = getElementPosition(element)

    range = range or 50000

    local nirestVeh
    local nirestDist = range
    for k,v in pairs(getElementsByType("vehicle")) do
        local xyx,yuy,zaz = getElementPosition(v)
        local chDist = getDistanceBetweenPoints3D ( positX, positY, positZ, xyx, yuy, zaz)
        if chDist < nirestDist then
            nirestDist = chDist
            nirestVeh = v
        end
    end

    return nirestVeh
end

function getPlayerNickName(player)
    if not player then return end
    local data = getElementData(player,"playerData")
    if not data then return "error to take player data!! (NickName taking)" end
    return data.nickname
end

function tonumberIdnx(tab)
    if type(tab) ~= "table" then return tab end

    for k,v in pairs(tab) do
        if tonumber(k) and (type(k) ~= "number") then
            tab[tonumber(k)] = v
            tab[k] = nil
        end
    end
    return tab
end
function defragTabIndx(tab)
    if type(tab) ~= "table" then return tab end

    local defragTab = {}
    for k,v in pairs(tab) do
        if type(k) ~= "number" then
            defragTab[k] = v
        else
            defragTab[#defragTab + 1] = v
        end
    end
    return defragTab
end
function tableCount(tab)
    local count = 0
    local lastK = 0
    for k,v in pairs(tab) do
        count = count + 1
        lastK = k
    end
    return count,lastK
end
function toBool(varible)
    if type(varible) == "number" then
        if varible == 1 then
            return true
        elseif varible == 0 then
            return false
        end
    else
        if varible then
            return true
        else
            return false
        end
    end
end
function checkArgs(arsArray,name)
    name = name or ""
    for i=1,#arsArray do
        if not arsArray[i] then 
            outputDebugString("ERROR! № "..i.." argument in "..name.."  not setted!")
            return
        end
    end
    return true
end


function getYeardaysDiff(time1,time2)    
    local daysT1 = (time1.year * 365) + math.floor(time1.year/4) + time1.yearday
    local daysT2 = (time2.year * 365) + math.floor(time2.year/4) + time2.yearday

    return daysT2 - daysT1
end

function fromColor(color)
    if color then
        local blue = bitExtract(color, 0, 8)
        local green = bitExtract(color, 8, 8)
        local red = bitExtract(color, 16, 8)
        local alpha = bitExtract(color, 24, 8)
        
        return {r = red,g = green,b = blue,a = alpha }
    end
end
------------------------------------------------------------------------------------------------------------
end
return usfulSh