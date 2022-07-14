--- oop oop s`sound a police
----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared
import('Organizations/garage.lua')()
------------------------------------

--------------------
--      int     dim     gar dim (int 1)     ammo dim (int 6)     kaz dim(int 2)
--lspd   6       54           501                   502                502
--------------------

enterP = {pos  = Vector3(2737.101,-2465.8795,13.5597),rot = Vector3(0,0,0),dim = 0,int = 0}
outP = {pos  = Vector3(2326.0166,2450.9727,1999.7018),rot = Vector3(0,0,-90),dim = 501,int = 1}
createGerageDoorFunctional(enterP,outP)

----------------------------------Снаружи--------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
--lsArmy3 = createObject(5835, 2781.2371, -2539.4504, 20.5311-1.2, 0, 0, 180) setObjectScale(lsArmy3, 1.0)
lsArmy4 = createObject(5835, 2789.6155, -2483.4551, 20.5311-1.2, 0, 0, 90) setObjectScale(lsArmy4, 1.0)
lsArmy5 = createObject(5835, 2789.6152, -2401.7065, 20.5311-1.2, 0, 0, 270) setObjectScale(lsArmy5, 1.0)
lsArmy6 = createObject(3620, 2815.0227, -2442.3618, 25.70105, 0, 0, 90) setObjectScale(lsArmy6, 1.0)
--lsArmy7 = createObject(5835, 2713.7927, -2539.4504, 20.3373-1.2, 0, 0, 0) setObjectScale(lsArmy7, 1.0)
--lsArmy8 = createObject(3279, 2747.615, -2559.4136, 12.28803, 0, 0, 90) setObjectScale(lsArmy8, 1.0)
lsArmy9 = createObject(8883, 2786.2017, -2339.0552, 16.01499, 0, 0, 270) setObjectScale(lsArmy9, 1.0)
lsArmy10 = createObject(8883, 2786.2021, -2370.0305, 16.01499, 0, 0, 270) setObjectScale(lsArmy10, 1.0)
lsArmy11 = createObject(8884, 2783.6072, -2438.4592, 16.06247, 0, 0, 270) setObjectScale(lsArmy11, 1.0)
lsArmy12 = createObject(8885, 2741.4028, -2476.6072, 16.07622, 0, 0, 270) setObjectScale(lsArmy12, 1.0)
lsArmy13 = createObject(8885, 2740.2483, -2485.592, 16.07622, 0, 0, 0) setObjectScale(lsArmy13, 1.0)
lsArmy14 = createObject(7025, 2745.7021, -2433.0383, 15.99031, 0, 0, 270) setObjectScale(lsArmy14, 1.0)
lsArmy15 = createObject(3279, 2804.3523, -2515.4841, 12.28803, 0, 0, 180) setObjectScale(lsArmy15, 1.0)
--lsArmy16 = createObject(3279, 2725.0593, -2516.605, 12.28803, 0, 0, 0) setObjectScale(lsArmy16, 1.0)
lsArmy17 = createObject(3279, 2725.0596, -2491.4412, 12.28803, 0, 0, 0) setObjectScale(lsArmy17, 1.0)
lsArmy18 = createObject(3279, 2725.0596, -2392.7434, 12.28803, 0, 0, 0) setObjectScale(lsArmy18, 1.0)
lsArmy19 = createObject(3279, 2725.0596, -2413.116, 12.28803, 0, 0, 0) setObjectScale(lsArmy19, 1.0)
lsArmy20 = createObject(3279, 2621.6484, -2337.7063, 12.28803, 0, 0, 0) setObjectScale(lsArmy20, 1.0)
lsArmy21 = createObject(3279, 2745.5452, -2453.75, 12.28803, 0, 0, 0) setObjectScale(lsArmy21, 1.0)
lsArmy22 = createObject(3475, 2616.6587, -2333.2888, 13.48715, 0, 0, 0) setObjectScale(lsArmy22, 1.0)
lsArmy23 = createObject(3475, 2616.6587, -2339.2695, 13.48715, 0, 0, 0) setObjectScale(lsArmy23, 1.0)
lsArmy24 = createObject(3475, 2616.6587, -2345.4783, 13.48715, 0, 0, 0) setObjectScale(lsArmy24, 1.0)
lsArmy25 = createObject(3279, 2757.4868, -2337.7061, 12.28803, 0, 0, 0) setObjectScale(lsArmy25, 1.0)
lsArmy26 = createObject(7191, 2616.6326, -2352.9897, 10.21494, 0, 0, 180) setObjectScale(lsArmy26, 1.0)
lsArmy27 = createObject(7191, 2616.6404, -2353.0007, 6.29202, 0, 0, 180) setObjectScale(lsArmy27, 1.0)
lsArmy28 = createObject(7191, 2616.6328, -2352.9932, 2.32397, 0, 0, 180) setObjectScale(lsArmy28, 1.0)
lsArmy29 = createObject(8883, 2783.6121, -2545.1575, 16.05534, 0, 0, 270) setObjectScale(lsArmy29, 1.0)
lsArmy30 = createObject(8883, 2783.6123, -2515.0371, 16.05534, 0, 0, 270) setObjectScale(lsArmy30, 1.0)
lsArmy31 = createObject(3620, 2814.3105, -2529.7244, 25.72228, 0, 0, 90) setObjectScale(lsArmy31, 1.0)
lsArmy32 = createObject(3279, 2732.0715, -2557.0107, 12.3218, 0, 0, 0)   setObjectScale(lsArmy32, 1.0)

removeWorldModel(5326,400,2742.2656,-2449.5234,19.84375)
--removeWorldModel(3707,20,2720.3203,-2530.9141,19.97656)
removeWorldModel(3574,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3624,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3761,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3577,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(1306,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3620,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3753,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3626,400,2742.2656,-2449.5234,19.84375)
--removeWorldModel(3708,20,2720.3203,-2530.9141,19.97656)
removeWorldModel(3744,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3710,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3746,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3758,400,2742.2656,-2449.5234,19.84375)
removeWorldModel(3770,400,2742.2656,-2449.5234,19.84375)
--removeWorldModel(3758,400,2742.2656,-2449.5234,19.84375)
--removeWorldModel(3758,400,2742.2656,-2449.5234,19.84375)

-------------------------------------------------------------------------
spawnGosPark(501)
spawnGosAmmo(502)
----------------------------------Внутри---------------------------------
-------------------------------------------------------------------------
-----------------------------------LSPD----------------------------------
lsArmyIn1  = createObject(14408, 2381.521, -1334.2479, 1027.8625, 0, 0, 0)     setElementInterior(lsArmyIn1 , 2)  setElementDimension(lsArmyIn1 , 502)
lsArmyIn2  = createObject(14409, 2401.2729, -1337.4106, 1021.6857, 0, 0, 0)    setElementInterior(lsArmyIn2 , 2)  setElementDimension(lsArmyIn2 , 502)
lsArmyIn3  = createObject(14464, 2371.28, -1322.4578, 1027.4838, 0, 0, 0)      setElementInterior(lsArmyIn3 , 2)  setElementDimension(lsArmyIn3 , 502)
lsArmyIn4  = createObject(3787, 2383.4971, -1346.9025, 1019.085, 0, 0, 0)      setElementInterior(lsArmyIn4 , 2)  setElementDimension(lsArmyIn4 , 502)
lsArmyIn5  = createObject(3791, 2361.2803, -1346.9965, 1018.9835, 0, 0, 0)     setElementInterior(lsArmyIn5 , 2)  setElementDimension(lsArmyIn5 , 502)
lsArmyIn6  = createObject(3795, 2368.9519, -1347.0089, 1018.8598, 0, 0, 0)     setElementInterior(lsArmyIn6 , 2)  setElementDimension(lsArmyIn6 , 502)
lsArmyIn7  = createObject(3794, 2365.3777, -1347.0311, 1019.1182, 0, 0, 0)     setElementInterior(lsArmyIn7 , 2)  setElementDimension(lsArmyIn7 , 502)
lsArmyIn8  = createObject(2991, 2362.5559, -1342.5917, 1019.1465, 0, 0, 0)     setElementInterior(lsArmyIn8 , 2)  setElementDimension(lsArmyIn8 , 502)
lsArmyIn9  = createObject(3015, 2380.9971, -1326.2605, 1018.5188, 0, 0, 0)     setElementInterior(lsArmyIn9 , 2)  setElementDimension(lsArmyIn9 , 502)
lsArmyIn10 = createObject(2969, 2375.5549, -1326.1743, 1018.6451, 0, 0, 0)     setElementInterior(lsArmyIn10, 2)  setElementDimension(lsArmyIn10, 502)
lsArmyIn11 = createObject(925, 2356.1152, -1344.5084, 1019.5807, 0, 0, 90)     setElementInterior(lsArmyIn11, 2)  setElementDimension(lsArmyIn11, 502)
lsArmyIn12 = createObject(930, 2356.1733, -1345.0498, 1021.1274, 0, 0, 0)      setElementInterior(lsArmyIn12, 2)  setElementDimension(lsArmyIn12, 502)
lsArmyIn13 = createObject(964, 2361.6125, -1339.739, 1019.7766, 0, 0, 180)     setElementInterior(lsArmyIn13, 2)  setElementDimension(lsArmyIn13, 502)
lsArmyIn14 = createObject(2567, 2394.3906, -1321.6306, 1020.4464, 0, 0, 180)   setElementInterior(lsArmyIn14, 2)  setElementDimension(lsArmyIn14, 502)
lsArmyIn15 = createObject(3761, 2380.6777, -1323.6345, 1020.4418, 0, 0, 0)     setElementInterior(lsArmyIn15, 2)  setElementDimension(lsArmyIn15, 502)
lsArmyIn16 = createObject(5260, 2387.1416, -1324.5165, 1020.2217, 0, 0, 180)   setElementInterior(lsArmyIn16, 2)  setElementDimension(lsArmyIn16, 502)
lsArmyIn17 = createObject(3761, 2375.4353, -1323.6348, 1020.4418, 0, 0, 0)     setElementInterior(lsArmyIn17, 2)  setElementDimension(lsArmyIn17, 502)
lsArmyIn18 = createObject(3761, 2370.6113, -1323.6348, 1020.4418, 0, 0, 0)     setElementInterior(lsArmyIn18, 2)  setElementDimension(lsArmyIn18, 502)
lsArmyIn19 = createObject(3761, 2365.1482, -1323.6348, 1020.4418, 0, 0, 0)     setElementInterior(lsArmyIn19, 2)  setElementDimension(lsArmyIn19, 502)
lsArmyIn20 = createObject(3761, 2359.7427, -1323.6348, 1020.4418, 0, 0, 0)     setElementInterior(lsArmyIn20, 2)  setElementDimension(lsArmyIn20, 502)
lsArmyIn21 = createObject(3015, 2380.2434, -1326.2607, 1018.5188, 0, 0, 0)     setElementInterior(lsArmyIn21, 2)  setElementDimension(lsArmyIn21, 502)
lsArmyIn22 = createObject(3015, 2380.2432, -1325.61, 1018.5188, 0, 0, 0)       setElementInterior(lsArmyIn22, 2)  setElementDimension(lsArmyIn22, 502)
lsArmyIn23 = createObject(3015, 2380.8062, -1325.6104, 1018.5188, 0, 0, 0)     setElementInterior(lsArmyIn23, 2)  setElementDimension(lsArmyIn23, 502)
lsArmyIn24 = createObject(3015, 2380.8066, -1324.61, 1018.5188, 0, 0, 0)       setElementInterior(lsArmyIn24, 2)  setElementDimension(lsArmyIn24, 502)
lsArmyIn25 = createObject(3015, 2380.1482, -1324.6104, 1018.5188, 0, 0, 0)     setElementInterior(lsArmyIn25, 2)  setElementDimension(lsArmyIn25, 502)
lsArmyIn26 = createObject(3015, 2380.1484, -1323.9254, 1018.5188, 0, 0, 0)     setElementInterior(lsArmyIn26, 2)  setElementDimension(lsArmyIn26, 502)
lsArmyIn27 = createObject(3015, 2380.8481, -1323.9258, 1018.5188, 0, 0, 0)     setElementInterior(lsArmyIn27, 2)  setElementDimension(lsArmyIn27, 502)
lsArmyIn28 = createObject(3015, 2380.8486, -1323.1613, 1018.5188, 0, 0, 0)     setElementInterior(lsArmyIn28, 2)  setElementDimension(lsArmyIn28, 502)
lsArmyIn29 = createObject(3015, 2380.1753, -1323.1611, 1018.5188, 0, 0, 0)     setElementInterior(lsArmyIn29, 2)  setElementDimension(lsArmyIn29, 502)
lsArmyIn30 = createObject(2969, 2375.5547, -1325.5494, 1018.6451, 0, 0, 0)     setElementInterior(lsArmyIn30, 2)  setElementDimension(lsArmyIn30, 502)
lsArmyIn31 = createObject(2969, 2375.5547, -1324.6787, 1018.6451, 0, 0, 0)     setElementInterior(lsArmyIn31, 2)  setElementDimension(lsArmyIn31, 502)
lsArmyIn32 = createObject(2969, 2375.5547, -1323.9786, 1018.6451, 0, 0, 0)     setElementInterior(lsArmyIn32, 2)  setElementDimension(lsArmyIn32, 502)
lsArmyIn33 = createObject(2969, 2375.5547, -1323.2216, 1018.6451, 0, 0, 0)     setElementInterior(lsArmyIn33, 2)  setElementDimension(lsArmyIn33, 502)
lsArmyIn34 = createObject(2969, 2375.5547, -1322.5179, 1018.6451, 0, 0, 0)     setElementInterior(lsArmyIn34, 2)  setElementDimension(lsArmyIn34, 502)
lsArmyIn35 = createObject(3795, 2372.5815, -1347.0088, 1018.8598, 0, 0, 0)     setElementInterior(lsArmyIn35, 2)  setElementDimension(lsArmyIn35, 502)
lsArmyIn36 = createObject(3795, 2376.2419, -1347.0088, 1018.8598, 0, 0, 0)     setElementInterior(lsArmyIn36, 2)  setElementDimension(lsArmyIn36, 502)
lsArmyIn37 = createObject(3791, 2379.7207, -1346.9961, 1018.9835, 0, 0, 0)     setElementInterior(lsArmyIn37, 2)  setElementDimension(lsArmyIn37, 502)
lsArmyIn38 = createObject(925, 2356.1152, -1342.1038, 1019.5807, 0, 0, 90)     setElementInterior(lsArmyIn38, 2)  setElementDimension(lsArmyIn38, 502)
lsArmyIn39 = createObject(925, 2356.1152, -1339.6837, 1019.5807, 0, 0, 90)     setElementInterior(lsArmyIn39, 2)  setElementDimension(lsArmyIn39, 502)
lsArmyIn40 = createObject(925, 2356.1077, -1337.2759, 1019.5807, 0, 0, 90)     setElementInterior(lsArmyIn40, 2)  setElementDimension(lsArmyIn40, 502)
lsArmyIn41 = createObject(2991, 2367.1931, -1342.5918, 1019.1465, 0, 0, 0)     setElementInterior(lsArmyIn41, 2)  setElementDimension(lsArmyIn41, 502)
lsArmyIn42 = createObject(2991, 2371.8306, -1342.5918, 1019.1465, 0, 0, 0)     setElementInterior(lsArmyIn42, 2)  setElementDimension(lsArmyIn42, 502)
lsArmyIn43 = createObject(2991, 2376.7649, -1342.5918, 1019.1465, 0, 0, 0)     setElementInterior(lsArmyIn43, 2)  setElementDimension(lsArmyIn43, 502)
lsArmyIn44 = createObject(2991, 2381.459, -1342.5918, 1019.1465, 0, 0, 0)      setElementInterior(lsArmyIn44, 2)  setElementDimension(lsArmyIn44, 502)
lsArmyIn45 = createObject(2991, 2396.741, -1346.9706, 1019.1465, 0, 0, 0)      setElementInterior(lsArmyIn45, 2)  setElementDimension(lsArmyIn45, 502)
lsArmyIn46 = createObject(2991, 2371.8914, -1339.8037, 1019.1465, 0, 0, 0)     setElementInterior(lsArmyIn46, 2)  setElementDimension(lsArmyIn46, 502)
lsArmyIn47 = createObject(2991, 2367.1362, -1339.8037, 1019.1465, 0, 0, 0)     setElementInterior(lsArmyIn47, 2)  setElementDimension(lsArmyIn47, 502)
lsArmyIn48 = createObject(2991, 2362.5215, -1339.8037, 1019.1465, 0, 0, 0)     setElementInterior(lsArmyIn48, 2)  setElementDimension(lsArmyIn48, 502)
lsArmyIn49 = createObject(964, 2363.4763, -1339.7393, 1019.7766, 0, 0, 180)    setElementInterior(lsArmyIn49, 2)  setElementDimension(lsArmyIn49, 502)
lsArmyIn50 = createObject(2567, 2389.2676, -1333.9287, 1020.4464, 0, 0, 270)   setElementInterior(lsArmyIn50, 2)  setElementDimension(lsArmyIn50, 502)
lsArmyIn51 = createObject(2567, 2400.6396, -1321.6309, 1020.4464, 0, 0, 180)   setElementInterior(lsArmyIn51, 2)  setElementDimension(lsArmyIn51, 502)
lsArmyIn52 = createObject(2567, 2394.3906, -1324.5214, 1020.4464, 0, 0, 180)   setElementInterior(lsArmyIn52, 2)  setElementDimension(lsArmyIn52, 502)
lsArmyIn53 = createObject(2991, 2381.459, -1339.8037, 1019.1465, 0, 0, 0)      setElementInterior(lsArmyIn53, 2)  setElementDimension(lsArmyIn53, 502)
lsArmyIn54 = createObject(2991, 2396.7412, -1346.9707, 1020.3862, 0, 0, 0)     setElementInterior(lsArmyIn54, 2)  setElementDimension(lsArmyIn54, 502)
lsArmyIn55 = createObject(2991, 2396.7412, -1346.9707, 1021.6295, 0, 0, 0)     setElementInterior(lsArmyIn55, 2)  setElementDimension(lsArmyIn55, 502)
lsArmyIn56 = createObject(3787, 2357.6162, -1347.0527, 1019.085, 0, 0, 0)      setElementInterior(lsArmyIn56, 2)  setElementDimension(lsArmyIn56, 502)
lsArmyIn57 = createObject(7294, 2403.2253, -1326.4224, 1031.7201, 0, 0, 90)    setElementInterior(lsArmyIn57, 2)  setElementDimension(lsArmyIn57, 502)
lsArmyIn58 = createObject(7294, 2403.2256, -1324.4055, 1031.7201, 0, 0, 90)    setElementInterior(lsArmyIn58, 2)  setElementDimension(lsArmyIn58, 502)
lsArmyIn59 = createObject(7294, 2403.2256, -1321.9857, 1031.7201, 0, 0, 90)    setElementInterior(lsArmyIn59, 2)  setElementDimension(lsArmyIn59, 502)
lsArmyIn60 = createObject(1663, 2393.4932, -1327.2996, 1025.3306, 0, 0, 210)   setElementInterior(lsArmyIn60, 2)  setElementDimension(lsArmyIn60, 502)
lsArmyIn61 = createObject(1663, 2393.4932, -1331.7734, 1025.3306, 0, 0, 210)   setElementInterior(lsArmyIn61, 2)  setElementDimension(lsArmyIn61, 502)
lsArmyIn62 = createObject(1663, 2393.4932, -1336.7915, 1025.3306, 0, 0, 210)   setElementInterior(lsArmyIn62, 2)  setElementDimension(lsArmyIn62, 502)
lsArmyIn63 = createObject(1499, 2403.4741, -1344.7249, 1024.8612, 0, 0, 270)   setElementInterior(lsArmyIn63, 2)  setElementDimension(lsArmyIn63, 502)  setElementFrozen(lsArmyIn63, true)
lsArmyIn64 = createObject(1499, 2398.8369, -1320.458, 1024.8704, 0, 0, 0)      setElementInterior(lsArmyIn64, 2)  setElementDimension(lsArmyIn64, 502)  setElementFrozen(lsArmyIn64, true)
lsArmyIn65 = createObject(1499, 2403.3545, -1325.5498, 1018.5188, 0, 0, 270)   setElementInterior(lsArmyIn65, 2)  setElementDimension(lsArmyIn65, 502)  setElementFrozen(lsArmyIn65, true)
lsArmyIn66 = createObject(1499, 2355.1111, -1336.0015, 1018.5095, 0, 0, 90)    setElementInterior(lsArmyIn66, 2)  setElementDimension(lsArmyIn66, 502)  setElementFrozen(lsArmyIn66, true)
lsArmyIn67 = createObject(1499, 2403.4941, -1347.7305, 1024.8612, 0, 0, 90)    setElementInterior(lsArmyIn67, 2)  setElementDimension(lsArmyIn67, 502)  setElementFrozen(lsArmyIn67, true)
lsArmyIn68 = createObject(1499, 2355.0999, -1332.9919, 1018.5095, 0, 0, 270)   setElementInterior(lsArmyIn68, 2)  setElementDimension(lsArmyIn68, 502)  setElementFrozen(lsArmyIn68, true)

lsArmyIn69 = createObject(3630, 2389.9155, -1324.5161, 1023.203, 0, 0, 90)     setElementInterior(lsArmyIn69, 2)  setElementDimension(lsArmyIn69, 502)  setObjectScale(lsArmyIn69, 0.83999997)
lsArmyIn70 = createObject(3630, 2385.9065, -1324.5156, 1023.203, 0, 0, 90)     setElementInterior(lsArmyIn70, 2)  setElementDimension(lsArmyIn70, 502)  setObjectScale(lsArmyIn70, 0.83999997)


lsArmyIn71 = createObject(3390, 2392.1284, -1326.5195, 1024.8704, 0, 0, 180)   setElementInterior(lsArmyIn71, 2)  setElementDimension(lsArmyIn71, 502)  setElementDoubleSided(lsArmyIn71, true)
lsArmyIn72 = createObject(3397, 2392.113, -1331.2698, 1024.8704, 0, 0, 180)    setElementInterior(lsArmyIn72, 2)  setElementDimension(lsArmyIn72, 502)  setElementDoubleSided(lsArmyIn72, true)
lsArmyIn73 = createObject(3396, 2392.1042, -1336.2018, 1024.8704, 0, 0, 180)   setElementInterior(lsArmyIn73, 2)  setElementDimension(lsArmyIn73, 502)  setElementDoubleSided(lsArmyIn73, true)
lsArmyIn74 = createObject(3384, 2392.2593, -1339.781, 1026.313, 0, 0, 270)     setElementInterior(lsArmyIn74, 2)  setElementDimension(lsArmyIn74, 502)  setElementDoubleSided(lsArmyIn74, true)
lsArmyIn75 = createObject(3384, 2398.0952, -1339.7812, 1026.313, 0, 0, 270)    setElementInterior(lsArmyIn75, 2)  setElementDimension(lsArmyIn75, 502)  setElementDoubleSided(lsArmyIn75, true)
-------------------------------------------------------------------------
-------------------------------------------------------------------------

marker = {"cylinder", 1.0, 225, 225, 225, 200}

army_ls_kaz = {
	{2729.539, -2451.474, 16.59, 0, 0},-----------------------Вход-----------
	{2355.8894, -1334.5009, 1018.5372, 2, 502},---------------Выход----------
	{2357.1558, -1334.5649, 1019.5188, 90, 2, 502},-----------Спавн внутри---
	{2730.939, -2451.474, 17.59, 180, 0, 0}-------------------Спавн снаружи--	
}

army_ls_gar = {
	{2402.748, -1326.29, 1018.5332, 2, 502},------------------Вход-----------
	{2352.8164, 2376.623, 1991.0834, 1, 501},-----------------Выход----------
	{2352.9036, 2378.4375, 1992.0759, 180, 1, 501},-----------Спавн внутри---
	{2401.4507, -1326.2914, 1019.5188, 270, 2, 502}-----------Спавн снаружи--	
}

army_ls_ammo = {
	{2399.5591, -1321.0428, 1024.8928, 2, 502},---------------Вход-----------
	{318.34863, -192.52441, 999.77271, 6, 502},---------------Выход----------
	{318.46875, -191.37695, 1000.7569, 0, 6, 502},------------Спавн внутри---
	{2399.4695, -1322.4314, 1025.8704, 180, 2, 502}-----------Спавн снаружи--	
}

addVhodVihod(army_ls_kaz, marker)
addVhodVihod(army_ls_gar, marker)
addVhodVihod(army_ls_ammo, marker)



--"mar rab_lvpd"         interior="3" posX="197.49998" posY="171.4959"   posZ="1002.0427"

--"pickup pereod_armyLS" interior="2" posX="2402.6547" posY="-1326.3773" posZ="1024.8982"
--"marker oruj_gos"      interior="6" posX="314.23053" posY="-188.63576" posZ="999.78418"
--"marker avto_gos"      interior="1" posX="2348.5078" posY="2378.9021"  posZ="1991.1016"