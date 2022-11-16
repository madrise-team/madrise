function usfulC()					 --
------------------------------------------------------------------------------------------------------------					 --
function CameraFadingAnimation(FadeTime,timeInFade,red,green,blue)					 --
	FadeTime = FadeTime or 1000					 --
	timeInFade = timeInFade or 1000					 --
					 --
	fadeCamera (false,FadeTime/1000,red,green,blue)					 --
	setTimer(function()					 --
		fadeCamera(true,FadeTime/1000)					 --
	end,FadeTime + timeInFade,1)					 --
end					 --
					 --
					 --
clientElements = {}					 --
					 --
					 --
function isPedAiming (thePedToCheck)					 --
    if isElement(thePedToCheck) then					 --
        if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then					 --
            if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" or isPedDoingGangDriveby(thePedToCheck) then					 --
                return true					 --
            end					 --
        end					 --
    end					 --
    return false					 --
end					 --
					 --
					 --
function getPositionFromElementOffset(element,offX,offY,offZ)					 --
    local m = getElementMatrix ( element )  -- Get the matrix					 --
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform					 --
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]					 --
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]					 --
    return Vector3(x, y, z)                               -- Return the transformed point					 --
end					 --
					 --
function getMatrixLeft(matrixLeftUC)					 --
    return matrixLeftUC[1][1], matrixLeftUC[1][2], matrixLeftUC[1][3]					 --
end					 --
function getMatrixForward(matrixForwardUC)					 --
    return matrixForwardUC[2][1], matrixForwardUC[2][2], matrixForwardUC[2][3]					 --
end					 --
function getMatrixUp(matrixUpUC)					 --
    return matrixUpUC[3][1], matrixUpUC[3][2], matrixUpUC[3][3]					 --
end					 --
function getMatrixPosition(matrixPosUC)					 --
    return matrixPosUC[4][1], matrixPosUC[4][2], matrixPosUC[4][3]					 --
end					 --
					 --
function getNsElementMatrix(element)        -- not Streamble Element Matrix					 --
    local rx, ry, rz = getElementRotation(element, "ZXY")					 --
    rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)					 --
    local matrix = {}					 --
    matrix[1] = {}					 --
    matrix[1][1] = math.cos(rz)*math.cos(ry) - math.sin(rz)*math.sin(rx)*math.sin(ry)					 --
    matrix[1][2] = math.cos(ry)*math.sin(rz) + math.cos(rz)*math.sin(rx)*math.sin(ry)					 --
    matrix[1][3] = -math.cos(rx)*math.sin(ry)					 --
    matrix[1][4] = 1					 --
    					 --
    matrix[2] = {}					 --
    matrix[2][1] = -math.cos(rx)*math.sin(rz)					 --
    matrix[2][2] = math.cos(rz)*math.cos(rx)					 --
    matrix[2][3] = math.sin(rx)					 --
    matrix[2][4] = 1					 --
    					 --
    matrix[3] = {}					 --
    matrix[3][1] = math.cos(rz)*math.sin(ry) + math.cos(ry)*math.sin(rz)*math.sin(rx)					 --
    matrix[3][2] = math.sin(rz)*math.sin(ry) - math.cos(rz)*math.cos(ry)*math.sin(rx)					 --
    matrix[3][3] = math.cos(rx)*math.cos(ry)					 --
    matrix[3][4] = 1					 --
    					 --
    matrix[4] = {}					 --
    matrix[4][1], matrix[4][2], matrix[4][3] = getElementPosition(element)					 --
    matrix[4][4] = 1					 --
    					 --
    return matrix					 --
end					 --
					 --
					 --
					 --
					 --
					 --
