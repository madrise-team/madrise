----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulSh.lua')()    -- Usful Server
import('Organizations/Territory_Sh.lua')()    -- Terrytory_Sh

rlsc = exports.RRL_Scripts


local dTerritorys = false
local sDrawTerritorys = false
local wDrawpoints = true

bindKey("f7","down",function()
	wDrawpoints = not wDrawpoints
end)
bindKey("f5","down",function()
	dTerritorys = not dTerritorys
end)
bindKey("f6","down",function()
	sDrawTerritorys = not sDrawTerritorys
end)

----------------------------------
drawsLocalData = exports.Draws:getDrawsLocalData()
test = drawsLocalData.test

function reformatTP(tPointsT,z)
	
	for k,v in pairs(tPointsT) do
		v.z = z
		v.u = 1
		v.v = 1
	end
	
	return tPointsT
end

function srArfm(terr)
	local srX,srY,srZ = unpack({0,0,40})
	for i=1,#terr.tPoints do
		local v = terr.tPoints[i];
		srX = srX + v.x
		srY = srY + v.y
	end
	srX = srX/#terr.tPoints
	srY = srY/#terr.tPoints

	return srX,srY,srZ
end


addEvent("debugTerritory",true)
--Terrytorys = {}

local territorysRT
addEventHandler("onClientRestore",root,function()
	territorysRT = writeTerritoriesToRT(Terrytorys)
end)
addEventHandler("debugTerritory",root,function(Terrytorysy)
	Terrytorys = Terrytorysy
	territorysRT = writeTerritoriesToRT(Terrytorys)
	
	addEventHandler("onClientRender",root,function()
--	local territorysRT = writeTerritoriesToRT(Terrytorys)
		if sDrawTerritorys then
			dxDrawRectangle(815,30,980,1030,tocolor(30,30,30,255))
		end
		for k,terr in pairs(Terrytorys) do
			if dTerritorys then
				local srX,srY,srZ = srArfm(terr)
				--- borders
				for j=5,5 do
					for i=1,#terr.tPoints-1 do
						local v = terr.tPoints[i]; local v1 = terr.tPoints[i+1]
						dxDrawMaterialLine3D(v.x,v.y,11*j,v1.x,v1.y,11*j,
											true,test,100,tocolor(255,255,255,150),false,srX,srY,11*j)
					end
				end
				--- /borders

				--- connections
				for k,conn in pairs(terr.connections) do
					local t2srX,t2srY,t2srZ = srArfm(Terrytorys[conn])
					dxDrawMaterialLine3D(srX,srY,srZ, t2srX,t2srY,t2srZ,
									true,test,2,tocolor(155,255,255,255),false,srX,srY,100000)
				end
				--- /connections

				--- nameDraw
				local xe,ye = getScreenFromWorldPosition(srX,srY,40)
				if xe then
					dxDrawRectangle(xe-18,ye-18,107,52,tocolor(25,25,25,255))
					dxDrawRectangle(xe-15,ye-15,100,46,territoryColors[terr.owner])
					dxDrawText(terr.index,xe-3,ye-8,0,0,tocolor(255,255,255,255),2)
				end
				--- /nameDraw
			end
		end
		if sDrawTerritorys then -----------------------------------------------------------------------------
			for terrRTtK,terrRTtV in pairs(territorysRT) do
				local terr = Terrytorys[terrRTtK]
				local colo = territoryColors[terr.owner]
				if tostring(terr.index):sub(1,1) == "B" then
					colo = fromColor(territoryColors[terr.owner])
					colo = tocolor(colo.r*1.1,colo.g*1.1,colo.b*1.1,colo.a)
				end
				dxDrawImage(terrRTtV.locSize.x,terrRTtV.locSize.y,terrRTtV.locSize.w,terrRTtV.locSize.h,terrRTtV.rt,
							0,0,0,colo)
			end

			for k,terr in pairs(Terrytorys) do
				for tpk,tpv in pairs(terr.tPoints) do
					if tpk ~= #terr.tPoints then
						local nexp = terr.tPoints[tpk + 1]

						dxDrawLine(tpv.xv,tpv.yv,nexp.xv,nexp.yv,tocolor(0,0,0,255))
					end
				end
				dxDrawText(terr.index,terr.srvx,terr.srvy,0,0,tocolor(255,255,255,255),1.1,1.1,"default","left","top",false,false,true)
				for conk,conv in pairs(terr.connections) do
					local sx = terr.srvx
					local sy = terr.srvy
					local ex = Terrytorys[conv].srvx
					local ey = Terrytorys[conv].srvy

					
					if napravSoedineniy then
						local doubleConn = false
						for k,v in pairs(Terrytorys[conv].connections) do
							if v == terr.index then
								doubleConn = true
							end
						end
						if doubleConn then
							dxDrawLine(sx,sy,ex,ey,tocolor(255,255,255,200),5)
						else
							dxDrawLine(sx,sy,ex,ey,tocolor(255,15,15,255),2)
						end
					else
						dxDrawLine(sx,sy,ex,ey,tocolor(255,255,255,12),3)
					end
				end
			end


			for initerName,initer in rpairs(sortedIniters) do
				local initerInitTerr = Terrytorys[initer.initTerrit]

				for connI,conn in pairs(initerInitTerr.connections) do
					local connTerr = Terrytorys[conn]
					if connTerr.owner == initer.name then
						local sx = connTerr.srvx
						local sy = connTerr.srvy
						local ex = initerInitTerr.srvx
						local ey = initerInitTerr.srvy

						local raznX = (ex - sx)
						local raznY = (ey - sy)

						local cx = sx + raznX/2
						local cy = sy + raznY/2

						local dist = getDistanceBetweenPoints2D(sx,sy,ex,ey)/2

						local ugol = 180*math.atan2(raznY,raznX)/math.pi

						
						local colol = fromColor(territoryColors[initer.name])
						if not initer.warning then
							colol = tocolorT(_,colol.r*1.5,colol.g*1.5,colol.b*1.5,255)
						else
							colol = tocolorT(_,255,255,255,125)
						end
						drawMoveLine(cx-dist/2,cy-10,dist,20, ugol,(-498/2)+dist/2,0,colol)
						
					end

				end
			end
			for terrIndex,v in pairs(battles) do
				local battleTerr = Terrytorys[terrIndex]

				local icoCol1 = fromColor(territoryColors[v.sides[1].name])
				icoCol1 = tocolorT(_,icoCol1.r*2,icoCol1.g*2,icoCol1.b*2,120)
				local ico2 = ":Draws/Elements/log/logGlow.png"
				if v.sides[2].name ~= "none" then
				if battleTerr.owner == v.sides[2].name then
						ico2 = "deffIco.png"
					else
						ico2 = "battleIco.png"
					end
				end
				local icoCol2 = fromColor(territoryColors[v.sides[2].name])
				icoCol2 = tocolorT(_,icoCol2.r*2,icoCol2.g*2,icoCol2.b*2,120)
				-- shadows
				dxDrawImage(battleTerr.srvx + 5,battleTerr.srvy + 7,50,50,ico2,0,0,0,tocolor(0,0,0,60))
				dxDrawImage(battleTerr.srvx-25 + 5,battleTerr.srvy + 7 -10,50,50,"battleIco.png",0,0,0,tocolor(0,0,0,60))
				--
				dxDrawImage(battleTerr.srvx,battleTerr.srvy,50,50,ico2,0,0,0,icoCol2)
				dxDrawImage(battleTerr.srvx-25,battleTerr.srvy-10,50,50,"battleIco.png",0,0,0,icoCol1)
			end

		end
	end)
end)

