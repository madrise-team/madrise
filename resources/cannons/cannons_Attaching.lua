loadstring(exports.importer:load())()
import('RRL_Scripts/usfulC.lua')()    -- Usful C



custWepType = "ak-47"
targBone = 25


addCommandHandler("wepoAttach",function()
	local x,y,z = getElementPosition(localPlayer)

	local pederMan = createPed(math.random(30,312), x, y, z)
	local custWep = createWeapon(custWepType, x, y, z)
	attachElementToBone(custWep, pederMan, targBone, 0, 0, 0, 0, 0, 0)
end)