addEvent("homeInterface",true)					 --
addEventHandler("homeInterface",root,function(home,homeTab,pick)					 --
	if getElementDimension(pick) ~= getElementDimension(localPlayer) then return end					 --
	outputChatBox("home: "..home.key)					 --
end)					 --
