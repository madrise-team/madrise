------------------------------					 --
----- imports					 --
loadstring(exports.importer:load())()					 --
import('RRL_Scripts/usfulC.lua')()    -- Usful Client					 --
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared					 --
					 --
localPlayer = getLocalPlayer()					 --
------------------------------					 --
					 --
local visible = true					 --
					 --
bindKey("q","down", function()					 --
    local veh = getPedOccupiedVehicle(localPlayer)					 --
    --local tablet = {}					 --
    --tablet = getVehicleComponents(veh)					 --
    --for k in pairs(getVehicleComponents(veh)) do					 --
    --   outputChatBox(tostring(k)) 					 --
    --end					 --
    visible = not visible					 --
    setVehicleComponentVisible(veh, "ramkapered", visible)					 --
    setVehicleComponentVisible(veh, "ramkazad", visible)					 --
end)					 --
					 --
					 --
--[[					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(502, x + 3,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces10", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor13", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor2", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces11", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers4", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector10", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor12", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "ug_spoiler", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump10", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor11", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor3", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers1", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump3", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump10", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuzor10", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets0", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Deflector5", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(579, x + 6,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "wtotopovorpered21", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "fenders_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "interior2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bonnet1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "diffuser1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_r1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "trunk_badge2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "splitter1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "skirts1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bonnet2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "scoop1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "trunk_badge1", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(587, x + 9,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers1", false)   					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnet1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnet4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnet2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter10", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnet3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust10", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust2", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(603, x + 12,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts3", false)   					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump2", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(517, x + 15,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "skirts1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_r1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "spoiler1", false)   					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(542, x + 18,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Trunk1", false)   					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser10", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnets1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers8", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust9", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends1", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(421, x + 21,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "trunk1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "spoiler1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "spoiler2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "diffuser1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "skirts1", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_r1", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "trunk_badge2", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "splitter1", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "skirts1", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bonnet2", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "scoop1", false)					 --
    --setTimer(setVehicleComponentVisible, 100, 1, vehTest, "trunk_badge1", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(540, x + 24,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Acces1", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(550, x + 27,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust7", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust3", false)   					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnet2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Spoilers3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Splitter1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust5", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "FrontFends2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust6", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "SideSkirts2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust4", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Diffuser2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearFends2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Exhaust1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "RearBump2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "Bonnet1", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(585, x + 30,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_r2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "fenders_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_r3", false)   					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "diffuser1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_r1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "spoiler1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "splitter3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "splitter2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "splitter1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "spoiler2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_f2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "fenders_r2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bonnet2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "scoop3", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "scoop2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "scoop1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "skirts2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "fenders_r1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "fenders_f2", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bonnet1", false)					 --
end)					 --
					 --
bindKey("e","down", function()					 --
    local x,y,z = getElementPosition(localPlayer)					 --
    local vehTest = createVehicle(400, x + 33,y,z)					 --
					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "door_pside_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "spoiler1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "bumper_r1", false)   					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "doorfender_rr1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "fenders_f1", false)					 --
    setTimer(setVehicleComponentVisible, 100, 1, vehTest, "doorfender_lr1", false)					 --
end)					 --
					 --
]]					 --
					 --
addEvent("getAcoountAvtos",true)					 --
function getMyAvtosFromBD(callback,errCallback)					 --
    serverRequest("getAcoountAvtos",5000,localPlayer,root,nil,callback,errCallback)					 --
end					 --
					 --
					 --
					 --
					 --
function hataNaTata()					 --
    local houseWin = guiCreateWindow(0.4, 0.3, 0.2, 0.4, "Управление домом", true)					 --
					 --
    local houseLabCost = guiCreateLabel(0.08, 0.2, 0.8, 0.2, "Цена: ", true, houseWin)					 --
    local houseLabOwner = guiCreateLabel(0.08, 0.4, 0.8, 0.2, "Владелец: ", true, houseWin)					 --
					 --
    local houseButLock = guiCreateButton(0.04, 0.6, 0.45, 0.15, "Закрыть", true, houseWin)					 --
    local houseButEnter = guiCreateButton(0.04, 0.8, 0.45, 0.15, "Войти", true, houseWin)					 --
    local houseButBuy = guiCreateButton(0.53, 0.6, 0.45, 0.15, "Купить", true, houseWin)					 --
    local houseButSell = guiCreateButton(0.53, 0.8, 0.45, 0.15, "Продать", true, houseWin)					 --
end					 --
					 --
