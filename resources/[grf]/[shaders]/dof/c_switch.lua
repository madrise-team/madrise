function onDataChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "dof") then
        if newValue == true then
		enableDoF()
	else
		disableDoF()
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange)