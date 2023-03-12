contactsLoaded = false
friends = {}
knowPeople = {}

comm_recRequests = {}


addEvent("communications_data",true)
addEventHandler("communications_data",root,function(cData)
	local localNick = getPlayerNickName(localPlayer)
	outputChatBox(" >> Client recived contacts data")
	do return end

	for k,v in pairs(cData) do
		local tabler = knowPeople
		if v.type == 2 then
			tabler = friends
		end

		local contactNick = v.ac1_Nick
		local contactId = v.ac1_Id
		if contactNick == localNick then
			contactNick = v.ac2_Nick
			contactId = v.ac2_Id
		end

		tabler[contactNick] = contactId
	end

	contactsLoaded = true
	outputDebugString("accounts_contacts подгружена")
end)

addEvent("contactUpdate",true)
addEventHandler("contactUpdate",root,function(contactNick, contactType)
	friends[contactNick] = nil
	knowPeople[contactNick] = nil

	local tabler
	if contactType == 0 then 
		return 
	elseif contactType == 1 then
		tabler = knowPeople
	elseif contactType == 2 then
		tabler = friends
	end
	
	if not tabler then 
		outputDebugString("ERR>> contactType: "..tostring(contactNick).." in "..tostring(contactNick))
		return 
	end

	tabler[contactNick] = true
end)

--/////////////////////////////////////////////////
--    deb show contacts
--// 

local loadSmbs = {"|","/","---",[[\]], frame = 0}
addEventHandler("onClientRender",root,function()
	if not contactsLoaded then
		loadSmbs.frame = loadSmbs.frame + 0.1
		local smb = math.ceil(loadSmbs.frame % 4)
		dxDrawText("Гружу контакты  "..loadSmbs[smb],250,0)
		return
	end

	local yOff = 0
	for k,v in pairs(friends) do
		dxDrawText("Друг "..k,250,yOff)
		yOff = yOff +15
	end
	for k,v in pairs(knowPeople) do
		dxDrawText("Контакт "..k,250,yOff)
		yOff = yOff +15
	end


end)


--/////////////////////////////////////////////////
--    debFace fucs
--//

function isPointInQuad(x,y,qx,qy,qw,qh)
	if x > qx and x < qx + qw and y > qy and y < qy + qh then return true end
end
function renderButton(pushButton,text,x,y,w,h, fuc, fucArg1,fucArg2,fucArg3)
	local butCol = tocolor(100,100,100,255)

	cx, cy = getCursorPosition()
	if cx then 
		cx = cx * screenW
		cy = cy * screenH

	    if isPointInQuad(cx,cy, x,y,w,h) then
	    	butCol = tocolor(200,180,75,255)
	    	if pushButton then
	    		fuc(fucArg1,fucArg2,fucArg3)
	    		swapInteraction()
	    	end
	    end
	end
	dxDrawRectangle(x,y,w,h,butCol)
	dxDrawText(text, x,y, x+w,y+h, tocolor(255,255,255,255), 1, 1, "default","center","center")

end


--/////////////////////////////////////////////////
--    Запросы
--//
local mouse1Up = false


function addContactAnswer(player1, contactTypeOrCancel)
 	triggerLatentServerEvent("addContactAnswer", 2000, false,  localPlayer, player1, contactTypeOrCancel)
end

addEvent("addContactRequest",true)
addEventHandler("addContactRequest",root,function(contactType)
	local pl1 = source
	local contactType = contactType

	local frame = 0

	local nick = getPlayerNickName(pl1)
	local text = nick .. " запрашивает ваш конакт"
	if contactType == 2 then
		text = nick .. " хочет стать вашим корешом"
	end

	local removeFrame
	frameFuc = function()
		frame = frame + 1

		dxDrawRectangle(300, 200, 300,120, tocolor(40,40,45,200))
		dxDrawText(text, 300 ,200, 600, 270, tocolor(255,255,255,255), 1.4, 1.4, "default","center","center")

		renderButton(mouse1Up,"Принять", 315,275, 120,35, function()
			addContactAnswer(pl1, contactType)
			removeRequest()
			triggerEvent('contactUpdate',root,pl1,contactType)
		end)
		renderButton(mouse1Up,"Отклонить", 465,275, 120,35, function()
			addContactAnswer(pl1, false)
			removeRequest()
		end)

		if frame > 10000 then
			removeRequest()
		end
		mouse1Up = false
	end
	removeRequest = function()
		comm_recRequests[nick] = false
		removeEventHandler("onClientRender",root,frameFuc)
	end
	addEventHandler("onClientRender",root,frameFuc)
	comm_recRequests[nick] = true
end)


addEvent("addContactAnswer",true)
addEventHandler("addContactAnswer",root,function(player2, status)
	local pl2Nick = getPlayerNickName(player2)
	if status then
		outputChatBox(" #22FFAA>> "..pl2Nick.." принял ваш запрос", 255,255,255,true)
	else
		outputChatBox(" #EE2233>> "..pl2Nick.." отклонил ваш запрос!", 255,255,255,true)
	end
end)



bindKey("mouse1","up",function()
	mouse1Up = true
end)



local frame = 0
