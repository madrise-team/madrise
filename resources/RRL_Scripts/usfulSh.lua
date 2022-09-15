function usfulSh()
------------------------------------------------------------------------------------------------------------
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