addEventHandler("onClientRender",root,function() 						--	Indicate battles ----------------------
	for k,v in pairs(sortedIniters) do
		local textTerrCol = fromColor(territoryColors[v.name])
		textTerrCol = tocolorT(_,textTerrCol.r*1.4,textTerrCol.g*1.4,textTerrCol.b*1.4,255)

		dxDrawRectangle(100-1 + 101*k,200-1,100+2,500+2,territoryColors[v.name])
		dxDrawRectangle(100 + 101*k,200,100,500,tocolor(15,15,15,200))
		dxDrawText(v.name,105 + 100*k,200,0,0,textTerrCol,1.3)

		textTerrCol = fromColor(territoryColors[Terrytorys[v.initTerrit].owner])
		textTerrCol = tocolorT(_,textTerrCol.r*1.5,textTerrCol.g*1.5,textTerrCol.b*1.5,255)
		dxDrawText(v.initTerrit.."<-",108 + 100*k,204 + 22,0,0,textTerrCol,1.3)
		dxDrawText(v.initPower,180 + 100*k,200,0,0,nil,1.3)
		dxDrawText(v.initerHod,165 + 100*k,203)
		local timeToEnd = getTimeToEnd(v.timerT.timerEndTime)
		dxDrawText(timeToEnd.hours.." : "..timeToEnd.mins.." : "..timeToEnd.secs,110 + 100*k,210 + 40)
		if v.warning then
			dxDrawImage(104 + 101*k,270,20,20,"warning.png")
			for indx,val in pairs(v.warning) do
				dxDrawText(val,108 + 100*k,220 + indx*75,100 + 101*k + 90,10000,nil,1,1,"default","left","top",false,true)
			end
		end
	end

	local forI = 0
	for k,v in pairs(battles) do
		local x1 = 100-1 +210*forI
		local x2 = x1 + 100
		local xc = x1+50
		local y = 700

		dxDrawRectangle(x1-1,	y-1,	100,100+2,	territoryColors[v.sides[1].name])
		dxDrawRectangle(x1,	 	y,		100,100,	tocolor(15,15,15,200))
		if not v.sides[2] then v.sides[2] = {name = "none",forces = {count = "-",elements = {}}} end
		dxDrawRectangle(x2-1,	y-1,	100+2,100+2,	territoryColors[v.sides[2].name])
		dxDrawRectangle(x2,		y,		100,100,	tocolor(15,15,15,200))
		


		dxDrawRectangle(x1+ 75,	y-1,	50,100+2,	tocolor(160,160,160,255))
		dxDrawRectangle(x1+ 75+1,	y-1 + 1,	50 - 2,100+2 -2,	tocolor(40,40,40,255))




		local nameCol1 = fromColor(territoryColors[v.sides[1].name])
		nameCol1 = tocolorT(_,nameCol1.r*1.5,nameCol1.g*1.5,nameCol1.b*1.5,255)
		fullText(v.sides[1].name,x1+12, y +4,	100,y + 20, nameCol1, 1.3,"left")

		local nameCol2 = fromColor(territoryColors[v.sides[2].name])
		nameCol2 = tocolorT(_,nameCol2.r*1.5,nameCol2.g*1.5,nameCol2.b*1.5,255)
		fullText(v.sides[2].name,x2, y +4,	100 - 12,y + 20, nameCol2, 1.3,"right")

		local icoCol1 = fromColor(territoryColors[v.sides[1].name])
		icoCol1 = tocolorT(_,icoCol1.r*3,icoCol1.g*3,icoCol1.b*3,40)
		dxDrawImage(x1+8,y+40,50,50,"battleIco.png",0,0,0,icoCol1)
		local ico2 = ":Draws/Elements/log/logGlow.png"
		if v.sides[2].name ~= "none" then
			if Terrytorys[k].owner == v.sides[2].name then
				ico2 = "deffIco.png"
			else
				ico2 = "battleIco.png"
			end
		end
		local icoCol2 = fromColor(territoryColors[v.sides[2].name])
		icoCol2 = tocolorT(_,icoCol2.r*3,icoCol2.g*3,icoCol2.b*3,40)
		dxDrawImage(x2+100-8 - 50,y+40,50,50,ico2,0,0,0,icoCol2)

		local terrCol = fromColor(territoryColors[Terrytorys[k].owner])
		terrCol = tocolorT(_,terrCol.r*1.5,terrCol.g*1.5,terrCol.b*1.5,255)
		fullText("["..k.."]",xc, y + 30,	100,1000, terrCol, 1,"center")

		local timeToEnd = getTimeToEnd(v.timerT.timerEndTime)
		fullText("VS",x1, y+5,	200,1000, nil, 1.2,"center")
		fullText(v.points.now,xc, y + 52,	100,1000, nil, 1.3,"center")
--		fullText(v.points.min,x1+14, 	y + 52,	200,1000, nameCol2, 1.3,"left")
--		fullText(v.points.max,x1, 		y + 52,	200-14,1000, nameCol1, 1.3,"right")

		fullText(timeToEnd.mins.." : "..timeToEnd.secs,xc, y + 80,	100,1000, nil, 1,"center")


		fullText(v.sides[1].forces.count,x1 - 5, 	y + 80,	75,1000, nameCol1, 1.2,"right")
		fullText(v.sides[2].forces.count,x2 + 25 + 5,y + 80,	75,1000, nameCol2, 1.2,"left")

		for si,side in pairs(v.sides) do
			for elmk,elm in pairs(side.forces.elements) do
				local ex,ey,ez = getElementPosition(elm)
				local x,y = getScreenFromWorldPosition ( ex,ey,ez + 1, 10000000000)

				if y then
					if x > 1920 then x = 1920 end
					if x < 0 then x = 0 end

					if y > 1080 then y = 1080 end
					if y < 0 then y = 0 end

					local wh = 20
					dxDrawRectangle(x-wh/2 - 2,y-wh/2 - 2,wh + 4,wh + 4,tocolor(25,25,25,200))
					dxDrawRectangle(x-wh/2,y-wh/2,wh,wh,territoryColors[side.name])
				end
			end
		end

		local side1Progress = v.points.now / v.points.max
		local side2Progress = (v.points.max - v.points.now) / (v.points.min + v.points.max)
		
		dxDrawRectangle(x1 - 1,y+102 - 1,200*side1Progress + 2,15 + 2,tocolor(25,25,25,255))
		dxDrawRectangle(x1,y+102,200*side1Progress,15,territoryColors[v.sides[1].name])
		dxDrawRectangle(x2+100 + 1,y+102 - 1,-200*side2Progress - 2,15 + 2,tocolor(25,25,25,255))
		dxDrawRectangle(x2+100,y+102,-200*side2Progress,15,territoryColors[v.sides[2].name])

		if v.domination then
			local domDir = 1

			local domText = ">"
			local domX = x1 + 125 + 5
			local domAlignX = "left"
			local domMultK = 1

			local domCol = fromColor(territoryColors[v.domination.side.name])
			domCol = tocolorT(_,domCol.r*1.5,domCol.g*1.5,domCol.b*1.5,255)

			if v.domination.side == v.sides[2] then
				domText = "<"
				domX = x1 - 25 - 5
				domAlignX = "right"
				domDir = -1
			end

			for i=1,v.domination.power do
				local mult= (i-1)
				fullText(domText,domX + 14*mult*domDir, y,	100,120, domCol, 1.6 + 0.4*mult,domAlignX,"center")	
			end

			if v.domination.side == v.sides[1] then
				drawMoveLine(x1,y+102,200*side1Progress,15,0,0,0,nameCol1)
			else
				drawMoveLine(x2+100,y+102,-200*side2Progress,15,0,0,0,nameCol2)
			end
		end

		--local side2Progress = v.points.now / v.points.min

		forI=forI+1
	end
end)







