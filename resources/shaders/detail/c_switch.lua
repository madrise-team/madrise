function onDataChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "detail") then
        if newValue == true then
           enableDetail()
	    else
		   disableDetail()
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange)