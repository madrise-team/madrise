----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulC.lua')()    -- Usful Client
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
------------------------------------
--------------------------------------------------------------------------------------------------------

addEvent("pedEnteredVehicle", true)
addEventHandler("pedEnteredVehicle",root,function(thePed,theVehicle)
	setPedEnterVehicle(thePed, theVehicle,passenger or true)
end)
addEvent("pedExitedVehicle", true)
addEventHandler("pedExitedVehicle",root,function(thePed)
	setPedExitVehicle(thePed)	
end)

--
addEventHandler("onClientRender",root,function()
    dxDrawRectangle(0,0,screenW,screenW,tocolor(0,0,0,255))
end)--]]


addEvent("createClientElement",true)
addEvent("destroyClientElement",true)
addEventHandler("createClientElement",root,function(key, modelId, x, y, z, rx, ry, rz, isLowLOD)
	if not key then outputDebugString("Client object creation key is Nil!!"); return end 
	clientElements[key] = createObject(modelId, x or 0, y or 0, z or 0, rx, ry, rz, isLowLOD)
end)
addEventHandler("destroyClientElement",root,function(key)
	if clientElements[key] then destroyElement(clientElements[key]); clientElements[key] = nil end
end)


addEvent("attachElementToBone",true)
addEvent("removeElementFromBone",true)
addEventHandler("attachElementToBone",root,function(element, ped, bone, offX, offY, offZ, offrx, offry, offrz)
	attachElementToBone(element, ped, bone, offX, offY, offZ, offrx, offry, offrz)
end)
addEventHandler("removeElementFromBone",root,function(element)
	removeElementFromBone(element)
end)
	
addEvent("elmDimIntChanged",true)




function ghostVehMode(veh,onOff)
	if not veh then return end
	for i,v in pairs(getElementsByType("vehicle")) do --LOOP through all vehicles
		setElementCollidableWith(v, veh, onOff) -- Set the collison off with the other vehicles.
	end
	outputChatBox(tostring(onOff))
end
addEvent('vehColGhostMode',true)
addEventHandler('vehColGhostMode',root,ghostVehMode)

ghosterCol = true
bindKey("l","down",function()
	ghoster = not ghoster
	ghostVehMode(getPedOccupiedVehicle(localPlayer),not ghoster)
end)

addCommandHandler("clear",function()
	clearChatBox()
	clearDebugBox()
end)






----- Поебота ------------------------------------------------------------------------------------------
HUD_Facer = true
bindKey("f2","down",function()
	HUD_Facer = not HUD_Facer
	setPlayerHudComponentVisible("all",HUD_Facer)
	showChat(HUD_Facer)
end)

boosting = true
screenW, screenH = guiGetScreenSize()
function boost(boost)
	if not boosting then return end
	local localPlayer = getLocalPlayer()

	local boost = boost or 15
	
	local pointX, pointY, pointZ = getWorldFromScreenPosition(screenW/2,screenH/3,boost)
	local playerX,playerY,playerZ = getElementPosition(localPlayer)


	local vX = pointX - playerX
	local vY = pointY - playerY
	local vZ = pointZ - playerZ

	
	local veh =	getPedOccupiedVehicle(localPlayer)
	if veh then
		local svX,svY,svZ = getElementVelocity(veh)
		setElementVelocity(veh,vX/30 + svX/200,vY/30 + svY/200,vZ/30 + svZ/200)
	else
		setElementVelocity(localPlayer,vX,vY,vZ*5)
	end


end

bindKey('j','down',function()
	boosting = not boosting
	if boosting then
		outputChatBox("usfulC: bosting enbled")
	else
		outputChatBox("usfulC: disabled boosting")
		setPedCanBeKnockedOffBike(localPlayer,true)
		triggerServerEvent("dayVeleg",localPlayer,false)
	end
	
end)

bindKey('3','down', function()
	boost()
end)
bindKey('4','down', function()
	boost(75)
end)
bindKey('5','down', function()
	boost(375)
end)


fob = false
bindKey('2','down', function()
	fob = not fob
	if not boosting then 
		fob = false 
	end
	setPedCanBeKnockedOffBike(localPlayer,not fob)
	triggerServerEvent("dayVeleg",localPlayer,fob)
end)


