--- oop oop s`sound a police
----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
import('Organizations/garage.lua')()
------------------------------------

--------------------
--      int     dim     gar dim (int 1)     ammo dim (int 6)
--lvpd   3       56           153                   156
--------------------

enterP = {pos  = Vector3(2291.0972,2498.9231,1.60074),rot = Vector3(0,0,0),dim = 0,int = 0}
outP = {pos  = Vector3(2326.0166,2450.9727,1999.7018),rot = Vector3(0,0,-90),dim = 153,int = 1}
createGerageDoorFunctional(enterP,outP)

----------------------------------Снаружи--------------------------------
-------------------------------------------------------------------------
-----------------------------------LVPD----------------------------------
lvpdPark1 = createObject(3037, 2293.8535, 2498.1943, 4.36713, 0, 0, 0)     setObjectScale(lvpdPark1, 1.0)
lvpdPark2 = createObject(3037, 2293.8618, 2498.1943, 8.76457, 0, 0, 0)     setObjectScale(lvpdPark2, 1.0)
lvpdPark3 = createObject(1533, 2293.7793, 2494.498, 2.24911, 0, 0, 270)    setObjectScale(lvpdPark3, 1.1)
lvpdPark4 = createObject(3037, 2335.126, 2443.5383, 6.9664, 0, 0, 330)     setObjectScale(lvpdPark3, 1.0)
lvpdPark5 = createObject(3037, 2335.1133, 2443.5212, 11.35824, 0, 0, 330)  setObjectScale(lvpdPark3, 1.0)
-------------------------------------------------------------------------
spawnGosPark(153)
spawnGosAmmo(156)
----------------------------------Внутри---------------------------------
-------------------------------------------------------------------------
-----------------------------------LVPD----------------------------------
lvpdIntk1 =  createObject(3089, 217.24316, 181.24219, 1003.3602, 0, 0, 0)    setElementInterior(lvpdIntk1, 3)   setElementDimension(lvpdIntk1, 56)
lvpdIntk2 =  createObject(3089, 220.2291, 181.24219, 1003.3602, 0, 0, 180)   setElementInterior(lvpdIntk2, 3)   setElementDimension(lvpdIntk2, 56)
lvpdIntk3 =  createObject(3089, 209.26729, 181.24219, 1003.3602, 0, 0, 0)    setElementInterior(lvpdIntk3, 3)   setElementDimension(lvpdIntk3, 56)
lvpdIntk4 =  createObject(3089, 212.24661, 181.24219, 1003.3602, 0, 0, 180)  setElementInterior(lvpdIntk4, 3)   setElementDimension(lvpdIntk4, 56)
lvpdIntk5 =  createObject(1649, 218.48969, 181.23222, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk5, 3)   setElementDimension(lvpdIntk5, 56)
lvpdIntk6 =  createObject(1649, 218.48926, 181.23242, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk6, 3)   setElementDimension(lvpdIntk6, 56)
lvpdIntk7 =  createObject(1649, 218.48926, 181.22401, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk7, 3)   setElementDimension(lvpdIntk7, 56)
lvpdIntk8 =  createObject(1649, 218.48926, 181.23204, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk8, 3)   setElementDimension(lvpdIntk8, 56)
lvpdIntk9 =  createObject(1649, 218.48926, 181.22401, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk9, 3)   setElementDimension(lvpdIntk9, 56)
lvpdIntk10 = createObject(1649, 211.07829, 181.22223, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk10, 3)  setElementDimension(lvpdIntk10, 56)
lvpdIntk11 = createObject(1649, 211.07813, 181.22266, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk11, 3)  setElementDimension(lvpdIntk11, 56)
lvpdIntk12 = createObject(1649, 211.07813, 181.22266, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk12, 3)  setElementDimension(lvpdIntk12, 56)
lvpdIntk13 = createObject(1649, 211.07813, 181.22266, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk13, 3)  setElementDimension(lvpdIntk13, 56)
lvpdIntk14 = createObject(1649, 211.07813, 181.22266, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk14, 3)  setElementDimension(lvpdIntk14, 56)
lvpdIntk15 = createObject(1649, 211.07813, 181.23106, 1003.697, 0, 0, 0)     setElementInterior(lvpdIntk15, 3)  setElementDimension(lvpdIntk15, 56)
-------------------------------------------------------------------------
-------------------------------------------------------------------------

marker = {"cylinder", 1.0, 225, 225, 225, 200}

police_lv_gar = {
	{218.72949, 180.63184, 1002.0513, 3, 56},-----------------Вход-----------
	{2352.8164, 2376.623, 1991.0834, 1, 153},-----------------Выход----------
	{2352.9036, 2378.4375, 1992.0759, 180, 1, 153},-----------Спавн внутри---
	{218.53563, 179.42496, 1003.0313, 180, 3, 56}-------------Спавн снаружи--	
}

police_lv_ammo = {
	{210.75488, 180.64844, 1002.0513, 3, 56},-------Вход---------------
	{318.34863, -192.52441, 999.77271, 6, 156},--------Выход-------------
	{318.46875, -191.37695, 1000.7569, 0, 6, 156},--------Спавн внутри---
	{211.05878, 179.09676, 1003.0378, 180, 3, 56}--------Спавн снаружи--	
}

addVhodVihod(police_lv_gar, marker)
addVhodVihod(police_lv_ammo, marker)



--"pickup pereod_lvpd" interior="3" posX="223.76407" posY="188.53043"  posZ="1003.0313"
--"mar rab_lvpd"       interior="3" posX="197.49998" posY="171.4959"   posZ="1002.0427"
--"marker oruj_gos"    interior="6" posX="314.23053" posY="-188.63576" posZ="999.78418"
--"marker avto_gos"    interior="1" posX="2348.5078" posY="2378.9021"  posZ="1991.1016"