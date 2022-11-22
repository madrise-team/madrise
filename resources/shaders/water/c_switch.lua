function onDataChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "water") then
        if newValue == true then
		enableWaterShine()
	else
		disableWaterShine()
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange)