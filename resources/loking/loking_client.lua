----- imports
loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()
rlsc = exports.RRL_Scripts
-------
localPlayer = getLocalPlayer()
------

----- <Packer attach> -------------------------------------------------------------------- 

addEvent("attachAvtoToPacker",true)
addEvent("attachAvtoToPackerDestroy",true)
addEventHandler("attachAvtoToPacker",root,function(packer,avto)
    local px,py,pz = getElementPosition(packer)
    local rx,ry,rz = getElementRotation(packer)

    setElementPosition(avto, px,py,pz)
    setElementRotation(avto, 0, 0, 0)

    local frameFuc = function() 
        local compRot = getVehicleComponentRotation (packer, "misc_a")

        local rotation = (compRot - 360) + 15
        if rotation == -345 then rotation = 15  end

        local positionZ = (2.385 + 0.05) -(rotation/15)*(0.715 + 0.05)

        attachElements(avto, packer, 0, -1.5, positionZ, rotation, 0, 0)
    end
    addEventHandler("onClientRender",root,frameFuc)
    local delFuc
    delFuc = function()
        removeEventHandler("onClientRender",root,frameFuc)
        removeEventHandler("attachAvtoToPackerDestroy", packer, delFuc)
    end
    addEventHandler("attachAvtoToPackerDestroy", packer, delFuc)
end)

----- </Packer attach> -------------------------------------------------------------------- 
----- <InAir watcher> -------------------------------------------------------------------- 

addEvent("addGruzInAirWatcher",true)
addEvent("removeGruzInAirWatcher",true)
addEventHandler("addGruzInAirWatcher", root, function()
    local poteryano = false
    local watcher
    watcher = function()
        if getPedSimplestTask(localPlayer) ~= "TASK_SIMPLE_PLAYER_ON_FOOT" then
            if not poteryano then
                outputChatBox("р=потеря")
                triggerServerEvent("GruzInAir", source)
            end
            poteryano = true
        else
            poteryano = false
        end
    end
    addEventHandler("onClientRender",root,watcher)
    
    local remover 
    remover = function()
        removeEventHandler("onClientRender",root, watcher)    
        removeEventHandler("removeGruzInAirWatcher", root, remover)    
        outputChatBox("removed")
    end
    addEventHandler("removeGruzInAirWatcher", root, remover)
end)

----- </InAir watcher> --------------------------------------------------------------------

----- <Elmontajnik climb> -------------------------------------------------------------------- 
setTimer(function()
    elMontajStolbi = exports.loking:getElMontajStolbi()
    --enterClimbMode2()                                 --<-- white rects debug stolby
end,50,1)

local customBlockName = "loking.elMontajnik"
local IFP = engineLoadIFP( "elMontaj/elMontajnik.ifp", customBlockName )
if not IFP then
    outputChatBox( "Failed to load" )
end
function setanimation( _, animationName )
    if IFP then
        setPedAnimation( localPlayer, customBlockName, animationName )
    end
end
addCommandHandler( "animation", setanimation )






