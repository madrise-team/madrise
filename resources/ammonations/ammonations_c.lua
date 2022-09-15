localPlayer = getLocalPlayer()
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
function y_answer(_,_,weaponInfo)
	--outputChatBox(tostring(weaponInfo))
	if getPlayerMoney() >= weaponInfo.cost then
		triggerServerEvent("y_buyer",root,localPlayer, weaponInfo)
	else
		outputChatBox("У вас денег нет!", thePlayer)
		unbindBuy()
	end
end
function n_answer()
	unbindBuy()
end
function bindBuy(weaponInfo)
	bindKey("i", "up", y_answer, weaponInfo)
	bindKey("n", "up", n_answer)
end
function unbindBuy() 
	unbindKey("i", "up", y_answer)
	unbindKey("n", "up", n_answer)
end


addEvent("AmmonationsMarker",true)
addEvent("leave AmmonationsMarker",true)
addEventHandler("AmmonationsMarker",root,function(weaponInfo)
	bindBuy(weaponInfo)
end)
addEventHandler("leave AmmonationsMarker",root,function()
	unbindBuy()
end)