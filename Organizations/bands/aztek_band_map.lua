----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
import('Organizations/garage.lua')()
------------------------------------

--------------------
--      int     dim     gar dim (int 1)     ammo dim (int 6)
--lspd   5      66           186                   187
--------------------

enterP = {pos  = Vector3(1698.8232,-2091.5625,12.60887),rot = Vector3(0,0,0),dim = 0,int = 0}
outP = {pos  = Vector3(2355.6582,2442.877,2025.1514),rot = Vector3(0,0,-90),dim = 186,int = 1}
createGerageDoorFunctional(enterP,outP)

----------------------------------Снаружи--------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
--yakPark1 = createObject(3037, -2580.7966, 329.58414, 5.20302, 0, 0, 0.5)   setObjectScale(yakPark1, 1.0)
-------------------------------------------------------------------------
spawnCrimePark(186)
spawnBandStorage(187)
----------------------------------Внутри---------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
--lspdInt1 = createObject(3089, 222.15251, 68.303, 1005.368, 0, 0, 90)     setElementInterior(lspdInt1, 6)  setElementDimension(lspdInt1, 54)
-------------------------------------------------------------------------

marker = {"cylinder", 1.0, 225, 0, 0, 200}

aztek_gar = {
	{331.00757, 1125.8373, 1082.9242, 5, 66},-----------------Вход-----------
	{2367.9229, 2398.7158, 2025.6096, 1, 186},----------------Выход----------
	{2366.752, 2398.7695, 2026.5931, 270, 1, 186},------------Спавн внутри---
	{330.96497, 1124.563, 1083.8828, 180, 5, 66}--------------Спавн снаружи--	
}

aztek_storage = {
	{321.18488, 1127.0422, 1082.9028, 5, 66},-----------------Вход-----------
	{2224.2913, 1597.6078, 999.00146, 1, 187},----------------Выход----------
	{2224.4106, 1596.147, 999.97693, 180, 1, 187},------------Спавн внутри---
	{322.62088, 1127.0073, 1083.8828, 90, 5, 66}--------------Спавн снаружи--
}

addVhodVihod(aztek_gar, marker)
addVhodVihod(aztek_storage, marker)



--"pickup pereod_band" interior="5" posX="311.20633" posY="1124.7035" posZ="1083.8828"
--"mar rab_band"       interior="1" posX="2226.8203" posY="1597.3933" posZ="998.99927"
--"mar oruj_band"      interior="1" posX="2215.9448" posY="1590.6552" posZ="999.02155"
--"marker parki_crime" interior="1" posX="2367.033"  posY="2403.3335" posZ="2025.6342"