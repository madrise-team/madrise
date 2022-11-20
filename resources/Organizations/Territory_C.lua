----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
import('RRL_Scripts/usfulC.lua')()    -- Usful Client
import('Organizations/Territory_Sh.lua')()    -- Terrytory_Sh

rlsc = exports.RRL_Scripts

------------------------------------
Terrytorys = {}



local efX = 2343.9943847656    
local efY = -1505.2958984375 
local efZ = 23.836727142334

local smokeTex = dxCreateTexture("smoke.png","dxt5")


local veter = {math.random(-10,10)/100000,math.random(-10,10)/100000}

particles = {}
partC = 0
addEventHandler("onClientPreRender",root,function()
	local _,_,camrz = getElementRotation(getCamera())
	camrz = (camrz*math.pi)/180

	local prexDiff = math.cos(camrz)
	local preyDiff = math.sin(camrz)


	local neddToDel = {}
	for k,v in pairs(particles) do
		xDiff = prexDiff * v.size/2
		yDiff = preyDiff * v.size/2


		local col = {r=v.color.r,g=v.color.g,b=v.color.b}
		col.r = maxer(col.r*v.colorMultR,255)
		col.g = maxer(col.g*v.colorMultG,255)
		col.b = maxer(col.b*v.colorMultB,255)
		if v.timer < 15 then
			col.r = col.r* (v.timer/14)
			col.g = col.g* (v.timer/14)
			col.b = col.b* (v.timer/14)
		end
		dxDrawMaterialLine3D(v.x -xDiff,v.y -yDiff,v.z,v.x + xDiff,v.y +yDiff,v.z,v.flip,smokeTex,v.size,tocolor(col.r,col.g,col.b,v.alfa),false,nil,nil,nil)
		
		v.x = v.x + v.velX
		v.y = v.y + v.velY
		v.z = v.z + v.velZ

		v.velX = v.velX/1.004 + veter[1]
		v.velY = v.velY/1.004 + veter[2]
		v.velZ = v.velZ/1.004 + 0.00001

		if v.size < 15 then
			v.size = v.size + (v.sizeKef/100)
		end

		v.alfa = v.alfa - 0.01


		v.timer = v.timer + 1
		if v.timer > v.lifeTime then
			v.alfa = v.alfa - 2
		end
		if v.alfa < 1 then
			neddToDel[k] = k
		end

	end
	for k,v in pairs(neddToDel) do
		particles[v] = nil
		partC = partC - 1
	end
end)
function createParticle(x,y,z,velX,velY,velZ,size,flip,lifeTime,color)
	if partC > 1400 then return end
	partC = partC + 1
	particles[#particles+1] = {
		x= x,
		y= y,
		z= z,
		velX = velX,
		velY = velY,
		velZ = velZ,
		size = size,
		alfa = math.random(15,85),
		timer = 0,
		flip = flip,
		lifeTime = lifeTime,
		sizeKef = math.random(0.2,10),
		color = color,
		colorMultR = math.random(0.55,2.5),
		colorMultG = math.random(0.55,2.5),
		colorMultB = math.random(0.55,2.5)
	}		
