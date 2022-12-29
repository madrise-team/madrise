----- imports
loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()    -- drawsCore
------------------------------------
addEvent("groupEnter",true)
addEvent("groupLeave",true)
------------------------------------

myGroup = nil
myGroupHandler = nil
addEventHandler("groupEnter",root,function(groupS)
	addEvent("groupChanged"..groupS,true)
	addEventHandler("groupChanged"..groupS,root,gruopChangedhandler)
end)

addEventHandler("groupLeave",root,function(groupS)
	removeEventHandler("groupChanged"..groupS,root,gruopChangedhandler)
	myGroup = nil
end)

function gruopChangedhandler(args)
	myGroup = args
end


function drawer(leaderOrOther)
	for k,v in pairs(myGroup.members) do
		local isLeader = v == myGroup.leader

		if isLeader == leaderOrOther then
			local leaderIco = ""
			if isLeader then leaderIco = "✫ " end
			dxDrawText (leaderIco..v, screenW - 500,yPos, screenW-15, 1000, tocolor(255,255,255,255), 1.2,1.2,"bold","right","top")	
			yPos = yPos + 20	
		end
	end
end


addEventHandler("onClientRender",root,function()
	yPos = screenH/4
	if myGroup then

		dxDrawText ("Группа: serial#"..myGroup.serial, screenW - 500,yPos, screenW-15, 1000, tocolor(255,255,255,255), 1.2,1.2,"bold","right","top")
		--yPos = yPos + 25
		--dxDrawText ("Задачи: ", screenW - 500,yPos, screenW-15, 1000, tocolor(255,255,255,255), 1.2,1.2,"bold","right","top")
		yPos = yPos + 25
		drawer(true)
		drawer(false)

	end

end)