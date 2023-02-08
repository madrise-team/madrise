localPlayer = getLocalPlayer()
setDevelopmentMode(true)



-----------------avto-------------------

setWorldSoundEnabled(40, false, true)
setWorldSoundEnabled(7 , false, true)
setWorldSoundEnabled(8 , false, true)
setWorldSoundEnabled(9 , false, true)
setWorldSoundEnabled(10, false, true)
setWorldSoundEnabled(11, false, true)
setWorldSoundEnabled(12, false, true)
setWorldSoundEnabled(13, false, true)
setWorldSoundEnabled(14, false, true)
setWorldSoundEnabled(15, false, true)
setWorldSoundEnabled(16, false, true)
setWorldSoundEnabled(19,19, false, true)
setWorldSoundEnabled(19,20, false, true)
setWorldSoundEnabled(19,37, false, true)

-----------------avto-------------------
--setTimer(function()
--	-- body
--end, 1000, 1)

pokoy = false

gaz = false
sspeed = 1

function avtoVPokoe()
	if pokoy and sound_pokoya then return end
	--pokoy = not pokoy
	if getVehicleEngineState(getPedOccupiedVehicle(localPlayer)) then 
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		sound_pokoya = playSound3D("sound_002.mp3", x, y, z, true)
		setSoundVolume(sound_pokoya, 40)
		--setSoundPan(sound_pokoya, 0.1)
		setSoundSpeed(sound_pokoya, sspeed)
		attachElements(sound_pokoya, getPedOccupiedVehicle(localPlayer))
	end
end

function stopAvtoVPokoe()
	if gaz then return end
	gaz = not gaz
	if sound_pokoya then
		stopSound(sound_pokoya)
	end 
end

function gazAvto()
	if gaz then return end
	if getVehicleEngineState(getPedOccupiedVehicle(localPlayer)) then 
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		sound_gaz = playSound3D("sound_001.wav", x, y, z, true)
		setSoundVolume(sound_gaz, 5)
		attachElements(sound_gaz, getPedOccupiedVehicle(localPlayer))
	end
end

addEventHandler("onClientRender", root, function()

	local vehicle = getPedOccupiedVehicle(localPlayer) 
	if not vehicle or getVehicleOccupant(vehicle) ~= localPlayer then return end

	if getKeyState("w") == true then
		if sspeed <= 1 then sspeed = sspeed + 0.08 end
		if sspeed >= 1 then sspeed = sspeed + 0.02 end
		--pokoy = false
		--gaz = true 
		--stopAvtoVPokoe()
		--gazAvto()
		--sound_pokoya = playSound3D("sound_002.wav", x, y, z, true)
		setSoundSpeed(sound_pokoya, sspeed)

		local x, y, z = getElementPosition(vehicle)
		z = z - 0.05
		if sspeed >= 5 then setElementPosition(vehicle, x, y, z) end

		if sspeed >= 100 then sspeed = 1 end
	else
		pokoy = true
		gaz = false
		avtoVPokoe()
		if sspeed ~= 0.5 and sspeed >= 0.5 then sspeed = sspeed - 0.05 end
		--sspeed = sspeed - 0.5


		setSoundSpeed(sound_pokoya, sspeed)
	end
end)