end
local renderrer = 0
addEventHandler("onClientRender",root,function()
	dxDrawRectangle(0,1080-25,25,25,tocolor(chosenColor.r,chosenColor.g,chosenColor.b,255))
	dxDrawText(tableCount(pjectiles),28,1080-25/1.5)
	renderrer = renderrer + 1 
	local ntRemove = {}
	pjectiles = randomSort(pjectiles)
	for k,projT in pairs(pjectiles) do
		if projT.timer > 3300 then
			ntRemove[k] = k
		end
		projT.timer = projT.timer + 1
		proj = projT.proj
		if projT.timer > 200 then
			local x,y,z = getElementPosition(proj)
			local rx,ry,rz = getElementRotation(proj)

			projT.curRot = projT.curRot + projT.rotVel
			setElementRotation(proj,0,0,projT.curRot)
			projT.rotVel = maxMiner(projT.rotVel + projT.rotVelChange/10,-10,10)
			projT.rotVelChange = maxMiner(projT.rotVelChange + math.random(-10,10)/15,-5,5)*(projT.rotVelLife/100)
			projT.rotVel = projT.rotVel /1.01

			if projT.rotVelLife > 25 then
				projT.rotVelLife = projT.rotVelLife - 0.05
			end

			local velx,vely,velz = getElementVelocity(proj)
			setElementVelocity(proj,velx/1.001,vely/1.001,velz/1.001)	

			local mat = Matrix(x,y,z,-rx,-ry,-rz)
			local pointPos = (mat.position + mat.forward) - mat.position
			local pointPos2 = (mat.position - mat.forward) - mat.position
			
			local flipper1 = math.random(1,2)
			if flipper1 > 1 then
				flipper1 = true
			else
				flipper1 = false
			end

			local flipper2 = math.random(1,2)
			if flipper2 > 1 then
				flipper2 = true
			else
				flipper2 = false
			end

			function rndV()
				return math.random(-0.3,0.3)
			end
			function rndVm()
				return math.random(-0.05,0.05)
			end

			local size = math.random(0.1,0.2)
			local lifeTime = math.random(60,120)
			if renderrer % 2 == 0 then
				lifeTime = math.random(400,800)
				size = math.random(0.2,1)
				createParticle(x+rndV(),y+rndV(),z+rndV(),pointPos.x/6 + rndV(),pointPos.y/6 + rndV(),pointPos.z/200 + math.random(-0.05,0.01),size,flipper1,lifeTime,projT.color)
			else
				for i=1,4 do
					lifeTime = math.random(10,40)
					createParticle(x+rndVm()*2,y+rndVm()*2,z+rndVm()*2,pointPos.x/6 + rndVm(),pointPos.y/6 + rndVm(),pointPos.z + rndVm(),size,flipper1,lifeTime,projT.color)
				end
			end			

			
		end
	end
	for k,v in pairs(ntRemove) do
		local projectile = pjectiles[v].proj
		local prjx,prjy,prjz = getElementPosition(projectile)
		setElementPosition(projectile,prjx,prjy,prjz + 100000)
		setTimer(function()
			destroyElement(projectile)
		end,50,1)
		pjectiles[v] = nil
	end
end)

