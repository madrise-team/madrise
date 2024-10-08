----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
import('Organizations/garage.lua')()
------------------------------------

--------------------
--      int     dim     gar dim (int 1)     ammo dim (int 6)
--lspd   5      70           170                   171
--------------------

enterP = {pos  = Vector3(-2583.5959,329.72903,3.99055),rot = Vector3(0,0,0),dim = 0,int = 0}
outP = {pos  = Vector3(2355.6582,2442.877,2025.1514),rot = Vector3(0,0,-90),dim = 170,int = 1}
createGerageDoorFunctional(enterP,outP)

----------------------------------Снаружи--------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
yakPark1 = createObject(3037, -2580.7966, 329.58414, 5.20302, 0, 0, 0.5)   setObjectScale(yakPark1, 1.0)
-------------------------------------------------------------------------
spawnCrimePark(170)
spawnCrimeStorage(171)
----------------------------------Внутри---------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
--lspdInt1 = createObject(3089, 222.15251, 68.303, 1005.368, 0, 0, 90)     setElementInterior(lspdInt1, 6)  setElementDimension(lspdInt1, 54)
-------------------------------------------------------------------------

marker = {"cylinder", 1.0, 225, 0, 0, 200}

yakudza_gar = {
	{1261.0703, -804.28711, 1083.0391, 5, 70},-----------------Вход-----------
	{2367.9229, 2398.7158, 2025.6096, 1, 170},-----------------Выход----------
	{2366.752, 2398.7695, 2026.5931, 270, 1, 170},-------------Спавн внутри---
	{1261.9863, -804.37305, 1084.0078, 90, 5, 70}--------------Спавн снаружи--	
}

yakudza_storage = {
	{1249.6387, -773.66016, 1083.0481, 5, 70},-----------------Вход-----------
	{2576.7041, -1300.3926, 1060.0205, 2, 171},----------------Выход----------
	{2575.5049, -1300.3531, 1060.9844, 270, 2, 171},-----------Спавн внутри---
	{1249.5723, -774.625, 1084.0078, 180, 5, 70}---------------Спавн снаружи--
}

addVhodVihod(yakudza_gar, marker)
addVhodVihod(yakudza_storage, marker)



--"pickup pereod_mafs" interior="5" posX="1272.2466" posY="-814.38855" posZ="1089.9375"
--"mar rab_maf"        interior="2" posX="2578.1301" posY="-1282.3282" posZ="1064.3888"
--"mar oruj_maf"       interior="2" posX="2553.3792" posY="-1291.2985" posZ="1060.0184"
--"marker parki_crime" interior="1" posX="2367.033"  posY="2403.3335"  posZ="2025.6342"