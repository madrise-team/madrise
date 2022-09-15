----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
------------------------------------------------------------



local timeToRehealth = 60000 --can't be lower then 10000 <<

function createReviveSequense(thePlayer)
	setElementHealth(thePlayer,3)
	local iterats = timeToRehealth/1000
	local iterN = 1

	setElementFrozen(thePlayer,true)

	local endF
	setTimer(function ()
		setElementHealth(thePlayer,10 + (90/iterats)*iterN)

		if iterN>= iterats then
			endF()
		end
		iterN = iterN + 1
	end,1000,iterats)
	endF = function()
		setElementHealth(thePlayer,100)

		setElementFrozen(thePlayer,false)
		outputChatBox("Глуяй")
	end
end