bindKey("g","down",function()
    setElementFrozen(localPlayer, not isElementFrozen(localPlayer))
    local veh = getPedOccupiedVehicle(localPlayer)
    if veh then
        setElementFrozen(veh, not isElementFrozen(veh))
    end
    outputChatBox("usfulC_local: g - freeze, cnsl pos check")
   	local x,y,z = getElementPosition(localPlayer)
    outputConsole(x.."  "..y.."  "..z)
end)
addCommandHandler("toHome",function(player)
	setElementPosition(localPlayer,1414.5958251953,-1638.9510498047,38.308795928955)
end)
outputDebugString(" \'toHome\' usfulC_local <")
--------------------------------------------------------------------------------------------------------
local corder = false
bindKey("h","down",function()
	corder = not corder
end)

addEventHandler( 'onClientRender', root, function( )
	if corder then
    	local x,y,z =  getElementPosition(localPlayer)
    	dxDrawText(x,screenW-150,0)
    	dxDrawText(y,screenW-150,15)
    	dxDrawText(z,screenW-150,30)
    	dxDrawText("corder us_c (h disable)",screenW-150,50)
        --setTime( 20, 59 )

	end
end)


screenWid,screenHeh = guiGetScreenSize()
pedVidelkaTex = dxCreateRenderTarget(50,50,true)
function createPedVidelka()
	dxSetRenderTarget(pedVidelkaTex,true)
	local modeSave = dxGetBlendMode()
	dxSetBlendMode("overwrite")
	dxDrawRectangle(0,0,100,100,tocolor(200,200,200,235))
	dxDrawRectangle(4,4,92,92,tocolor(40,40,40,235))
	dxDrawRectangle(10,10,80,80,tocolor(0,0,0,0))
	dxSetBlendMode(modeSave)
	dxSetRenderTarget()
end


cadr = 0

targShowingUI = true
targShowingLight = true
schLightTarget = nil
addCommandHandler("vetrovert",function()
	outputChatBox("veterEst")
	local helic = getPedOccupiedVehicle(localPlayer)
	if not helic then return end
	if getElementType(helic) ~= "vehicle" then return end
	if getVehicleType(helic) ~= "Helicopter" then return end

	bindKey("c","down",function()
		targShowingLight = not targShowingLight
	end)

	bindKey("m","down",function()
		local cX,cY,cZ = getWorldFromScreenPosition(screenWid/2,screenHeh/2.6,0.01)
		local clX,clY,clZ = getWorldFromScreenPosition(screenWid/2,screenHeh/2.6,200)	
		local hit, hitcX, hitcY, hitcZ, hitedElement = processLineOfSight ( cX, cY, cZ, 
	                                       									clX,	clY,	clZ, 
	                                       									true,true,true,true,true,false,true,false,helic)
		if hit then
			if hitedElement then
				if (getElementType(hitedElement) == "vehicle") or (getElementType(hitedElement) == "ped") or (getElementType(hitedElement) == "player") then
					schLightTarget = hitedElement
				end
			else
				schLightTarget = {hitcX, hitcY, hitcZ}
			end
		end
	end)


	triggerServerEvent("searchLightCreate",root,tostring(localPlayer))

	addEventHandler("onClientRender",root,function()
		cadr = cadr + 1
		createPedVidelka()
		dxDrawRectangle(screenWid/2-1,screenHeh/2.6 - 1,2,2)

		local schLightTargetElm
		if schLightTarget then
			local schLightTargetPosX,schLightTargetPosY,schLightTargetPosZ
			if type(schLightTarget) == "table" then
				schLightTargetPosX = schLightTarget[1]
				schLightTargetPosY = schLightTarget[2]
				schLightTargetPosZ = schLightTarget[3]
			else
				schLightTargetPosX,schLightTargetPosY,schLightTargetPosZ = getElementPosition(schLightTarget)
				schLightTargetElm = schLightTarget
			end
			local ftx,fty,ftz = getCameraMatrix()

			if targShowingUI then 
				local col = tocolor(255,255,255,160)
				if type(schLightTarget) ~= "table" then
					col = tocolor(20,235,245,255)
				end
				dxDrawMaterialLine3D(schLightTargetPosX - 0.5, schLightTargetPosY - 0.5, schLightTargetPosZ , schLightTargetPosX + 0.5, schLightTargetPosY + 0.5, schLightTargetPosZ , false, pedVidelkaTex, 1.3, col,true,0,0,100000) 
			end

			local helic = getPedOccupiedVehicle(localPlayer)
			if helic then  
				if getElementType(helic) == "vehicle" then 
					if getVehicleType(helic) == "Helicopter" then 
						local endPointer
						if schLightTargetElm then endPointer = schLightTargetElm 
						else endPointer = {x = schLightTargetPosX,y = schLightTargetPosY,z = schLightTargetPosZ} end

						if targShowingLight then
							if not (cadr%3 == 0) then
								triggerLatentServerEvent("searchLightUpdate",100*1024*1024,root,tostring(localPlayer),helic,endPointer)
							end
						else
							triggerLatentServerEvent("searchLightUpdate",100*1024*1024,root,tostring(localPlayer),false)
						end
					end
				end
			end

		end
	end)
end)


