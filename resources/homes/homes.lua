loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server

import('homes/homes_map.lua')() 	   -- homes table

SQLStorage = exports.DB:MSC()
rglg = exports.reglog
------------------------------------
homes = {}

home = {}
function home:create(key,interior,outcome)
	local this = {}

		this.key = key
		this.owner = "none"
		this.money = 0
		this.outcome = outcome
		this.interior = interior

		this.dim = tableCount(homes) + 1000

		local relTime = getRealTime()
		this.lastPay = {year = relTime.year,yearday = relTime.yearday}

	homes[this.key] = this
	dbExec(SQLStorage,"INSERT INTO `homes` (`key`,`owner`,`interior`,`outcome`,`dim`,`money`,`lastPay`) VALUES (?,?,?,?,?,?,?)",
			this.key,
			this.owner,
			this.interior,
			this.outcome,
			this.dim,
			this.money,
			toJSON(this.lastPay,true)
			)

	setmetatable(this, self)
	self.__index = self

	this:build()

	return this
end
function home:restore(data, callback)
	local this = {}
	this = data

	this.lastPay = fromJSON(data.lastPay)

	setmetatable(this, self)
	self.__index = self

	this:build()

	homes[this.key] = this
	if type(callback) == 'function' then callback(this) end
end
function home:build()
	self.houseTable = getHKeyTable(self.key)	
	
	local model = 1273
	if self.owner ~= "none" then model = 1272 end
	local x,y,z = getElementPosition(self.houseTable.pick)	
	destroyElement(self.houseTable.pick)
	self.houseTable.pick = createPickup(x,y,z, 3, model, 50)
	
	self.pickUp = self.houseTable.pick
	setElementData(self.pickUp,"homeData",{owner = self.owner,key = self.key})

	self:payTax()
end
function home:payTax()
	local relTime = getRealTime()

	--if true then return end
	if (getYeardaysDiff(self.lastPay,relTime) >= 7) and (self.owner ~= "none") then
		self.lastPay = {year = relTime.year,yearday = relTime.yearday}

		self.money = self.money - self.outcome
		if self.money < 0 then
			self.money = 0
			self:setOwner("none")
		else
			self:updateData()
		end
	end
end
function home:updateData()
	dbExec(SQLStorage,"UPDATE `homes` SET `owner`=?,`money`=?,`lastPay`=? WHERE `key` = ?",
		self.owner,
		self.money,
		toJSON(self.lastPay,true),
		self.key
		)
end
--giveAccountMoney(self.owner,self.money)
function home:setOwner(owner)
	if self.owner ~= "none" then removeFromAccountBizLink(self.owner,self.key) end
	self.owner = owner
	
	local relTime = getRealTime()
	self.lastPay = {year = relTime.year,yearday = relTime.yearday}

	self:updateData()
	if self.owner ~= "none" then addToAccountBizLink(self.owner,self.key) end

	self:build()
end

-------initing Buznesy --------------------------------
homesTotalCount = houses.count
homesInited = 0
function homeInited()
	homesInited = homesInited + 1

	if homesInited >= homesTotalCount then
		triggerEvent("homesReady",root)
		--triggerClientEvent("homesReady",root)
	end
end

for houseType,typetable in pairs(houses) do
	if type(typetable) == "table" then
		for key,homeTable in pairs(typetable) do
			if key ~= "params" then
				get1DbData('homes','key',key,function(data)
					if data then
						home:restore(data,function()
							homeInited()
						end)
					else
						home:create(key,"inter",2000)
						homeInited()
					end
				end)
			end
		end
	end
end
addEvent("homesReady",true)
addEventHandler("homesReady",root,function()
	for k,v in pairs(homes) do
		addEventHandler("onPickupHit",v.pickUp,function(player)
			triggerClientEvent(player,"homeInterface",root,v,getHKeyTable(v.key),v.pickUp)
		end)
	end
end)
--[[-----------------------------------------------------
addEvent("buyBiz",true)
addEventHandler("buyBiz",root,function(key)
	local nickname = getPlayerNickName(source)
	takeAccountMoney(nickname,businesses[key].cost)
	buzy[key]:setOwner(nickname)
	outputChatBox(nickname.." СЛОВИЛ БИЗ "..key)
end)
-------------------------------------------------------]]