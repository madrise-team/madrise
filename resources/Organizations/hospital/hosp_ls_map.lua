----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
import('Organizations/garage.lua')()
------------------------------------

--------------------
--      int     dim     gar dim (int 1)     ammo dim (int 6)
--lspd   3       57           160                                    
--------------------

enterP = {pos  = Vector3(1142.7791,-1326.6649,12.675),rot = Vector3(0,0,0),dim = 0,int = 0}
outP = {pos  = Vector3(2326.0166,2450.9727,1999.7018),rot = Vector3(0,0,-90),dim = 160,int = 1}
createGerageDoorFunctional(enterP,outP)

----------------------------------Снаружи--------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
lsHPark1 = createObject(3037, 1145.3672, -1326.8086, 14.74696, 0, 0, 0)
-------------------------------------------------------------------------
spawnGosPark(160)
----------------------------------Внутри---------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
--lspdInt1 = createObject(3089, 222.15251, 68.303, 1005.368, 0, 0, 90)     setElementInterior(lspdInt1, 6)  setElementDimension(lspdInt1, 54)
-------------------------------------------------------------------------
-------------------------------------------------------------------------

marker = {"cylinder", 1.0, 225, 225, 225, 200}

hosp_ls_gar = {
	{382.76245, 125.36088, 1013.8739, 3, 57},-----------------Вход-----------
	{2352.8164, 2376.623, 1991.0834, 1, 160},-----------------Выход----------
	{2352.9036, 2378.4375, 1992.0759, 180, 1, 160},-----------Спавн внутри---
	{381.63776, 125.32752, 1014.8371, 270, 3, 57}-------------Спавн снаружи--	
}

addVhodVihod(hosp_ls_gar, marker)



--"pickup pereod_hosp" interior="3" posX="364.44263" posY="124.85879" posZ="1014.8371"
--"marker rab_hosp"    interior="3" posX="382.79779" posY="108.82285" posZ="1013.869"
--"marker avto_gos"    interior="1" posX="2348.5078" posY="2378.9021" posZ="1991.1016"