txd = engineLoadTXD ('id400.txd')
engineImportTXD (txd, 400)
dff = engineLoadDFF ('id400.dff', 400)
engineReplaceModel (dff, 400)


function isAvto()
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then return
    else return veh end
end


local lightsShader = [[
float4 lightColor = float4(1,1,1,1);

float4 GetColor()
{
    return lightColor;
}

//-----------------------------------------------------------------------------
technique tec0
{
    pass P0
    {
        MaterialAmbient = GetColor();
        MaterialDiffuse = GetColor();
        MaterialEmissive = GetColor();
        MaterialSpecular = GetColor();

        AmbientMaterialSource = Material;
        DiffuseMaterialSource = Material;
        EmissiveMaterialSource = Material;
        SpecularMaterialSource = Material;

        ColorOp[0] = SELECTARG1;
        ColorArg1[0] = Diffuse;

        AlphaOp[0] = SELECTARG1;
        AlphaArg1[0] = Diffuse;

        Lighting = true;
    }
}]]



local dxShaderRightLeft = dxCreateShader(lightsShader)   ;dxSetShaderValue (dxShaderRightLeft, "lightColor",     0.9, 0.8, 0,       1.0)   --поворотники
local dxShaderLights = dxCreateShader(lightsShader)      ;dxSetShaderValue (dxShaderLights, "lightColor",        1.0, 1.0, 1.0,     1.0)   --габариты
local dxShaderBack = dxCreateShader(lightsShader)        ;dxSetShaderValue (dxShaderBack, "lightColor",          1.0, 1.0, 1.0,     1.0)   --задний ход
local dxShaderBrake = dxCreateShader(lightsShader)       ;dxSetShaderValue (dxShaderBrake, "lightColor",         1.0, 0, 0,         1.0)   --тормоза
local dxShaderLightsBack = dxCreateShader(lightsShader)  ;dxSetShaderValue (dxShaderLightsBack, "lightColor",    1.0, 0, 0,         1.0)   --габариты (зад)
local sh = {}

local red = 0.94
local green = 0.94
local blue = 0.94

local per = - math.pi / 2

setTimer(function()

    
    if per >= 3 * math.pi / 2 then per = - math.pi / 2 end
    per = per + 0.02

-- (sin x + 1.1) * 0.45

    red = (math.sin(per) + 1.1) * 0.45
    green = (math.sin(per * 3) + 1.1) * 0.45
    blue = (math.sin(per * 7) + 1.1) * 0.45

    --[[
    if red >= 0.1 and red <= 0.95 then red = red - math.random(1,10)/600 end
    if red <= 0.1 then red = red + 0.7 end

    if green >= 0.1 and green <= 0.95 then green = green - math.random(1,10)/600 end
    if green <= 0.1 then green = green + 0.6 end

    if blue >= 0.1 and blue <= 0.95 then blue = blue - math.random(1,10)/600 end
    if blue <= 0.1 then blue = blue + 0.8 end

    --]]

    dxSetShaderValue (dxShaderRightLeft, "lightColor",     red, green, blue,       1.0)   --поворотники
end
, 50, 0)
--[[
setTimer(function()
    if green >= 0.1 and green <= 0.95 then green = green - math.random(1,10)/100 end
    if green <= 0.1 then green = green + 0.5 end
end
, 200, 0)

setTimer(function()
    if blue >= 0.1 and blue <= 0.95 then blue = blue - math.random(1,10)/100 end
    if blue <= 0.1 then blue = blue + 0.5 end
end
, 200, 0)

dxSetShaderValue (dxShaderRightLeft, "lightColor",     red, green, blue,       1.0)   --поворотники
--]]



trigger = function(shader, type, veh)
    if sh[veh] then
        sh[veh] = nil
        return engineRemoveShaderFromWorldTexture(shader, type, veh)
    else
        sh[veh] = true
        return engineApplyShaderToWorldTexture(shader, type, veh)
    end
