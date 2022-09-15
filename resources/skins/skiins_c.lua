----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulC.lua')()    -- Usful Client
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
------------------------------------

local chosedSkinNum = 1

local ped

setCameraTarget(getLocalPlayer())

function checkSkin(magazInfo)
	setElementModel(ped, magazInfo.skins[chosedSkinNum])
end
function chooseSkin(_,_,dir,magazInfo)
	chosedSkinNum = chosedSkinNum + dir
	if chosedSkinNum < 1 then
		chosedSkinNum = #magazInfo.skins
	elseif chosedSkinNum > #magazInfo.skins then
		chosedSkinNum = 1
	end

	checkSkin(magazInfo)
end
function buySkin(_,_,magazInfo)
	buyInfo = {}
		buyInfo.cost = magazInfo.costs[chosedSkinNum]
		buyInfo.skin = magazInfo.skins[chosedSkinNum]
	triggerServerEvent("buySkin",root,localPlayer,buyInfo)
end

function setMarkersAlpha(magazInfo,alpha)
	for i,v in ipairs(magazInfo.decorMarkers) do
		setElementAlpha(v, alpha)
	end
end

function bindBuy(magazInfo, playerDimension, magazName)
	_G.magazInfo = magazInfo
	markerAlpha = getElementAlpha(magazInfo.marker)
	
	setMarkersAlpha(magazInfo,0)


	ped = createPed (magazInfo.skins[chosedSkinNum], magazInfo.ped[1], magazInfo.ped[2], magazInfo.ped[3], magazInfo.ped[4])
	setElementInterior(ped, magazInfo.markerInfo[4])
	setElementDimension(ped, playerDimension)                   ------------------------
	setCameraMatrix (magazInfo.camera[1], magazInfo.camera[2], magazInfo.camera[3],magazInfo.ped[1] + 2.24, magazInfo.ped[2] -0.18, magazInfo.ped[3] +0.14)
	chosedSkinNum = 1

	checkSkin(magazInfo)

	bindKey("arrow_l", "up", chooseSkin, -1,magazInfo)
	bindKey("arrow_r", "up", chooseSkin, 1,magazInfo)
	bindKey("enter", "up", buySkin, magazInfo)
	
	--Vihod

	local escapeFuk
	escapeFuk = function(but,press)
		if but == "escape" and press then
			
			local fadeAnimTime = 400
			CameraFadingAnimation(fadeAnimTime,fadeAnimTime)
			setTimer(function()
				unbindBuy()	
			end,fadeAnimTime,1)

			removeEventHandler("onClientKey",root,escapeFuk)
			cancelEvent()
		end
	end
	addEventHandler("onClientKey",root,escapeFuk)

end
function unbindBuy()
	unbindKey("arrow_l", "up", nextSkin)
	unbindKey("arrow_r", "up", prevSkin)
	unbindKey("enter", "up", buySkin)
	triggerServerEvent("exitBuySkin",localPlayer)
	setMarkersAlpha(magazInfo, markerAlpha)
	destroyElement(ped)
end

addEvent("bindBuy",true)
addEvent("unbindBuy",true)
addEventHandler("bindBuy",root,bindBuy)
addEventHandler("unbindBuy",root,unbindBuy)