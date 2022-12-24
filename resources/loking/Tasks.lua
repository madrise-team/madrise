----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared

rlg = exports.reglog
rlsc = exports.RRL_Scripts
------------------------------------
------------------------------------


local taskSerial = 0
Tasks = {}



--------------------------------------------
--Helper Functions
function triggerMembersState(taskBlock)
	if not taskBlock.membersGroup then return end 

	local grpMembers = rlg:getGroup(taskBlock.membersGroup).members
	for k,v in pairs(grpMembers) do
		local player = rlg:getPlayerByNickName(v)
		triggerClientEvent(player,"taskState",root,{
			serial= 		taskBlock.serial,
			tasksGroup= 	taskBlock.tasksGroup,
			description=	taskBlock.description,
			result= 		taskBlock.result,
			timer= 			taskBlock.timer 
		})
	end
end
--------------------------------------------


TasksPrefabs = {}



TasksPrefabs.markerCapture = {}
--------------------------
-- коснуться/покинуть маркер для выполнения
-- args.Type:
	-- def: 1 - любой из группы объектов касается маркера
	-- 		2 - все из группы объектов должны коснуться маркера

-- rgba size markerType - настройки маркера
-- objects - массив объектов которые должны занять маркер

-- event def:"onMarkerHit" - на какое событие реагировать (хит или лив, противоположное событие будет сбивать прогресс (лив сбивает таймер хита))
-- eventTimer - после срабатывания event запустится таймер, завершения которого приведет к окончанию таска с eventResult. 
-- eventTimerReaction - реакиция eventTimer на противоположное событие событию event.1
	-- def: 0 - сбрасывать
	-- 		1 - ставить на паузу [НЕ РЕАЛИЗОВАНО!]
	-- 		2 - разворачивать	 [НЕ РЕАЛИЗОВАНО!]
-- eventResult def:{true}- табилица результата по завершению таска 

-- gruopMembersDetect - следить за участиниками группы [НЕ РЕАЛИЗОВАНО!]

--------------------------
TasksPrefabs.markerCapture.create = function(tB)
	tB.description = tB.description or "@ markerCapture prefab"

	local arg = tB.args

	arg.capObjecs = {}
	arg.objectsKey = {}
	for k,v in pairs(arg.objects) do
		arg.objectsKey[tostring(v)] = v
	end

	arg.event = arg.event or "onMarkerHit"
	arg.oppositeEvent = "onMarkerLeave"
	if arg.event == "onMarkerLeave" then arg.oppositeEvent = "onMarkerHit" end
	if arg.eventResult == nil then arg.eventResult = true end
	arg.eventTimerReaction = 0
	arg.type = arg.type or 1
	arg.dim = arg.dim or 0
	arg.int = arg.int or 0
	arg.r = arg.r or 0; arg.g = arg.g or 0;	arg.b = arg.b or 0;	arg.a = arg.a or 0
	arg.size = arg.size or 3

	arg.marker = createMarker(arg.x,arg.y,arg.z, arg.markerType or "checkpoint",arg.size, arg.r, arg.g, arg.b, arg.a)

	local capHandle = function(capturing)
		if arg.eventTimer then
			if capturing then
				local timerIndex,_,timeToEnd = createTimer(arg.eventTimer.hours,arg.eventTimer.mins,arg.eventTimer.secs,function()
					tB.endTask({arg.eventResult})
				end)
				arg.eventTimerIndex = timerIndex
				tB.timer = timeToEnd
				triggerMembersState(tB)
			else
				if arg.eventTimerReaction == 0 then 	-- сброс таймера
					removeTimer(arg.eventTimerIndex)
				end
				tB.timer = false
				triggerMembersState(tB)
			end
		else
			if capturing then tB.endTask({arg.eventResult}) end -- моментальное завершение
		end
	end

	local checkCapObjects = function()
		if arg.type == 1 then
			capHandle(true)
		elseif arg.type == 2 then
			for k,v in pairs(arg.objects) do
				if not arg.capObjecs[tostring(v)] then return end
			end
			capHandle(true) -- все объекты внутри маркера
		end
	end
	local hanleObject = function(object, enable)
		if (getElementDimension(object) ~= arg.dim) then return end
		if (getElementInterior(object) ~= arg.int) then return end
		local objectStr = tostring(object)
		if arg.objectsKey[objectStr] then arg.capObjecs[objectStr] = enable end
	end
	tB.markerEventHandler = function(object)
		hanleObject(object, true)
		checkCapObjects()
	end
	tB.markerOppositeEventHandler = function(object)
		hanleObject(object, false)
		capHandle(false)
	end

	addEventHandler(arg.event,arg.marker,tB.markerEventHandler)
	addEventHandler(arg.oppositeEvent,arg.marker,tB.markerOppositeEventHandler)

	for k,v in pairs(arg.objects) do
		local x,y = getElementPosition(v)
		if getDistanceBetweenPoints2D ( arg.x, arg.y, x, y ) < arg.size then
			if arg.event == "onMarkerHit" then tB.markerEventHandler(v) end
		else
			if arg.event == "onMarkerLeave" then tB.markerEventHandler(v) end
		end
	end