function enterClimbMode2()
    --local stolb = findClosestElmInArray(elMontajStolbi,px,py,pz)
    for k,v in pairs(elMontajStolbi) do
        local stolb = v
        local stolbMtrix = getMatrix(stolb)

        local model = getElementModel(stolb)
        local startPoint
        local endPoint
        local rotater
        if model == 1307 then
            startPoint = stolbMtrix.position + stolbMtrix.up*1.5 - stolbMtrix.right*0.53 - stolbMtrix.forward*0.06 - stolbMtrix.up*0.15
            endPoint = stolbMtrix.position + stolbMtrix.up*13.5 - stolbMtrix.right*0.53 - stolbMtrix.forward*0.06 - stolbMtrix.up*0.15
            local _,_,rz = getElementRotation(stolb)
            rotater = rz - 90
        elseif model == 1308 then
            startPoint = stolbMtrix.position + stolbMtrix.up*1.5 - stolbMtrix.forward*0.5 - stolbMtrix.right*0.06 - stolbMtrix.up*0.15
            endPoint = stolbMtrix.position + stolbMtrix.up*9.2 - stolbMtrix.forward*0.5 - stolbMtrix.right*0.06 - stolbMtrix.up*0.15
            local _,_,rz = getElementRotation(stolb)
            rotater = rz 
        elseif model == 3459 then
            startPoint = stolbMtrix.position + stolbMtrix.up*1.5 - stolbMtrix.right*0.5 + stolbMtrix.forward*0.04 - stolbMtrix.up*7
            endPoint = stolbMtrix.position + stolbMtrix.up*9.5 - stolbMtrix.right*0.5 + stolbMtrix.forward*0.04 - stolbMtrix.up*7
            local _,_,rz = getElementRotation(stolb)
            rotater = rz - 90
        elseif model == 3875 then
            startPoint = stolbMtrix.position + stolbMtrix.up*1.5 - stolbMtrix.right*0.5 - stolbMtrix.forward*0.06 - stolbMtrix.up*7
            endPoint = stolbMtrix.position + stolbMtrix.up*10 - stolbMtrix.right*0.5 - stolbMtrix.forward*0.06 - stolbMtrix.up*7
            local _,_,rz = getElementRotation(stolb)
            rotater = rz + 90
        end

        addEventHandler("onClientRender",root,function()
            local px,py,pz = getElementPosition(localPlayer)
            local imX,imY = getScreenFromWorldPosition(startPoint.x,startPoint.y,startPoint.z)
            local im2X,im2Y = getScreenFromWorldPosition(endPoint.x,endPoint.y,endPoint.z)
            if getDistanceBetweenPoints2D(startPoint.x,startPoint.y,px,py) < 1000 then
                --if imX then dxDrawImage(imX - 6,imY - 6,12,12,"but.png") end
                --if im2X then dxDrawImage(im2X - 6,im2Y - 6,12,12,"but.png") end
                --if imX then dxDrawText(model,imX + 15,imY) end
            end
        end)
    end
end


climbingMode = false

