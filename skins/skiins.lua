----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
clothsShop = {}
---------------------------------------------------------------------------------------------------------------------------------------------------------
	clothsShop.binco = {}
		clothsShop.binco.markerInfo = {217.48537, -98.21656, 1004.2823, 15}
		clothsShop.binco.posExit = {217.48537, -101, 1004.2823}
		clothsShop.binco.marker =  createMarker(clothsShop.binco.markerInfo[1],clothsShop.binco.markerInfo[2],clothsShop.binco.markerInfo[3], "cylinder", 1.0, 80, 80, 80, 200)
		setElementInterior(clothsShop.binco.marker, clothsShop.binco.markerInfo[4])
		clothsShop.binco.skins = {1,     2,	    310,   14,    15,    20,    32,    34,    35,    47,    48,    72,    73,    101,   184}
		clothsShop.binco.costs = {10000, 20000, 30000, 25000, 15000, 16000, 17000, 18000, 19000, 20000, 21000, 22000, 18000, 19000, 20445}
		clothsShop.binco.ped = {clothsShop.binco.markerInfo[1],clothsShop.binco.markerInfo[2],clothsShop.binco.markerInfo[3] + 1, 130}
		clothsShop.binco.camera = {clothsShop.binco.ped[1] - 2.25, clothsShop.binco.ped[2] - 1, clothsShop.binco.ped[3] + 0.2}
		clothsShop.binco.dimensions = {127,129}
---------------------------------------------------------------------------------------------------------------------------------------------------------
	clothsShop.zip = {}
		clothsShop.zip.markerInfo = {181.43941, -86.5, 1001.0599, 18}
		clothsShop.zip.posExit = {181.43941, -88.3371, 1001.0599}
		clothsShop.zip.marker =  createMarker(clothsShop.zip.markerInfo[1],clothsShop.zip.markerInfo[2],clothsShop.zip.markerInfo[3], "cylinder", 1.0, 80, 80, 80, 200)
		setElementInterior(clothsShop.zip.marker, clothsShop.zip.markerInfo[4])
		clothsShop.zip.skins = {303,   7,     17,    21,    29,    43,    44,    66,    67,    24,    25,    33,    59,    60,    299,   185,   222,   250,    258,   259,   306,    297}
		clothsShop.zip.costs = {10000, 20000, 30000, 25000, 15000, 16000, 17000, 18000, 19000, 20000, 21000, 22000, 18000, 19000, 20445, 15822, 32588, 26855, 154888, 15889, 15844, 152282}
		clothsShop.zip.ped = {clothsShop.zip.markerInfo[1],clothsShop.zip.markerInfo[2],clothsShop.zip.markerInfo[3] + 1, 130}
		clothsShop.zip.camera = {clothsShop.zip.ped[1] - 2.25, clothsShop.zip.ped[2] - 1, clothsShop.zip.ped[3] + 0.2}
		clothsShop.zip.dimensions = {145,148}
---------------------------------------------------------------------------------------------------------------------------------------------------------
	clothsShop.trainH = {}
		clothsShop.trainH.markerInfo = {199.04732, -131.21674, 1002.5422, 3}
		clothsShop.trainH.posExit = {199.04732, -133.21674, 1002.5422}
		clothsShop.trainH.marker =  createMarker(clothsShop.trainH.markerInfo[1],clothsShop.trainH.markerInfo[2],clothsShop.trainH.markerInfo[3], "cylinder", 1.0, 80, 80, 80, 200)
		setElementInterior(clothsShop.trainH.marker, clothsShop.trainH.markerInfo[4])
		clothsShop.trainH.skins = {18,    19,    22,    26,    36,    37,    45,    52,    96,    97,    154}
		clothsShop.trainH.costs = {10000, 20000, 30000, 25000, 15000, 16000, 17000, 18000, 19000, 20000, 21000}
		clothsShop.trainH.ped = {clothsShop.trainH.markerInfo[1],clothsShop.trainH.markerInfo[2],clothsShop.trainH.markerInfo[3] + 1, 130}
		clothsShop.trainH.camera = {clothsShop.trainH.ped[1] - 2.25, clothsShop.trainH.ped[2] - 1, clothsShop.trainH.ped[3] + 0.2}
		clothsShop.trainH.dimensions = {137,138}
---------------------------------------------------------------------------------------------------------------------------------------------------------
clothsShop.victim = {}
		clothsShop.victim.markerInfo = {208.8286, -3.81167, 1000.2351, 5}
		clothsShop.victim.posExit = {208.8286, -5.81167, 1000.2351}
		clothsShop.victim.marker =  createMarker(clothsShop.victim.markerInfo[1],clothsShop.victim.markerInfo[2],clothsShop.victim.markerInfo[3], "cylinder", 1.0, 80, 80, 80, 200)
		setElementInterior(clothsShop.victim.marker, clothsShop.victim.markerInfo[4])
		clothsShop.victim.skins = {46,    98,    147,   186,   223,   307,   290}
		clothsShop.victim.costs = {10000, 20000, 30000, 25000, 15000, 16000, 17000}
		clothsShop.victim.ped = {clothsShop.victim.markerInfo[1],clothsShop.victim.markerInfo[2],clothsShop.victim.markerInfo[3] + 1, 130}
		clothsShop.victim.camera = {clothsShop.victim.ped[1] - 2.25, clothsShop.victim.ped[2] - 1, clothsShop.victim.ped[3] + 0.2}
		clothsShop.victim.dimensions = {134,136}