end
TasksPrefabs.markerCapture.destroy = function(tB)
	removeEventHandler(tB.args.event,tB.args.marker,tB.markerEventHandler)
	removeEventHandler(tB.args.oppositeEvent,tB.args.marker,tB.markerOppositeEventHandler)

	destroyElement(tB.args.marker)
end

---- Завершить таск шаблон может через tB.endTask, указав при этом таблицу result:
---			Результат целиком табилицей улетит в коллбек
--	succses - успешность результа (можно просто за 1м ключом назначить типо "{true}"" )
--	reason - тестованя причина звершнения 
--	args - параметры завершения

---- Можно также указать причину успеха или причину провала, залив её в аргументы таска
---			Они подставятся в причину по завершению
-- succsesReason - причина успеха
-- failReason - причина провала

function createTask(membersGroup,tasksGroup,prefabName,args,callback)
	taskSerial = taskSerial + 1
	
	local taskBlock = {
		serial = taskSerial, 
		tasksGroup = tasksGroup, 
		args = args,
		membersGroup = membersGroup,
		description = args.description
	}

	taskBlock.endTask = function(result)
		if result[1] then result.succses = result[1] end   -- для быстрого указания успешноти
		taskBlock.result = result or {}

		if taskBlock.succses then
			if taskBlock.succsesReason then taskBlock.reason = taskBlock.succsesReason end
		else
			if taskBlock.failReason then taskBlock.reason = taskBlock.failReason end
		end		

		triggerMembersState(taskBlock)
		TasksPrefabs[prefabName].destroy(taskBlock)
		if callback then callback(result) end
	end

	TasksPrefabs[prefabName].create(taskBlock)

	triggerMembersState(taskBlock)
	return taskBlock
end

addCommandHandler("dayTask",function(player,_,tasksGroup,description)
	

	local object = player
	local target = 'Займи маркер (не опять а снова)'

	local avto = getPedOccupiedVehicle(player)
	if avto then 
		object = avto
		target = 'Приезжай )' 
	end

	local grupSer = rlg:createGroupFromPlayer(player)
		
	local taskBlock 
	taskBlock = createTask(grupSer,tasksGroup or "simpleGroup","markerCapture",{
		x = 1690.8992919922,
		y= -1729.6876220703,
		z = 13.390605926514,
		size = 15,
		type = 1,
		objects = {object},
		eventTimer = {mins = 0,secs = 5},
		event = "onMarkerLeave",
		eventResult = true, 
	},function(result)
		if result.succses then
			outputChatBox("Ящек успешно доставлен... задрот")
		else
			outputChatBox("Вы провалено!")
		end
		rlg:destroyGroup(grupSer)
	end)

	local function deleter()
		if not taskBlock.result then taskBlock.endTask({false, reason = 'Вы нажали кнопку "Ой я не справлюсь хочу сдаться хнык-хнык" '}) end
		unbindKey(player,"0","down",deleter)
	end

	bindKey(player,"0","down",deleter)
end)