function enterClimbMode()
    if climbingMode then return end
    climbingMode = true

    rlsc:enterFreeTargetCameraMode()

    local px,py,pz = getElementPosition(localPlayer)

    climbModestolb = findClosestElmInArray(elMontajStolbi,px,py,pz)
    local stolbMtrix = getMatrix(climbModestolb)

    local model = getElementModel(climbModestolb)
    local startPoint
    local endPoint
    local rotater
    if model == 1307 then
        startPoint = stolbMtrix.position + stolbMtrix.up*1.5 - stolbMtrix.right*0.53 - stolbMtrix.forward*0.06 - stolbMtrix.up*0.15
        endPoint = stolbMtrix.position + stolbMtrix.up*13.5 - stolbMtrix.right*0.53 - stolbMtrix.forward*0.06 - stolbMtrix.up*0.15
        local _,_,rz = getElementRotation(climbModestolb)
        rotater = rz - 90
    elseif model == 1308 then
        startPoint = stolbMtrix.position + stolbMtrix.up*1.5 - stolbMtrix.forward*0.5 - stolbMtrix.right*0.06 - stolbMtrix.up*0.15
        endPoint = stolbMtrix.position + stolbMtrix.up*9.2 - stolbMtrix.forward*0.5 - stolbMtrix.right*0.06 - stolbMtrix.up*0.15
        local _,_,rz = getElementRotation(climbModestolb)
        rotater = -rz 
    elseif model == 3459 then
        startPoint = stolbMtrix.position + stolbMtrix.up*1.5 - stolbMtrix.right*0.5 + stolbMtrix.forward*0.04 - stolbMtrix.up*7
        endPoint = stolbMtrix.position + stolbMtrix.up*9.5 - stolbMtrix.right*0.5 + stolbMtrix.forward*0.04 - stolbMtrix.up*7
        local _,_,rz = getElementRotation(climbModestolb)
        rotater = -rz + 90
    elseif model == 3875 then
        startPoint = stolbMtrix.position + stolbMtrix.up*1.5 - stolbMtrix.right*0.5 - stolbMtrix.forward*0.06 - stolbMtrix.up*7
        endPoint = stolbMtrix.position + stolbMtrix.up*10 - stolbMtrix.right*0.5 - stolbMtrix.forward*0.06 - stolbMtrix.up*7
        local _,_,rz = getElementRotation(climbModestolb)
        rotater = -rz + 90
    end
                                                                                    --r--g--b  --a
    local workMarka = createMarker(endPoint.x, endPoint.y, endPoint.z, "corona", 1, 0, 0, 255, 255)

    
    setElementPosition(localPlayer,startPoint.x,startPoint.y,startPoint.z)    

    local startPlayerX = startPoint.x 
    local startPlayerY = startPoint.y
    local startPlayerZ = startPoint.z
    setElementPosition(localPlayer,startPlayerX,startPlayerY,startPlayerZ + 0.01)
    setPedAnimation (localPlayer ,"loking.elMontajnik", "elMontajnik_up", -1, false, false, true, true, 200, true) 

    --global save --
    climbStartPlayerX = px 
    climbStartPlayerY = py
    climbStartPlayerZ = pz
    --      -     --
    


    local forwd = false
    local backwrd = false
    local keyEnabled = true

    climbModeFdown = function()
        forwd = true
    end
    climbModeFup =  function()
        forwd = false
    end
    climbModeBdown = function()
        backwrd = true       
    end
    climbModeBup = function()
        backwrd = false
    end
    bindKey("forwards","down",climbModeFdown)
    bindKey("forwards","up",climbModeFup)
    bindKey("backwards","down",climbModeBdown)
    bindKey("backwards","up",climbModeBup)


    local progress = 0
    local totalProgress = 0
    local speedKoef = 2.2
    local cycle = 0
    local toHight = false
    local toLow = false

    local korobZ = startPlayerZ-1
    climbModeKorobka = createObject(1649,startPlayerX,startPlayerY,korobZ)
    setElementRotation(climbModeKorobka,-90,0,0)
    setElementCollidableWith(climbModeKorobka,climbModestolb,false)
    setElementAlpha(climbModeKorobka,0)

    rlsc:addFreeTargetCameraModeCollideSkipElements({climbModeKorobka,climbModestolb})

    --if true then return end

    local stolbWorks_Started = false
    local stolbWorks_Ended = false

    climbModePreFrameFuc =  function()
        setElementRotation(localPlayer,0,0,rotater)
    end
    addEventHandler("onClientPreRender",root,climbModePreFrameFuc)
    climbModeFrameFuc = function()
        if not keyEnabled then
            forwd = false
            backwrd = false
        end

        if forwd and (not toHight) then
            progress = progress + 0.01*speedKoef
            totalProgress = totalProgress + 0.01*speedKoef
        elseif backwrd and (not toLow) then
            progress = progress - 0.01*speedKoef
            totalProgress = totalProgress - 0.01*speedKoef
        end

        local _,_,boneBoseZ = getPedBonePosition(localPlayer,3)
        if (boneBoseZ >= endPoint.z) and (progress >= 0.9) then 
            toHight = true
            progress =0.9
        else toHight = false end
        if boneBoseZ <= startPoint.z + 0.3 then toLow = true
        else toLow = false end


        if toHight and (not stolbWorks_Started) then
            stolbWorks_Started = true
            keyEnabled = false

            outputChatBox("start stolb works")
            setPedAnimation (localPlayer ,"loking.elMontajnik", "elMontajnik_work", 1, true, true, false, true, 80, false)
            destroyElement(workMarka)

            setTimer(function()
                keyEnabled = true
                stolbWorks_Ended = true

                setPedAnimation (localPlayer ,"loking.elMontajnik", "elMontajnik_up", 1, false, true, nil, nil, 60, false)
                outputChatBox("stolb works done")
            end,12000,1)
        end
        if toLow and stolbWorks_Ended then
            outputChatBox("Все слезай нахуй ща перебешся ваще")
            leaveClimbMode()
        end

        if keyEnabled then setPedAnimationProgress(localPlayer,"elMontajnik_up",progress) end

        setElementPosition(climbModeKorobka,startPlayerX,startPlayerY,korobZ + cycle*0.651)

        if progress >= 0.99 then
            progress = 0
            cycle = cycle + 1
        end
        if progress < 0 then
            progress = 0.99
            cycle = cycle - 1
            if cycle < 0 then cycle = 0 end
        end


        --dxDrawText(tostring(toHight),1250,260)
        --dxDrawText(tostring(toLow),1250,270)
    end
    addEventHandler("onClientRender",root,climbModeFrameFuc)