---------------------------------------------------------------------------------------------------------------------------------------------------------
clothsShop.subur = {}
		clothsShop.subur.markerInfo = {214.64131, -40.45015, 1001.0598, 1}
		clothsShop.subur.posExit = {214.64131, -42.45015, 1001.0598}
		clothsShop.subur.marker =  createMarker(clothsShop.subur.markerInfo[1],clothsShop.subur.markerInfo[2],clothsShop.subur.markerInfo[3], "cylinder", 1.0, 80, 80, 80, 200)
		setElementInterior(clothsShop.subur.marker, clothsShop.subur.markerInfo[4])
		clothsShop.subur.skins = {302,   23,    28,    30,    100,   181,   183,   241,   247,   248,   254,   291,   293}
		clothsShop.subur.costs = {10000, 20000, 30000, 25000, 15000, 16000, 17000, 18000, 19000, 20000, 21000, 22000, 18000}
		clothsShop.subur.ped = {clothsShop.subur.markerInfo[1],clothsShop.subur.markerInfo[2],clothsShop.subur.markerInfo[3] + 1, 130}
		clothsShop.subur.camera = {clothsShop.subur.ped[1] - 2.25, clothsShop.subur.ped[2] - 1, clothsShop.subur.ped[3] + 0.2}
		clothsShop.subur.dimensions = {131,133}
---------------------------------------------------------------------------------------------------------------------------------------------------------
clothsShop.ds = {}
		clothsShop.ds.markerInfo = {215.88857, -154.94524, 999.53992, 14}
		clothsShop.ds.posExit = {215.88857, -156.94524, 999.53992}
		clothsShop.ds.marker =  createMarker(clothsShop.ds.markerInfo[1],clothsShop.ds.markerInfo[2],clothsShop.ds.markerInfo[3], "cylinder", 1.0, 80, 80, 80, 200)
		setElementInterior(clothsShop.ds.marker, clothsShop.ds.markerInfo[4])
		clothsShop.ds.skins = {83,    84,    294,   295,   296}
		clothsShop.ds.costs = {10000, 20000, 30000, 25000, 15000}
		clothsShop.ds.ped = {clothsShop.ds.markerInfo[1],clothsShop.ds.markerInfo[2],clothsShop.ds.markerInfo[3] + 1, 130}
		clothsShop.ds.camera = {clothsShop.ds.ped[1] - 2.25, clothsShop.ds.ped[2] - 1, clothsShop.ds.ped[3] + 0.2}
		clothsShop.ds.dimensions = {139,139}
---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
function spawnMarkers()
	for k,cShop in pairs(clothsShop) do
		cShop.decorMarkers = {}
		for i=cShop.dimensions[1],cShop.dimensions[2] do
			local clothsShopMarker = createMarker(cShop.markerInfo[1], cShop.markerInfo[2], cShop.markerInfo[3], "cylinder", 1.0, 80, 80, 80, 200)
			setElementInterior(clothsShopMarker, cShop.markerInfo[4])
			setElementDimension(clothsShopMarker, i)

			cShop.decorMarkers[#cShop.decorMarkers + 1] = clothsShopMarker
		end
	end
end
spawnMarkers()

-- Декоративные маркера создаются шоб игрок видел маркер в каждом из экземпляров магазина (дименшоне)
-- Взаимодействет игрок с маркером [Dimension: 0] находится в magaz.marker 
---------------------------------------------------------------------------------------------------------------------------------------------------------





for magazName,magaz in pairs(clothsShop) do
	addEventHandler("onMarkerHit",magaz.marker,function(thePlayer)
		if getElementType(thePlayer) ~= "player" then return end
		local playerDimension = getElementDimension(thePlayer)
		
		local fadeAnimTime = 400
		CameraFadingAnimation(thePlayer,fadeAnimTime,fadeAnimTime)

		setTimer(function()
			triggerClientEvent(thePlayer,"bindBuy",root, magaz, playerDimension, magazName)

			local positMarX,positMarY,positMarZ = getElementPosition(magaz.marker)

			setPlayerPositon(thePlayer,positMarX,positMarY,positMarZ + 5,0)
			setElementFrozen(thePlayer, true)

			local exitBuySkin
			exitBuySkin = function()
				setPlayerPositon(thePlayer,magaz.posExit[1],magaz.posExit[2],magaz.posExit[3] + 0.77)
				setElementFrozen(thePlayer, false)
				setCameraTarget(thePlayer,thePlayer)

				removeEventHandler("exitBuySkin",thePlayer,exitBuySkin)	
			end
			addEventHandler("exitBuySkin",thePlayer,exitBuySkin)
		end,fadeAnimTime,1)
	end)
end
addEvent("exitBuySkin",true)
addEvent("buySkin",true)
addEventHandler("buySkin",root,function(thePlayer, buyInfo)
	if getPlayerMoney(thePlayer) > buyInfo.cost then
		outputChatBox("vi pidor kak nikogda ranshe", thePlayer)
		outputChatBox("---- skin buyed: ---", thePlayer)
		outputChatBox(buyInfo.skin, thePlayer)
		outputChatBox(buyInfo.cost.." $", thePlayer)
		outputChatBox("---- ----------- ---", thePlayer)
		

		setElementModel(thePlayer, buyInfo.skin)
		takePlayerMoney (thePlayer, buyInfo.cost)
	else
		--Callback : no money!
		outputChatBox("Недостаточно средств!", thePlayer)
	end 
end)