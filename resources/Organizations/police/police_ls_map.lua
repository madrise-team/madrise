--- oop oop s`sound a police
----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
import('Organizations/garage.lua')()
------------------------------------

--------------------
--      int     dim     gar dim (int 1)     ammo dim (int 6)
--lspd   6       54           151                   154
--------------------

enterP = {pos  = Vector3(1588.6404,-1634.7295,11.9597),rot = Vector3(0,0,0),dim = 0,int = 0}
outP = {pos  = Vector3(2326.0166,2450.9727,1999.7018),rot = Vector3(0,0,-90),dim = 151,int = 1}
createGerageDoorFunctional(enterP,outP)

----------------------------------Снаружи--------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
lspdPark1 = createObject(3037, 1587.6533, -1638.1191, 14.58132, 0, 0, 90) setObjectScale(lspdPark1, 1.0)
lspdPark2 = createObject(3037, 1587.6533, -1638.1233, 15.66702, 0, 0, 90) setObjectScale(lspdPark2, 1.0)
lspdPark3 = createObject(1533, 1584.2098, -1637.963, 12.33096, 0, 0, 180) setObjectScale(lspdPark3, 1.1)
-------------------------------------------------------------------------
spawnGosPark(151)
spawnGosAmmo(154)
----------------------------------Внутри---------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
lspdInt1 = createObject(3089, 222.15251, 68.303, 1005.368, 0, 0, 90)     setElementInterior(lspdInt1, 6)  setElementDimension(lspdInt1, 54)
lspdInt2 = createObject(3089, 222.15251, 71.28761, 1005.368, 0, 0, 270)  setElementInterior(lspdInt2, 6)  setElementDimension(lspdInt2, 54)
lspdInt3 = createObject(1649, 222.17152, 69.81302, 1005.7048, 0, 0, 90)  setElementInterior(lspdInt3, 6)  setElementDimension(lspdInt3, 54)
lspdInt4 = createObject(1649, 222.17188, 69.81348, 1005.7048, 0, 0, 90)  setElementInterior(lspdInt4, 6)  setElementDimension(lspdInt4, 54)
lspdInt5 = createObject(1649, 222.17188, 69.81348, 1005.7048, 0, 0, 90)  setElementInterior(lspdInt5, 6)  setElementDimension(lspdInt5, 54)
lspdInt6 = createObject(1649, 222.16347, 69.81348, 1005.7048, 0, 0, 90)  setElementInterior(lspdInt6, 6)  setElementDimension(lspdInt6, 54)
-------------------------------------------------------------------------
-------------------------------------------------------------------------

marker = {"cylinder", 1.0, 225, 225, 225, 200}

police_ls_gar = {
	{246.41699, 87.77832, 1002.6655, 6, 54},------------------Вход-----------
	{2352.8164, 2376.623, 1991.0834, 1, 151},-----------------Выход----------
	{2352.9036, 2378.4375, 1992.0759, 180, 1, 151},-----------Спавн внутри---
	{246.35976, 85.86788, 1003.6406, 180, 6, 54}--------------Спавн снаружи--	
}

police_ls_ammo = {
	{222.75391, 69.78027, 1004.0632, 6, 54},---------------Вход---------------
	{318.34863, -192.52441, 999.77271, 6, 154},--------------Выход-------------
	{318.46875, -191.37695, 1000.7569, 0, 6, 154},--------Спавн внутри---
	{224.01819, 69.72672, 1005.0391, 90, 6, 54}-----------Спавн снаружи--	
}

addVhodVihod(police_ls_gar, marker)
addVhodVihod(police_ls_ammo, marker)



--"pickup pereod_lspd" interior="6" posX="258.46567" posY="76.59157"   posZ="1003.6406" 
--"marker lspd_rab"    interior="6" posX="240.65134" posY="71.91388"   posZ="1004.0674" 
--"marker oruj_gos"    interior="6" posX="314.23053" posY="-188.63576" posZ="999.78418" 
--"marker avto_gos"    interior="1" posX="2348.5078" posY="2378.9021"  posZ="1991.1016" 