function Terrytory_Sh()
---------------------------------------------------------------------
function findMyBase(terr,baseName,desConns)
	if terr.owner == "none" or terr.owner == "conquest" then
		return false
	end
	if terr.index == baseName then
		return true
	end
	local desConns = desConns or {}
	desConns[terr.index] = true
	for k,v in pairs(terr.connections) do
		if (Terrytorys[v].owner == Terrytorys[baseName].owner) and (not desConns[v]) then
			if findMyBase(Terrytorys[v],baseName,desConns) then
				return true
			end
		end
	end
	return false
end

function isTerrConnected(terr,initer)
	for k,conn in pairs(terr.connections) do
		local connTer = Terrytorys[conn]
		if connTer.owner == initer then
			if findMyBase(connTer,"BASE "..initer:sub(1,1)) then
				return true
			end
		end
	end
	return false
end


function isIniterHaveMorePriority(initerA,initerB)
	if (initerA.initPower > initerB.initPower) then
		return true
	else
		if (initerA.initPower == initerB.initPower) and (initerA.initerHod < initerB.initerHod) then
			return true
		end
	end
	return false
end

function sortIniters()
	local sortedIniters = {}
	for k,v in pairs(initersy) do
		sortedIniters[#sortedIniters + 1] = v
	end
	table.sort(sortedIniters,isIniterHaveMorePriority)
	return sortedIniters
end

function isIniterInBattle(battles,initer)
	for bk,bv in pairs(battles) do
		for sk,sv in pairs(bv.sides) do
			if sv.name == initer then
				return true
			end
		end
	end
end
function checkIniters(sortedIniters,subcheck)
	local terrPretendents = {}

	for initerIndex,initer in ipairs(sortedIniters) do
		initer.warning = nil

		local initerInitTerr = initer.initTerrit
		local initerInitTerrOwner = Terrytorys[initerInitTerr].owner

		for subiniterI,subinitr in ipairs(sortedIniters) do
			if subiniterI < initerIndex then
				if not subinitr.warning then
					
					local subiniterInitTerr = subinitr.initTerrit
					local subiniterInitTerrOwner = Terrytorys[subiniterInitTerr].owner

					if (subiniterInitTerrOwner == initer.name) then
						initer.warning = insertInTabOrCreate(initer.warning,"Блокировка бандой "..subinitr.name.." на територии "..subiniterInitTerr)
					elseif (subiniterInitTerrOwner == initerInitTerrOwner) and (initerInitTerrOwner ~= "none") then
						initer.warning = insertInTabOrCreate(initer.warning,"Перехват инициативы бадной "..subinitr.name)
					elseif (initerInitTerrOwner == subinitr.name) then
						initer.warning = insertInTabOrCreate(initer.warning,subinitr.name.." пресекает инициативу")
					end
				end
			end
		end

		if isIniterInBattle(battles,initerInitTerrOwner) then
			initer.warning = insertInTabOrCreate(initer.warning,initerInitTerrOwner.." в данный момент недоступен для подключения")
		end
		if isIniterInBattle(battles,initer.name) then
			initer.warning = insertInTabOrCreate(initer.warning,"Система заблокирована! Невохможно создать новое подключение")
		end



		local alreadyInThisNoneBattle = 0
		if battles[initerInitTerr] then
			local batleSidesCount = tableCount(battles[initerInitTerr].sides)
			if batleSidesCount > 1 then
				initer.warning = insertInTabOrCreate(initer.warning,initerInitTerr.." в данный момент недоступна")
			end
			alreadyInThisNoneBattle = batleSidesCount
		end
		if terrPretendents[initerInitTerr] then
			if (#terrPretendents[initerInitTerr] + alreadyInThisNoneBattle) > 1 then
				for i,v in ipairs(terrPretendents[initerInitTerr]) do
					initer.warning = insertInTabOrCreate(initer.warning,"Инициатива "..v.." преобладает на "..initerInitTerr)
				end
			end
		end
		if not initer.warning then terrPretendents[initerInitTerr] = insertInTabOrCreate(terrPretendents[initerInitTerr],initer.name) end
	end

	return sortedIniters
end
function fullText(text,leftX,topY,wX,hY,color,scale,alignX,alignY)
	dxDrawText(text,leftX,topY,leftX + wX, topY+hY,color or tocolor(255,255,255,255), scale, scale,"default", alignX, alignY, false,false,true)
end


territoryColors = {		--// DebugVersion
	none = tocolor(255,255,255,15),
	Aztec = tocolor(16,180,232,150),
	Vagos = tocolor(184,175,97,150),
	Groove = tocolor(9,173,9,150),
	Ballas = tocolor(113,30,165,150),
	conquest = tocolor(255,100,100,60)
}

function writeTerritoriesToRT(Terrytorys)  -------------------------------------------// Debug edition
	local polyWriterShader = dxCreateShader(":Draws/fx/polyWriter.fx")
	local territoryRTsTable = {}
	for k,terr in pairs(Terrytorys) do
		local srvx = 0
		local srvy = 0

		for terk,terv in pairs(terr.tPoints) do
			terv.xv = ((terv.x+3000)/1.3-2950 - 4)  + 200
			terv.yv = ((-terv.y+3000)/1.3-2950 - 4) + 20

			srvx = srvx + terv.xv
			srvy = srvy + terv.yv
		end 																---/// points	
		terr.srvx = srvx/#terr.tPoints + terr.pos.svrx
		terr.srvy = srvy/#terr.tPoints + terr.pos.svry

		local xCordsOfTerr = {} 											---/// fill
		local yCordsOfTerr = {}
		local indexer = 1

		local minX,maxX,minY,maxY = minMaxerTPoint(terr.tPoints)
		local w = (maxX - minX)*8
		local h = (maxY - minY)*8 
		territoryRTsTable[k] = {locSize = {x=minX,y=minY,w=w,h=h}, rt = dxCreateRenderTarget(w,h,true)}

		for indexer=1,#terr.tPoints do
			if terr.tPoints[indexer] then
				xCordsOfTerr[indexer] = (terr.tPoints[indexer].xv - minX)*8 + 0.005
				yCordsOfTerr[indexer] = (terr.tPoints[indexer].yv - minY)*8 + 0.005
			else
				xCordsOfTerr[indexer] = 0
				yCordsOfTerr[indexer] = 0
			end
		end

		if polyWriterShader then
			dxSetShaderValue(polyWriterShader,"polygonX",{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
			dxSetShaderValue(polyWriterShader,"polygonY",{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})

			dxDrawImage(0,0,1,1,polyWriterShader)

			dxSetShaderValue(polyWriterShader,"MAXpolySize",#xCordsOfTerr+1)
			dxSetShaderValue(polyWriterShader,"polygonX",xCordsOfTerr)
			dxSetShaderValue(polyWriterShader,"polygonY",yCordsOfTerr)
			
			dxSetRenderTarget(territoryRTsTable[k].rt)
			dxDrawImage(0,0,w,h,polyWriterShader)
			dxSetRenderTarget()

			territoryRTsTable[k].locSize.w = territoryRTsTable[k].locSize.w/8
			territoryRTsTable[k].locSize.h = territoryRTsTable[k].locSize.h/8
		end
	end
	destroyElement(polyWriterShader)
	return territoryRTsTable
end------------------------------------------------------------------------------------------

function calcTerrWSrv(terr)
	terr.wsrvx = 0
	terr.wsrvy = 0

	for k,v in pairs(terr.tPoints) do
		terr.wsrvx = terr.wsrvx + v.x
		terr.wsrvy = terr.wsrvy + v.y
	end
	terr.wsrvx = terr.wsrvx/#terr.tPoints
	terr.wsrvy = terr.wsrvy/#terr.tPoints
end

function isInPolSubCheck(element)
	local typ = getElementType(element)
	if (typ == "player") or (typ == "ped") then
		local x,y,z = getElementPosition(element)
		if (z < 4000) and (z > -4000) then
			return true
		end
	end
end


totalOwners = {
	{ index = 1, owner = "Ballas" },
	{ index = 2, owner = "Ballas" },
	{ index = 3, owner = "Groove" },
	{ index = 4, owner = "Ballas" },
	{ index = 5, owner = "Groove" },
	{ index = 6, owner = "Ballas" },
	{ index = 7, owner = "Vagos" },
	{ index = 8, owner = "none" },
	{ index = 9, owner = "Groove" },
	{ index = 10, owner = "Vagos" },
	{ index = 11, owner = "Ballas" },
	{ index = 12, owner = "Ballas" },
	{ index = 13, owner = "Groove" },
	{ index = 14, owner = "Groove" },
	{ index = 15, owner = "Vagos" },
	{ index = 16, owner = "Vagos" },
	{ index = 17, owner = "Vagos" },
	{ index = 18, owner = "Vagos" },
	{ index = 19, owner = "Ballas" },
	{ index = 20, owner = "none" },
	{ index = 21, owner = "none" },
	{ index = 22, owner = "Ballas" },
	{ index = 23, owner = "Groove" },
	{ index = 24, owner = "Groove" },
	{ index = 25, owner = "Groove" },
	{ index = 26, owner = "Vagos" },
	{ index = 27, owner = "Vagos" },
	{ index = 28, owner = "Vagos" },
	{ index = 29, owner = "Groove" },
	{ index = 30, owner = "Groove" },
	{ index = 31, owner = "none" },
	{ index = 32, owner = "none" },
	{ index = 33, owner = "none" },
	{ index = 34, owner = "Ballas" },
	{ index = 35, owner = "Groove" },
	{ index = 36, owner = "Groove" },
	{ index = 37, owner = "none" },
	{ index = 38, owner = "Vagos" },
	{ index = 39, owner = "none" },
	{ index = 40, owner = "Aztec" },
	{ index = 41, owner = "Aztec" },
	{ index = 42, owner = "none" },
	{ index = 43, owner = "Groove" },
	{ index = 44, owner = "Aztec" },
	{ index = 45, owner = "Aztec" },
	{ index = 46, owner = "Aztec" },
	{ index = 47, owner = "none" },
	{ index = 48, owner = "Groove" },
	{ index = 49, owner = "Aztec" },
	{ index = 50, owner = "Aztec" },
	{ index = 51, owner = "Aztec" },
	{ index = 52, owner = "Aztec" },
	{ index = 53, owner = "Aztec" },
	{ index = 54, owner = "Aztec" },
	{ index = 55, owner = "none" },
	{ index = 56, owner = "Vagos" },
	{ index = 57, owner = "Vagos" },
	{ index = 58, owner = "Aztec" },
	{ index = "BASE A", owner = "Aztec" },
	{ index = "BASE V", owner = "Vagos" },
	{ index = "BASE B", owner = "Ballas" },
	{ index = "BASE G", owner = "Groove" }
}
function getTotalOwner(terrIndex)
	for k,v in pairs(totalOwners) do
		if v.index == terrIndex then return v.owner end
	end
end




---------------------------------------------------------------------
end
return Terrytory_Sh
