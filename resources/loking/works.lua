----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server + Shared + usfulRoots + usfulDB + accUsful
import('loking/lokingWoksCoords.lua')()
------------------------------------

function collectDeposit(player, zalog)
	if getPlayerMoney(player) >= zalog then
		takePlayerMoney (player, zalog)
		return true
	else
		outputChatBox("У вас не хватает денег для оплаты залога за рабочий транспорт.", player)
		return false 
	end
end
function findClearPlaceIndex(array)
	for i,v in ipairs(array) do
		if not v.placeHolded then return array[i] end
	end
	return false
end
function createPlaceHolder(session,placeHoldArray,size, avto)
	placeHoldArray.placeHolded = true

	table.insert(session.tasks,createTask(_,_,"markerCapture",{
		x = placeHoldArray.x, y = placeHoldArray.y, z = placeHoldArray.z, size = size,
		objects = {avto},
		event = "onMarkerLeave"
	},function()
		placeHoldArray.placeHolded = false
	end))
end

function createAvtoWithHolder(session,model,coords,label)
	local avto = createVehicle (model, coords.x, coords.y, coords.z, 0, 0, coords.rz,	label)
	createPlaceHolder(session,coords, workHelpers.carPlaceHolderSize, avto)
	return avto
end

function createCareAvtoWithHolder(session,model,coords,label,blipIcon)
	local avto = createAvtoWithHolder(session,model,coords,label)
	avtoCareTask(session,avto,nil,taskResultCapture(session),nil,blipIcon or 55)
	session.createdAvtoHealthes = session.createdAvtoHealthes or {}
	session.createdAvtoHealthes[tostring(avto)] = getElementHealth(avto)


	return avto
end

function sessionTask(session,taskPrefabName,args,taskParams,callback)
	args.description = taskParams.description or taskParams[1]
	args.succsesReason = taskParams.succsesReason
	args.failReason = taskParams.failReason

	local index = #session.tasks + 1
	local task = createTask(session.groupS,Works[session.jobName].taskGroup,taskPrefabName,args,function(tB)
		if callback(tB) then
			table.remove(session.tasks,index)		
		end
	end)
	table.insert(session.tasks,task)
	return task
end

function arriveMarkerTask(session,objectsOrGruopMembersDetect,cords,size,callback,taskParams,blipIcon,timer)
	local eCol = workHelpers.edbaColor

	local gruopMembersDetect = not (type(objectsOrGruopMembersDetect) == "table")
	if gruopMembersDetect then objectsOrGruopMembersDetect = nil end

	local blip
	if blipIcon then blip = {icon = blipIcon} end

	return sessionTask(session,"markerCapture",{
		x = cords.x, y = cords.y, z = cords.z - 1,
		r = eCol.r,g = eCol.g,b = eCol.b,a = eCol.a,
		size = size,
		blip = blip,
		objects = objectsOrGruopMembersDetect,
		eventTimer = timer,
		gruopMembersDetect = gruopMembersDetect
	},taskParams,callback)
end
function avtoCareTask(session,avto,size,callback,taskParams,blipIcon,timer)
	timer = timer or workHelpers.avtoCareTimer
	local blip
	if blipIcon then blip = {icon = blipIcon} end

	taskParams = taskParams or {
		description = "Не покидайте на долго автомобиль и следите за его сохранностью!"
	}

	return sessionTask(session,"elementCare",{
		element = avto,
		size = size or workHelpers.carPlaceHolderSize,
		blip = blip,
		eventTimer = timer
	},taskParams,callback)

end

function taskResultCapture(session,succsesCallback)
	return function(tB)
		if tB.result.succses then
			if succsesCallback then succsesCallback(tB) end
		else 
			session.endJob(true)
		end
	end
end



workHelpers = {}
workHelpers.edbaColor = {r = 50,g = 150,b = 255,a = 255}
workHelpers.carArriveSize = 5
workHelpers.carPlaceHolderSize = 10
workHelpers.avtoCareTimer = {mins = 0,secs = 60}

Works = {}
------------------------------------------------------------------------------------------------------ dostJob
Works.dostJob = {};dostJob = Works.dostJob
dostJob.taskGroup = "Работа доставки"
dostJob.statPoint = {x= -49.89774,y= -270,z= 0}
dostJob.endPoint = {x=-94.785766601562,y= -382.04705810547,z= 0}
dostJob.deposit = 500
dostJob.depositCost = 0.1
dostJob.autoSpawnCoods = CoordsDostJob.autoSpawnCoods
dostJob.roads = CoordsDostJob.roads
dostJob.availableAutos = {414, 456, 498, 499}
dostJob.distancePayRatio = 1
dostJob.bonusRatio = 0.1
dostJob.unloadingTimer = {mins = 0, secs = 10}
dostJob.bonusDistTimeRatio = 18

dostJob.start = function(session)
	local arendCost = dostJob.deposit * dostJob.depositCost
	arriveMarkerTask(session,true,dostJob.statPoint,nil,function(tB)
		if not tB.result.succses then return end

		session.avtoSpawnCoord = findClearPlaceIndex(dostJob.autoSpawnCoods)
		if not session.avtoSpawnCoord then 
			outputChatBox("В данный момент рабочий транспрот не может быть выдан, пожалуйста попробуйте позже"); return false 
		end

		session.getGroupLeader()
		if collectDeposit(session.leaderPlayer, dostJob.deposit) then
			return dostJob.spawnAvtoAndStartRoad(session)
		else
			return false
		end
	end,{"Арендовать рабочий транспрот [Сумма Залога: "..(dostJob.deposit - arendCost)..", Cтоимость аренды: "..arendCost.." ]"},51)