function cuplinovAvto()					 --
    getMyAvtosFromBD(function(autos)					 --
        local avtos = autos					 --
        local avtoW = guiCreateWindow(0.4, 0.3, 0.2, 0.4, "Управление авто", true)					 --
					 --
        					 --
        local avtoGui = {}					 --
        deleteFromAvtoGui = function()					 --
            for k,v in pairs(avtoGui) do					 --
                destroyElement(v)					 --
            end					 --
        end					 --
					 --
        local avtoBox = guiCreateComboBox(0.05, 0.1, 0.9, 0.4, "Выберите автомобиль", true, avtoW)					 --
        for i=1,#avtos do					 --
            local avtoBoxItem = guiComboBoxAddItem(avtoBox, "avto: "..avtos[i].id.." ("..avtos[i].model..")")					 --
        end					 --
        addEventHandler("onClientGUIComboBoxAccepted",avtoBox,function()					 --
            local i = guiComboBoxGetSelected(avtoBox) + 1					 --
            deleteFromAvtoGui()					 --
					 --
            avtoGui.avtoLabOdod = guiCreateLabel(0.1,  0.2, 0.8, 0.2, "ID: "..avtos[i].id, true, avtoW)					 --
            avtoGui.avtoLabOdo = guiCreateLabel(0.08, 0.3, 0.8, 0.2, "Пробег: "..avtos[i].odo, true, avtoW)					 --
            avtoGui.avtoLabGaz = guiCreateLabel(0.08, 0.5, 0.8, 0.2, "Количество топлива: "..avtos[i].fuel, true, avtoW)					 --
					 --
            if autos[i].status == "cloud" then					 --
                avtoGui.avtoSpawnBut = guiCreateButton(0.05, 0.8, 0.9, 0.15, "Спавн", true, avtoW)					 --
                local fuck					 --
                fuck = function()					 --
                    local key = autos[i].id					 --
                    triggerServerEvent("buildThecar",localPlayer,key)					 --
                    destroyAvtoWin()					 --
                end					 --
                addEventHandler("onClientGUIClick",avtoGui.avtoSpawnBut,fuck) 					 --
            elseif autos[i].status == "buildet" then					 --
                avtoGui.avtoSpawnBut = guiCreateButton(0.05, 0.8, 0.9, 0.15, "Убрать", true, avtoW)					 --
                local fuck					 --
                fuck = function()					 --
                    local key = autos[i].id					 --
                    triggerServerEvent("removeThecar",localPlayer,key)					 --
                    destroyAvtoWin()					 --
					 --
                    avtoWin = "destroyBlock"					 --
                    cuplinovAvto()					 --
                end					 --
                addEventHandler("onClientGUIClick",avtoGui.avtoSpawnBut,fuck) 					 --
            end					 --
        end)					 --
					 --
					 --
        avtoWin = avtoW					 --
    end,function()					 --
        outputChatBox("cuplinovAvto - getMyAvtosFromBD waittime error")					 --
    end)					 --
end					 --
					 --
					 --
--------------------------------------Car Test buy					 --
function podiebkaAvto(vehTab,key)					 --
    local salonAvWin = guiCreateWindow(0.4, 0.3, 0.2, 0.4, "Покупка автомобиля", true)					 --
    local salonAvLabCost = guiCreateLabel(0.08, 0.2, 0.8, 0.2, "Цена: "..vehTab.cost..' $', true, salonAvWin)					 --
    local salonAvButEnter = guiCreateButton(0.04, 0.8, 0.45, 0.15, "Купить", true, salonAvWin)					 --
    					 --
    local fuck					 --
    fuck = function()					 --
        triggerServerEvent("buyTheCar",localPlayer,key)					 --
					 --
        destroyElement(salonAvWin)					 --
        removeEventHandler("onClientGUIClick",salonAvButEnter,fuck)					 --
    end					 --
    addEventHandler("onClientGUIClick",salonAvButEnter,fuck)					 --
					 --
    local salonAvButSell = guiCreateButton(0.53, 0.8, 0.45, 0.15, "Тест", true, salonAvWin)					 --
end					 --
					 --
addEvent("buyTheCar",true)					 --
addEventHandler("buyTheCar",root,function(vehTab,key)					 --
    podiebkaAvto(vehTab,key)					 --
end)					 --
					 --
					 --
function destroyAvtoWin()					 --
    destroyElement(avtoWin)					 --
    avtoWin = nil					 --
end					 --
bindKey("f3","down",function()					 --
    if not avtoWin then					 --
        avtoWin = "destroyBlock"					 --
        cuplinovAvto()					 --
    elseif avtoWin ~= "destroyBlock" then					 --
        destroyAvtoWin()					 --
    end					 --
end)					 --
