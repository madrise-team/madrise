----- imports
loadstring(exports.importer:load())()
import('Draws/drawsCore.lua')()    -- Draws

rlsc = exports.RRL_Scripts
------------------------------------
------------------------------------

taskBlips = {}

myTasks = {}
myTasksSorted = {}

function resortTasks()
	myTasksSorted = {}
	for k,v in pairs(myTasks) do
		table.insert(myTasksSorted,v)
	end
	table.sort(myTasksSorted, function(task1,task2)
		if task1.serial < task2.serial then return true end
	end)
end

addEvent('taskState',true)
addEventHandler('taskState',root,function(taskInfo)
	if taskInfo.delete then
		for k,v in pairs(taskInfo.tasks) do
			myTasks[k] = nil	
		end
	else
		hadleTaskInfo(taskInfo)
		myTasks[taskInfo.serial] = taskInfo
	end
	resortTasks()
end)
function hadleTaskInfo(taskInfo)

	local resDeb = " result : { "
	if taskInfo.result == nil then resDeb = "" 
	else
		resDeb = resDeb.."succses = "..tostring(taskInfo.result.succses).." "
		resDeb = resDeb.."blip = "..tostring(taskInfo.blip).." }"
	end

	--outputChatBox("task "..taskInfo.serial..": " .. taskInfo.description .. resDeb )

	if taskInfo.result then
		
		taskInfo.removeTimer = setTimer(function()
			myTasks[taskInfo.serial] = nil
			resortTasks()
		end,8000,1)
	end
end

addEventHandler("onClientRender",root,function()
	local yPos = screenH/3
	dxDrawText ("Мои задачи", screenW - 120,yPos, 1000, 1000, tocolor(255,255,255,255), 1.5)
	yPos = yPos + 40

	local taskGroups = {}
	for k,v in pairs(myTasksSorted) do
		taskGroups[v.tasksGroup] = taskGroups[v.tasksGroup] or {}
		table.insert(taskGroups[v.tasksGroup], v) 
	end

	for k,tasks in pairs(taskGroups) do
		dxDrawText (k..":", screenW - 500,yPos, screenW-15, 1000, tocolor(255,255,255,255), 1.2,1.2,"bold","right","top")
		yPos = yPos + 25
		
		for _,v in pairs(tasks) do
			local reasonAdded = false
			local col = tocolor(255,255,255,255)
			local resonCOL = tocolor(100,10,25,150)
			if v.result then
				if v.result.succses then col = tocolor(100,255,150,255); resonCOL =  tocolor(10,100,25,150)
				else col = tocolor(255,100,150,255) end
				if v.result.reason then reasonAdded = true end
				
			end

			local dopInf = " "
			if v.timer then
				local tm = getTimeToEnd(v.timer)
				local hours = tm.hours .. " : "
				if tm.hours == 0 then hours = "" end

				local case = "[ ".. hours  .. tm.mins .. " : " .. tm.secs  .." ] "
				dopInf = dopInf..case 
			end
			dxDrawText (v.description .. dopInf .. " •", screenW - 500,yPos, screenW-15, 1000, col, 1,1,"default","right","top")	

			if reasonAdded then
				yPos = yPos + 15
				dxDrawRectangle(screenW-420,yPos,405,14,resonCOL)
				dxDrawText (v.result.reason, screenW - 500,yPos, screenW-15, 1000, col, 1,1,"default","right","top")	
			end
			yPos = yPos + 20
		end	
		yPos = yPos + 5
	end

end)