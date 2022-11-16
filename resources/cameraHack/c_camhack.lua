-- state variables					 --
local speed = 0					 --
local camFov = 70					 --
local camRoll = 0					 --
local strafespeed = 0					 --
local speedUpDown = 0					 --
local rotX, rotY = 0,0					 --
local rotXSpeed, rotYSpeed = 0,0					 --
local isSlowCamHack = true					 --
					 --
-- configurable parameters					 --
local slowOptions = {					 --
	normalMaxSpeed = 0.04,					 --
	slowMaxSpeed = 0.002,					 --
	fastMaxSpeed = 1,					 --
	acceleration = 0.002,					 --
	decceleration = 0.0016,					 --
	mouseSensitivity = 0.015,					 --
	rotAcceleration = 0.0001,					 --
	rotDeacceleration = 0.0001,					 --
	rotMaxSpeed = 0.007					 --
}					 --
					 --
local fastOptions = {					 --
	normalMaxSpeed = 4,					 --
	slowMaxSpeed = 0.4,					 --
	fastMaxSpeed = 10,					 --
	acceleration = 0.3,					 --
	decceleration = 0.15,					 --
	mouseSensitivity = 0.3					 --
}					 --
					 --
local camKeys = {					 --
	key_fastMove = "lshift",					 --
	key_slowMove = "lalt",					 --
	key_forward = "forwards",					 --
	key_backward = "backwards",					 --
	key_left = "left",					 --
	key_right = "right",					 --
	key_up = "upper",					 --
	key_down = "downer",					 --
	key_forward_veh = "accelerate",					 --
	key_backward_veh = "brake_reverse",					 --
	key_left_veh = "vehicle_left",					 --
	key_right_veh = "vehicle_right",					 --
	key_up_fov = "c",					 --
	key_down_fov = "z",					 --
	key_left_roll = "q",					 --
	key_right_roll = "e",					 --
					 --
	key_cam_left = "arrow_l",					 --
	key_cam_right = "arrow_r",					 --
	key_cam_up = "arrow_u",					 --
	key_cam_down = "arrow_d",					 --
}					 --
					 --
local controlToKey = {					 --
	["forwards"] = "w",					 --
	["backwards"] = "s",					 --
	["left"] = "a",					 --
	["right"] = "d",					 --
	["upper"] = "r",					 --
	["downer"] = "f",					 --
	["accelerate"] = "w",					 --
	["brake_reverse"] = "s",					 --
	["vehicle_left"] = "a",					 --
	["vehicle_right"] = "d"					 --
}					 --
					 --
local mouseFrameDelay = 0					 --
					 --
local mta_getKeyState = getKeyState					 --
function getKeyState(key)					 --
	if not key then return end					 --
	if isMTAWindowActive() then					 --
		return false					 --
	end					 --
	if key == "lshift" or key == "lalt" or key == "arrow_u" or key == "arrow_d" or key == "arrow_l" or key == "arrow_r" or key == "z" or key == "c" or key == "q" or key == "e" then					 --
		return mta_getKeyState(key)					 --
	else 					 --
		if controlToKey[key] then					 --
			return mta_getKeyState(controlToKey[key]) or getPedControlState(key)					 --
		end					 --
	end					 --
end					 --
					 --
-- PRIVATE					 --
					 --
