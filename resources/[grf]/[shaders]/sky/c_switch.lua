function toggleSky ( dsOn )
	if dsOn then
		startDynamicSky()
	else
		stopDynamicSky()
	end
end
addEvent( "toggleSky", true )
addEventHandler( "toggleSky", getLocalPlayer(), toggleSky )

function onDataChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "sky") then
        if newValue == true then
		startDynamicSky()
	else
		stopDynamicSky()
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange)