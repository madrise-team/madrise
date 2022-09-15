----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulSh.lua')()    -- Usful Server

rlsc = exports.RRL_Scripts

------------------------------------
test = rlsc:getTxture("test")

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
addEventHandler("debugTerritory",root,function(territs)
	addEventHandler("onClientRender",root,function()
		for k,terr in pairs(territs) do
			local srX,srY,srZ = srArfm(terr)
			--- borders
			for j=5,5 do
				for i=1,#terr.tPoints-1 do
					local v = terr.tPoints[i]; local v1 = terr.tPoints[i+1]
					dxDrawMaterialLine3D(v.x,v.y,9*j,v1.x,v1.y,9*j,
										true,test,70,tocolor(255,255,255,225),false,srX,srY,9*j)
				end
			end
			--- /borders

			--- connections
			for k,conn in pairs(terr.connections) do
				local t2srX,t2srY,t2srZ = srArfm(territs[conn])
				dxDrawMaterialLine3D(srX,srY,srZ, t2srX,t2srY,t2srZ,
								true,test,2,tocolor(155,255,255,255),false,srX,srY,100000)
			end
			--- /connections

			--- nameDraw
			local xe,ye = getScreenFromWorldPosition(srX,srY,40)
			if xe then
				dxDrawRectangle(xe-18,ye-18,107,52,tocolor(0,15,150,255))
				dxDrawRectangle(xe-15,ye-15,100,46,tocolor(120,110,80,255))
				dxDrawText(terr.index,xe-3,ye-8,0,0,tocolor(255,255,255,255),2)
			end
			--- /nameDraw
		end	
	end)
end)

local wDrawpoints = false
local sDrawpoints = false
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

		if sDrawpoints then
			dxDrawRectangle(815,30,980,1030,tocolor(30,30,30,255))
			for k,v in pairs(tPoints) do
				local xv = ((v.x+3000)/1.3-2950 - 4)  + 200
				local yv = ((-v.y+3000)/1.3-2950 - 4) + 20
				dxDrawRectangle(xv,yv,8,8,tocolor(255,255,255,150))
				dxDrawText(v.index,xv,yv)
				if (xv > 1920) or (yv > 1080) then
					outputChatBox("uuuSuka")
				end
			end
		end
	end)
end)


function isInPoly(poly,point)
	local inPol = false

	for i=1,#poly do
		local nexp = i+1
		if i == #poly then nexp = 1 end
	
		slp = {x = poly[i].x,y = poly[i].y}
		elp = {x = poly[nexp].x,y = poly[nexp].y}


		local minXp = slp; local maxXp = elp
		local minYp = slp; local maxYp = elp

		if elp.x < slp.x then
			minXp = elp
			maxXp = slp
		end
		if elp.y < slp.y then
			minYp = elp
			maxYp = slp
		end

		local xR = maxXp.x - minXp.x

		local yRotn = (point.y - minYp.y)/(maxYp.y - minYp.y)
		if(maxYp.x < minYp.x) then
			yRotn = 1-yRotn
		end

		local needX = minXp.x + xR*yRotn
		if (point.x > needX) and (point.y > minYp.y) and (point.y < maxYp.y) then		
			inPol = not inPol
		end
	end	
	return inPol
end