addEvent("debugPoints",true)
addEventHandler("debugPoints",root,function(tPoints)
	addEventHandler("onClientRender",root,function()
		if wDrawpoints then	
			for k,v in pairs(tPoints) do
				local x,y = getScreenFromWorldPosition(v.x,v.y,40)
				if x then
					dxDrawRectangle(x-10,y-10,46,22,tocolor(255,255,255,150))
					dxDrawRectangle(x-8,y-8,42,18,tocolor(10,10,10,255))
					dxDrawText(v.index,x-3,y-9,0,0,tocolor(255,255,255,255),1.3)
				end
			end
		end
	end)
end)

function minMaxerTPoint(tPoints)
	local minX = 27000
	local maxX = 0
	local minY = 27000
	local maxY = 0
	for k,v in pairs(tPoints) do
		if v.xv < minX then minX = v.xv end
		if v.xv > maxX then maxX = v.xv end

		if v.yv < minY then minY = v.yv end
		if v.yv > maxY then maxY = v.yv end
	end

	return minX,maxX,minY,maxY
end



----------------------------- SIMULATES ------------------------------------------------------------
function initBand(name)
	return {
		name = name,
		owned = {},
		connects = {},
		going = {},
		summpower = 0
	}
end
local bandy = {
	initBand("Ballas"),
	initBand("Groove"),
	initBand("Vagos"),
	initBand("Aztec"),
}