schLights = {}

addEvent("searchLightCreate",true)
addEventHandler("searchLightCreate",root,function(key)
	schLights[key] = {}
	schLights[key][1] = createSearchLight (0,0,-100,0,0,-100,0.2,14,true)
end)

addEvent("searchLightUpdate",true)
addEventHandler("searchLightUpdate",root,function(key,helic,endPoint)
	if helic then
		if schLights[key] then
			schLights[key][2] = helic

			local endPointX,endPointY,endPointZ
			if type(endPoint) ~= "table" then
				endPointX,endPointY,endPointZ = getElementPosition(endPoint)
			else
				endPointX = endPoint.x
				endPointY = endPoint.y
				endPointZ = endPoint.z
			end
			setSearchLightEndPosition(schLights[key][1], endPointX, endPointY, endPointZ)
		end
	else
		setSearchLightStartPosition(schLights[key][1], 0, 0, -100)
		setSearchLightEndPosition(schLights[key][1], 0, 0, -110)
	end
end)

addEventHandler("onClientPedsProcessed",root,function()
	for k,v in pairs(schLights) do
		if v[2] then
			local MatrixerVeh = Matrix(Vector3(getElementPosition(v[2])),Vector3(getElementRotation(v[2])))
			local startPos = MatrixerVeh.position + MatrixerVeh.forward*3 + MatrixerVeh.up*0.1

			setSearchLightStartPosition(v[1], startPos.x, startPos.y, startPos.z)	
		end
	end
end)

addCommandHandler("dmt",function()
	function displayMyTask ()
	    local x,y = 100,200
	    dxDrawRectangle(x-5,y,500,400,tocolor(0,0,0,200))

	    local state = getPedMoveState(localPlayer)
	    dxDrawText(state,x,y+200)

	    local animB,animA = getPedAnimation(localPlayer)
		if animB then dxDrawText(animB,x,y+250) end
		if animA then dxDrawText(animA,x + 50,y+250) end

		local stask = getPedSimplestTask(localPlayer)
		if stask then dxDrawText(stask,x,y+280) end




	    for k=0,4 do
	        local a,b,c,d = getPedTask ( getLocalPlayer(), "primary", k )
	        dxDrawText ( "Primary task #"..k.." is "..tostring(a).." -> "..tostring(b).." -> "..tostring(c).." -> "..tostring(d).." -> ", x, y)
	        y = y + 15
	    end
	    y = y + 15
	    for k=0,5 do
	        local a,b,c,d = getPedTask ( getLocalPlayer(), "secondary", k )
	        dxDrawText ( "Secondary task #"..k.." is "..tostring(a).." -> "..tostring(b).." -> "..tostring(c).." -> "..tostring(d).." -> ", x, y )    
	        y = y + 15
	    end
	end    
	addEventHandler ( "onClientRender", root, displayMyTask )
end)



--[[ Server Timers Debug

adad = {}
addEvent("tat",true)
addEventHandler("tat",root,function(tata,name)
	if name == "loking" then
		adad = tata
	end
end)

addEventHandler("onClientRender",root,function()
    local timerC = 0
    for k,v in pairs(adad) do
        timerC = timerC + 1
    end
    local xPOs = 400
    local yPOs = 200

    dxDrawText("Timers: "..timerC, xPOs, 200)
	yPOs = yPOs + 20

    for i=1,25 do
        local tm = adad[i]
        if tm then
            local endTime = getTimeToEnd(tm.timerEndTime)
            dxDrawText("ind: "..i.." end: ["..endTime.mins.." : "..endTime.secs.."] ", xPOs, yPOs)
        end
        yPOs = yPOs + 15
    end
end)
--]]--

outputDebugString("----------------------------------------------------------------------")