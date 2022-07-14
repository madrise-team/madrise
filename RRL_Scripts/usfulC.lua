function usfulC()
------------------------------------------------------------------------------------------------------------
function CameraFadingAnimation(FadeTime,timeInFade,red,green,blue)
	FadeTime = FadeTime or 1000
	timeInFade = timeInFade or 1000

	fadeCamera (false,FadeTime/1000,red,green,blue)
	setTimer(function()
		fadeCamera(true,FadeTime/1000)
	end,FadeTime + timeInFade,1)
end


clientElements = {}





boneElms = {}
function attachedElementToBoneProcessing(element, ped, bone, offX, offY, offZ, offrx, offry, offrz)
    if isElementOnScreen(ped) then
        local boneMat = getElementBoneMatrix(ped, bone)
        local sroll, croll, spitch, cpitch, syaw, cyaw = math.sin(offrz), math.cos(offrz), math.sin(offry), math.cos(offry), math.sin(offrx), math.cos(offrx)
        local rotMat = {
            {sroll * spitch * syaw + croll * cyaw,
            sroll * cpitch,
            sroll * spitch * cyaw - croll * syaw},
            {croll * spitch * syaw - sroll * cyaw,
            croll * cpitch,
            croll * spitch * cyaw + sroll * syaw},
            {cpitch * syaw,
            -spitch,
            cpitch * cyaw}
        }
        local finalMatrix = {
            {boneMat[2][1] * rotMat[1][2] + boneMat[1][1] * rotMat[1][1] + rotMat[1][3] * boneMat[3][1],
            boneMat[3][2] * rotMat[1][3] + boneMat[1][2] * rotMat[1][1] + boneMat[2][2] * rotMat[1][2],-- right
            boneMat[2][3] * rotMat[1][2] + boneMat[3][3] * rotMat[1][3] + rotMat[1][1] * boneMat[1][3],
            0},
            {rotMat[2][3] * boneMat[3][1] + boneMat[2][1] * rotMat[2][2] + rotMat[2][1] * boneMat[1][1],
            boneMat[3][2] * rotMat[2][3] + boneMat[2][2] * rotMat[2][2] + boneMat[1][2] * rotMat[2][1],-- front 
            rotMat[2][1] * boneMat[1][3] + boneMat[3][3] * rotMat[2][3] + boneMat[2][3] * rotMat[2][2],
            0},
            {boneMat[2][1] * rotMat[3][2] + rotMat[3][3] * boneMat[3][1] + rotMat[3][1] * boneMat[1][1],
            boneMat[3][2] * rotMat[3][3] + boneMat[2][2] * rotMat[3][2] + rotMat[3][1] * boneMat[1][2],-- up
            rotMat[3][1] * boneMat[1][3] + boneMat[3][3] * rotMat[3][3] + boneMat[2][3] * rotMat[3][2],
            0},
            {offX * boneMat[1][1] + offY * boneMat[2][1] + offZ * boneMat[3][1] + boneMat[4][1],
            offX * boneMat[1][2] + offY * boneMat[2][2] + offZ * boneMat[3][2] + boneMat[4][2],-- pos
            offX * boneMat[1][3] + offY * boneMat[2][3] + offZ * boneMat[3][3] + boneMat[4][3],
            1}
        }
        setElementMatrix(element, finalMatrix)
        return true
    else
        setElementPosition(element, 0, 0, -1000)
        return false
    end
end

function attachElementToBone(element, ped, bone, offX, offY, offZ, offrx, offry, offrz)
	removeElementFromBone(element)

	local fuc = function()
		attachedElementToBoneProcessing(element, ped, bone, offX, offY, offZ, offrx, offry, offrz)
	end
	local destroyFunc = function()
		removeElementFromBone(element)
	end
    local dimIntFunc = function(dim,int)
        setElementDimension(element,dim)
        setElementInterior(element,int)
    end
    addEventHandler("onClientPedsProcessed",root, fuc)
	addEventHandler("onElementDestroy",element, destroyFunc)
    addEventHandler("elmDimIntChanged",ped, dimIntFunc)

	boneElms[tostring(element)] = {fuc,destroyFunc,dimIntFunc,["ped"] = ped}
end
function removeElementFromBone(element)
	if boneElms[tostring(element)] then
		removeEventHandler("onClientPedsProcessed",root, boneElms[tostring(element)][1])
        removeEventHandler("onElementDestroy",element, boneElms[tostring(element)][2])
        removeEventHandler("elmDimIntChanged",boneElms[tostring(element)].ped, boneElms[tostring(element)][3])
		boneElms[tostring(element)] = nil
	end
end

function serverRequest(eventName,waitTime,element,answerElm,args,callback,errCallback)
    triggerServerEvent (eventName, element, args)

    local answerElment = answerElm or root

    local removeTimer
    local answeFuc
    waitTime = waitTime or 50
    local removeFuc = function()
        removeEventHandler(eventName,answerElment,answeFuc)
        if removeTimer then
            killTimer(removeTimer); removeTimer = nil
        end
    end
    answeFuc = function(ansArgs)
        callback(ansArgs)
        removeFuc()
    end
    addEventHandler(eventName,answerElment,answeFuc)

    if type(waitTime) == "number" then
        removeTimer = setTimer(function()
            removeFuc()
            errCallback()
        end,waitTime,1)
    end
end



function ESCskipper(but)
    if but == "escape" then
        outputChatBox("gggga")
        cancelEvent()
        ESCskipperFuc()
    end
end
ESCskipperCreated = false
ESCskipperFuc = nil

function createECSskipper(fucer)
    if not ESCskipperCreated then
        addEventHandler("onClientKey",root,ESCskipper)
        ESCskipperCreated = true
        ESCskipperFuc = fucer
    end
end
function deleteECSskipper()
    if ESCskipperCreated then
        removeEventHandler("onClientKey",root,ESCskipper)
        ESCskipperCreated = false
        ESCskipperFuc = nil
    end
end

local frameWaiters = {}
function frameWait(frames,callback,key)
    if key then
        if frameWaiters[key] then
            frameWaiters[key].remove()
            frameWaiters[key] = nil
        end
    end


    local frameN = 0
    local waiterF
    local remover = function()
        removeEventHandler("onClientRender",root,waiterF)
    end
    waiterF = function()
        frameN = frameN + 1
        if frameN > frames then
            callback()
            remover()
        end
    end
    addEventHandler("onClientRender",root,waiterF)

    if key then frameWaiters[key] = {remove = remover} end
end

------------------------------------------------------------------------------------------------------------
end
return usfulC
------------------------------------------------------------------------------------------------------------