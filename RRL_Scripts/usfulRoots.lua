function usfulRoots()
-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
rlsc = exports.RRL_Scripts






function checkRoot(nick,rootKey,callback)
	getAccountRoots(nick,function(playerRoots)
		callback(findRoot(nick,rootKey,playerRoots))
	end)	
end

--prpx - root prefix
function findRoot(nick,rootKey,rootsT,excludeT)
	local rprxEndI = rootKey:find("_")
	local rprx = rootKey:sub(1,rprxEndI)

	excludeT = excludeT or {}
	for k,ex_rt in pairs(excludeT) do
		if rootKey == ex_rt then
			return false
		end
	end


	for k,playerRootK in pairs(rootsT) do
		if playerRootK == rootKey then return true end


		if playerRootK:sub(1,rprxEndI) == rprx then
			local key2 = playerRootK:sub(rprxEndI+1,	( playerRootK:find("_",rprxEndI+1) or (#playerRootK+1) )	-1)
			
			if key2 == "orgpack" then
				local playerRootK_splt = strsplit(playerRootK,":")
				local plrk_excludeT = strsplit(playerRootK_splt[2],",") or {}
				for k,ex_rt in pairs(plrk_excludeT) do
					table.insert(excludeT,ex_rt)
				end
				if findRoot(nick,rootKey,rlsc:getOrgRootPackage(playerRootK_splt[1]),excludeT) then
					return true
				end
			end
		end
	end
	return false
end


function isRootCheckEnabled(rootT)
	if not rootT then return false end
	if rootT.rootCheckDisabled then return false end
	return true
end



function objectInteract_RootChekingProtocol(player,rootT,succesCallback)
	
	local finallFuc = function(accses)
		if accses then
			
				outputDebugString("Roots Finded!1")

			succesCallback()
		else
			
				outputDebugString("no root < " ..rootT.rootK .. " > Detected!")

		end	
	end

	if isRootCheckEnabled(rootT) then
		checkRoot(getPlayerNickName(player),rootT.rootK,finallFuc)
	else
		finallFuc(true)
	end
end



-------------------------------------------------------------------------------------------------------------------------------------
end
return usfulRoots