end
trigger2 = function(shader, veh)
    if sh[veh] then
        sh[veh] = nil
        engineRemoveShaderFromWorldTexture(shader, "rightflash", veh)
        return engineRemoveShaderFromWorldTexture(shader, "leftflash", veh)
    else
        sh[veh] = true
        engineApplyShaderToWorldTexture(shader, "rightflash", veh)
        return engineApplyShaderToWorldTexture(shader, "leftflash", veh)
  end
end

setTimer(function()
  for _,v in ipairs(getElementsByType("vehicle")) do
    if getElementData(v, "rightflash") then
      setElementData(v, 'leftflash', false)
      setElementData(v, 'allflash', false)
      trigger(dxShaderRightLeft, "rightflash", v)
    end
  end
end
, 600, 0)
setTimer(function()
  for _,veh in ipairs(getElementsByType("vehicle")) do
    if getElementData(veh, "leftflash") then
      setElementData(veh, 'rightflash', false)
      setElementData(veh, 'allflash', false)
      trigger(dxShaderRightLeft, "leftflash", veh)
    end
  end
end
, 600, 0)
setTimer(function()
  for _,vehicle in ipairs(getElementsByType("vehicle")) do
    if getElementData(vehicle, "allflash") then
    	setElementData(vehicle, "leftflash", false)
    	setElementData(vehicle, "rightflash", false)
      	trigger2(dxShaderRightLeft, vehicle)
    end
  end
end
, 600, 0)

left = function()

  outputChatBox("left")
  local veh = isAvto()
  if not veh then return end
  if setElementData(veh, "leftflash", true) then
    if getElementData(veh, 'rightflash') then
    	setElementData(veh, "rightflash", false)
    	engineRemoveShaderFromWorldTexture(dxShaderRightLeft, "rightflash",veh)
	end
	setElementData(veh, "allflash", false)
    engineApplyShaderToWorldTexture(dxShaderRightLeft, "leftflash", veh)
  else
    setElementData(veh, "leftflash", false)
    engineRemoveShaderFromWorldTexture(dxShaderRightLeft, "leftflash", veh)
    setTimer(function()
      end, 1000, 1)
  end
end
bindKey("num_4", "down", left)

right = function()
  outputChatBox("right")
  local veh = isAvto()
  if not veh then return end
  if setElementData(veh, "rightflash", true) then
  	if getElementData(veh, 'leftflash') then
    	setElementData(veh, "leftflash", false)
    	engineRemoveShaderFromWorldTexture(dxShaderRightLeft, "leftflash",veh)
	end
	setElementData(veh, "allflash", false)
    engineApplyShaderToWorldTexture(dxShaderRightLeft, "rightflash", veh)
  else
    setElementData(veh, "rightflash", false)
    engineRemoveShaderFromWorldTexture(dxShaderRightLeft, "rightflash",veh)
    setTimer(function()
      end, 1000, 1)
  end
end
bindKey("num_6", "down", right)
--[[
all = function()
    local veh = isAvto()
    if not veh then return end
  if not getElementData(veh, "allflash") then
  	if getElementData(veh, 'leftflash') then
    	setElementData(veh, "leftflash", false)
    	engineRemoveShaderFromWorldTexture(dxShaderRightLeft, "leftflash",veh)
	end
	if getElementData(veh, 'rightflash') then
    	setElementData(veh, "rightflash", false)
    	engineRemoveShaderFromWorldTexture(dxShaderRightLeft, "rightflash",veh)
	end
	setElementData(veh, "allflash", true)
	engineApplyShaderToWorldTexture(dxShaderRightLeft, "rightflash", veh)
	engineApplyShaderToWorldTexture(dxShaderRightLeft, "leftflash", veh)
  else
  	setElementData(veh, "allflash", false)
  	engineRemoveShaderFromWorldTexture(dxShaderRightLeft, "rightflash",veh)
  	engineRemoveShaderFromWorldTexture(dxShaderRightLeft, "leftflash",veh)
  end
end
bindKey("num_5", "down", all)
--]]