function findOtrezku(terr,desConns,critTers)
	for connectedTerrI,connectedTerrIndex in pairs(terr.connections) do
		local connectedTerr = Terrytorys[connectedTerrIndex]
		if connectedTerr.owner == "conquest" or connectedTerr.owner == "none" then
			for conquestedTerrConI,conquestedTerrConIndex in pairs(connectedTerr.connections) do
				local conquestedTerrCon = Terrytorys[conquestedTerrConIndex]
				if conquestedTerrCon.owner == terr.owner then
					if not critTers[conquestedTerrCon.index] then
						return connectedTerr
					end
				end
			end
		end
	end
	desConns[terr.index] = terr.index
	for connectedTerrI,connectedTerrIndex in pairs(terr.connections) do
		local connectedTerr = Terrytorys[connectedTerrIndex]
		if not desConns[connectedTerr.index] then
			if connectedTerr.owner == terr.owner then
				local result = findOtrezku(connectedTerr,desConns,critTers)
				if result then
					return result
				end
			end 
		end
	end
	return false
end
function calculateDistFromBaseToTerrs(baseName)
	doIterationCalculateDistFromBaseToTerr(Terrytorys[baseName],Terrytorys[baseName].owner,-1)
end
function doIterationCalculateDistFromBaseToTerr(terr,bandaName,distance)
	distance = distance + 1
	terr.stats.distToBases[bandaName].dist = distance

	for k,conn in pairs(terr.connections) do
		if Terrytorys[conn].stats.distToBases[bandaName].dist > distance+1 then
			Terrytorys[conn].stats.distToBases[bandaName].shortestToBaseIndx = terr.index
			if not Terrytorys[conn].cantCapture then
				doIterationCalculateDistFromBaseToTerr(Terrytorys[conn],bandaName,distance)
			else
				Terrytorys[conn].stats.distToBases[bandaName].dist = distance + 1
			end
		end
	end
end

function initTerrStats()
	for terrk,terr in pairs(Terrytorys) do
		terr.stats = {
			contollStats = {
				none = 0,
				conquest = 0
			},
			distToBases = {}
		}
		for k,v in pairs(bandy) do
			terr.stats.contollStats[v.name] = 0
			terr.stats.distToBases[v.name] = {dist = 10000}
		end
	end


	---- calculateDistances From Bases to terrs
	for k,v in pairs(bandy) do
		calculateDistFromBaseToTerrs("BASE "..v.name:sub(1,1))
	end
end