end
function leaveClimbMode()
    if not climbingMode then return end
    climbingMode = false

    removeEventHandler("onClientPreRender",root,climbModePreFrameFuc)
    removeEventHandler("onClientRender",root,climbModeFrameFuc)

    unbindKey("forwards","down",climbModeFdown)
    unbindKey("forwards","up",climbModeFup)
    unbindKey("backwards","down",climbModeBdown)
    unbindKey("backwards","up",climbModeBup)

    destroyElement(climbModeKorobka)
    rlsc:enterPlayerTargetCameraMode()
    rlsc:removeFreeTargetCameraModeCollideSkipElements({climbModeKorobka,climbModestolb})

    setElementPosition(localPlayer,climbStartPlayerX,climbStartPlayerY,climbStartPlayerZ)

    triggerServerEvent("endStolbWork_ElMontajnik",localPlayer)
end



addEvent("startClimb_ElMontajnik",true)
addEventHandler("startClimb_ElMontajnik",root,function()
    enterClimbMode()
end)

--bindKey("k","down",function()
--    enterClimbMode()
--end)

----- </Elmontajnik climb> -------------------------------------------------------------------- 

engineReplaceModel (engineLoadDFF("elMontaj/claws_11.dff"), 3092)
engineReplaceModel (engineLoadDFF("elMontaj/claws_12.dff"), 3011)
engineReplaceModel (engineLoadDFF("elMontaj/claws_21.dff"), 3010)
engineReplaceModel (engineLoadDFF("elMontaj/claws_22.dff"), 3009)


bindKey("r","down",function()
	outputChatBox("tapki")
	
	local px,py,pz = getElementPosition(localPlayer)
	outputChatBox(px)
	local tapki = {}
	tapki["r"] = {createObject(3092,px + 1,py, pz),createObject(3011,px + 1,py, pz)}
	tapki["l"] = {createObject(3010,px + 2,py, pz),createObject(3009,px + 2,py, pz)}

	setElementCollisionsEnabled(tapki["r"][1],false)
	setElementCollisionsEnabled(tapki["r"][2],false)
	setElementCollisionsEnabled(tapki["l"][1],false)
	setElementCollisionsEnabled(tapki["l"][2],false)

	attachElements(tapki["r"][2], tapki["l"][1], 0, 0, 0)
	attachElements(tapki["l"][2], tapki["r"][1], 0, 0, 0)


	local rx = -4
	local ry = 11.15
	local rz = 0.6

	local rxMod = 0
	local ryMod = 0
	local rzMod = 0

	bindKey("6","down",function()
		rxMod = 1
	end)
	bindKey("7","down",function()
		rxMod = -1
	end)
	bindKey("8","down",function()
		ryMod = 1
	end)
	bindKey("9","down",function()
		ryMod = -1
	end)
	bindKey("0","down",function()
		rzMod = 1
	end)
	bindKey("o","down",function()
		rzMod = -1
	end)


	bindKey("6","up",function()
		rxMod = 0
	end)
	bindKey("7","up",function()
		rxMod = 0
	end)
	bindKey("8","up",function()
		ryMod = 0
	end)
	bindKey("9","up",function()
		ryMod = 0
	end)
	bindKey("0","up",function()
		rzMod = 0
	end)
	bindKey("o","up",function()
		rzMod = 0
	end)

	addEventHandler("onClientPedsProcessed",root,function()
		rx = rx + (rxMod/20)
		ry = ry + (ryMod/20)
		rz = rz + (rzMod/20)

		attachedElementToBoneProcessing(tapki["r"][1],localPlayer,54,0.1 , -0.02, 0, -3.5, 11.15, 0.6)
		attachedElementToBoneProcessing(tapki["l"][1],localPlayer,44,0.1 , -0.02, 0, -3.8, 11.15, 0.6)
	end)

	bindKey("i","up",function()
		outputChatBox(rx.." "..ry.." "..rz)
	end)
	outputChatBox("tapki da")
end)