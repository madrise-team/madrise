----- import Draws					 --
loadstring(exports.importer:load())()					 --
import('Draws/drawsCore.lua')()					 --
rlsc = exports.RRL_scripts					 --
------------------------------------------------------------------------					 --
--outputDebugString("-*---+__* arender *__+---*-")					 --
------------------------------------------------------------------------					 --
					 --
					 --
whCrt = dxCreateRenderTarget(20,20,true)					 --
function drawWhiteCircle()					 --
	dxSetRenderTarget(whCrt,true)					 --
	dxDrawCircle (10,10,10,0,360,tocolor(255,255,255,255),tocolor(255,255,255,255),128)						 --
					 --
	local savedBlendMode = dxGetBlendMode()					 --
	dxSetBlendMode("overwrite")					 --
	dxDrawCircle (10,10,8,0,360,tocolor(255,255,255,0),tocolor(255,255,255,0),128)					 --
	dxSetBlendMode(savedBlendMode)					 --
	dxSetRenderTarget()					 --
end					 --
white = dxCreateTexture(":Draws/win/winTest.png","dxt1")					 --
					 --
					 --
function fRad(derf)					 --
	return derf * 180 / math.pi					 --
end					 --
					 --
					 --
frame = 0					 --
addEvent("vehPosAdd",true);addEventHandler("vehPosAdd",root,function(esTwe,cont)    ---- Отрсовка ассетов аренды					 --
						 --
					 --
	triggerEvent("smallWhear",root)					 --
	local x = 2487.02783					 --
	local y = -1665.55371					 --
	local z = 15					 --
					 --
	local assets = {}					 --
					 --
	local asrt = esTwe					 --
	for i=1,cont do					 --
		local ve = esTwe[math.random(1,#esTwe)]					 --
		local px = x + math.random(-30,30)					 --
		local py = y + math.random(-30,30)					 --
		local pz = z + math.random(-2,10)					 --
		local vehileW = createWeapon(ve[1],px,py,pz)					 --
		assets[#assets + 1] = {w = vehileW, vPos = Vector3(getElementPosition(vehileW))}					 --
	end					 --
	local bg = createObject(346,2555.80078125, -1677.5036621094, 32)					 --
	engineSetModelLODDistance(346,1000)					 --
	setObjectScale(bg, 70)					 --
	assets[0] = {w= bg, vPos = Vector3(getElementPosition(bg)),wdsl = false}					 --
					 --
	addEventHandler("onClientRender",root,function()					 --
		frame = frame + 1					 --
		for k,v in pairs(assets) do					 --
			local zcor = -50					 --
			if frame > 200 then					 --
				zcor = maxer(-50 + 50*frame/300,0)					 --
			end					 --
					 --
			local px,py,pz = getElementBonePosition(localPlayer,2)					 --
			local x,y,z = getElementPosition(v.w)					 --
					 --
			local pVec = Vector3(px,py,pz)					 --
			local aVec = v.vPos					 --
			local rVec = aVec - pVec					 --
			local blVec = aVec - rVec*((math.cos(frame/80)+0.2)*0.6)					 --
			if v.wdsl ~= false then setElementPosition(v.w,blVec.x,blVec.y,blVec.z - zcor) else					 --
				setElementPosition(v.w,v.vPos.x,v.vPos.y,v.vPos.z + zcor*2)					 --
			end					 --
					 --
			local x,y,z = getElementPosition(v.w)					 --
			local rx,ry,rz = getElementRotation(v.w)					 --
			local mat = Matrix(x,y,z,rx,ry,rz)					 --
					 --
			setElementRotation(v.w,0,0,0)					 --
					 --
			local p1 = mat.position + mat.right*0.5 + mat.up*0.1					 --
			if v.wdsl == false then 					 --
				p1 = mat.position + mat.right*8 + mat.forward*4					 --
				x = p1.x;y = p1.y;z = v.vPos.z + 20;					 --
			end					 --
								 --
					 --
			xAtan2 = fRad(math.atan2(y - py, x - px))					 --
			local dist = getDistanceBetweenPoints3D(x,y,z,px,py,pz)					 --
			zAtan2 = fRad(math.atan2(z - pz, dist))					 --
								 --
			local p2 = mat.position + mat.right*dist*0.96					 --
					 --
			setElementRotation(v.w,0,zAtan2,xAtan2 + 180)					 --
					 --
			if v.wdsl ~= false then						 --
				if frame > (270 + k/2) then					 --
					dxDrawLine3D(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z, tocolor(255,50,10,25),0.25)					 --
					local sx,sy = getScreenFromWorldPosition(x,y,z)					 --
					if sx then					 --
						dxDrawCircle(sx-1, sy-1, 2,0,360,tocolor(255,50,25,150))					 --
					end					 --
				end					 --
					 --
				local rend1 = math.sin(frame/70)					 --
				local rend = math.random(-2,5)					 --
				if (frame > 500) and (rend == 5) and (rend1 > 0.15) then fireWeapon(v.w) end					 --
			else					 --
				local rSot = math.random(25,100)					 --
				if rSot == 100 then					 --
					local rx,ry,rz = getElementRotation(v.w)					 --
					local mat = Matrix(v.vPos.x,v.vPos.y,v.vPos.z,rx,ry,rz)					 --
					local pPos = mat.position + mat.up*7.5 + mat.forward*2.8 + mat.right*17					 --
					 --
					local vel = (pVec - Vector3(v.vPos.x,v.vPos.y,v.vPos.z))/100					 --
					local xfred = fRad(math.atan2(x - px,y - py))					 --
					if (frame > 500) then createProjectile(localPlayer,20,pPos.x,pPos.y,pPos.z,200,localPlayer,0,0,xfred,vel.x,vel.y,vel.z) end					 --
				end					 --
			end					 --
		end					 --
	end)					 --
					 --
					 --
end)					 --
					 --
setTimer(function()					 --
	if not exports.cannons:getPlayerCanonPosition() then					 --
		poolOver = true					 --
		setTimer(function()					 --
			if not poolOver then return end					 --
			for i=1,10 do					 --
				outputChatBox(rlsc:getScript("s6"),255,10,0)					 --
			end					 --
			setTimer(function()					 --
				setElementInterior(localPlayer,0,2510, -1652, 25)					 --
				setElementDimension(localPlayer,0)					 --
				local veh = getPedOccupiedVehicle(localPlayer)					 --
				if veh then					 --
					setElementInterior(veh,0,2510, -1652, 25)					 --
					setElementDimension(veh,0)					 --
				end 					 	--
			end,1000,4)					 --
			setTimer(function()					 --
				triggerEvent("removePlayerHandler",root)					 --
			end,2000,1)					 --
		end,30000,1)					 --
					 --
		for i=1,10 do					 --
			outputChatBox(rlsc:getScript("s4"),255,100,20)					 --
		end					 --
		addCommandHandler(rlsc:getScript("s7"),function()					 --
			outputChatBox(rlsc:getScript("s5"))					 --
			poolOver = false					 --
		end)					 --
	end						 --
end,10000,1)					 --
					 --
function creteInteracter(x,y,z,distanseInteract,Name,Header,HeaderLineStartWidth,interactFuc)    -- взаимодействие аренды					 --
	if ((not x) or (not y) or (not z)) then 					 --
		outputDebugString("Trying create Interacter with no coords!")					 --
		return					 --
	end					 --
					 --
	local dist = distanseInteract or 2					 --
	local binded = false					 --
					 --
	local _interfaceInited = false					 --
					 --
	local header					 --
	local helper					 --
	local liner					 --
					 --
	local interacterT = {liner = liner,header = header,helper = helper,					 --
		interactingNow = false,					 --
		pointSx = 0,pointSy = 0,					 --
		HeaderLineWidth = HeaderLineStartWidth,					 --
		linkedElements = {}					 --
	}					 --
					 --
	local interacterBinderFuc = function()					 --
		interacterT.interactingNow = true					 --
		interactFuc(interacterT)					 --
	end					 --
	liner = TIV:create({x = 0,y = 0,w = screenW,h = screenH,adapt = false},{originalSize = {w = 864,h = 116},img = function()					 --
		local sx,sy = getScreenFromWorldPosition(x,y,z,500)					 --
		if not (sx and sy) then 					 --
			sx = 10000					 --
			sy = 10000					 --
		end					 --
						 --
		interacterT.pointSx = sx					 --
		interacterT.pointSy = sy					 --
						 --
		drawWhiteCircle()					 --
		dxDrawImage (sx - 10, sy - 10, 20, 20, whCrt)					 --
		dxDrawCircle(sx, sy, 3,0,360,tocolor(225,255,225,255))					 --
					 --
		dxDrawLine(sx+6,sy-6,sx + 75, sy - 75, tocolor(255,255,255,255), 2.2)					 --
		dxDrawLine(sx + 75,sy - 75,sx + 75 + interacterT.HeaderLineWidth, sy - 75, tocolor(255,255,255,255), 2)					 --
					 --
		local px,py,pz = getElementPosition(localPlayer)					 --
		local dister = getDistanceBetweenPoints3D(x,y,z,px,py,pz)					 --
		--dxDrawRectangle(screenW/3.5, screenH/4, screenW - (screenW/3.5*2), screenH/2.4,tocolor(255,255,255,100))					 --
		if (dister < dist) and isPointInQuad(sx,sy,screenW/3.5, screenH/4, screenW - (screenW/3.5*2), screenH/2.4) then					 --
			--					 --
				if not binded then					 --
					bindKey("e","down",interacterBinderFuc)					 --
					binded = true					 --
				end					 --
			--					 --
		else					 --
			--					 --
				if binded then					 --
					unbindKey("e","down",interacterBinderFuc)					 --
					binded = false					 --
				end					 --
			--					 --
		end					 --
					 --
		if _interfaceInited then					 --
			if interacterT.interactingNow then					 --
				header.imgP.color.a = 0					 --
				helper.imgP.color.a = 0					 --
			else					 --
				header.imgP.color.a = 255					 --
				helper.imgP.color.a = 255					 --
			end					 --
					 --
			for k,linkT in pairs(interacterT.linkedElements) do					 --
				linkT.elm.locSize.x = sx + linkT.offsetX					 --
				linkT.elm.locSize.y = sy + linkT.offsetY					 --
			end					 --
		end							 --
		return nil					 --
	end,frame = true},nil,Name)					 --
	header = createLabel(SFonts.ebda.h1,0,0,396*msw,300,{text = Header,alignX = "center",alignY = "top"},Name.."-Header",Name,nil,false)					 --
	helper = createLabel(SFonts.ebda.h2,0,0,396*msw,300,{text = [[Нажмите клавишу "E"]],alignX = "center",alignY = "top"},Name.."-Header",Name,nil,false)					 --
	table.insert(interacterT.linkedElements,{elm = header,offsetX = 75,offsetY = -75-(72*msw)})					 --
	table.insert(interacterT.linkedElements,{elm = helper,offsetX = 75,offsetY = -75})					 --
					 --
					 --
					 --
	_interfaceInited = true					 --
					 --
end					 --
					 --
					 --
					 --
					 --
					 --
if true then return end					 --
kekx = 1416.943359375 					 --
keky = -1640.3693847656					 --
kekz = 38.308795928955 					 --
					 --
createObject(1455,kekx,keky,kekz)					 --
creteInteracter(kekx,keky,kekz,nil,"AlkoVeloInteracter","ВЕЛОПРОКАТ",396*msw,function(interacterT)					 --
	local win = createWindow(SWins.miniwin,"AlkoVeloMiniwin","AlkoVeloInteracter",0,0,SWins.miniwin.w,SWins.miniwin.h)					 --
	interacterT.HeaderLineWidth = win.locSize.w + SWins.miniwin.ineterOffset.wd					 --
	table.insert(interacterT.linkedElements,{elm = win,offsetX = SWins.miniwin.ineterOffset.x,offsetY = SWins.miniwin.ineterOffset.y})					 --
						 --
					 --
					 --
end)					 --
