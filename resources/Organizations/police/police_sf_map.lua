--- oop oop s`sound a police
----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
import('Organizations/garage.lua')()
------------------------------------

--------------------
--      int     dim     gar dim (int 1)     ammo dim (int 6)
--sfpd   10      55           152                   155
--------------------

enterP = {pos  = Vector3(-1631.2341,683.80206,7.1875),rot = Vector3(0,0,0),dim = 0,int = 0}
outP = {pos  = Vector3(2326.0166,2450.9727,1999.7018),rot = Vector3(0,0,-90),dim = 152,int = 1}
createGerageDoorFunctional(enterP,outP)

----------------------------------Снаружи--------------------------------
-------------------------------------------------------------------------
-----------------------------------SFPD----------------------------------
sfpdPark1 = createObject(3037, -1634.967, 688.08588, 8.386, 0, 0, 90)  
sfpdPark2 = createObject(3037, -1624.746, 688.08594, 8.386, 0, 0, 90)
sfpdPark3 = createObject(3037, -1624.7461, 688.09015, 12.78274, 0, 0, 90)  
sfpdPark4 = createObject(3037, -1634.962, 688.08984, 12.78274, 0, 0, 90)
sfpdPark5 = createObject(5399, -1620.1577, 695.23218, 11.72005, 0, 0, 270)
-------------------------------------------------------------------------
spawnGosPark(152)
spawnGosAmmo(155)
----------------------------------Внутри---------------------------------
-------------------------------------------------------------------------
-----------------------------------SFPD----------------------------------
sfpdIntk1 =  createObject(3089, 264.46851, 115.82237, 1004.9462, 0, 0, 0)    setElementInterior(sfpdIntk1, 10)   setElementDimension(sfpdIntk1, 55)
sfpdIntk2 =  createObject(3089, 267.44379, 115.82227, 1004.9462, 0, 0, 180)  setElementInterior(sfpdIntk2, 10)   setElementDimension(sfpdIntk2, 55)
sfpdIntk3 =  createObject(3089, 267.31317, 112.58474, 1004.9462, 0, 0, 180)  setElementInterior(sfpdIntk3, 10)   setElementDimension(sfpdIntk3, 55)
sfpdIntk4 =  createObject(3089, 264.33856, 112.59383, 1004.9462, 0, 0, 0)    setElementInterior(sfpdIntk4, 10)   setElementDimension(sfpdIntk4, 55)
sfpdIntk5 =  createObject(1649, 266.07828, 115.81008, 1005.283, 0, 0, 0)     setElementInterior(sfpdIntk5, 10)   setElementDimension(sfpdIntk5, 55)
sfpdIntk6 =  createObject(1649, 266.07813, 115.81055, 1005.283, 0, 0, 0)     setElementInterior(sfpdIntk6, 10)   setElementDimension(sfpdIntk6, 55)
sfpdIntk7 =  createObject(1649, 266.07813, 115.81895, 1005.283, 0, 0, 0)     setElementInterior(sfpdIntk7, 10)   setElementDimension(sfpdIntk7, 55)
sfpdIntk8 =  createObject(1649, 266.07813, 115.80254, 1005.283, 0, 0, 0)     setElementInterior(sfpdIntk8, 10)   setElementDimension(sfpdIntk8, 55)
sfpdIntk9 =  createObject(1649, 266.07813, 115.80273, 1005.283, 0, 0, 0)     setElementInterior(sfpdIntk9, 10)   setElementDimension(sfpdIntk9, 55)
sfpdIntk10 = createObject(1649, 266.07813, 115.80273, 1005.283, 0, 0, 0)     setElementInterior(sfpdIntk10, 10)  setElementDimension(sfpdIntk10, 55)
sfpdIntk11 = createObject(1649, 266.07813, 112.61282, 1005.283, 0, 0, 180)   setElementInterior(sfpdIntk11, 10)  setElementDimension(sfpdIntk11, 55)
sfpdIntk12 = createObject(1649, 266.07813, 112.61328, 1005.283, 0, 0, 180)   setElementInterior(sfpdIntk12, 10)  setElementDimension(sfpdIntk12, 55)
sfpdIntk13 = createObject(1649, 266.07813, 112.60068, 1005.283, 0, 0, 180)   setElementInterior(sfpdIntk13, 10)  setElementDimension(sfpdIntk13, 55)
sfpdIntk14 = createObject(1649, 266.07813, 112.60059, 1005.283, 0, 0, 180)   setElementInterior(sfpdIntk14, 10)  setElementDimension(sfpdIntk14, 55)
sfpdIntk15 = createObject(1649, 266.07813, 112.60059, 1005.283, 0, 0, 180)   setElementInterior(sfpdIntk15, 10)  setElementDimension(sfpdIntk15, 55)
sfpdIntk16 = createObject(1649, 266.07813, 112.60899, 1005.283, 0, 0, 180)   setElementInterior(sfpdIntk16, 10)  setElementDimension(sfpdIntk16, 55)
-------------------------------------------------------------------------
-------------------------------------------------------------------------

marker = {"cylinder", 1.0, 225, 225, 225, 200}

police_sf_gar = {
	{265.78125, 113.24707, 1003.6505, 10, 55},----------------Вход-----------
	{2352.8164, 2376.623, 1991.0834, 1, 152},-----------------Выход----------
	{2352.9036, 2378.4375, 1992.0759, 180, 1, 152},-----------Спавн внутри---
	{263.78024, 113.46235, 1004.6172, 270, 10, 55}------------Спавн снаружи--	
}

police_sf_ammo = {
	{265.98633, 115.15234, 1003.6505, 10, 55},-------Вход---------------
	{318.34863, -192.52441, 999.77271, 6, 155},--------Выход-------------
	{318.46875, -191.37695, 1000.7569, 0, 6, 155},--------Спавн внутри---
	{264.33243, 114.9902, 1004.6172, 270, 10, 55}--------Спавн снаружи--	
}

addVhodVihod(police_sf_gar, marker)
addVhodVihod(police_sf_ammo, marker)



--"pickup pereod_sfpd" interior="10" posX="215.54106" posY="125.53399"  posZ="1003.2188"
--"mar rab_sfpd"       interior="10" posX="259.49759" posY="109.66575"  posZ="1002.2303"
--"marker oruj_gos"    interior="6"  posX="314.23053" posY="-188.63576" posZ="999.78418"
--"marker avto_gos"    interior="1"  posX="2348.5078" posY="2378.9021"  posZ="1991.1016"