----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server

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

	for k,player in pairs(taskBlock.grpPlayers) do
		triggerLatentClientEvent(player,"taskState",10000,false,root,{
			serial= 		taskBlock.serial,
			tasksGroup= 	taskBlock.tasksGroup,
			description=	taskBlock.description,
			result= 		taskBlock.result,
			timer= 			taskBlock.timer,
			blip= 			taskBlock.blip
		})
	end
end
--------------------------------------------


TasksPrefabs = {}
----------------------------------------------------------------------------------------------------
---- Параметры передающиеся клиентской стороне
-- result - если есть, задание будет отмечено как выполненное или проваленное
-- reason - если есть, рядом с заданием будет указана причина результа
-- timer -  если есть, редом с заданием будет идти таймер обратного отсчета

---------------------------------------------------------------------------------------------------- elementCare
-- Не покидать зону, привязанную к элементу
-- element - элемент за которым нужно следить [ Игрок / Пед / Авто ]

-- Все настройки таска markerCapture, Переопределено:
	-- attach - Аттачем всегда будте element
	-- eventResult - Нормальное завершение всегда приведет к провалу
	-- type - всегда 2 (за элементов может следить хоть 1 игрок).
	-- size def:10 - размер зоны
	-- timer def: {mins = 2} - тамер на защиту element
	-- gruopMembersDetect - всегда true

TasksPrefabs.elementCare = {}
TasksPrefabs.elementCare.create = function(tB)
	tB.args.elementType = getElementType(tB.args.element)
	tB.description = tB.description or "@ elementCare prefab: "..tB.args.elementType

	tB.args.attach = tB.args.element
	tB.args.type = 2
	tB.args.size = tB.args.size or 10
	tB.args.event = "onMarkerLeave"
	tB.args.eventResult = false
	tB.args.eventTimer = tB.args.eventTimer or {mins = 2}
	tB.args.gruopMembersDetect = true

	TasksPrefabs.markerCapture.create(tB)

	tB.args.taskFailHandler	= function()
		tB.endTask({false})
	end
	tB.args.removeCareHandler = function()
		if tB.args.careHandlRemoved then return end
		tB.args.careHandlRemoved = true

		local elemel = source or tB.args.element
		removeEventHandler("onElementDestroy", elemel, tB.args.removeCareHandler)
		removeEventHandler(tB.args.careEvent, elemel, tB.args.taskFailHandler)

		tB.endTask({false})
	end

	if tB.args.elementType == "player" then tB.args.careEvent = "onPlayerWasted"
	elseif tB.args.elementType == "ped" then tB.args.careEvent = "onPedWasted"
	elseif tB.args.elementType == "vehicle" then tB.args.careEvent = "onVehicleExplode" 
	else outputDebugString('Таск "elementCare" не может быть создан с element типа '..tostring(tB.args.elementType)) end

	addEventHandler(tB.args.careEvent,tB.args.element, tB.args.taskFailHandler)
	addEventHandler("onElementDestroy", tB.args.element, tB.args.removeCareHandler)
end

TasksPrefabs.elementCare.destroy = function(tB)
	TasksPrefabs.markerCapture.destroy(tB)
	tB.args.removeCareHandler()
end

function setElementVisibleToPlayers(playersArray,element,visible,rootVisible)
	setElementVisibleTo(element,root,rootVisible or false)
	for k,v in pairs(playersArray) do
		setElementVisibleTo(element,v,visible)
	end
end

---------------------------------------------------------------------------------------------------- markerCapture
TasksPrefabs.markerCapture = {}

-- коснуться/покинуть маркер для выполнения
-- type:
	-- def: 1 - любой из группы объектов вызывает событие маркера
	-- 		2 - все из группы объектов должны вызвать событие маркера

-- rgba size markerType - настройки маркера
-- attach - элемент к котолрому приаттачить маркер
-- xOffset,yOffset,zOffset - параметры аттача
-- objects - массив объектов которые должны занять маркер

-- blip - настройки блипа, в найстроки будут принудетельно перенесены координаты созданного маркера

-- event def:"onMarkerHit" - на какое событие реагировать (хит или лив, противоположное событие будет сбивать прогресс (лив сбивает таймер хита))
-- eventTimer - после срабатывания event запустится таймер, завершения которого приведет к окончанию таска с eventResult. 
-- eventTimerReaction - реакиция eventTimer на противоположное событие событию event.1
	-- def: 0 - сбрасывать
	-- 		1 - ставить на паузу [НЕ РЕАЛИЗОВАНО!]
	-- 		2 - разворачивать	 [НЕ РЕАЛИЗОВАНО!]
-- eventResult def:{true}- табилица результата по завершению таска 

-- gruopMembersDetect - objects - участиники группы [НЕ РЕАЛИЗОВАНО!]

