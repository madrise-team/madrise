--BOK---------------------------------------------------------------------------------------------------------------------------------
posOffRand = 100
rotOffRand = 3000
posSinSmeser = 0.4
rotSinSmeser = 8

offsets = {}
for i=1,14 do
	offsets[i] = {x=math.random(-posOffRand,posOffRand),y=math.random(-posOffRand,posOffRand),z=math.random(-posOffRand,posOffRand),
				rx=math.random(-rotOffRand,rotOffRand),ry=math.random(-rotOffRand,rotOffRand),rz=math.random(-300,300),
				s = {sinSmeserX = math.random(0,10000), sinSmeserY = math.random(0,10000), sinSmeserZ = math.random(0,10000),
				sinSmeserRX = math.random(0,10000), sinSmeserRY = math.random(0,10000), sinSmeserRZ = math.random(0,10000)}
			}
end

function sinSmeser(framN)
	return (math.sin(framN) + math.cos(framN))/2
end

spasedBokWepes = false
addEventHandler("onClientRender",root,function()
	if not spasedBokWepes then return end

	local x,y,z = getElementBonePosition(localPlayer,2)
	local rx,ry,rz = getElementRotation(localPlayer)

	local mat = Matrix(x,y,z,rx,ry,rz)
	local rotter = rz+90

	local poses = {
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[1].s.sinSmeserX)*posSinSmeser) + mat.right*0.4 + mat.forward*0.3,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[2].s.sinSmeserX)*posSinSmeser) + mat.right*0.5 + mat.up*0.2 + mat.forward*0.4,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[3].s.sinSmeserX)*posSinSmeser) + mat.right*0.4 + mat.up*0.4 + mat.forward*0.3,

		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[4].s.sinSmeserX)*posSinSmeser) - mat.right*0.4 + mat.forward*0.3,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[5].s.sinSmeserX)*posSinSmeser) - mat.right*0.5 + mat.up*0.2 + mat.forward*0.4,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[6].s.sinSmeserX)*posSinSmeser) - mat.right*0.4 + mat.up*0.4 + mat.forward*0.3,


		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[7].s.sinSmeserX)*posSinSmeser) - mat.right*0.6 - mat.up*0.1,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[8].s.sinSmeserX)*posSinSmeser) - mat.right*0.7 + mat.up*0.1 + mat.forward*0.1,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[9].s.sinSmeserX)*posSinSmeser) - mat.right*0.7 + mat.up*0.3 + mat.forward*0.1,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[10].s.sinSmeserX)*posSinSmeser) - mat.right*0.6 + mat.up*0.5,

		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[11].s.sinSmeserX)*posSinSmeser) + mat.right*0.6 - mat.up*0.1,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[12].s.sinSmeserX)*posSinSmeser) + mat.right*0.7 + mat.up*0.1 + mat.forward*0.1,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[13].s.sinSmeserX)*posSinSmeser) + mat.right*0.7 + mat.up*0.3 + mat.forward*0.1,
		mat.position - mat.forward*(0.1 + sinSmeser(frame/200 + offsets[14].s.sinSmeserX)*posSinSmeser) + mat.right*0.6 + mat.up*0.5,
	}

	local itoe = 0
	for k,v in pairs(poses) do
		itoe = itoe + 1

		setElementPosition(spasedBokWepes[itoe],
						v.x + offsets[itoe].x    	+ sinSmeser(frame/300 + offsets[itoe].s.sinSmeserX)*posSinSmeser/10,
						v.y + offsets[itoe].y 		+ sinSmeser(frame/300 + offsets[itoe].s.sinSmeserY)*posSinSmeser/10, 
						v.z + offsets[itoe].z 		+ sinSmeser(frame/300 + offsets[itoe].s.sinSmeserZ)*posSinSmeser/10)

		setElementRotation(spasedBokWepes[itoe],
						rx + offsets[itoe].rx 		+ sinSmeser(frame/300 + offsets[itoe].s.sinSmeserRX)*rotSinSmeser/10,
						ry + offsets[itoe].ry 		+ sinSmeser(frame/300 + offsets[itoe].s.sinSmeserRY)*rotSinSmeser/10, 
						rotter + offsets[itoe].rz 	+ sinSmeser(frame/300 + offsets[itoe].s.sinSmeserRZ)*rotSinSmeser/10)

		for k,v in pairs(offsets[itoe]) do
			if type(v)~='table' then
				offsets[itoe][k] = offsets[itoe][k]/1.03
			end
		end
	end
end)

addEventHandler("onClientKey",root,function(button,por)
	if not spasedBokWepes then return end
	if button == "mouse1" then 
		m1but = por
		frame = frame + frame%3
	end
end)


wepsy = {"ak-47","m4","mp5","uzi","tec-9"}
addCommandHandler("bok",function()
	if spasedBokWepes  then return end
	spasedBokWepes = {}

	for i=1,14 do
		spasedBokWepes[i] = createWeapon(wepsy[math.random(1,#wepsy)],0, 0, 0)
	end
end)

frame = 0
addEventHandler("onClientRender",root,function()
	frame = frame + 1
	if not m1but then return end

	if frame > 10000 then frame = 0 end
	if frame % 3 ~= 0 then return end


	if spasedBokWepes then
		for k,v in pairs(spasedBokWepes) do
			local spvr = math.random(0,100)
			if spvr > 40 then
				fireWeapon(v)
			end
		end
	end
end)