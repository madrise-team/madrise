----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server

usfulAcc()

rlg = exports.reglog
rlsc = exports.RRL_Scripts
------------------------------------
------------------------------------

Groups = {}

Group = {}

function createGroup()
	local group = {}
		group.members = {}
		group.membersData = {}
		group.tags = {}
		group.tasks = {}

	group.serial = #Groups + 1

	Groups[group.serial] = group

	return group.serial,group
end
function forGroupS(groupS,func)
	if Groups[groupS] then
		return func(Groups[groupS])
	end
end
function forAllMembers(membersData,func)
	for k,v in pairs(membersData) do
		func(v.player)
	end
end
function groupChanged(group)
	local grpArgs = {
		serial = group.serial,
		leader = group.leader,
		deleted = (#group.members < 1),
		members = group.members
	}
	triggerEvent("groupChanged"..group.serial,root,grpArgs)

	forAllMembers(group.membersData,function(player)
		triggerLatentClientEvent(player,"groupChanged"..group.serial,10000,false,root,grpArgs)
	end)
end

function groupPlayersParentSet(group,parent)
	for k,v in pairs(group.membersData) do
		if v.player ~= parent then setElementParent(v.player,parent) end
	end
end

function groupSetLeader(groupS,nickname)
	return forGroupS(groupS,function(group)
		if groupIsMember(groupS,nickname) then
			group.leader = nickname
			outputDebugString("new dear leader: "..group.leader..'!')
			groupPlayersParentSet(group,group.membersData[group.leader].player)
			groupChanged(group)
		end
	end)
end
function groupGetLeader(groupS)
	return forGroupS(groupS,function(group)  return group.leader  end)
end
function groupGetLeaderPlayer(groupS)
	return forGroupS(groupS,function(group)  return group.membersData[group.leader].player  end)
end

function groupGetMemberIndex(groupS,nickname)
	return forGroupS(groupS,function(group)
		for k,v in pairs(group.members) do
			if v == nickname then  return k  end
		end
	end)
end
function groupAddMember(groupS,nickname)
	local player = getPlayerByNickName(nickname)
	if not player then
		outputDebugString("Попытка добавить в группу несуществующего игрока [ "..nickname.." ] !")
		return false
	end

	--if getPlayerGroupData(player) then 
	--	return "Игрок уже состоит в группе"
	--end

	return forGroupS(groupS,function(group)
		if not groupIsMember(groupS,nickname) then
			group.members[#group.members + 1] = nickname

			triggerLatentClientEvent(player,"groupEnter",5000,false,root,group.serial)
			group.membersData[nickname] = {player = player}
			group.membersData[nickname].leaveHandler = function()
				groupRemoveMember(groupS,nickname)
			end
			addEventHandler("onPlayerQuit",player,group.membersData[nickname].leaveHandler)

			setPlayerGroupData(player,group.serial)

			groupChanged(group)
			return true
		else
			outputDebugString("Игрок уже состоит в данной группе [ "..nickname.." ] !")
			return false
		end
	end)
end
function groupRemoveMember(groupS,nickname)
	return forGroupS(groupS,function(group)
		local indx = groupGetMemberIndex(groupS,nickname)
		if indx then 
			table.remove(group.members,indx)
			local memberData = group.membersData[nickname]

			setPlayerGroupData(memberData.player,nil)

			triggerLatentClientEvent(memberData.player,"groupLeave",5000,false,root,group.serial)
			removeEventHandler("onPlayerQuit",memberData.player, memberData.leaveHandler)

			triggerLatentClientEvent(memberData.player,"taskState",5000,false,root,{ tasks = group.tasks, delete = true })

			group.membersData[nickname] = nil

			if #group.members < 1 then
				groupDestroy(group.serial)
				return true
			end

			if (nickname == group.leader) then
				groupSetLeader(groupS,group.members[1])
			else
				groupChanged(group)
			end

			return true
		else
			return false
		end
	end)
end
function groupGetMembers(groupS)
	return forGroupS(groupS,function(group)
		return group.members
	end)
end
function groupIsMember(groupS,nickname)
	return forGroupS(groupS,function(group)
		return (group.membersData[nickname] ~= nil)
	end)
end
function groupDestroy(groupS)
	forGroupS(groupS,function(group)

		if(#group.members > 0) then
			for k,v in pairs(group.members) do
				groupRemoveMember(groupS,v)
			end
			return
		end

		group.leader = nil
		group.members = {}
		groupChanged(group)
		Groups[group.serial] = nil
	end)
end
function groupAddTag(groupS,tag)
	forGroupS(groupS,function(group)  group.tags[tag] = true  end)
end
function groupRemoveTag(groupS,tag)
	forGroupS(groupS,function(group)  group.tags[tag] = nil  end)
end
function groupGetTags(groupS,serial)
	return forGroupS(groupS,function(group)  return group.tags end)
end
function groupAddTask(groupS,taskSerial)
	forGroupS(groupS,function(group) 
		group.tasks[taskSerial] = true
	end)
end
function groupRemoveTask(groupS,taskSerial)
	forGroupS(groupS,function(group) group.tasks[taskSerial] = nil end)
end
function groupGetTasks(groupS)
	return forGroupS(groupS,function(group) return group.tasks end)
end
function groupGetPlayers(groupS)
	return forGroupS(groupS,function (group)
		local players = {}
		for k,v in pairs(group.membersData) do
			players[k] = v.player
		end
		return players
	end)
end

function createGroupFromNickname(nickname)
	local grupS,grupObject = createGroup()
	groupAddMember(grupS,nickname); groupSetLeader(grupS,nickname)
	return grupS,grupObject
end
function createGroupFromPlayer(player)
	return createGroupFromNickname(getPlayerNickName(player))
end

addCommandHandler("createGroup",function(player)
	 createGroupFromPlayer(player)
end)

addCommandHandler("addToGroup",function(player,_,nickname)
	local groupS = getPlayerGroupData(player)
	groupAddMember(groupS,nickname)
end)

addCommandHandler("removeFromGroup",function(player,_,nickname)
	local groupS = getPlayerGroupData(player)
	groupRemoveMember(groupS,nickname)
end)