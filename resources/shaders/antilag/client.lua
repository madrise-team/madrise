function onDataChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "birds") then
        if newValue == true then
		setBirdsEnabled(false)
	else
		setBirdsEnabled(true)
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange)

function onDataChange2(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "occlusions") then
        if newValue == true then
        setOcclusionsEnabled(false)
    else
        setOcclusionsEnabled(true)
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange2)

function onDataChange3(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "blur") then
        if newValue == true then
        setBlurLevel(0)
    else
        setBlurLevel(36)
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange3)

function onDataChange4(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "clouds") then
        if newValue == true then
        setCloudsEnabled(false)
    else
        setCloudsEnabled(true)
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange4)