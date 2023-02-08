----- import Interface
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulSh.lua')()
------------------------------------


txd = engineLoadTXD ('id400.txd')
engineImportTXD (txd, 400)
dff = engineLoadDFF ('id400.dff', 400)
engineReplaceModel (dff, 400)

setBlurLevel(0)

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

addEventHandler("onClientRender",root,function()    
    if per >= 3 * math.pi / 2 then per = - math.pi / 2 end
--<<<<<<< Updated upstream
    --per = per + 0.008
--=======
    per = per + 0.004
-->>>>>>> Stashed changes

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
end)
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
    dxDrawText("client.id400", 1750, 680)
    dxDrawText("Num 5 - аварийка", 1750, 700)
    dxDrawText("Num 4 - левый поворотник", 1750, 720)
    dxDrawText("Num 6 - правый поворотник", 1750, 740)
    dxDrawText("Num 2 - габариты", 1750, 760)
    dxDrawText("Num 8 - фары", 1750, 780)
end)

--[[

-------- vot eto prikol
bindKey("num_2","down",function()
    local veher = getPedOccupiedVehicle(localPlayer)
    if veher then
        local shah = dxCreateShader("coloder.fx")

        outputChatBox(getElementModel(veher))
        local texters = engineGetModelTextureNames(getElementModel(veher))
        for k,v in pairs(texters) do
            --outputChatBox(tostring(v))
            engineApplyShaderToWorldTexture(shah,v,veher)
        end
    end
end)

]]--




--------------------------------------------------------   Nomera
--- Shader --------------------
    nomeraShaderData = [[
        texture nomerTex;

        technique setTex
        {
            pass P0
            {
                Texture[0] = nomerTex;
                ColorArg1[0] = Texture;
                ColorArg2[0] = Diffuse;
                ColorOp[0] = Modulate;
                AlphaOp[0] = SelectArg1;

                ColorOp[1] = Disable;
                AlphaOp[1] = Disable;
            }
        }
    ]]
------------------------------------------------------

nomeraTemplates = {}
nomeraTemplates.ru = {
        img = "images/number_ru.png", 
        font = dxCreateFont('fonts/number_ru.ttf',50),
        zone1 = {w = 402, h = 124},
        zone2 = {x = 398, y = 19, w = 98, h = 43},
        drawSymbols = function(nomT)
            templ = nomeraTemplates.ru

            local symb = string.sub(nomT.symbols,1,6)
            local reg = string.sub(nomT.symbols,7,9)
            
            dxDrawText ( symb, 0, 0, templ.zone1.w, templ.zone1.h, tocolor(0,0,0,255), 1, 1,
                templ.font,  "center", "center")
            dxDrawText ( reg, 
                templ.zone2.x, templ.zone2.y, 
                templ.zone2.x+templ.zone2.w, templ.zone2.y+templ.zone2.h,
                tocolor(0,0,0,255), 0.6, 0.6, templ.font,  "center", "top")
        end
}
nomeraTemplates.ru_nf = {
        img = "images/number_ru_noFlag.png", 
        font = nomeraTemplates.ru.font,
        zone1 = nomeraTemplates.ru.zone1,
        zone2 = nomeraTemplates.ru.zone2,
        drawSymbols = nomeraTemplates.ru.drawSymbols
}
nomeraTemplates.ru_federal = {
        img = "images/number_ru_federal.png", 
        font = nomeraTemplates.ru.font,
        zone1 = nomeraTemplates.ru.zone1,
        zone2 = nomeraTemplates.ru.zone2,
        drawSymbols = nomeraTemplates.ru.drawSymbols
}


local avto_number_pairs = {}

local nomerW = 520
local nomerH = 122 


function bakeNomer(numberT)
    local nomT = numberT           -- табилца номера
    local templ = nomeraTemplates[nomT.type]  -- табилца шаблона
    
    --- ///////////////
    dxSetRenderTarget(nomT.nomerRT)
    dxDrawImage(0,0,nomerW,nomerH,templ.img)
    templ.drawSymbols(nomT)
    dxSetRenderTarget()
    --- ///////////////

    dxSetShaderValue(nomT.shader,"nomerTex",nomT.nomerRT)
    engineApplyShaderToWorldTexture(nomT.shader,'nomer',nomT.avto)
end

-->> Перерисовка RT после сворачивания
addEventHandler("onClientRestore",root,function( didClearRenderTargets )
    if not didClearRenderTargets then return end
    for k,v in pairs(avto_number_pairs) do
    --    outputChatBox("paqapa pepe get ma body")
        bakeNomer(v)
    end
end)

function applyNomer(avto,type, symbols)
    local shader = dxCreateShader(nomeraShaderData)
    local nomerRT = dxCreateRenderTarget(nomerW,nomerH)
    
    if not shader or not nomerRT then
        outputChatBox("nomer shader or RT creating error (out of Memory?)")
        destroyElement(shader)  -- cancel
        destroyElement(nomerRT) 
        return 
    end

    local numberT = {
        avto = avto,
        type = type, symbols = symbols,
        shader = shader, nomerRT = nomerRT
    }

    bakeNomer(numberT)

    
    table.insert(avto_number_pairs,numberT)
    setElementData(avto,"nomer", numberT)
    lastNomerdRT = nomerRT
end
------------------------------------------------------ 

function addNomer(typ,symbols)
    local avto = getPedOccupiedVehicle(localPlayer)
    if not avto then return end

    setVehicleEngineState(avto, false)

    applyNomer(avto,typ,symbols)
end

addCommandHandler("nomer",function()
    addNomer("ru","b888bb88")
end)

bindKey("0","down",function()
    addNomer("ru","b888bb88")
end)