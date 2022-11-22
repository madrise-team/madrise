function onDataChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "hdr") then
        if newValue == true then
		enableContrast()
	else
		disableContrast()
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange)