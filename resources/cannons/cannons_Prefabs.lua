function canonTables()
------------------------------------------------------------------------------------------------------------------
	triggerShootToS = function(atG,args)
		triggerServerEvent("shootGun",root,atG.gunSerial,args)
	end
	triggerShootEndToS = function(atG,args)
		triggerServerEvent("endshootGun",root,atG.gunSerial,args)
	end

	longShooting = function(atG,args)
		if atG.longShoot then return end
		atG.longShoot = true
		triggerServerEvent("shootGun",root,atG.gunSerial,args)
	end


	function calcShootPoint(atG, ifHaveMatrix)
		local matrix = ifHaveMatrix
		if not matrix then
			local gmX,gmY,gmZ = getElementPosition(atG.gunObject)
			local gmRx,gmRy,gmRz = getElementPosition(atG.gunObject)
			matrix = Matrix(gmX,gmY,gmZ,gmRx,gmRy,gmRz)
		end

		local ofsT = atG.gunT.shootP
		local pont = matrix.position + matrix.forward*ofsT.forward + matrix.right*ofsT.right + matrix.up*ofsT.up
		return pont,matrix
	end
	function calcShootPointM2(atG)
		local otn = atG.gunT.shootP
		return getPositionFromElementOffset(atG.gunObject,otn.forward,otn.right,otn.up)
	end

	