function camFrame()					 --
	setPedWeaponSlot(localPlayer, 0 )					 --
						 --
	-- Edit the camera angle within 0.5 degrees.					 --
	if getKeyState( camKeys.key_right_roll ) then					 --
		if camRoll - 1 < -45 then					 --
			return					 --
		else					 --
			camRoll = camRoll - 0.5					 --
		end					 --
	elseif getKeyState( camKeys.key_left_roll ) then					 --
		if camRoll + 1 > 45 then					 --
			return					 --
		else					 --
			camRoll = camRoll + 0.5					 --
		end					 --
	end					 --
						 --
	if getKeyState( camKeys.key_down_fov ) then					 --
		if camFov - 1 < 0 then					 --
			return					 --
		else					 --
			camFov = camFov - 0.5					 --
		end					 --
	elseif getKeyState( camKeys.key_up_fov ) then					 --
		if camFov + 1 > 180 then					 --
			return					 --
		else					 --
			camFov = camFov + 0.5					 --
		end					 --
	end					 --
						 --
	if isSlowCamHack then					 --
		-- Calculate what the maximum speed that the camera should be able to move at.					 --
		local mspeed = slowOptions.normalMaxSpeed					 --
		if getKeyState ( camKeys.key_fastMove ) then					 --
			mspeed = slowOptions.fastMaxSpeed					 --
		elseif getKeyState ( camKeys.key_slowMove ) then					 --
			mspeed = slowOptions.slowMaxSpeed					 --
		end					 --
							 --
		local acceleration = slowOptions.acceleration					 --
		local decceleration = slowOptions.decceleration					 --
						 --
	    -- Check to see if the forwards/backwards camKeys are pressed					 --
	    local speedKeyPressed = false					 --
	    if ( getKeyState ( camKeys.key_forward ) or getKeyState ( camKeys.key_forward_veh ) ) and not getKeyState("arrow_u") then					 --
			speed = speed + acceleration 					 --
	        speedKeyPressed = true					 --
	    end					 --
		if ( getKeyState ( camKeys.key_backward ) or getPedControlState ( camKeys.key_backward_veh ) ) and not getKeyState("arrow_d") then					 --
			speed = speed - acceleration 					 --
	        speedKeyPressed = true					 --
	    end					 --
					 --
	    -- Check to see if the strafe camKeys are pressed					 --
	    local strafeSpeedKeyPressed = false					 --
		if ( getKeyState ( camKeys.key_right ) or getKeyState ( camKeys.key_right_veh ) ) and not getKeyState("arrow_r") then					 --
	        if strafespeed > 0 then -- for instance response					 --
	            strafespeed = 0					 --
	        end					 --
	        strafespeed = strafespeed - acceleration / 2					 --
	        strafeSpeedKeyPressed = true					 --
	    end					 --
		if ( getKeyState ( camKeys.key_left ) or getKeyState ( camKeys.key_left_veh ) ) and not getKeyState("arrow_l") then					 --
	        if strafespeed < 0 then -- for instance response					 --
	            strafespeed = 0					 --
	        end					 --
	        strafespeed = strafespeed + acceleration / 2					 --
	        strafeSpeedKeyPressed = true					 --
	    end					 --
					 --
	    -- Check to see if the upper/downer camKeys are pressed					 --
	   local speedUpDownKeyPressed = false					 --
	   if ( getKeyState ( camKeys.key_up ) ) then					 --
			speedUpDown = speedUpDown + acceleration 					 --
	        speedUpDownKeyPressed = true					 --
	    end					 --
		if ( getKeyState ( camKeys.key_down ) ) then					 --
			speedUpDown = speedUpDown - acceleration 					 --
	        speedUpDownKeyPressed = true					 --
	    end					 --
					 --
					 --
	    -- If no forwards/backwards camKeys were pressed, then gradually slow down the movement towards 0					 --
	    if speedKeyPressed ~= true then					 --
			if speed > 0 then					 --
				speed = speed - decceleration					 --
			elseif speed < 0 then					 --
				speed = speed + decceleration					 --
			end					 --
	    end					 --
					 --
	    -- If no strafe camKeys were pressed, then gradually slow down the movement towards 0					 --
	    if strafeSpeedKeyPressed ~= true then					 --
			if strafespeed > 0 then					 --
				strafespeed = strafespeed - decceleration					 --
			elseif strafespeed < 0 then					 --
				strafespeed = strafespeed + decceleration					 --
			end					 --
	    end					 --
					 --
	    -- If no upDown camKeys were pressed, then gradually slow down the movement towards 0					 --
	    if speedUpDownKeyPressed ~= true then					 --
			if speedUpDown > 0 then					 --
				speedUpDown = speedUpDown - decceleration					 --
			elseif speedUpDown < 0 then					 --
				speedUpDown = speedUpDown + decceleration					 --
			end					 --
	    end					 --
					 --
	    -- Check the ranges of values - set the speed to 0 if its very close to 0 (stops jittering), and limit to the maximum speed					 --
	    if speed > -decceleration and speed < decceleration then					 --
	        speed = 0					 --
	    elseif speed > mspeed then					 --
	        speed = mspeed					 --
	    elseif speed < -mspeed then					 --
	        speed = -mspeed					 --
	    end					 --
	 					 --
	    if strafespeed > -(acceleration / 2) and strafespeed < (acceleration / 2) then					 --
	        strafespeed = 0					 --
	    elseif strafespeed > mspeed then					 --
	        strafespeed = mspeed					 --
	    elseif strafespeed < -mspeed then					 --
	        strafespeed = -mspeed					 --
	    end					 --
					 --
	    if speedUpDown > -(decceleration / 1.5) and speedUpDown < (decceleration / 1.5) then					 --
	        speedUpDown = 0					 --
	    elseif speedUpDown > mspeed then					 --
	        speedUpDown = mspeed					 --
	    elseif speedUpDown < -mspeed then					 --
	        speedUpDown = -mspeed					 --
	    end					 --
	else					 --
		-- Calculate what the maximum speed that the camera should be able to move at.					 --
		local mspeed = fastOptions.normalMaxSpeed					 --
		if getKeyState ( camKeys.key_fastMove ) then					 --
			mspeed = fastOptions.fastMaxSpeed					 --
		elseif getKeyState ( camKeys.key_slowMove ) then					 --
			mspeed = fastOptions.slowMaxSpeed					 --
		end					 --
							 --
		local acceleration = fastOptions.acceleration					 --
		local decceleration = fastOptions.decceleration					 --
						 --
	    -- Check to see if the forwards/backwards camKeys are pressed					 --
	    local speedKeyPressed = false					 --
	    if ( getKeyState ( camKeys.key_forward ) or getKeyState ( camKeys.key_forward_veh ) ) and true then					 --
			speed = speed + acceleration 					 --
	        speedKeyPressed = true					 --
	    end					 --
		if ( getKeyState ( camKeys.key_backward ) or getPedControlState ( camKeys.key_backward_veh ) ) and true then					 --
			speed = speed - acceleration 					 --
	        speedKeyPressed = true					 --
	    end					 --
					 --
	    -- Check to see if the strafe camKeys are pressed					 --
	    local strafeSpeedKeyPressed = false					 --
		if ( getKeyState ( camKeys.key_right ) or getKeyState ( camKeys.key_right_veh ) ) and true then					 --
	        if strafespeed > 0 then -- for instance response					 --
	            strafespeed = 0					 --
	        end					 --
	        strafespeed = strafespeed - acceleration / 2					 --
	        strafeSpeedKeyPressed = true					 --
	    end					 --
		if ( getKeyState ( camKeys.key_left ) or getKeyState ( camKeys.key_left_veh ) ) and true then					 --
	        if strafespeed < 0 then -- for instance response					 --
	            strafespeed = 0					 --
	        end					 --
	        strafespeed = strafespeed + acceleration / 2					 --
	        strafeSpeedKeyPressed = true					 --
	    end					 --
					 --
	    -- If no forwards/backwards camKeys were pressed, then gradually slow down the movement towards 0					 --
	    if speedKeyPressed ~= true then					 --
			if speed > 0 then					 --
				speed = speed - decceleration					 --
			elseif speed < 0 then					 --
				speed = speed + decceleration					 --
			end					 --
	    end					 --
					 --
	    -- If no strafe camKeys were pressed, then gradually slow down the movement towards 0					 --
	    if strafeSpeedKeyPressed ~= true then					 --
			if strafespeed > 0 then					 --
				strafespeed = strafespeed - decceleration					 --
			elseif strafespeed < 0 then					 --
				strafespeed = strafespeed + decceleration					 --
			end					 --
	    end					 --
					 --
	    -- Check the ranges of values - set the speed to 0 if its very close to 0 (stops jittering), and limit to the maximum speed					 --
	    if speed > -decceleration and speed < decceleration then					 --
	        speed = 0					 --
	    elseif speed > mspeed then					 --
	        speed = mspeed					 --
	    elseif speed < -mspeed then					 --
	        speed = -mspeed					 --
	    end					 --
	 					 --
	    if strafespeed > -(acceleration / 2) and strafespeed < (acceleration / 2) then					 --
	        strafespeed = 0					 --
	    elseif strafespeed > mspeed then					 --
	        strafespeed = mspeed					 --
	    elseif strafespeed < -mspeed then					 --
	        strafespeed = -mspeed					 --
	    end					 --
	end					 --
	---- VehMode calculations)					 --
    if vehMode then					 --
    	local veher = ChoosedVehs[followVehI]					 --
    	if veher then					 --
    		local vehPosX,vehPosY,vehPosZ = getElementPosition(ChoosedVehs[followVehI])					 --
    		if not vehPosX then					 --
    			ChoosedVehs[followVehI] = nil					 --
    		else					 --
	    		local _camPosX, _camPosY, _camPosZ = getCameraMatrix()					 --
					 --
	    		if vehCamRotMode == 'free' then					 --
		    		local defVehX = vehPosX - vehSavePosX					 --
		    		local defVehY = vehPosY - vehSavePosY					 --
		    		local defVehZ = vehPosZ - vehSavePosZ					 --
					 --
		    		_camPosX = _camPosX + defVehX					 --
		    		_camPosY = _camPosY + defVehY					 --
		    		_camPosZ = _camPosZ + defVehZ					 --
					 --
		    		setCameraMatrix(_camPosX,_camPosY,_camPosZ)					 --
		    	elseif vehCamRotMode == 'fixed' then					 --
		    		local vehMatrix = Matrix(Vector3(getElementPosition(ChoosedVehs[followVehI])),Vector3(getElementRotation(ChoosedVehs[followVehI])))					 --
					 --
					local posCam = vehMatrix.position + vehMatrix.forward*camPos_vehB.x + vehMatrix.right*camPos_vehB.y + vehMatrix.up * camPos_vehB.z					 --
					local posCamLook = vehMatrix.position + vehMatrix.forward*camLookPos_vehB.x + vehMatrix.right*camLookPos_vehB.y + vehMatrix.up * camLookPos_vehB.z					 --
					 --
					setCameraMatrix(posCam.x,posCam.y,posCam.z)					 --
					targetCameraAt(posCamLook.x,posCamLook.y,posCamLook.z)					 --
		    	end					 --
		    	saveVehPos()					 --
    		end					 --
    	end					 --
    end					 --
    ---- ------- -------------					 --
    camMouse()	-- com mouse now here					 --
    ---- ------- -------------					 --
					 --
					 --
    -- work out an angle in radians based on the number of pixels the cursor has moved (ever)					 --
    local cameraAngleX = rotX					 --
    local cameraAngleY = rotY					 --
					 --
    local freeModeAngleZ = math.sin(cameraAngleY)					 --
    local freeModeAngleY = math.cos(cameraAngleY) * math.cos(cameraAngleX)					 --
    local freeModeAngleX = math.cos(cameraAngleY) * math.sin(cameraAngleX)					 --
					 --
					 --
					 --
    local camPosX, camPosY, camPosZ = getCameraMatrix()					 --
					 --
    -- calculate a target based on the current position and an offset based on the angle					 --
    local camTargetX = camPosX + freeModeAngleX * 100					 --
    local camTargetY = camPosY + freeModeAngleY * 100					 --
    local camTargetZ = camPosZ + freeModeAngleZ * 100					 --
						 --
    -- Work out the distance between the target and the camera (should be 100 units)					 --
    local camAngleX = camPosX - camTargetX					 --
    local camAngleY = camPosY - camTargetY					 --
    local camAngleZ = 0 -- we ignore this otherwise our vertical angle affects how fast you can strafe					 --
					 --
    -- Calulcate the length of the vector					 --
    local angleLength = math.sqrt(camAngleX*camAngleX+camAngleY*camAngleY+camAngleZ*camAngleZ)					 --
					 --
    -- Normalize the vector, ignoring the Z axis, as the camera is stuck to the XY plane (it can't roll)					 --
    local camNormalizedAngleX = camAngleX / angleLength					 --
    local camNormalizedAngleY = camAngleY / angleLength					 --
    local camNormalizedAngleZ = 0					 --
					 --
    -- We use this as our rotation vector					 --
    local normalAngleX = 0					 --
    local normalAngleY = 0					 --
    local normalAngleZ = 1					 --
					 --
    -- Perform a cross product with the rotation vector and the normalzied angle					 --
    local normalX = (camNormalizedAngleY * normalAngleZ - camNormalizedAngleZ * normalAngleY)					 --
    local normalY = (camNormalizedAngleZ * normalAngleX - camNormalizedAngleX * normalAngleZ)					 --
    local normalZ = (camNormalizedAngleX * normalAngleY - camNormalizedAngleY * normalAngleX)					 --
					 --
    -- Update the camera position based on the forwards/backwards speed					 --
    camPosX = camPosX + freeModeAngleX * speed					 --
    camPosY = camPosY + freeModeAngleY * speed					 --
    camPosZ = camPosZ + freeModeAngleZ * speed					 --
					 --
    -- Update the camera position based on the strafe speed					 --
    camPosX = camPosX + normalX * strafespeed					 --
    camPosY = camPosY + normalY * strafespeed					 --
    camPosZ = camPosZ + normalZ * strafespeed					 --
					 --
    -- Update the camera position Z based on speedUpDown					 --
    camPosZ = camPosZ + speedUpDown					 --
					 --
    -- Update the target based on the new camera position (again, otherwise the camera kind of sways as the target is out by a frame)					 --
    camTargetX = camPosX + freeModeAngleX * 100					 --
    camTargetY = camPosY + freeModeAngleY * 100					 --
    camTargetZ = camPosZ + freeModeAngleZ * 100					 --
						 --
    -- Set the new camera position and target						 --
    setCameraMatrix ( camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ, camRoll, camFov )					 --
    if vehCamRotMode == "fixed" then saveCameraCoordsInVehBasis(camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ) end					 --
end					 --
function axayUpdate(_,_,nAX,nAY)					 --
	aX = nAX					 --
	aY = nAY					 --
end					 --
					 --
function camMouse ()					 --
	--ignore mouse movement if the cursor or MTA window is on					 --
	--and do not resume it until at least 5 frames after it is toggled off					 --
	--(prevents cursor mousemove data from reaching this handler)					 --
					 --
	local leftRightRotKey = false					 --
	if getKeyState(camKeys.key_cam_left) then					 --
		rotXSpeed = rotXSpeed - slowOptions.rotAcceleration					 --
		leftRightRotKey = true					 --
	end					 --
	if getKeyState(camKeys.key_cam_right) then					 --
		rotXSpeed = rotXSpeed + slowOptions.rotAcceleration					 --
		leftRightRotKey = true					 --
	end					 --
	if not leftRightRotKey then					 --
		if rotXSpeed > 0 then					 --
			rotXSpeed = rotXSpeed - slowOptions.rotDeacceleration					 --
		elseif rotXSpeed < 0 then					 --
			rotXSpeed = rotXSpeed + slowOptions.rotDeacceleration					 --
		end					 --
	end					 --
					 --
	if rotXSpeed < slowOptions.rotDeacceleration/2 and rotXSpeed > -slowOptions.rotDeacceleration/2 then					 --
		rotXSpeed = 0					 --
	end					 --
					 --
	local upDownRotKey = false					 --
	if getKeyState(camKeys.key_cam_down) then					 --
		rotYSpeed = rotYSpeed - slowOptions.rotAcceleration					 --
		upDownRotKey = true					 --
	end					 --
	if getKeyState(camKeys.key_cam_up) then					 --
		rotYSpeed = rotYSpeed + slowOptions.rotAcceleration					 --
		upDownRotKey = true					 --
	end					 --
	if not upDownRotKey then					 --
		if rotYSpeed > 0 then					 --
			rotYSpeed = rotYSpeed - slowOptions.rotDeacceleration					 --
		elseif rotYSpeed < 0 then					 --
			rotYSpeed = rotYSpeed + slowOptions.rotDeacceleration					 --
		end					 --
	end					 --
	if rotYSpeed < slowOptions.rotDeacceleration/2 and rotYSpeed > -slowOptions.rotDeacceleration/2 then					 --
		rotYSpeed = 0					 --
	end					 --
					 --
	if rotXSpeed > slowOptions.rotMaxSpeed then rotXSpeed = slowOptions.rotMaxSpeed end					 --
	if rotXSpeed < -slowOptions.rotMaxSpeed then rotXSpeed = -slowOptions.rotMaxSpeed end					 --
	if rotYSpeed > slowOptions.rotMaxSpeed then rotYSpeed = slowOptions.rotMaxSpeed end					 --
	if rotYSpeed < -slowOptions.rotMaxSpeed then rotYSpeed = -slowOptions.rotMaxSpeed end					 --
						 --
					 --
	rotX = rotX + rotXSpeed					 --
	rotY = rotY + rotYSpeed					 --
						 --
					 --
					 --
	if isCursorShowing() or isMTAWindowActive() then					 --
		mouseFrameDelay = 5					 --
		return					 --
	elseif mouseFrameDelay > 0 then					 --
		mouseFrameDelay = mouseFrameDelay - 1					 --
		return					 --
	end					 --
						 --
	-- how far have we moved the mouse from the screen center?					 --
    local width, height = guiGetScreenSize()					 --
    aX = aX - width / 2 					 --
    aY = aY - height / 2					 --
					 --
	if isSlowCamHack then					 --
		rotX = rotX + aX * slowOptions.mouseSensitivity * 0.01745					 --
		rotY = rotY - aY * slowOptions.mouseSensitivity * 0.01745					 --
	else					 --
		rotX = rotX + aX * fastOptions.mouseSensitivity * 0.01745					 --
		rotY = rotY - aY * fastOptions.mouseSensitivity * 0.01745					 --
	end					 --
						 --
	local PI = math.pi					 --
	if rotX > PI then					 --
		rotX = rotX - 2 * PI					 --
	elseif rotX < -PI then					 --
		rotX = rotX + 2 * PI					 --
	end					 --
						 --
	if rotY > PI then					 --
		rotY = rotY - 2 * PI					 --
	elseif rotY < -PI then					 --
		rotY = rotY + 2 * PI					 --
	end					 --
    -- limit the camera to stop it going too far up or down - PI/2 is the limit, but we can't let it quite reach that or it will lock up					 --
	-- and strafeing will break entirely as the camera loses any concept of what is 'up'					 --
					 --
   	if rotY < -PI / 2.05 then					 --
      rotY = -PI / 2.05					 --
   elseif rotY > PI / 2.05 then					 --
      rotY = PI / 2.05					 --
   end					 --
					 --
   aX = screenWid/2					 --
   aY = screenHeh/2					 --
					 --
end					 --
					 --
addEvent( "onClientEnableCamMode", true )					 --
addEventHandler( "onClientEnableCamMode", root, 					 --
	function( state )					 --
		if getElementData( localPlayer, "isPlayerInCamHackMode" ) then					 --
			return false					 --
		end					 --
		addEventHandler( "onClientPreRender", root, camFrame )					 --
		addEventHandler( "onClientCursorMove", root, axayUpdate ) 					 --
		setElementData( localPlayer, "isPlayerInCamHackMode", true )					 --
		isSlowCamHack = state					 --
		return true					 --
	end					 --
)					 --
					 --
addEvent( "onClientDisableCamMode", true )					 --
addEventHandler( "onClientDisableCamMode", root, 					 --
	function( )					 --
		if not getElementData( localPlayer, "isPlayerInCamHackMode" ) then					 --
			return false					 --
		end					 --
		speed = 0					 --
		camFov = 70					 --
		camRoll = 0						 --
		strafespeed = 0					 --
		removeEventHandler( "onClientPreRender", root, camFrame )					 --
		removeEventHandler( "onClientCursorMove",root, axayUpdate )					 --
		setElementData( localPlayer, "isPlayerInCamHackMode", false )					 --
		setCameraTarget( localPlayer )					 --
		return true					 --
	end					 --
)					 --
					 --
addEventHandler( "onClientResourceStop", resourceRoot, 					 --
	function( )					 --
		if not getElementData( localPlayer,"isPlayerInCamHackMode" ) then					 --
			return					 --
		end					 --
		speed = 0					 --
		camFov = 70					 --
		camRoll = 0						 --
		strafespeed = 0					 --
		removeEventHandler( "onClientPreRender", root, camFrame )					 --
		removeEventHandler( "onClientCursorMove",root, axayUpdate )					 --
		setElementData( localPlayer, "isPlayerInCamHackMode", false )					 --
		setCameraTarget( localPlayer )					 --
	end					 --
)					 --
					 --
addEventHandler( "onClientResourceStart", resourceRoot, 					 --
	function( )					 --
		setElementData(localPlayer, "isPlayerInCamHackMode", false)					 --
	end					 --
)					 --
					 --
addCommandHandler( "camhackm", 					 --
	function( )					 --
		isSlowCamHack = not isSlowCamHack					 --
	end					 --
)					 --
					 --
					 --
					 --
					 --
					 --
--------------------------------------------------------------------------------------------					 --
function getMatixWithoutRowColumn(matrix3x3,row,column)					 --
	local newMatrix = {}					 --
	for i=1,3 do					 --
		for j=1,3 do					 --
			if (i ~= row) and (j ~= column) then					 --
				table.insert(newMatrix,matrix3x3[i][j])					 --
			end					 --
		end					 --
	end					 --
	return {{newMatrix[1],newMatrix[2]},{newMatrix[3],newMatrix[4]}}					 --
end					 --
function calculateDeterminant2x2(matrix2x2)					 --
	return matrix2x2[1][1]*matrix2x2[2][2] - matrix2x2[1][2]*matrix2x2[2][1]					 --
end					 --
function calculateDeterminant3x3(matrix3x3)					 --
	local a = matrix3x3					 --
	return a[1][1]*a[2][2]*a[3][3] + a[3][1]*a[1][2]*a[2][3] + a[2][1]*a[3][2]*a[1][3] - a[3][1]*a[2][2]*a[1][3] - a[1][1]*a[3][2]*a[2][3] - a[2][1]*a[1][2]*a[3][3]					 --
end					 --
					 --
function getMinorsMatrixWithSigns(matrix3x3)					 --
	local minorMat = {{},{},{}}					 --
						 --
	local index = 1					 --
					 --
	for i=1,3 do					 --
		for j=1,3 do					 --
			index = index + 1					 --
			local znak = ((-1)^index)					 --
			table.insert(minorMat[i],calculateDeterminant2x2(getMatixWithoutRowColumn(matrix3x3,i,j)) * znak)					 --
		end					 --
	end					 --
	return minorMat					 --
end					 --
					 --
					 --
function getTransposedRectMatrix(matrix)					 --
	local rows = #matrix					 --
	local columns = #matrix[1]					 --
	local transposedMatrix = {}					 --
	for i=1,columns do					 --
		table.insert(transposedMatrix,{})					 --
	end					 --
	for i=1,rows do					 --
		for j=1,columns do					 --
			table.insert(transposedMatrix[j],matrix[i][j])					 --
		end					 --
	end					 --
	return transposedMatrix					 --
end					 --
					 --
function devideMatrixToNumber(matrix,number)					 --
	for rowI,row in ipairs(matrix) do					 --
		for colI,elm in ipairs(row) do					 --
			matrix[rowI][colI] = elm/number					 --
		end					 --
	end					 --
	return matrix					 --
end					 --
					 --
function getInverseMatrix(matrix)					 --
	local det = calculateDeterminant3x3(matrix)					 --
	local transposedAdditions = getTransposedRectMatrix(getMinorsMatrixWithSigns(matrix))					 --
					 --
	return devideMatrixToNumber(transposedAdditions,det)					 --
end					 --
					 --
function MultiplyMatrix3x3ByVector3(matrix3x3,Vec3)					 --
	return Vector3(matrix3x3[1][1]*Vec3.x + matrix3x3[1][2]*Vec3.y + matrix3x3[1][3]*Vec3.z,					 --
						matrix3x3[2][1]*Vec3.x + matrix3x3[2][2]*Vec3.y + matrix3x3[2][3]*Vec3.z,					 --
						matrix3x3[3][1]*Vec3.x + matrix3x3[3][2]*Vec3.y + matrix3x3[3][3]*Vec3.z)					 --
end					 --
					 --
function tostringMatrix(matrix)					 --
	local s = "\n"					 --
	for i=1,#matrix do					 --
		s = s.."{"					 --
		for j=1,#matrix[i] do					 --
			s = s..matrix[i][j].." "					 --
		end					 --
		s = s.."}\n"					 --
	end					 --
	return s					 --
end					 --
					 --
					 --
					 --
					 --
					 --
----------------------------------------------------------------------------------------------					 --
function toGrad(num)					 --
	return num*180/math.pi					 --
end					 --
function targetCameraAt(targetX,targetY,targetZ)					 --
	local camPosX,camPosY,camPosZ = getElementPosition(getCamera())					 --
					 --
	----X-------						 --
	local rotterX = math.atan2(targetX - camPosX,targetY - camPosY)					 --
	----Y-------					 --
	local rotterY = math.atan2(targetZ - camPosZ,getDistanceBetweenPoints2D(targetX,targetY,camPosX,camPosY))					 --
	------------					 --
					 --
	rotX = rotterX					 --
	rotY = rotterY					 --
end					 --
-----------------------------------Veher -----------------------------------------------------					 --
veherKeys = {					 --
	vehmodeOnOff = "n",					 --
	vehChoosing = "mouse2",					 --
	fixMode = "x"					 --
}					 --
					 --
					 --
screenWid,screenHeh = guiGetScreenSize()					 --
aX = screenWid/2					 --
ay = screenHeh/2					 --
					 --
function findfrstClear(array,max)					 --
	local lastIndexer = 0					 --
	for i,v in ipairs(array) do					 --
		lastIndexer = i					 --
		if v == nil then					 --
			return i					 --
		end					 --
		if i >= max then					 --
			return false					 --
		end					 --
	end					 --
	return lastIndexer + 1					 --
end					 --
-------------------------------------					 --
vehVidelkaTex = dxCreateRenderTarget(100,100,true)					 --
function createVehVidelka()					 --
	dxSetRenderTarget(vehVidelkaTex,true)					 --
	local modeSave = dxGetBlendMode()					 --
	dxSetBlendMode("overwrite")					 --
	dxDrawRectangle(0,0,100,100,tocolor(200,200,200,235))					 --
	dxDrawRectangle(4,4,92,92,tocolor(40,40,40,235))					 --
	dxDrawRectangle(10,10,80,80,tocolor(0,0,0,0))					 --
	dxSetBlendMode(modeSave)					 --
	dxSetRenderTarget()					 --
end					 --
-------------------------------------					 --
colors = {	tocolor(0,160,160,200),					 --
				tocolor(220,140,0,200),					 --
				tocolor(34,139,34,200),					 --
				tocolor(220,60,20,200),					 --
				tocolor(240,0,235,200)}					 --
-------------------------------------					 --
					 --
vehMode = false					 --
bindKey(veherKeys.vehmodeOnOff,"down",function()					 --
	vehMode = not vehMode					 --
end)					 --
					 --
lshifterKey = false					 --
lctrlerKey = false					 --
ChoosedVehs = {}					 --
followVehI = 1					 --
ChoosedVehsShowing = true					 --
lookAtVeh = nil					 --
bindKey(veherKeys.vehChoosing,"down",function()					 --
	if lookAtVeh and ChoosedVehsShowing then					 --
		local finded = false					 --
		local findedK = ""					 --
		for k,v in pairs(ChoosedVehs) do					 --
			if v == lookAtVeh then					 --
				finded = true					 --
				findedK = k					 --
			end					 --
		end					 --
					 --
		if finded then					 --
			ChoosedVehs[findedK] = nil					 --
		else					 --
			ChoosedVehs[findfrstClear(ChoosedVehs,#colors)] = lookAtVeh					 --
			saveVehPos()					 --
		end					 --
					 --
	else					 --
		if lshifterKey then					 --
			ChoosedVehs = {}					 --
		else					 --
			ChoosedVehsShowing = not ChoosedVehsShowing					 --
		end					 --
	end					 --
end)					 --
					 --
					 --
vehSavePosX = 0					 --
vehSavePosY = 0					 --
vehSavePosZ = 0					 --
function saveVehPos()					 --
	if ChoosedVehs[followVehI] then vehSavePosX,vehSavePosY,vehSavePosZ = getElementPosition(ChoosedVehs[followVehI]) end					 --
end					 --
function chooseVehI(i)					 --
	followVehI = i					 --
	if ChoosedVehs[followVehI] then					 --
		saveVehPos()					 --
		if lctrlerKey then					 --
			local vposx,vposy,vposz = getElementPosition(ChoosedVehs[followVehI])					 --
			local vehMatrix = Matrix(Vector3(vposx,vposy,vposz),Vector3(getElementRotation(ChoosedVehs[followVehI])))					 --
			local posCam = vehMatrix.position - vehMatrix.forward*8 + vehMatrix.up * 3					 --
			setCameraMatrix(posCam.x,posCam.y,posCam.z)					 --
			targetCameraAt(vposx,vposy,vposz)					 --
		end					 --
	end					 --
end					 --
					 --
addEventHandler("onClientPreRender",root,function()					 --
	if not vehMode then return end					 --
	createVehVidelka()					 --
	if mta_getKeyState("lshift") then					 --
		lshifterKey = true					 --
	else					 --
		lshifterKey = false					 --
	end					 --
	if mta_getKeyState("lctrl") then					 --
		lctrlerKey = true					 --
	else					 --
		lctrlerKey = false					 --
	end					 --
					 --
	for i=1,#colors do					 --
		if mta_getKeyState("num_"..(i+3)) then					 --
			chooseVehI(i)				--numpad keys					 --
		end					 --
		if mta_getKeyState(i) then					 --
			--chooseVehI(i)			--numbers keys					 --
		end					 --
	end					 --
					 --
	local cX,cY,cZ = getWorldFromScreenPosition(screenWid/2,screenHeh/2,0.01)					 --
	local clX,clY,clZ = getWorldFromScreenPosition(screenWid/2,screenHeh/2,60)						 --
	local hit, hitX, hitY, hitZ, hitElement = processLineOfSight ( cX, cY, cZ, 					 --
                                       									clX,	clY,	clZ, 					 --
                                       									true,true,false,false,false)					 --
	if hitElement then					 --
		if getElementType(hitElement) == "vehicle" then					 --
			lookAtVeh = hitElement					 --
		end					 --
	else					 --
		lookAtVeh = nil					 --
	end					 --
					 --
	if ChoosedVehsShowing then					 --
		dxDrawRectangle(screenWid/2-2,screenHeh/2-2,4,4,tocolor(255,255,255,225))					 --
		dxDrawRectangle(screenWid/2-1,screenHeh/2-1,2,2,tocolor(30,30,30,225))					 --
		if lookAtVeh then					 --
			local lavX,lavY,lavZ = getElementPosition(lookAtVeh)					 --
			local sx,sy = getScreenFromWorldPosition(lavX,lavY,lavZ)					 --
			if sx and sy then 					 --
				sx = sx - 30					 --
				sy = sy - 30					 --
				dxDrawImage(sx,sy,60,60,vehVidelkaTex) 					 --
			end					 --
		end					 --
					 --
		for i=1,#colors do					 --
			local veh = ChoosedVehs[i]					 --
			if veh then					 --
				local lavX,lavY,lavZ = getElementPosition(veh)					 --
				local sx,sy = getScreenFromWorldPosition(lavX,lavY,lavZ)					 --
				if sx and sy then 					 --
					sx = sx - 15					 --
					sy = sy - 15					 --
					dxDrawRectangle(sx,sy,30,30,colors[i]) 					 --
				end					 --
					 --
				dxDrawRectangle(400 + (i-1)*40,screenHeh - 50,30,30,colors[i])					 --
			else					 --
				ChoosedVehs[i] = nil					 --
			end					 --
					 --
			if followVehI == i then					 --
				dxDrawImage((400 + (i-1)*40) - 5,screenHeh - 50 - 5,40,40,vehVidelkaTex)						 --
			end					 --
		end					 --
	end					 --
end)					 --
					 --
function saveCameraCoordsInVehBasis(camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ)					 --
	local MatrixVeh = Matrix( Vector3(getElementPosition(ChoosedVehs[followVehI])),Vector3(getElementRotation(ChoosedVehs[followVehI])) )					 --
	if not MatrixVeh then					 --
		vehCamRotMode = "free"					 --
		return					 --
	end					 --
					 --
	local mPos = MatrixVeh.position					 --
	local forwardPos = MatrixVeh.forward					 --
	local rightPos = MatrixVeh.right					 --
	local upPos = MatrixVeh.up					 --
					 --
	local VehBasisInKanonBasis = {					 --
		{forwardPos.x, rightPos.x, upPos.x},					 --
		{forwardPos.y, rightPos.y, upPos.y},					 --
		{forwardPos.z, rightPos.z, upPos.z}					 --
	}					 --
					 --
	local cx,cy,cz,clx,cly,clz = getCameraMatrix()					 --
	if camPosX then					 --
		cx = camPosX					 --
		cy = camPosY					 --
		cz = camPosZ					 --
		clx = camTargetX					 --
		cly = camTargetY					 --
		clz = camTargetZ					 --
	end					 --
	local camPos = Vector3(cx,cy,cz) - mPos					 --
	local camLookPos = Vector3(clx,cly,clz) - mPos 					 --
					 --
	local swapToVehBasisMatrix = getInverseMatrix(VehBasisInKanonBasis)					 --
					 --
	camPos_vehB = MultiplyMatrix3x3ByVector3(swapToVehBasisMatrix, camPos)					 --
	camLookPos_vehB = MultiplyMatrix3x3ByVector3(swapToVehBasisMatrix, camLookPos)					 --
					 --
	--targetCameraAt(camLookPos.x,camLookPos.y,camLookPos.z)					 --
end					 --
					 --
vehCamRotMode = "free"					 --
bindKey(veherKeys.fixMode,"down",function()					 --
	if vehCamRotMode == "free" then					 --
		if ChoosedVehs[followVehI] then					 --
			vehCamRotMode = "fixed"					 --
			saveCameraCoordsInVehBasis()					 --
		end					 --
	else					 --
		vehCamRotMode = "free"					 --
	end					 --
end)					 --
					 --
					 --
					 --
local inter = true					 --
bindKey("f2","down",function()					 --
	inter = not inter					 --
	showChat(inter)					 --
	setPlayerHudComponentVisible("all",inter)					 --
end)					 --