pjectiles = {}
addEventHandler("onClientProjectileCreation", root, function()
	if not (getProjectileType(source) == 16) then return end
	setProjectileCounter(source,1000000)
	local initerName = initer
	pjectiles[#pjectiles + 1] = {proj = source,curRot = 0,rotVel = math.random(-15,15),rotVelLife = 70,rotVelChange = math.random(-2,2),starter = 0,timer = 0,color = chosenColor}

	local velx,vely,velz = getElementVelocity(source)
	setElementVelocity(source,velx*2.2,vely*2.2,velz)
	
	local proj = source
	setTimer(function()
		local x,y = getElementPosition(proj)
		for k,v in pairs(Terrytorys) do
			if isInPolygon(v.tPoints,{x=x,y=y}) then
				doMoveToTerr(initerName,v)
				break
			end
		end
	end,5000,1)

end)


chosenColors1 = {r=255,g=255,b=255}
chosenColors2 = {r=50,g=150,b=255}
chosenColors3 = {r=255,g=200,b=70}
chosenColors4 = {r=60,g=255,b=80}
chosenColors5 = {r=230,g=80,b=255}

chosenColor = chosenColors1
initer = "none"

function setBandaData(banda)
	setElementData(localPlayer,"banda",banda)
end

bindKey("1","down",function()
	chosenColor = chosenColors1
	initer = "none"
	setBandaData(initer)
end)
bindKey("2","down",function()
	chosenColor = chosenColors2
	initer = "Aztec"
	setBandaData(initer)
end)
bindKey("3","down",function()
	chosenColor = chosenColors3
	initer = "Vagos"
	setBandaData(initer)
end)
bindKey("4","down",function()
	chosenColor = chosenColors4
	initer = "Groove"
	setBandaData(initer)
end)
bindKey("5","down",function()
	chosenColor = chosenColors5
	initer = "Ballas"
	setBandaData(initer)
end)

function doMoveToTerr(initerName,terr)
	if not terr.cantCapture then
		if isTerrConnected(terr,initerName) then
			if terr.owner ~= initerName then				
				if (not isIniterInBattle(battles,terr.owner) or (terr.owner == "none")) then
					if not battles[terr.index] then
						triggerServerEvent("addInit",root,initerName,terr.index)
					else
						outputChatBox(terr.index.." в данный момент недоступна для подключения")
					end
				else
					outputChatBox(terr.owner.." в данный момент недоступен для подключения")
				end
			else
				outputChatBox(terr.index.." уже и так принадлежит "..initerName)
			end
		else
			outputChatBox("У "..initerName.." отсутвует подключение к "..terr.index)	
		end
	else
		outputChatBox(terr.index.." захватить нельзя...")
	end
end



addEvent("territoriesState",true)
addEventHandler("territoriesState",root,function(locked,terrs)
	if territoriesLock ~= locked then			-- lock state changed
		if locked then
			outputChatBox('[terrs locked]')
		else
			outputChatBox('> terrs unlocked! <')
		end
	end
	territoriesLock = locked
	Terrytorys = terrs
end)

territoriesLock = true

battles = {}
initersy = {}
sortedIniters = {}
addEvent("updateIniters",true)
addEventHandler("updateIniters",root,function(initersInfo)
	initersy = initersInfo
	sortedIniters = sortIniters()
	checkIniters(sortedIniters)
end)
addEvent("updateBattles",true)
addEventHandler("updateBattles",root,function(battlesInfo)
	battles = battlesInfo
end)





--[[
local sis = 0
bindKey("f","down",function()
	sis = setTimer(function()
		local px,py,pz = getElementPosition(localPlayer)
		createProjectile (localPlayer, 16, px,py,pz+1, 1)
	end,50,0)	
end)

bindKey("f","up",function()
	if sis ~= 0 then
		killTimer(sis)
	end
	sis = 0
end)
]]
for k,v in pairs(getElementsByType("projectile")) do
	setElementPosition(v,0,0,100000)
	destroyElement(v)
end


function fastMove(Banda,terr,delay)
	if delay then
		setTimer(function()
			fastMove(Banda,terr)
		end,1000*delay,1)
		return
	end

	local banda = Banda
	if not (banda and terr) then return end

	if banda == "A" then banda = "Aztec" end
	if banda == "B" then banda = "Ballas" end
	if banda == "G" then banda = "Groove" end
	if banda == "V" then banda = "Vagos" end

	local terrIndxNum = tonumber(terr)
	if terrIndxNum then doMoveToTerr(banda,Terrytorys[terrIndxNum]) end
end




addCommandHandler("move",function(_,banda,terr)
	fastMove(banda,terr)
end)



setTimer(function()
	if true then return end
	
	fastMove("A",20, 	1)
	fastMove("B",3,		2)
	fastMove("G",8,		3)
	fastMove("V",54,	4)

	fastMove("A",20,1)
	fastMove("B",31,2)
	fastMove("V",9,	7)

end,1000,1)



local patternFrame = 0
movePatternRT_sub = dxCreateRenderTarget(498,20,true)
movePatternRT_mask = dxCreateRenderTarget(498,20,true)
movePatternRT = dxCreateRenderTarget(498,20,true)

LayerMaskShader = dxCreateShader(":Draws/fx/LayerMask.fx")

function drawMoveLine(x,y,w,h,rc,rx,ry,colo)
	local wK = 1
	if w < 1 then
		wK = -1
		w = w*-1
	end

	if (w + 14) > 498 then w = 498 - 20 end
	patternFrame = patternFrame + 0.25
	if patternFrame >= 502 then patternFrame = 0 end

	local saveBlendMode = dxGetBlendMode()
	dxSetBlendMode("modulate_add")	

	dxSetRenderTarget(movePatternRT_sub,true)								-- Pattern
	dxDrawImage(patternFrame,0,			498,20	,"moveLine.png",0,0,0,colo)
	dxDrawImage(-498 + patternFrame,0,	498,20	,"moveLine.png",0,0,0,colo)
	dxSetShaderValue(LayerMaskShader,"textura",movePatternRT_sub)			-----------

	
	dxSetRenderTarget(movePatternRT_mask,true)								-- Mask
	dxDrawImage(0,0,		w ,20	,"moveLineMask.png",0,0,0)
	dxDrawImage(w,0,		14,20	,"moveLineMask_end.png",0,0,0)
	dxSetShaderValue(LayerMaskShader,"mask",movePatternRT_mask)				-----------
	dxSetRenderTarget(movePatternRT,true)									-- Combine
	
	dxDrawImage(0,0,		w ,20	,"moveLineMask.png",0,0,0,colo)
	dxDrawImage(w,0,		14,20	,"moveLineMask_end.png",0,0,0,colo)
	dxDrawImage(0,0,498,20,LayerMaskShader,0,0,0,colo)						-----------

	dxSetRenderTarget()
	dxSetBlendMode(savedBlendMode)

	dxDrawImage(x + 3,y + 4,498*wK,h,movePatternRT,rc or 0,rx or 0,ry or 0,tocolor(25,25,25,80))
	dxDrawImage(x,y,		498*wK,h,movePatternRT,rc or 0,rx or 0,ry or 0)
end