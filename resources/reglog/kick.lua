addEvent("afkKickMe", true)
addEventHandler("afkKickMe",root,function(kickPlayer)
	setTimer(function()
		kickPlayerHandler(getPlayerName(kickPlayer), "Длительное безйдействие")
	end,5000,1)
end)

function kickPlayerHandler (name, reasoner)
	-- Get player element from the name
	local kicked = getPlayerFromName(name)
    local reason = reasoner
		-- Kick the player
		kickPlayer ( kicked, reason )
end