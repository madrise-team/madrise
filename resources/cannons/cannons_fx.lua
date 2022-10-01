-- EFX ----------------------------------------------------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------ ROPE -----------------------
local ropeSerials = 0
ropes = {}



local wTex = dxCreateTexture(":Draws/win/winTest.png")

local pointsCount = 10
local restingDistance = 0.5
local grav = 0.005
local constraintSolve = 3
local tension = 0.36
local envFrictionKef = 1.15



function createRope(ropx,ropy,ropz,pontCap,initer)
	ropeSerials = ropeSerials + 1

	local ropeSerial  = ropeSerials

	local mat = Matrix(ropx,ropy,ropz,0,0,0)
	local sfPos = mat.position + mat.up*10

	local points = {}
	for i=1,pointsCount do
		points[#points + 1] = {pos = Vector3(ropx,ropy,ropz),last = Vector3(ropx+i*0.001,ropy+i*0.001,ropz+i*0.001)}
	end
	points[1].sps = Vector3(ropx,ropy,ropz)


	local pontCap = pontCap

	local totalCheker = true

	local function intertia(pont,checker)
		local vel = pont.pos - pont.last 
		
		local spX = pont.last.x
		local spY = pont.last.y
		local spZ = pont.last.z

		local epX = pont.last.x + vel.x
		local epY = pont.last.y + vel.y
		local epZ = pont.last.z + vel.z


		

		local hasHit, hitX, hitY, hitZ, element = processLineOfSight(
				spX,spY,spZ,--s
				 epX, epY, epZ, --e
				true,	--checkBuildings
				true,	--checkVehicles
				true,	--checkPlayers
				true,	--checkObjects
				true,	--checkDummies
				false,
				false,
				true,
				ropes[ropeSerial].initer
		)
		if hasHit then
			if checker and element and totalCheker then
				if getElementType(element) == "player" or getElementType(element) == "ped" then
					ropes[ropeSerial].targetElm = element
					totalCheker = false
					if ropes[ropeSerial].initer == localPlayer then
						triggerServerEvent("tazerRopeElement",root,ropeSerial,element)
					end
				end
			end
			pont.last = Vector3(hitX,hitY,hitZ)
		else
			local nextX = pont.pos.x + vel.x/envFrictionKef
			local nextY = pont.pos.y + vel.y/envFrictionKef
			local nextZ = pont.pos.z + vel.z/envFrictionKef - grav

			pont.last = Vector3(pont.pos.x,pont.pos.y,pont.pos.z)
			pont.pos = Vector3(nextX,nextY,nextZ)
		end
	end
	local function solveConstraint(pont1,pont2)
		local p1 = pont1.pos
		local p2 = pont2.pos

		local diffX = p1.x - p2.x
		local diffY = p1.y - p2.y
		local diffZ = p1.z - p2.z
		local d = math.sqrt(diffX*diffX + diffY*diffY + diffZ*diffZ)

		if d > restingDistance then
			-- difference scalar
			local difference = (restingDistance - d) / d
			 
			local translateX = diffX * tension * difference
			local translateY = diffY * tension * difference
			local translateZ = diffZ * tension * difference
	 
			
			pont1.pos = Vector3(p1.x + translateX,p1.y + translateY,p1.z + translateZ)
			pont2.pos = Vector3(p2.x - translateX,p2.y - translateY,p2.z - translateZ)
		end
	end


	local framerSkipper = 0
	local ocPp_fuc = function()
		framerSkipper = framerSkipper + 1
		--if framerSkipper % 25 ~= 0 then return end

		for i=1,constraintSolve do
			for i,v in ipairs(points) do
				if i~=1 then
					solveConstraint(v,points[i-1])
				end
			end
		end

		for i,v in ipairs(points) do
			local checker = false
			if i == #points then checker = true end
			intertia(v,checker)

		end
		if pontCap then
			local pont = getPositionFromElementOffset(pontCap.obj,pontCap.forward,pontCap.right,pontCap.up)	

			points[1].pos = pont
			if ropes[ropeSerial].targetElm then
				points[#points].pos  = Vector3(getElementPosition(ropes[ropeSerial].targetElm)) + Vector3(0,0,0.35)
				points[#points].last = Vector3(points[#points].pos.x,points[#points].pos.y,points[#points].pos.z)
			end
		end


		--------------------------------------------
		for i,v in ipairs(points) do
			if i ~= #points then
				local colocolna = tocolor(5,10,20,255)
				
				dxDrawLine3D(v.pos.x,v.pos.y,v.pos.z + 0.02,points[i+1].pos.x,points[i+1].pos.y,points[i+1].pos.z  + 0.02,colocolna,0.8)
				if ropes[ropeSerial].voltage then 
					local rander = math.random(0,100)/100
					colocolna = tocolor(255,140,2,40*rander)
					dxDrawLine3D(v.pos.x,v.pos.y,v.pos.z + 0.02,points[i+1].pos.x,points[i+1].pos.y,points[i+1].pos.z  + 0.02,colocolna,0.6)

					colocolna = tocolor(255,255,255,100*rander)
					dxDrawLine3D(v.pos.x,v.pos.y,v.pos.z + 0.02,points[i+1].pos.x,points[i+1].pos.y,points[i+1].pos.z  + 0.02,colocolna,0.03)
				end
			else
				local prev = Vector3(points[i-1].pos.x,points[i-1].pos.y,points[i-1].pos.z  + 0.02)
				local now  = Vector3(v.pos.x,v.pos.y,v.pos.z + 0.02)
				local xfer = now - (now - prev)/30
				dxDrawLine3D(now.x,now.y,now.z,xfer.x,xfer.y,xfer.z,tocolor(255,200,220,50),0.8)
			end
		end
	end
	addEventHandler("onClientPedsProcessed",root,ocPp_fuc)

 	ropes[ropeSerial] = {points = points,ocPp_fuc = ocPp_fuc,serial = ropeSerial}
 	ropes[ropeSerial].initer = initer

	return ropes[ropeSerial]
end

function voltageRope(ropeSerial,bool)
	ropes[ropeSerial].voltage = bool
end


addEvent("tazerRopeElement",true)
addEventHandler("tazerRopeElement",root,function(ropeSerial,element)		-- shooter = source
	ropes[ropeSerial].targetElm = element
end)


-----------------------------------------------------------------------------------------------