all = function()
    local veh = isAvto()
    if not veh then return end

    if not getElementData(veh, "allflash") then
        setElementData(veh, "allflash", true)
        engineApplyShaderToWorldTexture(dxShaderLights, "leftflash", veh)
        engineApplyShaderToWorldTexture(dxShaderLightsBack, "rightflash", veh)
    else
        setElementData(veh, "allflash", false)
        engineRemoveShaderFromWorldTexture(dxShaderLights, "leftflash",veh)
        engineRemoveShaderFromWorldTexture(dxShaderLightsBack, "rightflash",veh)
    end
end
bindKey("num_5", "down", all)
------------------------------------------------------------------------------------------------------

gabarityLight = function()
    local veh = isAvto()
    if not veh then return end

    if not getElementData(veh, "allLight") then
        setElementData(veh, "allLight", true)
        engineApplyShaderToWorldTexture(dxShaderLights, "lightflash", veh)
        engineApplyShaderToWorldTexture(dxShaderLightsBack, "lightbackflash", veh)
    else
        setElementData(veh, "allLight", false)
        engineRemoveShaderFromWorldTexture(dxShaderLights, "lightflash",veh)
        engineRemoveShaderFromWorldTexture(dxShaderLightsBack, "lightbackflash",veh)
    end
end
bindKey("num_2", "down", gabarityLight)

------------------------------------------------------------------------------------------------------

function isVehicleReversing(veh)
    local getMatrix = getElementMatrix (veh)
    local getVelocity = Vector3 (getElementVelocity(veh))
    local getVectorDirection = (getVelocity.x * getMatrix[2][1]) + (getVelocity.y * getMatrix[2][2]) + (getVelocity.z * getMatrix[2][3])

    local bre = "Brake"
    engineRemoveShaderFromWorldTexture(dxShaderBrake, "brakelight", veh)

    if (getVehicleCurrentGear(veh) == 0 and getVectorDirection < 0) then
        engineApplyShaderToWorldTexture(dxShaderBack, "backlight", veh)
        if getKeyState("w")  or getKeyState("space") then 
            engineApplyShaderToWorldTexture(dxShaderBrake, "brakelight", veh)
            return bre 
        end
        return "Back"
    end
    engineRemoveShaderFromWorldTexture(dxShaderBack, "backlight", veh)
    if getKeyState("s") or getKeyState("space") then 
        engineApplyShaderToWorldTexture(dxShaderBrake, "brakelight", veh)
        return bre 
    end
    return "Norm"
end

addEventHandler("onClientRender", root, function()
    local veh = isAvto()
    if not veh then return end
    dxDrawText(tostring(isVehicleReversing(veh)), 1800, 600)
end)

------------------------------------------------------------------------------------------------------
function consoleVehicleLights ()
    if isPedInVehicle(getLocalPlayer()) then
        local playerVehicle = getPedOccupiedVehicle ( getLocalPlayer() )     
        if ( playerVehicle ) then                                      
           if ( getVehicleOverrideLights ( playerVehicle ) ~= 1 ) then
               setVehicleOverrideLights ( playerVehicle, 1 )          
           else
               setVehicleOverrideLights ( playerVehicle, 2 )          
           end
       end
   end
end
bindKey("num_8", "down", consoleVehicleLights)

------------------------------------------------------------------------------------------------------





---dubug
addEventHandler("onClientRender", root, function()
    local veh = isAvto()
    if not veh then return end
    dxDrawText("clientavtos400", 1750, 680)
    dxDrawText("Num 5 - аварийка", 1750, 700)
    dxDrawText("Num 4 - левый поворотник", 1750, 720)
    dxDrawText("Num 6 - правый поворотник", 1750, 740)
    dxDrawText("Num 2 - габариты", 1750, 760)
    dxDrawText("Num 8 - фары", 1750, 780)
end)