attBoneElms = {}					 --
function attachedElementToBoneProcessing(element, ped, bone, offX, offY, offZ, offrX, offrY, offrZ)					 --
        local boneMat = getElementBoneMatrix(ped, bone)					 --
        local sroll, croll, spitch, cpitch, syaw, cyaw = math.sin(offrZ), math.cos(offrZ), math.sin(offrY), math.cos(offrY), math.sin(offrX), math.cos(offrX)					 --
        local rotMat = {					 --
            {sroll * spitch * syaw + croll * cyaw,					 --
            sroll * cpitch,					 --
            sroll * spitch * cyaw - croll * syaw},					 --
            {croll * spitch * syaw - sroll * cyaw,					 --
            croll * cpitch,					 --
            croll * spitch * cyaw + sroll * syaw},					 --
            {cpitch * syaw,					 --
            -spitch,					 --
            cpitch * cyaw}					 --
        }					 --
        local finalMatrix = {					 --
            {boneMat[2][1] * rotMat[1][2] + boneMat[1][1] * rotMat[1][1] + rotMat[1][3] * boneMat[3][1],					 --
            boneMat[3][2] * rotMat[1][3] + boneMat[1][2] * rotMat[1][1] + boneMat[2][2] * rotMat[1][2],-- right					 --
            boneMat[2][3] * rotMat[1][2] + boneMat[3][3] * rotMat[1][3] + rotMat[1][1] * boneMat[1][3],					 --
            0},					 --
            {rotMat[2][3] * boneMat[3][1] + boneMat[2][1] * rotMat[2][2] + rotMat[2][1] * boneMat[1][1],					 --
            boneMat[3][2] * rotMat[2][3] + boneMat[2][2] * rotMat[2][2] + boneMat[1][2] * rotMat[2][1],-- front 					 --
            rotMat[2][1] * boneMat[1][3] + boneMat[3][3] * rotMat[2][3] + boneMat[2][3] * rotMat[2][2],					 --
            0},					 --
            {boneMat[2][1] * rotMat[3][2] + rotMat[3][3] * boneMat[3][1] + rotMat[3][1] * boneMat[1][1],					 --
            boneMat[3][2] * rotMat[3][3] + boneMat[2][2] * rotMat[3][2] + rotMat[3][1] * boneMat[1][2],-- up					 --
            rotMat[3][1] * boneMat[1][3] + boneMat[3][3] * rotMat[3][3] + boneMat[2][3] * rotMat[3][2],					 --
            0},					 --
            {offX * boneMat[1][1] + offY * boneMat[2][1] + offZ * boneMat[3][1] + boneMat[4][1],					 --
            offX * boneMat[1][2] + offY * boneMat[2][2] + offZ * boneMat[3][2] + boneMat[4][2],-- pos					 --
            offX * boneMat[1][3] + offY * boneMat[2][3] + offZ * boneMat[3][3] + boneMat[4][3],					 --
            1}					 --
        }					 --
        setElementMatrix(element, finalMatrix)					 --
					 --
        return true					 --
end					 --
					 --
function attachElementToBone(element, ped, bone, offX, offY, offZ, offrX, offrY, offrZ)					 --
    removeElementFromBone(element)					 --
					 --
	local fuc = function()					 --
        local aTo = attBoneElms[tostring(element)].offsets					 --
							 --
        if aTo.new then					 --
            aTo.offX = aTo.offX + aTo.new.offX					 --
            aTo.offY = aTo.offY + aTo.new.offY					 --
            aTo.offZ = aTo.offZ + aTo.new.offZ					 --
            aTo.offrX = aTo.offrX + aTo.new.offrX					 --
            aTo.offrY = aTo.offrY + aTo.new.offrY					 --
            aTo.offrZ = aTo.offrZ + aTo.new.offrZ					 --
					 --
            aTo.new.interFrames = aTo.new.interFrames - 1					 --
            if aTo.new.interFrames <= 0 then aTo.new = nil end					 --
        end					 --
					 --
        attachedElementToBoneProcessing(element, ped, bone, 					 --
            aTo.offX, aTo.offY, aTo.offZ,					 --
            aTo.offrX, aTo.offrY, aTo.offrZ)					 --
	end					 --
	local destroyFunc = function()					 --
		removeElementFromBone(element)					 --
	end					 --
    local dimIntFunc = function(dim,int)					 --
        setElementDimension(element,dim)					 --
        setElementInterior(element,int)					 --
    end					 --
					 --
    attBoneElms[tostring(element)] = {fuc,destroyFunc,dimIntFunc,ped = ped,					 --
        offsets = {					 --
            offX = offX, offY = offY, offZ = offZ,					 --
            offrX = offrX, offrY = offrY, offrZ = offrZ					 --
        }					 --
    }					 --
					 --
    addEventHandler("onClientPedsProcessed",root, fuc)					 --
	addEventHandler("onElementDestroy",element, destroyFunc)					 --
    addEventHandler("elmDimIntChanged",ped, dimIntFunc)					 --
