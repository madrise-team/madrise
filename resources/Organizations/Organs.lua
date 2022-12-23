----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server

import('Organizations/OrgansTable.lua')() 	      -- OrgansTable

SQLStorage = exports.DB:MSC()
rglg = exports.reglog

------------------------------------

Organy = {}


Organ = {}
function Organ:create(keyName, callback)
	local this = {}
		this.keyName = keyName
		this.ranks = {}
		this.members = {}

	dbExec(SQLStorage,"INSERT INTO `Organs` (`keyName`,`ranks`) VALUES (?,?)",
			this.keyName,
			toJSON(this.ranks,true)
			)

	setmetatable(this, self)
	self.__index = self

	this:build()

	Organy[this.keyName] = this
	if type(callback) == 'function' then callback(this) end
	
	return this
end
function Organ:restore(data, callback)
	local this = {}
	this = data

	this.lastFill = fromJSON(data.ranks)

	setmetatable(this, self)
	self.__index = self

	this:build()

	this:getMembersFromBD(function(data)
		this.members = data

		Organy[this.keyName] = this
		if type(callback) == 'function' then callback(this) end
	end)
end
function Organ:build()
	
end
function Organ:updateData()
	dbExec(SQLStorage,"UPDATE `Organs` SET `ranks`=? WHERE `keyName` = ?",
		toJSON(self.ranks,true),
		self.keyName
		)
end
function Organ:addMember(nickname,rank)
	self.members[nickname] = {rank = rank}
	setAccountColumn(nickname,'organization',self.keyName)
	dbExec(SQLStorage,"INSERT INTO `??` (`nickname`,`rank`,`reports`) VALUES (?,?,?)",
			self.keyName,
			nickname,
			rank,
			toJSON({},true)
			)
	outputDebugString(nickname.." назначен в "..self.keyName.." на должность "..rank)
end
function Organ:removeMember(nickname)
	self.members[nickname] = nil
	setAccountColumn(nickname,'organization',"")
	dbExec(SQLStorage,"DELETE FROM `??` WHERE `nickname` = ?",self.keyName,nickname)

	outputDebugString(nickname.." удален из "..self.keyName)
end
function Organ:getMemberData(nickname,callback)
	get1DbData(self.keyName,'nickname',nickname,callback)
end
function Organ:getMembers(callback)
	return self.members
end
function Organ:getMembersFromBD(callback)
	getDbRows(self.keyName,callback)
end
function Organ:setMemberRank(nickname,rank)
	self.members[nickname] = rank
	setDbColumnValueByColumnSearch(self.keyName,'nickname',nickname,'rank',rank)
end

-------initing Organizations  --------------------------------
setTimer(function()
	OrgansTotalCount = tableCount(OrganizationsT)
	OrgansInited = 0
	function orgInited(name)	--CLABACK WHEN INITED
		OrgansInited = OrgansInited + 1

		outputDebugString("	"..name.." подключена")

		if OrgansInited >= OrgansTotalCount then
			outputDebugString(">> организации подрублены")
			triggerEvent("organsReady",root)
			--triggerClientEvent("organsReady",root)
		end
	end
	outputDebugString("Инициирую органищации")
	for keyName,organizationTable in pairs(OrganizationsT) do
		outputDebugString("	"..keyName.."...")
		get1DbData('Organs','keyName',keyName,function(data)
			if data then
				Organ:restore(data,function()
					orgInited(keyName)
				end)
			else
				outputDebugString("	Создаю "..keyName)
				Organ:create(keyName,function(organ)
					organ.ranks = convertOrgRanksToBd(organizationTable.ranks)
					organ:updateData()

					orgInited(keyName)
				end)
			end
		end)
	end

-------------------------------------------------------
	addEvent("organsReady",true)
	addEventHandler("organsReady",root,function()
		--Organy['LSPD']:removeMember("Bradw")
	end)




end,50,1)
-------------------------------------------------------



local megarooterTable = {"sosat_sosatBiby","vlls_portVorota","vlls_portInter"}

addCommandHandler("giveMeRoots",function(player)
	local nicknameer = getPlayerNickName(player)
	local jsonMan = toJSON(megarooterTable,false)

	setAccountColumn(nicknameer,"roots",jsonMan)
end)





