----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
------------------------------------------------------------
function wastedPlayer()
	local player = source
	local x,y,z = 1177.6767578125,-1320.2841796875,14.082455635071
	x,y,z = getElementPosition(player)
	spawnPlayerAtPosition(player, x, y, z, 90.0, nil, nil,function()
		--exports.Organizations:createReviveSequense(player)
	end)
end

addEventHandler("onPlayerWasted", root, wastedPlayer)