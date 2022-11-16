rlsc = exports.RRL_Scripts					 --
					 --
camera = getCamera()					 --
setCameraTarget(localPlayer)					 --
					 --
					 --
freeTargetCameraModeCollideSkipElementsArray = {}					 --
function enterFreeTergCamMode()					 --
    local playerPos = Vector3(getElementPosition(localPlayer))					 --
    setCameraMatrix(playerPos.x + 5,playerPos.y,playerPos.z + 1,playerPos.x,playerPos.y,playerPos.z)					 --
					 --
    rlsc:showVspomogatCursorS()					 --
					 --
					 --
    local xyRotateAngle = 0					 --
    local yzRotateAngle = 0    					 --
    local sensetivy = 5.5					 --
					 --
    local ender = false					 --
					 --
    freeTargFrameFuc = function()					 --
        local camPos = Vector3(getElementPosition(camera))					 --
        local targetPos = Vector3(getPedBonePosition(localPlayer,4))					 --
        targetPos.z = targetPos.z + 0.1					 --
					 --
        local radis = -5					 --
					 --
        function calcCamPos()					 --
            ---- YZ ----					 --
            camPos = Vector3(0,radis,0)					 --
					 --
            local newY = camPos.y * math.cos(yzRotateAngle) - camPos.z * math.sin(yzRotateAngle)					 --
            local newZ = camPos.y * math.sin(yzRotateAngle) + camPos.z * math.cos(yzRotateAngle)					 --
					 --
            camPos = Vector3(0,newY,newZ)					 --
            ------------					 --
            ---- XY ----					 --
            camPos = Vector3(0,camPos.y,camPos.z)					 --
					 --
            local newX = camPos.x * math.cos(xyRotateAngle) - camPos.y * math.sin(xyRotateAngle)					 --
            local newY = camPos.x * math.sin(xyRotateAngle) + camPos.y * math.cos(xyRotateAngle)					 --
					 --
            camPos = Vector3(newX,newY,camPos.z)					 --
            ------------]]					 --
					 --
            camPos = camPos + targetPos					 --
        end					 --
					 --
        calcCamPos()					 --
        local finded = false					 --
        while not finded do					 --
					 --
            local starter = camPos - targetPos					 --
            starter = starter*1.5					 --
					 --
            starter = starter + targetPos					 --
					 --
            local hit, x, y, z, elementHit = processLineOfSight (starter.x,starter.y,starter.z, targetPos.x,targetPos.y,targetPos.z, true, true, true, true, true, false, false, false,localPlayer)					 --
            if radis >= - 0.3 then finded = true end					 --
            if hit then					 --
                radis = radis + 0.04					 --
                calcCamPos()					 --
            else					 --
                finded = true					 --
            end					 --
        end 					 --
					 --
        local smesC = rlsc:getVspomogatCursorSmes()					 --
					 --
        xyRotateAngle = xyRotateAngle - ((smesC.x/1000)*360) * sensetivy					 --
        yzRotateAngle = yzRotateAngle - ((smesC.y/1000)*360) * sensetivy					 --
					 --
					 --
        if yzRotateAngle > 1 then					 --
            yzRotateAngle = 1 					 --
        end					 --
        if yzRotateAngle < -1.4 then					 --
           yzRotateAngle = -1.4 					 --
        end					 --
					 --
        calcCamPos()					 --
					 --
        setCameraMatrix(camPos.x,camPos.y,camPos.z,targetPos.x,targetPos.y,targetPos.z)					 --
    end					 --
    addEventHandler("onClientPreRender",root,freeTargFrameFuc)					 --
end					 --
function addFreeTargetCameraModeCollideSkipElement(Elm)					 --
    freeTargetCameraModeCollideSkipElementsArray[tostring(Elm)] = Elm					 --
end					 --
function addFreeTargetCameraModeCollideSkipElements(tableOfElmemnts)					 --
    for k,v in pairs(tableOfElmemnts) do					 --
        addFreeTargetCameraModeCollideSkipElement(v)					 --
    end					 --
end					 --
function removeFreeTargetCameraModeCollideSkipElement(Elm)					 --
    freeTargetCameraModeCollideSkipElementsArray[tostring(Elm)] = nil					 --
end					 --
function removeFreeTargetCameraModeCollideSkipElements(Elm)					 --
    for k,v in pairs(tableOfElmemnts) do					 --
        removeFreeTargetCameraModeCollideSkipElement(v)					 --
    end 					 --
end					 --
function enterFreeTargetCameraMode()					 --
    enterFreeTergCamMode()					 --
end					 --
function enterPlayerTargetCameraMode()					 --
    removeEventHandler("onClientPreRender",root,freeTargFrameFuc)					 --
    setCameraTarget(localPlayer)					 --
    exports.RRL_Scripts:showVspomogatCursorS()					 --
end					 --
