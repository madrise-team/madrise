----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared

rlg = exports.reglog
rlsc = exports.RRL_Scripts
------------------------------------
------------------------------------

Groups = {}

Group = {}
function Group:create()
	local this = {}
		this.members = {}
		this.tags = {}
		this.tasks = {}

	this.serial = #Groups + 1

	Groups[this.serial] = this

	setmetatable(this, self)
	self.__index = self

	return this.serial,this
end

function setLeader(nickname)
	self.leader = nickname
	if not self:isMember(nickname) then
		self:addMember(nickname)
	end
end

function Group:getMemberIndex(nickname)
	for k,v in pairs(self.members) do
		if v == nickname then return k end
	end
end
function Group:addMember(nickname)
	if not self:isMember(nickname) then
		self.members[#self.members + 1] = nickname
	end
end
function Group:removeMember(nickname)
	local indx = self:getMemberIndex(nickname)
	if indx then table.remove(self.members,indx) end 
end
function Group:isMember(nickname)
	local indx = self:getMemberIndex(nickname)
	if indx then return true end
end
function Group:Destroy()
	Groups[self.serial] = nil
	this = nil
	triggerEvent("groupDestroyed",root,serial)
end

function createGroup()
	return Group:create()
end
function getGroups()
	return Groups
end
function getGroup(serial)
	return Groups[serial]
end
function destroyGroup(serial)
	if Groups[serial] then return Groups[serial]:Destroy() end
end
function groupAddMember(serial,nickname)
	if Groups[serial] then return Groups[serial]:addMember(nickname) end
end
function groupRemoveMember(serial,nickname)
	if Groups[serial] then return Groups[serial]:removeMember(nickname) end
end
function groupIsMember(serial,nickname)
	if Groups[serial] then return Groups[serial]:isMember(nickname) end
end
function groupSetLeader(serial,nickname)
	if Groups[serial] then return Groups[serial]:setLeader(nickname) end
end

function groupAddTag(serial,tag)
	if Groups[serial] then Groups[serial].tags[tag] = true end
end
function groupRemoveTag(serial,tag)
	if Groups[serial] then Groups[serial].tags[tag] = nil end
end
function groupGetTags(serial)
	if Groups[serial] then return Groups[serial].tags end
end
function groupAddTask(serial,taskSerial)
	if Groups[serial] then Groups[serial].tasks[taskSerial] = true end
end
function groupRemoveTask(serial,taskSerial)
	if Groups[serial] then Groups[serial].tasks[taskSerial] = nil end
end
function groupGetTasks(serial)
	if Groups[serial] then return Groups[serial].tasks end
end


function createGroupFromNickname(nickname)
	local grupSer,grupObject = rlg:createGroup()
	rlg:groupAddMember(grupSer,nickname)
	return grupSer,grupObject
end
function createGroupFromPlayer(player)
	return createGroupFromNickname(getPlayerNickName(player))
end