----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server

SQLStorage = exports.DB:MSC()
------------------------------------

actualId = 0
function updateActualId(acId)
	if acId then actualId = actualId 
	else actualId = actualId + 1 end
	dbExec(SQLStorage,"UPDATE `ids` SET `id` = ? WHERE (`name` = 'vehicles')",actualId)
	--dbExec(SQLStorage,"DELETE FROM `vehicles`")
end
dbQuery(function(qh)
	actualId = dbPoll(qh,0)[1].id + 1
	updateActualId(actualId)
	triggerEvent("vehReady",root)
end,SQLStorage,"SELECT `id` FROM `ids` WHERE (`name` = 'vehicles')")


function fromattColors(colTab)
	local col = colTab
	if not col then col = {} end

	for i=1,4 do
		col[i] = col[i] or {0,0,0}
	end

	return col
end

buildetThecars = {}


thecar = {}
function thecar:create(owner,model,colors)
	local this = {}

		this.owner = owner
		this.model = model
		this.colors = fromattColors(colors)

		this.odo = 0
		this.fuel = 20
		this.hp = 1000

		this.pos = {x=0,y=0,z=20,rx = 0,ry = 0,rz = 0,dim=0,int=0}

		this.locked = true

		dbExec(SQLStorage,"INSERT INTO `vehicles` (`id`,`owner`, `model`, `colors`, `odo`, `fuel`, `hp`, `pos`) VALUES (?,?,?,?,?,?,?,?)",
			actualId,
			this.owner,
			this.model,
			toJSON(this.colors,true),
			this.odo,
			this.fuel,
			this.hp,
			toJSON(this.pos,true)
			)
		this.id = actualId
		updateActualId()


	buildetThecars[this.id] = this

	setmetatable(this, self)
	self.__index = self
	return this
end
function thecar:build(data, callback)
	local this = {}
	this = data

	this.colors = fromJSON(this.colors)
	this.pos = fromJSON(this.pos)
	this.locked = toBool(this.locked)

	setmetatable(this, self)
	self.__index = self

	this:spawn()

	buildetThecars[this.id] = this
	if type(callback) == 'function' then callback(this) end
end
function thecar:spawn(pos)
	if pos then 
		self.pos = pos
		self:updateData()
	end
	self.element = createVehicle(self.model,self.pos.x,self.pos.y,self.pos.z,self.pos.rx,self.pos.ry,self.pos.rz, "nahuee",false)
	setElementDimension(self.element,self.pos.dim or 0)
	setElementInterior(self.element,self.pos.int or 0)
	self:updateElement()
end
function thecar:remove(cancelPosSave)
	if not cancelPosSave then self:savePositon() end

	destroyElement(self.element)
	buildetThecars[self.id] = nil
	self = nil 
end
function thecar:savePositon()
	local x,y,z = getElementPosition(self.element)
	local rx,ry,rz = getElementPosition(self.element)
	self.pos = {x=x,y=y,z=z,rx = rx,ry = ry,rz = rz,dim=getElementDimension(self.element),int=getElementInterior(self.element)}
	self:updateData()
end
function thecar:updateElement()
	local col = self.colors

	setVehicleColor(self.element, col[1][1], col[1][2], col[1][3], col[2][1], col[2][2], col[2][3], col[3][1], col[3][2], col[3][3], col[4][1], col[4][2], col[4][3])
	setVehicleLocked(self.element,self.locked)
	setElementData (self.element, "vehData", {owner = self.owner})
end
function thecar:updateData()
	dbExec(SQLStorage,"UPDATE `vehicles` SET `owner` = ?,`model`=?,`colors`=?,`odo`=?,`fuel`=?,`hp`=?,`pos`=? WHERE `id` = ?",
		self.owner,
		self.model,
		toJSON(self.colors,true),
		self.odo,
		self.fuel,
		self.hp,
		toJSON(self.pos,true),
		self.id)
end

function thecar:delete()
	dbExec(SQLStorage,"DELETE FROM `vehicles` WHERE (`id` = ?)", self.id)
	self:remove("not save pos")
end



function bindPlayerAvtoControls(thePlayer)
	bindKey(thePlayer,"k","down",function()
		local veh = getVehicleNearestToElementAtRange(thePlayer,100)
		if veh then
			local zakrit = isVehicleLocked(veh)
			setVehicleLocked(veh,not zakrit)
			if zakrit then
				outputChatBox("Открыть")
			else
				outputChatBox("Закрыть")
				setVehicleDoorState(veh,2,0)
				setVehicleDoorState(veh,3,0)
				setVehicleDoorState(veh,4,0)
				setVehicleDoorState(veh,5,0)
			end
		end
	end)

	bindKey(thePlayer,"mouse5","down",function()
		local veh = getPedOccupiedVehicle(thePlayer)
		local vehSeat = getPedOccupiedVehicleSeat(thePlayer)
		if vehSeat == 0 then
			local started = getVehicleEngineState(veh)
			setVehicleEngineState(veh,not started)
			if started then
				outputChatBox("Выключить")
			else
				outputChatBox("Запустить (в том смысле что включить а не кинуть (если кинуть, то эт на 3-5))")
			end
		end
	end)
end

addCommandHandler("avtoBind",function(thePlayer)
	bindPlayerAvtoControls(thePlayer)
end)


addEvent("vehReady")
addEventHandler("vehReady",root,function()
	-----  Скрипт готов к хуйне (старт скрипта тут писать а еще лучше в другом ваще скрипте тут сам класс(ядро) 
		
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function findBuildetThecars(array)
	for k,v in pairs(array) do
		if buildetThecars[v.id] then
			v.status = "buildet"
		else
			v.status = "cloud"
		end
	end
end

function getThecarFromId(id,callback)
	get1DbData('vehicles','id',id,function(data)
		callback(data)
	end)
end
function getThecarsFromIds(ids,callback)
	getDbDataFromArray('vehicles','id',ids,function(data)
		callback(data)
	end)
end

function buildThecarFromId(id)
	if not id then return end
	getThecarFromId(id,function(data)
		thecar:build(data)
	end)
end
addEvent("getAcoountAvtos",true)
addEventHandler("getAcoountAvtos",root,function()
    local requstedPlayer = source
    getAccountColumn(getPlayerNickName(requstedPlayer),'vehicles',function(data)
    	local accVehicles = fromJSON(data.vehicles)

		if #accVehicles < 0 then
			triggerClientEvent(requstedPlayer,"getAcoountAvtos",root)
		else
			getThecarsFromIds(accVehicles,function(avty)
				findBuildetThecars(avty)
				triggerClientEvent(requstedPlayer,"getAcoountAvtos",root,avty)
			end)
		end
    end)
end)





addEvent("removeThecar",true)
addEventHandler("removeThecar",root,function(id)
	local car = buildetThecars[id]
	if not car then return end

	car:remove()
end)

addEvent("buildThecar",true)
addEventHandler("buildThecar",root,function(id,pos)
	local car = buildThecarFromId(id)
	if not car then return end

	car:spawn()
end)

