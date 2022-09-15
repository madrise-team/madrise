----- import Draws
loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()
------------------------------------------------------------------------
outputDebugString("-*---+__* arender *__+---*-")
------------------------------------------------------------------------


whCrt = dxCreateRenderTarget(20,20,true)
function drawWhiteCircle()
	dxSetRenderTarget(whCrt,true)
	dxDrawCircle (10,10,10,0,360,tocolor(255,255,255,255),tocolor(255,255,255,255),128)	

	local savedBlendMode = dxGetBlendMode()
	dxSetBlendMode("overwrite")
	dxDrawCircle (10,10,8,0,360,tocolor(255,255,255,0),tocolor(255,255,255,0),128)
	dxSetBlendMode(savedBlendMode)
	dxSetRenderTarget()
end

frame = 0
function creteInteracter(x,y,z,distanseInteract,Name,Header,HeaderLineStartWidth,interactFuc)
	if ((not x) or (not y) or (not z)) then 
		outputDebugString("Trying create Interacter with no coords!")
		return
	end

	local dist = distanseInteract or 2
	local binded = false

	local _interfaceInited = false

	local header
	local helper
	local liner

	local interacterT = {liner = liner,header = header,helper = helper,
		interactingNow = false,
		pointSx = 0,pointSy = 0,
		HeaderLineWidth = HeaderLineStartWidth,
		linkedElements = {}
	}

	local interacterBinderFuc = function()
		interacterT.interactingNow = true
		interactFuc(interacterT)
	end
	liner = TIV:create({x = 0,y = 0,w = screenW,h = screenH,adapt = false},{originalSize = {w = 864,h = 116},img = function()
		local sx,sy = getScreenFromWorldPosition(x,y,z,500)
		if not (sx and sy) then 
			sx = 10000
			sy = 10000
		end
	
		interacterT.pointSx = sx
		interacterT.pointSy = sy
	
		drawWhiteCircle()
		dxDrawImage (sx - 10, sy - 10, 20, 20, whCrt)
		dxDrawCircle(sx, sy, 3,0,360,tocolor(225,255,225,255))

		dxDrawLine(sx+6,sy-6,sx + 75, sy - 75, tocolor(255,255,255,255), 2.2)
		dxDrawLine(sx + 75,sy - 75,sx + 75 + interacterT.HeaderLineWidth, sy - 75, tocolor(255,255,255,255), 2)

		local px,py,pz = getElementPosition(localPlayer)
		local dister = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
		--dxDrawRectangle(screenW/3.5, screenH/4, screenW - (screenW/3.5*2), screenH/2.4,tocolor(255,255,255,100))
		if (dister < dist) and isPointInQuad(sx,sy,screenW/3.5, screenH/4, screenW - (screenW/3.5*2), screenH/2.4) then
			--
				if not binded then
					bindKey("e","down",interacterBinderFuc)
					binded = true
				end
			--
		else
			--
				if binded then
					unbindKey("e","down",interacterBinderFuc)
					binded = false
				end
			--
		end

		if _interfaceInited then
			if interacterT.interactingNow then
				header.imgP.color.a = 0
				helper.imgP.color.a = 0
			else
				header.imgP.color.a = 255
				helper.imgP.color.a = 255
			end

			for k,linkT in pairs(interacterT.linkedElements) do
				linkT.elm.locSize.x = sx + linkT.offsetX
				linkT.elm.locSize.y = sy + linkT.offsetY
			end
		end		
		return nil
	end,frame = true},nil,Name)
	header = createLabel(SFonts.ebda.h1,0,0,396*msw,300,{text = Header,alignX = "center",alignY = "top"},Name.."-Header",Name,nil,false)
	helper = createLabel(SFonts.ebda.h2,0,0,396*msw,300,{text = [[Нажмите клавишу "E"]],alignX = "center",alignY = "top"},Name.."-Header",Name,nil,false)
	table.insert(interacterT.linkedElements,{elm = header,offsetX = 75,offsetY = -75-(72*msw)})
	table.insert(interacterT.linkedElements,{elm = helper,offsetX = 75,offsetY = -75})



	_interfaceInited = true

end








kekx = 1416.943359375 
keky = -1640.3693847656
kekz = 38.308795928955 

createObject(1455,kekx,keky,kekz)

creteInteracter(kekx,keky,kekz,nil,"AlkoVeloInteracter","ВЕЛОПРОКАТ",396*msw,function(interacterT)
	local win = createWindow(SWins.miniwin,"AlkoVeloMiniwin","AlkoVeloInteracter",0,0,SWins.miniwin.w,SWins.miniwin.h)
	interacterT.HeaderLineWidth = win.locSize.w + SWins.miniwin.ineterOffset.wd
	table.insert(interacterT.linkedElements,{elm = win,offsetX = SWins.miniwin.ineterOffset.x,offsetY = SWins.miniwin.ineterOffset.y})
	


end)