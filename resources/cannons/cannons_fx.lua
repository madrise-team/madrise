-- EFX ----------------------------------------------------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------ ROPE -----------------------
local wTex = dxCreateTexture(":Draws/win/winTest.png")

local pointsCount = 6
local restingDistance = 0.5
local grav = 0.005
local constraintSolve = 3
local tension = 0.1
local envFrictionKef = 1.2



function createRope(ropx,ropy,ropz,pontCap)
	local mat = Matrix(ropx,ropy,ropz,0,0,0)
	local sfPos = mat.position + mat.up*10

	local points = {}
	for i=1,pointsCount do
		points[#points + 1] = {pos = Vector3(ropx,ropy,ropz),last = Vector3(ropx+i*0.001,ropy+i*0.001,ropz+i*0.001)}
	end
	points[1].sps = Vector3(ropx,ropy,ropz)


	local pontCap = pontCap

	local totalCheker = true

	local targetElm

	local function intertia(pont,checker)
		local vel = pont.pos - pont.last 
		
		local spX = pont.last.x - vel.x*0.1
		local spY = pont.last.y - vel.y*0.1
		local spZ = pont.last.z - vel.z*0.1

		local epX = pont.last.x + vel.x/2
		local epY = pont.last.y + vel.y/2
		local epZ = pont.last.z + vel.z/2


		

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
				localPlayer
		)

		if hasHit then
			if checker and element and totalCheker then
				if getElementType(element) == "player" or getElementType(element) == "ped" then
					targetElm = element
					totalCheker = false
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
	addEventHandler("onClientPedsProcessed",root,function()
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
			if targetElm then
				points[#points].pos  = Vector3(getElementPosition(targetElm)) + Vector3(0,0,0.35)
			end
		end
	end)


	addEventHandler("onClientPedsProcessed",root,function()
		for i,v in ipairs(points) do
			if i ~= #points then
				--local colocolna = tocolor(0,40,75,255)
				local colocolna = tocolor(10,20,40,255)
				dxDrawLine3D(v.pos.x,v.pos.y,v.pos.z + 0.02,points[i+1].pos.x,points[i+1].pos.y,points[i+1].pos.z  + 0.02,colocolna,0.8)
				--dxDrawMaterialLine3D(,false,wTex,)
			end
		end
	end)

	return points
end

-----------------------------------------------------------------------------------------------