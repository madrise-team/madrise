loadstring(exports.importer:load())()
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
------------------------------------


function updateBuzyPickUps()
	bizyPickUpsParent = getElementData(root,"bizyPickUpsParent")

	myNickName = getPlayerNickName(localPlayer)
	buzyPickUpy = getElementChildren(bizyPickUpsParent,"pickup")
	for k,pickuP in pairs(buzyPickUpy) do
		setElementDimension(pickuP,2)
		setElementInterior(pickuP,2)
		local buzData = getElementData(pickuP,"buzData")
		if (buzData.owner == myNickName) or (buzData.owner == 'none') then
			setElementDimension(pickuP,0)
			setElementInterior(pickuP,0)
		end
	end
end

addEvent("playerLogin",true)
addEventHandler('playerLogin',root,function()
	outputChatBox("updating")
	updateBuzyPickUps()
end)
bindKey("m",'down',function()
	updateBuzyPickUps()
end)
addEvent("buzyUpdate",true)
addEventHandler("buzyUpdate",root,function()
	updateBuzyPickUps()
end)




function buzHuebiz(buz,buzTab)
    buzWin = guiCreateWindow(0.35, 0.3, 0.3, 0.4, "Активъ под ключъ", true)

    local vladik = buz.owner
    local buying = false
    if vladik == "none" then
    	buying = true
    	vladik = "на хуе вертелец"
    end
    local buzOwner = guiCreateLabel(0.08, 0.1, 0.8, 0.2, "Владелец: "..vladik, true, buzWin)
    local buzKey = guiCreateLabel(0.08, 0.15, 0.8, 0.2, "Кодовое имя: "..buz.key, true, buzWin)
    
    if buying then
    	local costyaVronin = guiCreateLabel(0.08, 0.2, 0.8, 0.2, "Стоимость: "..buzTab.cost, true, buzWin)
    	local dodhodyNeKrutatsa = guiCreateLabel(0.08, 0.25, 0.8, 0.2, "Пассивный доход: "..buzTab.income, true, buzWin)
    	local dodhodyKrutatsaLavehaMudakTy = guiCreateLabel(0.08, 0.3, 0.8, 0.2, "Дисконтированный маржинальный доход: "..buzTab.income*4, true, buzWin)

    	local houseButBuy = guiCreateButton(0.53, 0.6, 0.45, 0.15, "Купить", true, buzWin)
    	addEventHandler("onClientGUIClick",houseButBuy,function()
	    	triggerServerEvent("buyBiz",localPlayer,buz.key)

	    	destroyElement(buzWin)
	    	sukaWin = guiCreateWindow(0.45, 0.3, 0.1, 0.2, "Грязь", true)
			guiCreateLabel(0.08, 0.05, 0.2, 0.2, "Активъ сдан!", true, buzWin)
	    	setTimer(function()
	    		destroyElement(sukaWin)
	    	end,2500,1)
	    end)
    else
    	local prihodJdun = guiCreateLabel(0.08, 0.2, 0.8, 0.2, "Ожидаемый Приход: "..buzTab.income * buz.incomeK, true, buzWin)
    	local silaPrihoda = guiCreateLabel(0.08, 0.25, 0.8, 0.2, "Текущий коэффициент эффективности актива: "..buz.incomeK, true, buzWin)
    	local naSchetyTyUmena = guiCreateLabel(0.08, 0.35, 0.8, 0.2, "Денег на счету: "..buz.money, true, buzWin)
    end

    

    local zakroy = guiCreateButton(0.04, 0.6, 0.45, 0.15, "Закрыть", true, buzWin)
    addEventHandler("onClientGUIClick",zakroy,function()
    	destroyElement(buzWin)
    end)
    --local houseButEnter = guiCreateButton(0.04, 0.8, 0.45, 0.15, "Войти", true, buzWin)

    --local houseButSell = guiCreateButton(0.53, 0.8, 0.45, 0.15, "Продать", true, buzWin)
end

addEvent("bizInterface",true)
addEventHandler("bizInterface",root,function(buz,buzTab,pick)
	if getElementDimension(pick) ~= getElementDimension(localPlayer) then return end
	buzHuebiz(buz,buzTab)
end)