outputDebugString("setCameraTarget(localPlayer) Teritory_C,sim")
setCameraTarget(localPlayer)
function simulate1()
	local TerrytorysPrvCadr;
	local prevCadrMode = false
	local totlSimTicks = 0
	local px,py,pz = getElementPosition(localPlayer)
	setElementPosition(getCamera(),px,py,pz + 10)



	initTerrStats()


	local hody = {}
	local savedCaders = {}
	local savedBandy = {}
	local savedHody = {}

	for i=1,10 do
		table.insert(savedCaders,1,copy(Terrytorys))
		table.insert(savedBandy,1,copy(bandy))
		table.insert(savedHody,1,copy(hody))
	end
	function simPlease()
		-- table.insert(savedCaders,1,copy(Terrytorys))
		-- table.insert(savedBandy,1,copy(bandy))
		-- table.insert(savedHody,1,copy(hody))

		if totlSimTicks > 10 then
			-- table.remove(savedCaders,11)
			-- table.remove(savedBandy,11)	
			-- table.remove(hody,11)	
		end



		hody = {}
		if prevCadrMode then return end
		TerrytorysPrvCadr = copy(Terrytorys)
		totlSimTicks = totlSimTicks + 1
		--outputDebugString("--")
		for terrk,terr in pairs(Terrytorys) do
			if terr.owner == "conquest" then
				local tabc = tableCount(terr.conquestContext.sides)
				local winner = math.random(1,tabc)

				local index = 0
				--outputDebugString("check"..terr.index.."  "..tabc)
				for k,v in pairs(terr.conquestContext.sides) do
					index = index + 1
					if index == winner then
						Terrytorys[terr.index].owner = v.banda.name
						Terrytorys[terr.index].conquestContext = nil
						--outputDebugString("terr win "..terr.index.." :"..v.name)
						break
					end
					
				end
			end
		end
		for terrk,terr in pairs(Terrytorys) do
			terr.connectFailed = false
			if terr.owner ~= "none" then
				if not findMyBase(terr,"BASE "..terr.owner:sub(1,1)) then
					terr.owner = "none"
					terr.connectFailed = true
					--outputDebugString(terr.index.."sletela")
				end
			end
		end

		--outputDebugString("-------")
		for i=1,3 do
			bandy = randomSort(bandy)
			for bandaIndex,banda in pairs(bandy) do
				hody[#hody + 1] = banda.name

				banda.owned = {}
				banda.connects = {}
				banda.going = {}
				banda.criticalTerrs = {}

				for terrk,terr in pairs(Terrytorys) do
					if terr.owner == banda.name then
						banda.owned[terrk] = terr
					end
				end
				banda.summpower = banda.summpower + tableCount(banda.owned)
				for terrk,vterr in pairs(banda.owned) do
					if findMyBase(vterr,"BASE "..vterr.owner:sub(1,1)) then
						for connectk,connect in pairs(vterr.connections) do
							if (Terrytorys[connect].owner ~= banda.name) and (Terrytorys[connect].cantCapture == false) then
								banda.connects[connect] = Terrytorys[connect]
							end
						end
					else
						banda.criticalTerrs[vterr.index] = vterr
					end
				end

				local goingNums = 0
				local totalCritConcont = tableCount(banda.criticalTerrs)
				-- if totalCritConcont > 0 then totalCritConcont = totalCritConcont + 1 end
					
				---------------------------------------------------------------				
					if goingNums == 1 then break end
					if(totalCritConcont > 0) then
						local cCrts = tableCount(banda.criticalTerrs)
						local tryToGoing = math.random(1,cCrts)
						local index = 0 
						for k,v in pairs(banda.criticalTerrs) do
							index = index + 1
							if index == tryToGoing then
								-- totalCritConcont = totalCritConcont - 1
								local otrezalka = findOtrezku(v,{},banda.criticalTerrs)
								if otrezalka then
									banda.going[#banda.going + 1] = {index = otrezalka.index,deff = v.index}
									goingNums = goingNums + 1
									break
								end
							end
						end	
					else
						local haveNoneConnects = false
						local unNoneConnects = {}
						for k,v in pairs(banda.connects) do
							if v.owner == "none" then
								haveNoneConnects = true
							else
								unNoneConnects[#unNoneConnects + 1] = k
							end
						end
						if haveNoneConnects then
							for k,v in pairs(unNoneConnects) do
								banda.connects[v] = nil
							end
						end				

						local concont = tableCount(banda.connects)
						local tryToGoing = math.random(1,concont)
						local index = 0
						for k,v in pairs(banda.connects) do
							index = index + 1
							if index == tryToGoing then
								banda.going[#banda.going + 1] = {index = v.index} 
								goingNums = goingNums + 1
								break
							end
						end
					end
				---------------------------------------------------------------

				for goingConnIndx,goingConnT in pairs(banda.going) do
					local goingConn = goingConnT.index
					Terrytorys[goingConn].conquestContext = Terrytorys[goingConn].conquestContext or {sides = {},prevOwner = Terrytorys[goingConn].owner}
					Terrytorys[goingConn].owner = "conquest"
					table.insert(Terrytorys[goingConn].conquestContext.sides,{banda = banda,context = {deff = goingConnT.deff}})
					local coc = tableCount(Terrytorys[goingConn].conquestContext.sides)
					--outputDebugString(banda.name.." shodila at "..Terrytorys[goingConn].index.."; terrSides: "..coc)
				end
			end	
		end

		---- Stats Control *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		for k,v in pairs(Terrytorys) do
			v.stats.contollStats[v.owner] = v.stats.contollStats[v.owner] + 1
		end
		---- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
	end

	--------------------------------------------------------------------- SIM control --------------------
	simPlease()
	local simTimer = 0;

	function removeTimer()
		if simTimer ~= 0 then killTimer(simTimer) end
		simTimer = 0
	end
	function moveCadr(n)
		prevCadrModeCadr = prevCadrModeCadr + 1*n
		if prevCadrModeCadr < 1 then prevCadrModeCadr = 1 end
		if prevCadrModeCadr > 10 then prevCadrModeCadr = 10 end
	
		Terrytorys = savedCaders[prevCadrModeCadr]
		bandy = savedBandy[prevCadrModeCadr]
		hody = savedHody[prevCadrModeCadr]
	end

	bindKey("arrow_r","down",function()
		if zalivkaMode then return end
		if not prevCadrMode then
			simPlease()
			simTimer = setTimer(simPlease,80,0)
		else
			moveCadr(-1)
			simTimer = setTimer(moveCadr,80,0,-1)
		end
	end)
	bindKey("arrow_r","up",function()
		removeTimer()
	end)
	bindKey("arrow_l","up",function()
		removeTimer()
	end)

	zalivkaMode = false	
	bindKey("c","down",function()
		zalivkaCard = 0
		zalivkaMode = not zalivkaMode
	end)


	local siminRender = false
	bindKey("arrow_l","down",function()
		if zalivkaMode then return end
		if not prevCadrMode then
			siminRender = not siminRender
		else
			moveCadr(1)
			simTimer = setTimer(moveCadr,80,0,1)
		end
	end)
	addEventHandler("onClientRender",root,function()
		if siminRender then
			for i=1,100 do
				simPlease()
			end
		end
	end)

	local savedLastCadr;
	local savedBandyLastCadr;
	local savedHodyLastCadr;
	bindKey("arrow_d","up",function()
		if zalivkaMode then return end
		siminRender = false
		if not prevCadrMode then
			prevCadrModeCadr = 1
			removeTimer()

			savedLastCadr = copy(Terrytorys)
			savedBandyLastCadr = copy(bandy)
			savedHodyLastCadr = copy(hody)
			Terrytorys = savedCaders[prevCadrModeCadr]
			bandy = savedBandy[prevCadrModeCadr]
			hody = savedHody[prevCadrModeCadr]
			
			prevCadrMode = true
		else
			Terrytorys = savedLastCadr
			bandy = savedBandyLastCadr
			hody = savedHodyLastCadr

			prevCadrMode = false
		end
	end)

	local debTerritory = false
	bindKey("mouse2","down",function()
		if debTerritory then
			debTerritorySmes = not debTerritorySmes
		end
	end)
	bindKey("mouse1","down",function()
		--debTerritorySmes = false
		debTerritory = false
		if not isCursorShowing() then return end
		local cursX,cursY = getCursorPosition()
		for k,v in pairs(Terrytorys) do
			local formedTPoints = {}
			for k,v in pairs(v.tPoints) do
				formedTPoints[k] = {x = v.xv,y = v.yv}
			end


			if isInPolygon(formedTPoints,{x=cursX*1920,y=cursY*1080}) then
				debTerritory = v.index
			end
		end
	end)

	local upravlenie = false
	bindKey("F1","down",function()
		upravlenie = not upravlenie
	end)

	local rasstoyaniya = true
	bindKey("Z","down",function()
		rasstoyaniya = not rasstoyaniya
	end)
	napravSoedineniy = false
	bindKey("X","down",function()
		napravSoedineniy = not napravSoedineniy
	end)


	--------------------------------------------------------------------- SIM control -----------------------

	--------------------------------------------------------------------- Deb -----------------------
	function fullText(text,leftX,topY,wX,hY,color,scale,alignX,alignY)
		dxDrawText(text,leftX,topY,leftX + wX, topY+hY,color or tocolor(255,255,255,255), scale, scale,"default", alignX, alignY, false,false,true)
	end

	addEventHandler("onClientRender",root,function()
		if not sDrawTerritorys then return end
		if upravlenie then
			dxDrawRectangle(815 - 300 - 2,30 - 2,300 +4 ,505 + 4,tocolor(164,164,164,255))
			dxDrawRectangle(815 - 300,30,300,505,tocolor(25,25,25,255))

			local otsp = 35

			fullText("Управление: ",525,35,300,200,tocolor(255,255,255,150),1.4)
			fullText("[ > ] ",525,80 + otsp*											0,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Следующий шаг ",525,80 + otsp*									0,277,200,tocolor(255,255,255,150),1.4,"right")
			fullText("[ < ] ",525,80 + otsp*											1,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Ускоренная симуляция/\nПредыдущ. шаг",525,80 + otsp*				1,277,200,tocolor(255,255,255,150),1.4,"right")
			fullText("[ v ] ",525,80 + otsp*											3,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Просмотр предыдущ. шагов",525,80 + otsp*							3,277,200,tocolor(255,255,255,150),1.4,"right")
			fullText("[ mouse1 ] ",525,80 + otsp*										4,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Дебаг территории",525,80 + otsp*									4,277,200,tocolor(255,255,255,150),1.4,"right")
			fullText("[ mouse2 ] ",525,80 + otsp*										5,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Смена режима\n отображения дебага\n территории",525,80 + otsp*	5,277,200,tocolor(255,255,255,150),1.4,"right")

			fullText("[ Z ] ",525,80 + otsp*											7,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Вкл./Выкл. отображения\n расстояний",525,80 + otsp*				7,277,200,tocolor(255,255,255,150),1.4,"right")
			fullText("[ X ] ",525,80 + otsp*											9,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Вкл./Выкл. отображения\n направления соединений",525,80 + otsp*	9,277,200,tocolor(255,255,255,150),1.4,"right")

			fullText("[ C ] ",525,80 + otsp*											10.5,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Вкл./Выкл. Режима\n контроля конфлитов",525,80 + otsp*			10.5,277,200,tocolor(255,255,255,150),1.4,"right")

			fullText("[ F1 ] ",525,80 + otsp*											12,277,200,tocolor(255,255,255,150),1.4,"left")
			fullText(" Показ/Скрыть управление",525,80 + otsp*							12,277,200,tocolor(255,255,255,150),1.4,"right")
		end
		
		--fullText("[ > ] - ",525,65 + 10*		0,283,200,nil,1.4,"left")
		--fullText(" Следующий шаг ",525,65 + 10*	0,283,200,nil,1.4,"right")


		local deBundy = {}
		if prevCadrMode then 
			dxDrawRectangle(815,0,980,30,tocolor(60,25,25,255))
			dxDrawText(" Включен режим просмотра предыдущего тика Тик: "..(-prevCadrModeCadr),815,0,0,0,tocolor(50,150,255,255),1.9)
		
		elseif siminRender then
			dxDrawRectangle(815,0,980,30,tocolor(25,45,46,255))
			dxDrawText(" Включен режим ускоренной симуляции",815,0,0,0,tocolor(125,150,50,255),1.9)
		elseif zalivkaMode then
			dxDrawRectangle(815,0,980,30,tocolor(45,105,155,255))
			dxDrawText(" Включен режим контроля конфликов",815,0,0,0,tocolor(200,250,200,255),1.9)
		elseif not upravlenie then
			dxDrawRectangle(815,0,980,30,tocolor(35,35,45,200))
			dxDrawText(" Показать управление - [ F1 ]",815,0,0,0,tocolor(255,255,255,160),1.9)
		end


		for hodI,bandaName in ipairs(hody) do
			dxDrawText(hodI.."."..bandaName, 835 + hodI, 160 + 24*hodI, 0,0)
			if hodI ~= #hody then
				dxDrawText("v", 835 + 20, 160 + 24*hodI + 13, 0,0,nil,0.8)
			end
		end

		for k,v in pairs(bandy) do
			if v.name == "Ballas" then
				deBundy[1] = v
			elseif v.name == "Groove" then
				deBundy[2] = v
			elseif v.name == "Vagos" then
				deBundy[3] = v
			elseif v.name == "Aztec" then
				deBundy[4] = v
			end
		end
		for bandaIndex,banda in pairs(deBundy) do
			local bandPower = tableCount(banda.owned)
			fullText(banda.name .. ": ",835,30 + 20*bandaIndex,0,0,nil,1.2)
			fullText("Pow "..tableCount(banda.owned),895,30 + 20*bandaIndex,0,0,nil,1.2)
			fullText(" | tSrP: "..tonumber(string.format("%.3f", banda.summpower/totlSimTicks)),950,30 + 20*bandaIndex,0,0,nil,1.2)
		end

		dxDrawText("Ticks simulated: "..totlSimTicks,835,140,0,0,nil,1.2)
		for terrk,terr in pairs(Terrytorys) do
			if not findMyBase(terr,"BASE "..terr.owner:sub(1,1)) then
				if terr.owner ~= "none" and terr.owner ~= "conquest" then
					dxDrawRectangle(terr.srvx-4,terr.srvy-3,20,20,tocolor(255,95,95,165))
				end
			end
			if terr.connectFailed then
				fullText("-x-",terr.srvx + 18,terr.srvy-3,0,0,tocolor(255,255,255,255),1.2)
			end
			if terr.owner == "conquest" then
				local sidesC = tableCount(terr.conquestContext.sides)
				local inx = 0
				for k,v in pairs(terr.conquestContext.sides) do
					--dxDrawRectangle(terr.srvx-5-1 + 10*(inx),terr.srvy-5-1,10+2,10+2,tocolor(5,5,5,255))
					if v.context.deff then
						dxDrawImage(terr.srvx-9 + 17*inx,   terr.srvy-20,    18,24,"deffIco.png",0,0,0,territoryColors[v.banda.name])
						dxDrawText(v.context.deff,  terr.srvx -4 + 17*inx,   terr.srvy-15,    12,12,nil,0.8,1,"default")
					else
						dxDrawRectangle(terr.srvx-9 + 17*(inx),terr.srvy-15,18,18,tocolor(15,15,15,255))
						dxDrawRectangle(terr.srvx-8 + 17*(inx),terr.srvy-14,16,16,territoryColors[v.banda.name])
					end
					inx = inx + 1
				end
				dxDrawRectangle(terr.srvx-9,terr.srvy+14,34,6,tocolor(15,15,15,255))
				dxDrawRectangle(terr.srvx-8,terr.srvy+14,32,4,territoryColors[terr.conquestContext.prevOwner])
			end
		end

		if zalivkaMode then
			local TotalDistValues = {}
			for k,v in pairs(bandy) do
				TotalDistValues[v.name] = 0
			end

			local distM = 10
			for tk,tv in pairs(Terrytorys) do
				dxDrawImage(territorysRT[tk].locSize.x,territorysRT[tk].locSize.y,territorysRT[tk].locSize.w,territorysRT[tk].locSize.h,territorysRT[tk].rt,
							0,0,0,tocolor(0,0,0,200))
				for bk,bv in pairs(bandy) do
					local raster = tv.stats.distToBases[bv.name].dist
					TotalDistValues[bv.name] = TotalDistValues[bv.name] + raster
				end
			end

			local forI = 0

			local debTotalDistValues = {}
			
			for k,v in pairs(TotalDistValues) do
				local insertIndex = 0
				if k == "Ballas" then
					insertIndex = 1
				elseif k == "Groove" then
					insertIndex = 2
				elseif k == "Vagos" then
					insertIndex = 3
				elseif k == "Aztec" then
					insertIndex = 4
				end
				debTotalDistValues[insertIndex] = {name = k,value = v}
			end


			for k,v in pairs(debTotalDistValues) do
				fullText(v.name,1090,900+30*forI,0,0,nil,1.5,"left")
				fullText(v.value/distM,1090,900+30*forI,150,0,nil,1.5,"right")
				forI = forI + 1
			end
			fullText("} Плотность удаленных территорий",1050,975,540,0,nil,1.5,"right")
			fullText("(Если у базы плотность территорий и соединений меньше,\nто их легче контороллировать и воевать фракция будет дальше (как следствие больше tsrp))",1090,1020,0,0,nil,1,"left")

			local bandyControls = {}
			for k,v in pairs(bandy) do
				bandyControls[v.name] = {
					disabledPoints = {},
					points = {"BASE "..v.name:sub(1,1)}
				}
			end

			local drawLine = true
			zalivkaCard = zalivkaCard + 0.1

			local itrer = 0 
			while(drawLine and (itrer < zalivkaCard)) do
				itrer = itrer + 1
				drawLine = false
				for bk,bv in pairs(bandy) do
					local neddToAdd = {}
					for k,v in pairs(bandyControls[bv.name].points) do
						if v ~= false then
						  local vTerr = Terrytorys[v]
						  if (vTerr.influence == bv.name) or (not vTerr.influence) then
							bandyControls[bv.name].points[k] = false
							bandyControls[bv.name].disabledPoints[v] = true
							
							vTerr.influence = bv.name

							for vTerrConnIndx,vTerrConnV in pairs(vTerr.connections) do
								local vTerrConn = Terrytorys[vTerrConnV]
								if not bandyControls[bv.name].disabledPoints[vTerrConnV] and (not vTerrConn.cantCapture) then
									local smesPline = false
									
									local sx = vTerr.srvx
									local sy = vTerr.srvy
									local ex = vTerrConn.srvx
									local ey = vTerrConn.srvy

									if vTerrConn.influence ~= bv.name then
										ex = sx + (ex - sx)/2
										ey = sy + (ey - sy)/2

									end

									local coloc = fromColor(territoryColors[bv.name])
									coloc = tocolor(coloc.r/2,coloc.g/2,coloc.b/2,coloc.a)
									dxDrawLine(sx,sy,ex,ey,tocolor(35,35,35,100),10)
									dxDrawLine(sx,sy,ex,ey,coloc,8)
									drawLine = true

									if (vTerrConn.influence ~= bv.name) and (vTerrConn.influence ~= nil) then
										dxDrawRectangle(ex-5,ey-5,10,10,tocolor(255,5,5,255))
									end

									table.insert(neddToAdd,1,vTerrConnV) --afrtercycle Add new Points									
								end
							end
						  end
						end
					end

					for k,v in pairs(neddToAdd) do
						table.insert(bandyControls[bv.name].points ,1,v)
					end

				end
			end
		end


		if debTerritory then
			local dTer = Terrytorys[debTerritory]
			local x = dTer.srvx+15
			if debTerritorySmes then
				x = 600
			end

			local y = dTer.srvy+15
			local w = 220
			local h = 300
			if y > 1080 - h then
				y = 1080 - h - 10
			end
			if x > 1900 - w then
				x = 1900 - w
			end


			if debTerritorySmes then
				local xP = 8
				local yP = 8
				dxDrawLine(dTer.srvx-15 +xP,dTer.srvy-15 +yP,dTer.srvx+15 +xP,dTer.srvy-15 +yP,tocolor(255,255,255,100),2)
				dxDrawLine(dTer.srvx+15 +xP,dTer.srvy-15 +yP,dTer.srvx+15 +xP,dTer.srvy+15 +yP,tocolor(255,255,255,100),2)
				
				dxDrawLine(dTer.srvx+15 +xP,dTer.srvy+15 +yP,dTer.srvx-15 +xP,dTer.srvy+15 +yP,tocolor(255,255,255,100),2)
				dxDrawLine(dTer.srvx-15 +xP,dTer.srvy+15 +yP,dTer.srvx-15 +xP,dTer.srvy-15 +yP,tocolor(255,255,255,100),2)
			end
			

			dxDrawRectangle(x+8,y+8,w+3,h,tocolor(5,5,5,180),true)
			dxDrawRectangle(x-4,y-4,w+3+8,h+8,tocolor(95,95,95,255),true)
			dxDrawRectangle(x-2,y-2,w+3+4,h+4,territoryColors[dTer.owner],true)

			
			dxDrawRectangle(x,y,w+3,h,tocolor(65,65,65,255),true)

			fullText(debTerritory,x+15,y+8,w,200,nil,2.2)
			dxDrawRectangle(x+14,y+46,w-30+ 2,3 + 2,territoryColors[dTer.owner],true)
			dxDrawRectangle(x+15,y+47,w-30,3,tocolor(100,100,100,255),true)
			
			--fullText("Контроль территории ",x,y+70,w,20,nil,1,"center")

			local forIndex = 1
			local debConStats = {
				{summ = dTer.stats.contollStats['Ballas'],owner = 'Ballas'},
				{summ = dTer.stats.contollStats['Vagos'],owner = 'Vagos'},
				{summ = dTer.stats.contollStats['Groove'],owner = 'Groove'},
				{summ = dTer.stats.contollStats['Aztec'],owner = 'Aztec'},

				{summ = dTer.stats.contollStats['conquest'],owner = 'conquest'},
				{summ = dTer.stats.contollStats['none'],owner = 'none'},
			}

			for dcsk,dcsv in pairs(debConStats) do
				local owner = dcsv.owner
				local summ = dcsv.summ
				local otsutup = 20
				local plusOtstp = 0
				local col = tocolor(255,255,255,255)
				if owner == "conquest" or owner == "conquest" then 
					plusOtstp = 0

				end

				dxDrawRectangle(x+80,plusOtstp+ y+65 + otsutup*forIndex,w-126,2,tocolor(105,105,105,45),true)
				fullText(owner..": ",x+20,plusOtstp+ y+50 + otsutup*forIndex,w,200,col,1.4,"left")
				fullText(summ,x,plusOtstp+ y+50 + otsutup*forIndex,w-20+30,200,tocolor(255,255,255,80),1.3,"center")
				
				local srK = tonumber(string.format("%.1f", summ/totlSimTicks*100))
				fullText(srK.."%",x,plusOtstp+ y+50 + otsutup*forIndex,w-20,200,col,1.4,"right")
				
				forIndex = forIndex + 1
			end


			for k,banda in pairs(deBundy) do
				fullText(banda.name:sub(1,1),x-3 + k*20,y+250,10,10,nil,1.2)
				fullText(dTer.stats.distToBases[banda.name].dist,x-3 + k*20,y+270,10,10,nil,1.2)

				if rasstoyaniya then
					local bandaBaseIndex = "BASE "..banda.name:sub(1,1)
					if debTerritorySmes then
						local nowTerr = dTer
						while(true) do
							local nextTerrIndex = nowTerr.stats.distToBases[banda.name].shortestToBaseIndx
							if not nextTerrIndex then break end
							local nextTerr = Terrytorys[nowTerr.stats.distToBases[banda.name].shortestToBaseIndx]
							dxDrawLine(nowTerr.srvx,nowTerr.srvy,nextTerr.srvx,nextTerr.srvy, tocolor(25,25,25,165), 10)
							local colo = fromColor(territoryColors[banda.name])
							--local colo = fromColor(tocolor(255,255,255,255))
							dxDrawLine(nowTerr.srvx,nowTerr.srvy,nextTerr.srvx,nextTerr.srvy,tocolor(maxer(colo.r*1.5,255),maxer(colo.g*1.5,255),maxer(colo.b*1.5,255),255), 6)
							
							if nextTerr.index == bandaBaseIndex then
								fullText(dTer.stats.distToBases[banda.name].dist,nextTerr.srvx-20,nextTerr.srvy+10,0,0,nil,1.8)
								break
							end
							nowTerr = nextTerr
						end					
					end
				end
			end
		end

	end)
end
addEvent("simulate1",true)
addEventHandler("simulate1",root,simulate1)

----------------------------- SIMULATES ------------------------------------------------------------


--[[								-- Выгрузка овнеров
bindKey("p","down",function()
	outputConsole("toatlOwners = {")
	for k,v in pairs(Terrytorys) do
		local owner = v.owner
		if owner == "conquest" then
			owner = "none"
		end
		outputConsole("{ index = "..v.index..", owner = \"".. owner.."\" },")
	end
	outputConsole("}")
end)
]]