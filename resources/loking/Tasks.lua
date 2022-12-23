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
		})
	end
end
--------------------------------------------


TasksPrefabs = {}



TasksPrefabs.markerCapture = {}
--------------------------
-- коснуться маркера для выполнения
-- args.Type:
--  default 1 - любой из группы объектов касается маркера
--  2 - все из группы объектов должны коснуться маркера

-- rgba size markerType - настройки маркера
-- objects - массив объектов которые должны занять маркер

-- gruopMembersDetect - следить за участиниками группы [НЕ РЕАЛИЗОВАНО!]

--------------------------
TasksPrefabs.markerCapture.create = function(tB)
	tB.description = tB.description or "Прибыть на условленное место"

	local arg = tB.args
	
	arg.type = arg.type or 1

	arg.dim = arg.dim or 0
	arg.int = arg.int or 0

	arg.r = arg.r or 0
	arg.g = arg.g or 0
	arg.b = arg.b or 0
	arg.a = arg.a or 0

	arg.capObjecs = {}
	
	arg.objects = arg.objects or {}

	arg.marker = createMarker(arg.x,arg.y,arg.z, arg.markerType or "checkpoint",arg.size or 3, arg.r, arg.g, arg.b, arg.a)

	local checkCapObjects = function()
		if arg.type == 1 then
			tB.endTask({true})
		elseif arg.type == 2 then

			for k,v in pairs(args.objects) do
				if not arg.capObjecs[tostring(v)] then return end
			end
			-- все объекты внутри маркера
			tB.endTask({true})
		end
	end

	tB.markerHandler = function(object,dimention)
		local dim = getElementDimension(object)
		local int = getElementInterior(object)

		if (dim ~= arg.dim) or (int ~= arg.int) then return end
		
		for k,v in pairs(arg.objects) do
			if object == v then
				arg.capObjecs[tostring(object)] = true
				checkCapObjects()
			end
		end

	end
	addEventHandler("onMarkerHit",arg.marker,tB.markerHandler)

end
TasksPrefabs.markerCapture.destroy = function(tB)
	removeEventHandler("onMarkerHit",tB.args.marker,tB.markerHandler)
	destroyElement(tB.args.marker)
end

---- Завершить таск шаблон может через tB.endTask, указав при этом таблицу result:
--	succses - успешность результа
--	reason - тестованя причина звершнения 
--	args - параметры завершения
---			Результат улетит в коллбек

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


	local reEnd = false
	local taskBlock 
	taskBlock = createTask(grupSer,tasksGroup or "simpleGroup","markerCapture",{
		x = 1690.8992919922,
		y= -1729.6876220703,
		z = 13.390605926514,
		objects = {object},
		description = description or target 
	},function(result)
		if result.succses then
			if avto then
				result.reason = "Приехал Лох"
			end
			outputChatBox("Ящек успешно доставлен... задрот")
		else
			outputChatBox("Ты угораешь? Это задание для тестирования системы, как его ваще завалить можно было? Ебать ты коооонч...")
		end
		rlg:destroyGroup(grupSer)
	end)

	local function deleter()
		if not taskBlock.result then taskBlock.endTask({false, reason = 'Вы нажали кнопку "Ой я не справлюсь хочу сдаться хнык-хнык" '}) end
		unbindKey(player,"0","down",deleter)
	end

	bindKey(player,"0","down",deleter)
end)