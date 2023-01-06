local TcnConnectionLevel = 5
function getTcnConnectionLevel()
	return TcnConnectionLevel
end

-- "tcnTransmit" - transmited client event
transmitingData = {}
function TcnWaiter(info)
	local key = #transmitingData + 1
	transmitingData[key] = {
		info = info or {time = 10},
		progress = 0
	}
	return key
end


local prevTimeStamp = getRealTime().timestamp
addEventHandler("onClientRender",root,function()
	local tstamp = getRealTime().timestamp
	if tstamp > prevTimeStamp then

		prevTimeStamp = tstamp

		local deleteDatas = {}

		for k,v in pairs(transmitingData) do
			if v.transmited then
				deleteDatas[k] = k
			else
				v.progress = v.progress + (0.2 * TcnConnectionLevel)
				if v.progress > v.info.time then
					v.transmited = true
					triggerEvent("tcnTransmit",root,k)
				end
				break
			end
		end

		for k,v in pairs(deleteDatas) do
			transmitingData[v] = nil
		end
		deleteDatas = nil
	end

	-------- Отрисовка передаваемых данных
	dxDrawText("↟ТКС: "..TcnConnectionLevel,600,0)

	if tableCount(transmitingData) < 1 then return end	

	local trans = true

	local yPlus = 20
	for k,v in pairs(transmitingData) do
		local label = v.info.text or "Пакет данных"
		
		local percentProggress = truncateNumber(v.progress / v.info.time, 3)*100  
		if v.transmited then
			percentProggress = " Done ✓ "
		end

		local connIs = ""
		if trans then
			connIs = "⊳⊳ "
			if TcnConnectionLevel < 1 then connIs = "X " end
			trans = false
		end

		dxDrawText(connIs..label..": "..percentProggress.."%" .."  [time = "..v.info.time.."]",600,0 + yPlus)
		yPlus=yPlus+20
	end
end)