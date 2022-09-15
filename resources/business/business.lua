loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server

import('business/business_map.lua')() 	   -- businesses table

SQLStorage = exports.DB:MSC()
rglg = exports.reglog
------------------------------------

buzy = {}
bizyPickUpsParent = createObject(2881,0,0,-2000)
setElementData(root,"bizyPickUpsParent",bizyPickUpsParent)

business = {}
function business:create(key)
	local this = {}

		this.owner = "none"
		this.key = key
		this.incomeK = 1
		this.money = 0

		local relTime = getRealTime()
		this.lastFill = {year = relTime.year,yearday = relTime.yearday}

	dbExec(SQLStorage,"INSERT INTO `buzy` (`key`,`owner`,`lastFill`) VALUES (?,?,?)",
			this.key,
			this.owner,
			toJSON(this.lastFill,true)
			)

	setmetatable(this, self)
	self.__index = self

	this:build()

	buzy[this.key] = this
	return this
end
function business:restore(data, callback)
	local this = {}
	this = data

	this.lastFill = fromJSON(data.lastFill)

	setmetatable(this, self)
	self.__index = self

	this:build()

	buzy[this.key] = this
	if type(callback) == 'function' then callback(this) end
end
function business:build()
	self.pickUp = businesses[self.key].pick
	setElementParent(self.pickUp,bizyPickUpsParent)
	setElementData(self.pickUp,"buzData",{owner = self.owner,key = self.key})

	self:doIncome()
end
function business:doIncome()
	local relTime = getRealTime()
	if (relTime.yearday > self.lastFill.yearday) or (relTime.year > self.lastFill.year) then
		self.lastFill = {year = relTime.year,yearday = relTime.yearday}

		self.money = self.money + (businesses[self.key].income*self.incomeK)
		self.incomeK = 1

		self:updateData()
	end
end
function business:increaseIncomeK()
	if self.incomeK == 1 then
		self.incomeK = 1.5
	elseif self.incomeK == 1.5 then
		self.incomeK = 2.5
	elseif self.incomeK == 2.5 then	
		self.incomeK = 4
	elseif self.incomeK == 4 then
		return
	end

	self:updateData()
end
function business:updateData()
	dbExec(SQLStorage,"UPDATE `buzy` SET `owner`=?,`incomeK`=?,`money`=?,`lastFill`=? WHERE `key` = ?",
		self.owner,
		self.incomeK,
		self.money,
		toJSON(self.lastFill,true),
		self.key
		)
end
function business:takeMoney()
	giveAccountMoney(self.owner,self.money)

	self.money = 0
	self:updateData()
end
function business:setOwner(owner)
	if self.owner ~= "none" then removeFromAccountBizLink(self.owner,self.key) end
	self.owner = owner
	self:updateData()
	if self.owner ~= "none" then addToAccountBizLink(self.owner,self.key) end

	self:build()
	triggerEvent("buzyUpdate",root)
	triggerClientEvent("buzyUpdate",root)
end



-------initing Buznesy --------------------------------
buzyTotalCount = tableCount(businesses)
bizesInited = 0
function buzInited()
	bizesInited = bizesInited + 1

	if bizesInited >= buzyTotalCount then
		triggerEvent("buzyReady",root)
		--triggerClientEvent("buzyReady",root)
	end
end

for key,buzTable in pairs(businesses) do
	get1DbData('buzy','key',key,function(data)
		if data then
			business:restore(data,function()
				buzInited()
			end)
		else
			business:create(key)
			buzInited()
		end
	end)
end
addEvent("buzyReady",true)
addEventHandler("buzyReady",root,function()
	for k,v in pairs(buzy) do
		addEventHandler("onPickupHit",v.pickUp,function(player)
			triggerClientEvent(player,"bizInterface",root,v,businesses[v.key],v.pickUp)
		end)
	end
end)
-------------------------------------------------------
addEvent("buyBiz",true)
addEventHandler("buyBiz",root,function(key)
	local nickname = getPlayerNickName(source)
	takeAccountMoney(nickname,businesses[key].cost)
	buzy[key]:setOwner(nickname)
	outputChatBox(nickname.." СЛОВИЛ БИЗ "..key)
end)
-------------------------------------------------------