end
dostJob.spawnAvtoAndStartRoad = function(session)
	session.avtoModel = dostJob.availableAutos[math.random(1, #dostJob.availableAutos)]
	session.avto = createCareAvtoWithHolder(session,session.avtoModel,session.avtoSpawnCoord,"Dost Ltd")
	session.avtoA = {session.avto}

	session.roadNum = math.random(1, #dostJob.roads)
	session.roadCoord = dostJob.roads[session.roadNum]

	session.deliveryDistance = getDistanceBetweenPoints2D(				
			session.avtoSpawnCoord.x,session.avtoSpawnCoord.y, 
			session.roadCoord.x, session.roadCoord.y)

	session.reward =  session.deliveryDistance * dostJob.distancePayRatio
	session.reward = math.ceil(session.reward)

	dostJob.delivery(session)
end
dostJob.delivery = function(session)
	session.deliveryStartTime = getRealTime().timestamp
	arriveMarkerTask(session,session.avtoA,session.roadCoord,workHelpers.carArriveSize,taskResultCapture(session,function()
		local bonusText = ""
		local deliveryEndTime = getRealTime().timestamp

		session.bonusSumm = 0

		local dostTime = (deliveryEndTime - session.deliveryStartTime)
		local bonusTime = (session.deliveryDistance/dostJob.bonusDistTimeRatio + (dostJob.unloadingTimer.mins*60 + dostJob.unloadingTimer.secs) )
		if dostTime < bonusTime then
			session.bonusSumm = math.floor(session.reward*dostJob.bonusRatio)
			bonusText = " + Премиальные за скорость доставки: $ "..session.bonusSumm
		end
		outputChatBox( "Время доставки: "..dostTime.. " / " ..bonusTime)

		arriveMarkerTask(session,session.avtoA,dostJob.endPoint,workHelpers.carArriveSize,taskResultCapture(session,function()
			session.endJob()
		end),{"Вернуть автомобиль для получения вознарграждения [ $ ".. session.reward .. bonusText .." ]"},0)
	end),{"Доставить груз в назначенное место"},0,dostJob.unloadingTimer)
end
dostJob.endJob = function(session, error)
	local avtoHealth = 0
	if session.avto then 
		avtoHealth = getElementHealth(session.avto)/session.createdAvtoHealthes[tostring(session.avto)]

		destroyElement(session.avto)
		session.avto = nil
	end
	if not error then
		session.getGroupLeader()
		--- Расстояние * Коэффициент + (Залог - Залог * (Проц. стоимости аренды*Процент сотояния авто))
		
		local depositReturn = (dostJob.deposit - dostJob.deposit*dostJob.depositCost)
		local realDepositReturn = math.floor(depositReturn * avtoHealth)

		outputChatBox("Состояние авто: "..avtoHealth)
		if avtoHealth ~= 1 then
			outputChatBox("Конпесация издержек за ущерб рабочему транспортру составила: $ "..depositReturn - realDepositReturn)
		end

		givePlayerMoney(session.leaderPlayer, session.reward + realDepositReturn + session.bonusSumm)

		dostJob.start(session)
	end
end
------------------------------------------------------------------------------------------------------ dostJob



function startNewJob(groupS,jobName)
	local job = Works[jobName]
	if job == nil then outputConsole("ERROR! Trying starting doesn't existed job ("..jobName.."), check job name!!!!") ; return end
	
	local session = createSession(groupS,jobName)
	job.start(session)
end

function createSession(groupS,jobName)
	local session = {}
		session.groupS = groupS
		session.jobName = jobName
		session.tasks = {}

	session.endJob = function(error)
		if session.jobEndBlock then return end
		session.jobEndBlock = true
		
		local res = {not error}
		for k,v in pairs(session.tasks) do
			if not v.result then v.endTask(res) end
		end
		session.tasks = {}

		session.jobEndBlock = nil
		Works[jobName].endJob(session, error)
	end

	session.getGroupLeader = function()
		session.leaderNickname = rlg:groupGetLeader(session.groupS)
		session.leaderPlayer = rlg:getPlayerByNickName(session.leaderNickname)
	end


	return session
end 

function startNewJobForPlayer(player,jobName)
	local grupSer = getPlayerGroupData(player)
	if grupSer then
		rlg:groupRemoveMember(grupSer,getPlayerNickName(player))
		setPlayerGroupData(player,nil)
	end

	grupSer = rlg:createGroupFromPlayer(player)
	startNewJob(grupSer,jobName)
end

addCommandHandler("hochuWorka",function(player)
	startNewJobForPlayer(player,"dostJob")
end)

-- 55 - avto
outputChatBox("money in works gmMoney")
addCommandHandler("gmMoney", function(thePlayer)
	setPlayerMoney(thePlayer,900000)
	outputChatBox("loking gmMoney 900000")
end)