TasksPrefabs.markerCapture.create = function(tB)
	tB.description = tB.description or "@ markerCapture prefab"

	local arg = tB.args

	arg.objects = arg.objects or {}

	arg.capObjecs = {}

	local getObjectsKeys = function()
		arg.objectsKey = {}
		for k,v in pairs(arg.objects) do
			arg.objectsKey[tostring(v)] = true
		end	
	end
	getObjectsKeys()

	arg.event = arg.event or "onMarkerHit"
	arg.oppositeEvent = "onMarkerLeave"
	if arg.event == "onMarkerLeave" then arg.oppositeEvent = "onMarkerHit" end
	if arg.eventResult == nil then arg.eventResult = true end
	arg.eventTimerReaction = 0
	arg.type = arg.type or 1

	arg.x = arg.x or 0; arg.y = arg.y or 0; arg.z = arg.z or 0
	arg.dim = arg.dim or 0
	arg.int = arg.int or 0
	arg.r = arg.r or 0; arg.g = arg.g or 0;	arg.b = arg.b or 0;	arg.a = arg.a or 0
	arg.size = arg.size or 3

	arg.marker = createMarker(arg.x,arg.y,arg.z, arg.markerType or "checkpoint",arg.size, arg.r, arg.g, arg.b, arg.a)
	if tB.membersGroup then setElementVisibleToPlayers(tB.grpPlayers,arg.marker,true) end

	if arg.blip then
		arg.blip.x = arg.x
		arg.blip.y = arg.y
		arg.blip.z = arg.z
		arg.blip.attach = arg.attach

		arg.blip = createBlip( arg.blip.x,arg.blip.y,arg.blip.z,
					arg.blip.icon, arg.blip.size, 
					arg.blip.r, arg.blip.g, arg.blip.b, arg.blip.a, 
					arg.blip.ordering, arg.blip.visibleDistance
				)
		if tB.membersGroup then setElementVisibleToPlayers(tB.grpPlayers,arg.blip,true) end
	end

	if arg.attach then 
		attachElements(arg.marker, arg.attach, arg.xOffset, arg.yOffset, arg.zOffset) 
		if arg.blip then
			attachElements(arg.blip, arg.attach, arg.xOffset, arg.yOffset, arg.zOffset) 
		end
	end

	local capHandle = function(capturing)
		if arg.eventTimer then
			if capturing then
				if tB.timer then return end
				local timerIndex,_,timeToEnd = createTimer(arg.eventTimer.hours,arg.eventTimer.mins,arg.eventTimer.secs,function()
					tB.endTask({arg.eventResult})
				end)
				arg.eventTimerIndex = timerIndex
				tB.timer = timeToEnd
				triggerMembersState(tB)
			else
				if not tB.timer then return end
				
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
		for k,v in pairs(arg.objectsKey) do
			if not arg.capObjecs[k] then
				capHandle(false) -- не все объекты внутри маркера
				return
			else
				if arg.type == 1 then
					capHandle(true)
					return
				end
			end
		end
		capHandle(true) -- все объекты внутри маркера
	end
	local hanleObject = function(object, enable)
		if not object then return end
		if (getElementDimension(object) ~= arg.dim) or (getElementInterior(object) ~= arg.int) then return end

		local objectStr = tostring(object)
		if arg.objectsKey[objectStr] then 
			arg.capObjecs[objectStr] = enable 
			checkCapObjects()
		end
	end
	tB.markerEventHandler = function(object)
		hanleObject(object, true)
	end
	tB.markerOppositeEventHandler = function(object)
		hanleObject(object, false)
	end

	if arg.gruopMembersDetect then
		tB.groupChanged = function()
			arg.objects = tB.grpPlayers
			getObjectsKeys()

			if arg.type == 2 then
				checkCapObjects()
			end

			setElementVisibleToPlayers(tB.grpPlayers,arg.marker,true)
			if arg.blip then setElementVisibleToPlayers(tB.grpPlayers,arg.blip,true) end

		end
		tB.groupChanged()
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

	if tB.timer then 
		removeTimer(tB.args.eventTimerIndex)
		tB.timer = nil
	end

	destroyElement(tB.args.marker)
	if tB.args.blip then destroyElement(tB.args.blip) end
end
----------------------------------------------------------------------------------------------------


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
		description = args.description,
	}

	taskBlock.endTask = function(result)
		if taskBlock.result then return end

		if result[1] then result.succses = result[1] end   -- для быстрого указания успешноти result = {true}
		taskBlock.result = result

		local callBackResult
		if callback then 
			callBackResult = callback(taskBlock)
		end

		if callBackResult == false then
			taskBlock.result = nil
			return
		end

		if taskBlock.succses then
			if taskBlock.succsesReason then taskBlock.reason = taskBlock.succsesReason end
		else
			if taskBlock.failReason then taskBlock.reason = taskBlock.failReason end
		end		

		TasksPrefabs[prefabName].destroy(taskBlock)
		triggerMembersState(taskBlock)
		if taskBlock.membersGroup then
			removeEventHandler("groupChanged".. (membersGroup or "_X"),root,taskBlock._groupChanged)
			rlg:groupRemoveTask(taskBlock.membersGroup,taskBlock.serial)
		end
	end

	taskBlock._groupChanged = function(args)
		taskBlock.grpPlayers = rlg:groupGetPlayers(taskBlock.membersGroup)
		if args.deleted then
			outputDebugString("Таск закрыт поскльку группы больше нет.")
			taskBlock.endTask({false, "Группа расформирована"})
		else
			if taskBlock.groupChanged then taskBlock.groupChanged(args) end
		end
	end
	if taskBlock.membersGroup then
		rlg:groupAddTask(taskBlock.membersGroup,taskBlock.serial)
		taskBlock.grpPlayers = rlg:groupGetPlayers(taskBlock.membersGroup)
		addEvent("groupChanged"..taskBlock.membersGroup,true)
		addEventHandler("groupChanged"..taskBlock.membersGroup,root,taskBlock._groupChanged)
	end

	TasksPrefabs[prefabName].create(taskBlock)

	triggerMembersState(taskBlock)
	return taskBlock
end