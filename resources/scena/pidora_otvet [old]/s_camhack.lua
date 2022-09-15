function setPlayerCamHackEnabled( thePlayer, state )
	return triggerClientEvent( thePlayer,"onClientEnableCamMode", root, state )
end

function setPlayerCamHackDisabled( thePlayer )
	return triggerClientEvent( thePlayer,"onClientDisableCamMode", root )
end

addEventHandler( "onResourceStop", resourceRoot, 
	function( )
		for i,thePlayer in pairs( getElementsByType( "player" ) ) do
			if getElementData( thePlayer, "isPlayerInCamHackMode" ) then 
				setElementAlpha( thePlayer, 255 )
				setElementFrozen( thePlayer, false ) 
				setElementCollisionsEnabled( thePlayer, true ) 	
			end
		end
	end
)

addCommandHandler( "camhack", 
	function( thePlayer )
		if isPedInVehicle( thePlayer ) then
			if getVehicleOccupant( getPedOccupiedVehicle( thePlayer ) ) ~= thePlayer then
				if getElementData( thePlayer, "isPlayerInCamHackMode" ) then 
					setElementAlpha( thePlayer, 255 )
					setPlayerCamHackDisabled( thePlayer )
				else
					setElementAlpha( thePlayer, 0 )
					setPlayerCamHackEnabled( thePlayer, false )
				end
			end
		else
			if getElementData( thePlayer, "isPlayerInCamHackMode" ) then 
				setElementAlpha( thePlayer, 255 )
				setPlayerCamHackDisabled( thePlayer )
				setElementFrozen( thePlayer, false ) 
				setElementCollisionsEnabled( thePlayer, true ) 		
			else
				setElementAlpha( thePlayer, 0 )
				setPlayerCamHackEnabled( thePlayer, true )
				setElementFrozen( thePlayer, true ) 
				setElementCollisionsEnabled( thePlayer, false ) 			
			end
		end
	end
)




addEvent("givePedTWeapon",true)
addEventHandler("givePedTWeapon",root,function(pedTs,wepId)
	for k,v in pairs(pedTs) do
		giveWeapon(v.ped, wepId, 3000, true)
	end
end)

addCommandHandler("createPed",function(player,_,model)
	local x,y,z = getElementPosition(player)
	local rx,ry,rz = getElementRotation(player)

	local f = 0
	if getControlState (player ,"sprint") then
		f = 0.6
	end

	local peder = createPed (model, x + f, y, z , rz, true)

	setElementInterior(peder,getElementInterior(player))
	setElementDimension(peder,getElementDimension(player))


	setPedStat(peder, 76, 1000)
	setPedStat(peder, 77, 0)
	setPedStat(peder, 78, 1000)

	

	triggerClientEvent(player,"yourCreatedPed",root,peder)

	local plel = player
	setTimer(function()
		setElementSyncer (peder, false)
		setElementSyncer (peder, plel)
	end,3000,0)
end)



--setSearchLightStartPosition


addEvent("pedsSync",true)
addEventHandler("pedsSync",root,function(pedsData)
	triggerLatentClientEvent("pedsSync",2*1024*1024,root,pedsData)
end)


addEvent('setVehPos',true)
addEventHandler('setVehPos',root,function(veh,x,y,z)
	if veh and x and y and z then
		setElementPosition(veh,x,y,z)
		local _,_,vrz = getElementRotation(veh)
		setElementRotation(veh,0,0,vrz)
	end
end)

addEvent("syncVeh",true)
addEventHandler("syncVeh",root,function(veh,hwo)
	setTimer(function()
		setElementSyncer(veh,false)
		setElementSyncer(veh,hwo)	
	end,2000,0)
end)


addEvent("vehAttacherTudaSuda",true)
addEventHandler("vehAttacherTudaSuda",root,function(veh)
	--triggerClientEvent("vehAttacherTudaSuda",root,veh)
end)


addEvent("killerPed",true)
addEventHandler("killerPed",root,function(ped)
	killPed (ped)
end)