------------------------------------------------------------------------------------------------------------------


	--- shoot_Init 		- initer client Fuc when do shoot
	--- shoot_End		- initer client Fuc when shoot ends (not shoot delay)

	--- shoot      		- all clients at the request of the server when initer starts shoot (redirect to all from initer (initer include))
	--- shootEnding     - all clients at the request of the server when initer stop shooting (redirect to all from initer (initer include))

	cannonsT = {}

	cannonsT.tazer = {
		name = "Электрошоковое оружие несмертельного действия \"Tazer\"",
		saweaponId = 23,
		modelId = 1248,
		canShoot = false,

		sh_delay = 2500,



		crossShow = function(atG)
			atG.eoFframe = 0
			atG.frame = 0
			atG.eoFframeTotal = 0
		end,
		frame = function(atG)
			if not atG.mode then
				atG.textColor = tocolor(220,170,30,255)
				atG.mode = "SAVE"
			end

			local textP = Vector3(getElementPosition(atG.gunObject))
			local tx,ty = getScreenFromWorldPosition(textP.x,textP.y,textP.z,2)
			
			if tx then
				tx = tx + 100
				if ty > screenH - 35 then ty = screenH - 35 end
				dxDrawText("charge: "..atG.mode,tx,ty,400,400,atG.textColor,1,1,thin200Font)
			end
		end,
		ppframe = function(atG)

			if atG.pulse then return end

			local cam = getCamera()
			local camX,camY,camZ = getElementPosition(cam)
			local camrX,camrY,camrZ = getElementRotation(cam)
			local camMat = Matrix(camX,camY,camZ,camrX,camrY,camrZ)

			if atG.crossShowed then
				atG.mode = "READY"
				atG.frame = atG.frame + 1
				
				local totalA = maxer(atG.frame/16,1)

				local otn = atG.gunT.shootP
				local sPos = getPositionFromElementOffset(atG.gunObject,otn.forward*2.5,otn.right,otn.up)
				local ePos = getPositionFromElementOffset(atG.gunObject,otn.forward*8,otn.right,otn.up)

				dxDrawLine3D(sPos.x,sPos.y,sPos.z+0.01, 
							ePos.x,ePos.y,ePos.z +0.01,
				tocolor(10,150,255,100*totalA),1)


				local ePlPos = getPositionFromElementOffset(atG.gunObject,otn.forward*42,otn.right,otn.up)
				local hasHit, hitX, hitY, hitZ, element = processLineOfSight(
						sPos.x,sPos.y,sPos.z,--s
						 ePlPos.x, ePlPos.y, ePlPos.z, --e
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

				local elementOnFire = false
				if element then
					if getElementType(element) == "player" or getElementType(element) == "ped" then
						elementOnFire = true
					end
				end

				local smeser = 0.5 * totalA
				local smeserUp = 0.1 * totalA
				local coloc = tocolor(10,150,240,100*totalA)

				if elementOnFire then
					if atG.eoFframe < 15 then 
						atG.eoFframe = atG.eoFframe + 1
					end
					coloc = tocolor(90,45,245,220*atG.eoFframeTotal)
				else
					if atG.eoFframe > 0 then 
						atG.eoFframe = atG.eoFframe - 1
					end
				end
				atG.eoFframeTotal = atG.eoFframe/15

				smeser = smeser - (smeser - 0.2)*atG.eoFframeTotal
				smeserUp = smeserUp - (smeserUp - 0.15)*atG.eoFframeTotal

				local p1 = sPos + camMat.right*smeser + camMat.up*smeserUp
				local p2 = p1 + camMat.right*0.07 - camMat.up*0.05
				local p3 = p1 + camMat.right*0.07 - camMat.up*0.1
				local p4 = p1 - camMat.up*0.15

				dxDrawLine3D(p1.x,p1.y,p1.z, 	p2.x,p2.y,p2.z,	coloc,0.5)
				dxDrawLine3D(p2.x,p2.y,p2.z, 	p3.x,p3.y,p3.z,	coloc,0.5)
				dxDrawLine3D(p3.x,p3.y,p3.z, 	p4.x,p4.y,p4.z,	coloc,0.5)

				p1 = sPos - camMat.right*smeser + camMat.up*smeserUp
				p2 = p1 - camMat.right*0.07 - camMat.up*0.05
				p3 = p1 - camMat.right*0.07 - camMat.up*0.1
				p4 = p1 - camMat.up*0.15

				dxDrawLine3D(p1.x,p1.y,p1.z, 	p2.x,p2.y,p2.z,	coloc,0.5)
				dxDrawLine3D(p2.x,p2.y,p2.z, 	p3.x,p3.y,p3.z,	coloc,0.5)
				dxDrawLine3D(p3.x,p3.y,p3.z, 	p4.x,p4.y,p4.z,	coloc,0.5)

				atG.textColor = fromColor(coloc)
				atG.textColor.r = atG.textColor.r*2; atG.textColor.g = atG.textColor.g*2; atG.textColor.b = atG.textColor.b*2; atG.textColor.a = 255
				atG.textColor = tocolorT(atG.textColor)
			else
				if not atG.pulse then
					atG.textColor = tocolor(220,170,30,255)
					atG.mode = "SAVE"
				end
			end
		end,

		offsets = {
			idle = {
 				x = 0.068, y = 0.014, z = 0.05,
 				rx = -0.192, ry = -0.022, rz = 0.09
			},
			aim = {
 				x = 0.088, y = 0.018, z = 0.05,
 				rx = -0.224, ry = 0.054, rz = 0.09
			}
		},
		shootP = {
			 forward = 0.19, right = 0.004, up = 0.020 		-- matrix2
		},

		shoot_Init = function(atG)
			if not atG.pulse then
				setFr_block(1500)
			end
			triggerShootToS(atG,{pulse = atG.pulse})
		end, 
		shoot_End = triggerShootEndToS,

		shoot = function(atG,args)
			if atG.pulse then
				cannonsT.tazer.shoot_voltageRope(atG)
			else
				cannonsT.tazer.shootRope(atG)
			end
		end,
		shootEnding = function()
			voltageRope(atG.ropes[1],false)
			voltageRope(atG.ropes[2],false)
		end,
		
		shoot_voltageRope = function(atG,args)
			voltageRope(atG.ropes[1],true)
			voltageRope(atG.ropes[2],true)
		end,			
		
		shootRope = function(atG)
			
			atG.pulse = true
			atG.mode = 'PULSE'
			atG.textColor = tocolor(225,40,50,255)

			local me = false
			local myRope = false
			if atG.player == localPlayer then
				me = true
				myRope = true
			end
			
			local otn = atG.gunT.shootP

			local smeser = 0.01

			local p1 = getPositionFromElementOffset(atG.gunObject,otn.forward,otn.right-smeser,otn.up)
			local p2 = getPositionFromElementOffset(atG.gunObject,otn.forward,otn.right+smeser,otn.up)

			local forw1 = getPositionFromElementOffset(atG.gunObject,otn.forward - 5,otn.right,otn.up)
			local forw11 = getPositionFromElementOffset(atG.gunObject,otn.forward - 2,otn.right,otn.up)
			local forw111 = getPositionFromElementOffset(atG.gunObject,otn.forward - 1,otn.right,otn.up)

			local rope1 = createRope(p1.x,p1.y,p1.z,{obj = atG.gunObject,forward = otn.forward,right = otn.right - smeser,up = otn.up,myRope = me})
			local rope2 = createRope(p2.x,p2.y,p2.z,{obj = atG.gunObject,forward = otn.forward,right = otn.right + smeser,up = otn.up,myRope = me})

			atG.ropes = {rope1.serial,rope2.serial}
			outputChatBox(tostring(atG.ropes))

			ropePoints1 = rope1.points
			ropePoints2 = rope2.points

			ropePoints1[#ropePoints1].last = forw1 		+ Vector3(0,smeser,0)
			ropePoints1[#ropePoints1-1].last = forw11 	+ Vector3(0,smeser,0)
			ropePoints1[#ropePoints1-2].last = forw111 	+ Vector3(0,smeser,0)

			ropePoints2[#ropePoints2].last = forw1 		- Vector3(0,smeser,0)
			ropePoints2[#ropePoints2-1].last = forw11 	- Vector3(0,smeser,0)
			ropePoints2[#ropePoints2-2].last = forw111 	- Vector3(0,smeser,0)

			setEffectDensity(createEffect("gunsmoke",p1.x,p1.y,p1.z,-90,0,0),2)
			setEffectDensity(createEffect("camflash",p1.x,p1.y,p1.z,-90,0,0),0.15)
			--prt_sand
			--prt_spark
			--setTimer("prt_sand")
			
		end
	}

---  idle == crouch & aim    = idle
---  aim == courch   		 = aim









------------------------------------------------------------------------------------------------------------------
end
return canonTables
--string.format("%05d", agun.gunSerial)