end					 --
function removeElementFromBone(element)					 --
	if attBoneElms[tostring(element)] then					 --
		removeEventHandler("onClientPedsProcessed",root, attBoneElms[tostring(element)][1])					 --
        removeEventHandler("onElementDestroy",element, attBoneElms[tostring(element)][2])					 --
        removeEventHandler("elmDimIntChanged",attBoneElms[tostring(element)].ped, attBoneElms[tostring(element)][3])					 --
		attBoneElms[tostring(element)] = nil					 --
	end					 --
end					 --
function setAttachedElementToBoneOffsets(element,noffX, noffY, noffZ, noffrX, noffrY, noffrZ, interpolation)					 --
    interpolation = interpolation or 1					 --
    if attBoneElms[tostring(element)] then					 --
        local aTo = attBoneElms[tostring(element)].offsets					 --
					 --
        aTo.new = {interFrames = interpolation}					 --
         aTo.new.offX = (noffX - aTo.offX)/interpolation					 --
         aTo.new.offY = (noffY - aTo.offY)/interpolation					 --
         aTo.new.offZ = (noffZ - aTo.offZ)/interpolation					 --
         aTo.new.offrX = (noffrX - aTo.offrX)/interpolation					 --
         aTo.new.offrY = (noffrY - aTo.offrY)/interpolation					 --
         aTo.new.offrZ = (noffrZ - aTo.offrZ)/interpolation					 --
    else					 --
        outputDebugString("attBoneElmError: no attBoneElms[tostring(element)]")					 --
    end					 --
end					 --
					 --
function interpolateAttachedElementToBoneOffsets()					 --
    					 --
end					 --
					 --
					 --
					 --
					 --
function serverRequest(eventName,waitTime,element,answerElm,args,callback,errCallback)					 --
    triggerServerEvent (eventName, element, args)					 --
					 --
    local answerElment = answerElm or root					 --
					 --
    local removeTimer					 --
    local answeFuc					 --
    waitTime = waitTime or 50					 --
    local removeFuc = function()					 --
        removeEventHandler(eventName,answerElment,answeFuc)					 --
        if removeTimer then					 --
            killTimer(removeTimer); removeTimer = nil					 --
        end					 --
    end					 --
    answeFuc = function(ansArgs)					 --
        callback(ansArgs)					 --
        removeFuc()					 --
    end					 --
    addEventHandler(eventName,answerElment,answeFuc)					 --
					 --
    if type(waitTime) == "number" then					 --
        removeTimer = setTimer(function()					 --
            removeFuc()					 --
            errCallback()					 --
        end,waitTime,1)					 --
    end					 --
end					 --
					 --
					 --
					 --
function ESCskipper(but)					 --
    if but == "escape" then					 --
        outputChatBox("gggga")					 --
        cancelEvent()					 --
        ESCskipperFuc()					 --
    end					 --
end					 --
ESCskipperCreated = false					 --
ESCskipperFuc = nil					 --
					 --
function createECSskipper(fucer)					 --
    if not ESCskipperCreated then					 --
        addEventHandler("onClientKey",root,ESCskipper)					 --
        ESCskipperCreated = true					 --
        ESCskipperFuc = fucer					 --
    end					 --
end					 --
function deleteECSskipper()					 --
    if ESCskipperCreated then					 --
        removeEventHandler("onClientKey",root,ESCskipper)					 --
        ESCskipperCreated = false					 --
        ESCskipperFuc = nil					 --
    end					 --
end					 --
					 --
local frameWaiters = {}					 --
function frameWait(frames,callback,key)					 --
    if key then					 --
        if frameWaiters[key] then					 --
            frameWaiters[key].remove()					 --
            frameWaiters[key] = nil					 --
        end					 --
    end					 --
					 --
					 --
    local frameN = 0					 --
    local waiterF					 --
    local remover = function()					 --
        removeEventHandler("onClientRender",root,waiterF)					 --
    end					 --
    waiterF = function()					 --
        frameN = frameN + 1					 --
        if frameN > frames then					 --
            callback()					 --
            remover()					 --
        end					 --
    end					 --
    addEventHandler("onClientRender",root,waiterF)					 --
					 --
    if key then frameWaiters[key] = {remove = remover} end					 --
end					 --
					 --
------------------------------------------------------------------------------------------------------------					 --
end					 --
return usfulC					 --
------------------------------------------------------------------------------------------------------------					 --
