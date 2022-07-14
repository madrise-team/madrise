--createObject ( int modelId, float x, float y, float z, [ float rx, float ry, float rz, bool isLowLOD = false ] )
--setObjectScale(session.kirka, 0.8)
--setElementDoubleSided ( element theElement, bool enable )
--setElementInterior ( element theElement, int interior [, float x, float y, float z] )
--setElementDimension ( element theElement, int dimension )
--setObjectBreakable ( object theObject, bool breakable )


--Грузчик
--createObject (10245, 2199.304, -2277.2271, 9.0224, 0, 0, 0, false)
local rampaGruzchikaRaboty = createObject (1503, 2204.1697, -2282.5439, 12.46649, 0, 0, 225, false)
setObjectScale(rampaGruzchikaRaboty, 0.9)
--model="1503" scale="0.89999998"   posX="2204.1697" posY="-2282.5439" posZ="12.46649" rotZ="225"

--Пицца
createObject (1522, 2108.1484, -1822.2644, 12.51509, 0, 0, 0, false)

--Мусор
createObject (11292, -1905.3662, -1700.1035, 22.22044, 0, 0, 3, false)
createObject (1498, -1908.2817, -1701.8447, 20.97336, 0, 0, 3, false)

--Инкосы
createObject (987, 1370.2484, -1631.8077, 11.74329, 0, 0, 180, false)
createObject (987, 1382.2235, -1631.8077, 11.74329, 0, 0, 180, false)
createObject (987, 1347.1014, -1631.7697, 11.74329, 0, 0, 270, false)
createObject (987, 1347.1016, -1643.769, 11.74329, 0, 0, 270, false)
createObject (987, 1347.1016, -1651.0227, 11.74329, 0, 0, 270, false)
createObject (987, 1347.0575, -1662.8673, 11.74329, 0, 0, 0, false)
createObject (987, 1356.0303, -1662.8672, 11.74329, 0, 0, 0, false)
createObject (987, 1368.0183, -1662.8672, 11.74329, 0, 0, 0, false)
createObject (987, 1380.0474, -1662.9386, 11.74329, 0, 0, 270, false)
createObject (987, 1380.0479, -1674.9261, 11.74329, 0, 0, 270, false)
createObject (987, 1380.0479, -1686.9161, 11.74329, 0, 0, 270, false)
createObject (987, 1379.9723, -1698.6222, 11.74329, 0, 0, 0, false)
createObject (987, 1359.0255, -1631.8076, 11.74329, 0, 0, 180, false)

--pravayaVorotinaIkosaWorka = createObject (985, 1386.06372, -1653.32727, 14.08198, 0, 0, 270, false)
--levayaVorotinaIkosaWorka = createObject (986, 1386.05688, -1645.36707, 14.08435, 0, 0, 270, false)

createObject (4199, 1391.1362, -1682.7693, 14.49529, 0, 0, 180, false)

----- Столбы Элмонтажника
removeWorldModel                     (1307, 10, 1044.2891, -1362.6016, 12.78125)
removeWorldModel                     (1307, 10, 1044.375, -1250.9687, 14.49219)
removeWorldModel                     (1307, 10, 1092.2969, -1109.0234, 23.73438)
removeWorldModel                     (1307, 10, 1958.2356, -1037.7708, 32.73583)
removeWorldModel                     (1307, 10, 2385.9719, -1511.8489, 25.62191)
removeWorldModel                     (1307, 10, 2331.3098, -1742.1481, 15.45748)
removeWorldModel                     (1307, 10, 2263.4033, -1741.6495, 21.19765)
removeWorldModel                     (1307, 10, 2779.8672, -1939.7578, 12.28906)
removeWorldModel                     (1307, 10, 885.88281, -861.5625, 77.76563)
removeWorldModel                     (1307, 10, 984.67188, -798.23437, 98.74219)
removeWorldModel                     (1307, 10, -2820.6641, -162.83594, 5.89063)
removeWorldModel                     (1307, 10, -2820.6641, -61.60156, 5.89063)
removeWorldModel                     (1307, 10, -2820.6641, 39.63281, 5.89063)
removeWorldModel                     (1307, 10, -2820.6641, 140.875, 5.89063)
removeWorldModel                     (1307, 10, -2820.6641, 242.10938, 5.89063)
removeWorldModel                     (1307, 10, -2843.5625, 395.875, 1.47656)
removeWorldModel                     (1308, 10, 1070.4219, -1029.5234, 29.96875)
removeWorldModel                     (1308, 10, 1861.7891, -1251.0078, 12.70313)
removeWorldModel                     (1308, 10, 2166.3203, -1127.9453, 23.86719)
removeWorldModel                     (1308, 10, 2250.5469, -1151.4844, 24.51563)
removeWorldModel                     (1308, 10, 2478.6563, -1136.4879, 43.68336)
removeWorldModel                     (1308, 10, 2540.229, -1194.1969, 64.96092)
removeWorldModel                     (1308, 10, 2491.6738, -1516.8757, 27.91045)
removeWorldModel                     (1308, 10, 2332.9502, -1516.9469, 27.37383)
removeWorldModel                     (1308, 10, 2229.875, -1904.125, 12.60156)
removeWorldModel                     (1308, 10, 2322.0625, -1884.6875, 12.82813)
removeWorldModel                     (1308, 10, 2316.7266, -1982.0156, 11.51563)
removeWorldModel                     (1308, 10, 2424.0938, -1999.4219, 12.70313)
removeWorldModel                     (1308, 10, 2496.2891, -1942.1172, 11.51563)
removeWorldModel                     (1308, 10, 2091.1641, -1826.8359, 12.70313)
removeWorldModel                     (1308, 10, 2003.0859, -1922.5, 11.51563)
removeWorldModel                     (1308, 10, 1951.9531, -1993.0156, 11.51563)
removeWorldModel                     (1308, 10, 1951.8359, -2095.625, 12.75)
removeWorldModel                     (1308, 10, 1951.6172, -2156.4844, 12.75)
removeWorldModel                     (1308, 10, 2056.8281, -2224.1641, 12.75)
removeWorldModel                     (1308, 10, 399.02808, -1334.3484, 16.98646)
removeWorldModel                     (1308, 10, 510.47562, -1290.67, 19.49526)
removeWorldModel                     (1308, 10, 521.0625, -1212.1641, 43.29688)
removeWorldModel                     (1308, 10, 603.00781, -1173.8281, 44.65625)
removeWorldModel                     (1308, 10, 694.38281, -1009.9453, 50.4375)
removeWorldModel                     (1308, 10, 1836.75, -1271.0078, 12.6875)
removeWorldModel                     (1308, 10, 2440.3721, -1242.7985, 26.2945)
removeWorldModel                     (1308, 10, 2091.75, -1716.8594, 12.78125)
removeWorldModel                     (1308, 10, 1853.1328, -2062.4062, 12.59375)
removeWorldModel                     (1308, 10, 1951.6172, -1824.0234, 12.70313)
removeWorldModel                     (1308, 10, -2311.8359, -80.07031, 34.625)
removeWorldModel                     (1308, 10, -2414.3203, -195.65625, 34.625)
removeWorldModel                     (1308, 10, -2531.9766, -220.24219, 18.35938)
removeWorldModel                     (1308, 10, -2619.7344, -220.24219, 3.64063)
removeWorldModel                     (1308, 10, -2759.6016, -128.72656, 6.10938)
removeWorldModel                     (1308, 10, -2754.2109, -60.14844, 6.10938)
removeWorldModel                     (1308, 10, -2766.4375, 80.03906, 6.10938)
removeWorldModel                     (1308, 10, -2696.6641, -13.38281, 3.64063)
removeWorldModel                     (1308, 10, -2696.6719, -116.89062, 3.64063)
removeWorldModel                     (1308, 10, -2696.5078, 147.74219, 3.64063)
removeWorldModel                     (1308, 10, -2668.5625, 207.78906, 3.64063)
removeWorldModel                     (1308, 10, -2656.5156, 270.92188, 3.64063)
removeWorldModel                     (1308, 10, -2663.7891, 167.57813, 3.64063)
removeWorldModel                     (1308, 10, -2634.2891, 147.78906, 3.64063)
removeWorldModel                     (1308, 10, -2650.8359, 94.96094, 3.25)
removeWorldModel                     (1308, 10, -2653.005, -151.95312, 3.25)
removeWorldModel                     (1308, 10, -2594.1797, -140.46094, 3.49219)
removeWorldModel                     (1308, 10, -2613.4141, -100.45312, 3.64063)
removeWorldModel                     (1308, 10, -2613.4219, 58.72656, 3.64063)
removeWorldModel                     (1308, 10, -2585.5234, 214.38281, 8.84375)
removeWorldModel                     (1308, 10, -2411.0469, -80.25781, 34.625)
removeWorldModel                     (1308, 10, -2411.2109, 69.5625, 34.47656)
removeWorldModel                     (1308, 10, -2409.8516, 169.58594, 34.47656)
removeWorldModel                     (3875, 10, -1588.9531, 1205.9141, 13.625)
removeWorldModel                     (3875, 10, -1562.9062, 1080.0938, 13.53125)
removeWorldModel                     (3875, 10, -1569.3125, 943.03125, 13.35938)
removeWorldModel                     (3875, 10, -1548.0469, 902.36719, 13.66406)
removeWorldModel                     (3875, 10, -1548.0469, 824.59375, 13.66406)
removeWorldModel                     (3875, 10, -1570.875, 743.30469, 13.53125)
removeWorldModel                     (3875, 10, -1551.3906, 667.15625, 13.57031)
removeWorldModel                     (3875, 10, -1913.9375, 862.22656, 42.10156)
removeWorldModel                     (3875, 10, -1914.6406, 939.41406, 41.78125)
removeWorldModel                     (3875, 10, -1726.6328, 828.57813, 31.22656)
removeWorldModel                     (3875, 10, -1573.6641, 869.22656, 13.61719)
removeWorldModel                     (3459, 10, 2697.1172, 757.9375, 17.32031)
removeWorldModel                     (3459, 10, 2672.4219, 683.46094, 17.32031)
removeWorldModel                     (3459, 10, 2521.8906, 683.5, 17.32031)
removeWorldModel                     (3459, 10, 2497.6328, 733.53906, 17.32031)
removeWorldModel                     (3459, 10, 2397.4453, 722.99219, 17.29688)
removeWorldModel                     (3459, 10, 2244.3125, 722.99219, 17.29688)
removeWorldModel                     (3459, 10, 2117.3984, 663.53906, 17.29688)
removeWorldModel                     (3459, 10, 2000.6016, 663.53906, 17.29688)
removeWorldModel                     (3459, 10, 1958.5, 623.94531, 17.29688)
removeWorldModel                     (3459, 10, 1875.1641, 623.94531, 17.29688)
removeWorldModel                     (3459, 10, 2418.3672, 959.70313, 17.32031)
removeWorldModel                     (3459, 10, 2417.6406, 1040.2031, 17.32031)
removeWorldModel                     (3459, 10, 2537.1719, 1023.4531, 17.32031)
removeWorldModel                     (3459, 10, 2617.1406, 1104.2656, 17.32031)
removeWorldModel                     (3459, 10, 2617.1641, 1227.0703, 17.32031)
removeWorldModel                     (3459, 10, 2533.1094, 1207.0234, 17.32031)
removeWorldModel                     (3459, 10, 2418.2344, 1241.3047, 17.32031)
removeWorldModel                     (3459, 10, 2336.1563, 1381.4844, 17.32031)
removeWorldModel                     (3459, 10, 2631.4141, 1377.1328, 17.32031)
removeWorldModel                     (3459, 10, 2376.9063, 1482.4141, 17.32031)
removeWorldModel                     (3459, 10, 2534.25, 1482.9766, 17.32031)
removeWorldModel                     (3459, 10, 2517.4688, 1943.4063, 17.32031)
removeWorldModel                     (3459, 10, 2565.5547, 2101.7109, 17.32031)
removeWorldModel                     (3459, 10, 2855.9063, 2033.0938, 17.32031)
removeWorldModel                     (3459, 10, 2841.0703, 2082.7344, 17.32031)
removeWorldModel                     (3459, 10, 2838.8594, 2302.625, 17.32031)
removeWorldModel                     (3459, 10, 1140.4844, 2043.8203, 17.32031)
removeWorldModel                     (3459, 10, 1017.0156, 2025.7578, 17.32031)
removeWorldModel                     (3459, 10, 1016.7578, 1915.1797, 17.32031)
removeWorldModel                     (3459, 10, 1016.7578, 1798.6953, 17.32031)
removeWorldModel                     (3459, 10, 1453.4531, 1983.0391, 17.32031)
removeWorldModel                     (3459, 10, 1633.6875, 2026.0625, 17.32031)
removeWorldModel                     (3459, 10, 1685.1953, 2263.6875, 17.32031)
removeWorldModel                     (3459, 10, 1717.1016, 1863.4219, 17.32031)
removeWorldModel                     (3459, 10, 1852.2422, 2263.8594, 17.32031)
removeWorldModel                     (3459, 10, 2037.6797, 2444.4375, 17.32031)
removeWorldModel                     (3459, 10, 2148.2578, 2446.6563, 17.32031)
removeWorldModel                     (3459, 10, 2280.0781, 2521.5859, 17.32031)
removeWorldModel                     (3459, 10, 2575.9453, 2064.1641, 17.32031)
removeWorldModel                     (3459, 10, 1497.5938, 1884.1797, 17.32031)

stolbi = {}
table.insert(stolbi, createObject    (1307, 1045.0012, -1361.9214, 12.38281, 0, 0, 170, false))
table.insert(stolbi, createObject    (1307, 1044.5486, -1251.0339, 14.26539, 0, 0, 170, false))
table.insert(stolbi, createObject    (1307, 1092.1595, -1109.0732, 23.51329, 0, 0, 0, false))
table.insert(stolbi, createObject    (1307, 1958.7371, -1036.9729, 23.30968, 0, 0, 90, false))
table.insert(stolbi, createObject    (1307, 2385.6047, -1511.5948, 23.005, 0, 0, 180, false))
table.insert(stolbi, createObject    (1307, 2330.2976, -1741.5137, 12.54688, 0, 0, 270, false))
table.insert(stolbi, createObject    (1307, 2262.6992, -1741.0435, 12.54688, 0, 0, 270, false))
table.insert(stolbi, createObject    (1307, 2779.709, -1939.7499, 12.54688, 0, 0, 90, false))
table.insert(stolbi, createObject    (1307, 886.52271, -862.89221, 77.39453, 0, 0, 290, false))
table.insert(stolbi, createObject    (1307, 985.23907, -798.12683, 98.19103, 0, 0, 90, false))
table.insert(stolbi, createObject    (1307, -2820.8711, -162.67122, 6.50638, 0, 0, 180, false))
table.insert(stolbi, createObject    (1307, -2820.7637, -61.66135, 6.25869, 0, 0, 180, false))
table.insert(stolbi, createObject    (1307, -2820.8838, 39.74148, 6.42277, 0, 0, 180, false))
table.insert(stolbi, createObject    (1307, -2820.7344, 140.66728, 6.83285, 0, 0, 180, false))
table.insert(stolbi, createObject    (1307, -2820.782, 242.03271, 6.50849, 0, 0, 180, false))
table.insert(stolbi, createObject    (1307, -2843.4446, 395.89279, 3.5, 0, 0, 1, false))
table.insert(stolbi, createObject    (1308, 1070.1797, -1029.6465, 31.10156, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, 1862.0305, -1250.7744, 12.57363, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, 2166.1558, -1127.9821, 24.60156, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, 2250.4954, -1151.4984, 25.41387, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, 2478.9851, -1136.5975, 37.19105, 0, 0, 270, false))
table.insert(stolbi, createObject    (1308, 2540.1741, -1194.3911, 58.7944, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, 2491.6455, -1517.4763, 22.99219, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, 2332.8157, -1516.9161, 22.99221, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, 2229.8867, -1904.1359, 12.54688, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, 2322.2429, -1884.7382, 12.61582, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, 2316.7327, -1982.1569, 12.56548, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, 2424.1433, -1999.5016, 12.54688, 0, 0, 90, false))
table.insert(stolbi, createObject    (1308, 2496.1938, -1942.0538, 12.54688, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, 2091.1077, -1826.8854, 12.55454, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, 2003.1035, -1922.4891, 12.54688, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, 1951.849, -1992.7051, 12.54688, 0, 0, 90, false))
table.insert(stolbi, createObject    (1308, 1951.842, -2095.3743, 12.54688, 0, 0, 90, false))
table.insert(stolbi, createObject    (1308, 1950.8922, -2156.9692, 12.55421, 0, 0, 90, false))
table.insert(stolbi, createObject    (1308, 2056.8738, -2223.9458, 12.54688, 0, 0, 90, false))
table.insert(stolbi, createObject    (1308, 398.98886, -1334.2234, 13.7918, 0, 0, 30, false))
table.insert(stolbi, createObject    (1308, 510.55106, -1290.6743, 14.98077, 0, 0, 220, false))
table.insert(stolbi, createObject    (1308, 521.02399, -1212.2018, 43.18028, 0, 0, 215, false))
table.insert(stolbi, createObject    (1308, 602.89063, -1173.9445, 44.63884, 0, 0, 220, false))
table.insert(stolbi, createObject    (1308, 693.07697, -1009.2232, 51.21121, 0, 0, 60, false))
table.insert(stolbi, createObject    (1308, 1836.7701, -1270.8345, 12.57381, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, 2439.6809, -1242.2614, 23.36387, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, 2091.865, -1716.7992, 12.55694, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, 1853.9357, -2061.6782, 12.54688, 0, 0, 270, false))
table.insert(stolbi, createObject    (1308, 1951.6455, -1824.0505, 12.54688, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, -2311.9019, -80.04093, 34.32031, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2414.2207, -195.59262, 34.32031, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2531.9778, -220.15233, 18.05935, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2619.7354, -219.99847, 3.33594, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2759.325, -128.78148, 6.00185, 0, 0, 358, false))
table.insert(stolbi, createObject    (1308, -2754.2612, -60.16729, 6.03906, 0, 0, 2, false))
table.insert(stolbi, createObject    (1308, -2766.2751, 80.03165, 6.00891, 0, 0, 2, false))
table.insert(stolbi, createObject    (1308, -2696.6282, -13.51601, 3.33594, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2696.6433, -116.85427, 3.33594, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, -2696.5271, 147.73801, 3.32813, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2668.71, 207.8784, 3.32813, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2656.3738, 270.56091, 3.32813, 0, 0, 90, false))
table.insert(stolbi, createObject    (1308, -2663.9062, 167.48724, 3.32812, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, -2634.5288, 147.96715, 3.33544, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2650.9973, 94.87116, 3.14346, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2653.1621, -151.72699, 3.15543, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, -2594.2554, -140.51709, 3.2546, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2613.5505, -100.43871, 3.33594, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2613.4937, 58.74921, 3.33594, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, -2585.5774, 214.30913, 8.48771, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2411.0195, -80.47544, 34.32031, 0, 0, 180, false))
table.insert(stolbi, createObject    (1308, -2411.1392, 69.5423, 34.16406, 0, 0, 0, false))
table.insert(stolbi, createObject    (1308, -2409.8542, 169.60548, 34.16445, 0, 0, 0, false))
table.insert(stolbi, createObject    (3875, -1588.8619, 1205.6373, 13.6943, 0, 0, 18, false))
table.insert(stolbi, createObject    (3875, -1562.7551, 1080.1377, 13.68562, 0, 0, 0, false))
table.insert(stolbi, createObject    (3875, -1569.358, 943.08862, 13.68562, 0, 0, 180, false))
table.insert(stolbi, createObject    (3875, -1547.9778, 902.52557, 13.76374, 0, 0, 0, false))
table.insert(stolbi, createObject    (3875, -1547.9814, 824.40332, 13.76374, 0, 0, 0, false))
table.insert(stolbi, createObject    (3875, -1570.8691, 743.35608, 13.68562, 0, 0, 180, false))
table.insert(stolbi, createObject    (3875, -1551.4016, 667.10376, 13.68562, 0, 0, 180, false))
table.insert(stolbi, createObject    (3875, -1913.7703, 862.11005, 41.7853, 0, 0, 90, false))
table.insert(stolbi, createObject    (3875, -1914.5344, 939.35095, 41.8956, 0, 0, 270, false))
table.insert(stolbi, createObject    (3875, -1726.5245, 828.56854, 31.38093, 0, 0, 270, false))
table.insert(stolbi, createObject    (3875, -1573.4792, 869.16138, 14.08993, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 2697.1768, 757.87946, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 2672.4243, 683.41492, 17.31843, 0, 0, 315, false))
table.insert(stolbi, createObject    (3459, 2521.948, 683.53503, 17.31843, 0, 0, 135, false))
table.insert(stolbi, createObject    (3459, 2497.6128, 733.46155, 17.31843, 0, 0, 180, false))
table.insert(stolbi, createObject    (3459, 2397.4575, 723.04578, 17.31843, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 2244.1875, 722.89063, 17.31843, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 2117.4746, 663.63647, 17.31843, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 2000.5265, 663.19159, 17.31843, 0, 0, 333, false))
table.insert(stolbi, createObject    (3459, 1958.6677, 623.83972, 17.31843, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 1875.0597, 623.90613, 17.31063, 0, 0, 218, false))
table.insert(stolbi, createObject    (3459, 2418.3354, 959.75391, 17.31063, 0, 0, 180, false))
table.insert(stolbi, createObject    (3459, 2417.6016, 1040.2434, 17.31843, 0, 0, 180, false))
table.insert(stolbi, createObject    (3459, 2537.1553, 1023.3827, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 2617.1187, 1104.2028, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 2617.1216, 1226.8973, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 2533.0205, 1207.0305, 17.31843, 0, 0, 180, false))
table.insert(stolbi, createObject    (3459, 2418.4092, 1241.3695, 17.31843, 0, 0, 180, false))
table.insert(stolbi, createObject    (3459, 2336.0632, 1381.5524, 17.31843, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 2631.3286, 1377.2465, 17.31843, 0, 0, 58, false))
table.insert(stolbi, createObject    (3459, 2376.8113, 1482.5261, 17.31843, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 2534.3013, 1482.9655, 17.31843, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 2517.417, 1943.5099, 17.31843, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 2565.3787, 2101.7048, 17.59968, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 2856.0559, 2033.0547, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 2841.1191, 2082.7861, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 2838.8352, 2302.6208, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 1140.4382, 2043.7917, 17.31843, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 1017.0604, 2025.8136, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 1016.7834, 1915.219, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 1016.8333, 1798.5972, 17.31843, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 1453.5602, 1983.016, 17.31843, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 1633.6744, 2024.6259, 17.43057, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 1685.0389, 2263.6877, 17.31843, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 1717.0637, 1863.5068, 17.95097, 0, 0, 0, false))
table.insert(stolbi, createObject    (3459, 1852.1675, 2263.7949, 17.47936, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 2037.6898, 2444.4099, 17.31843, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 2148.2615, 2446.6382, 17.31843, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 2280.1914, 2521.5884, 17.31843, 0, 0, 90, false))
table.insert(stolbi, createObject    (3459, 2575.9717, 2064.2273, 17.31843, 0, 0, 270, false))
table.insert(stolbi, createObject    (3459, 1497.6238, 1884.1865, 17.3509, 0, 0, 90, false))

--1307 22.6
--1308 14.4
--3459 17.15
--3875 16


function getElMontajStolbi()
	return stolbi
end


























--Банк 
function spawnBanks(dimension)
local corpusBanka1 = createObject (14858, 180.50586, 133.97641, 992.35681, 0, 0, 0, false) --int="3" doublesided="true"
setElementInterior (corpusBanka1, 3)
setElementDoubleSided (corpusBanka1, true)
setElementDimension(corpusBanka1, dimension)
local corpusBanka2 = createObject (14858, 188.62242, 125.30473, 992.35681, 0, 0, 270, false) --int="3" doublesided="true"
setElementInterior (corpusBanka2, 3)
setElementDoubleSided (corpusBanka2, true)
setElementDimension(corpusBanka2, dimension)
local reshetkaBanka1 = createObject (14843, 157.79446, 127.68787, 988.62775, 0, 0, 90, false) --int="3" scale="1.15"
setElementInterior (reshetkaBanka1, 3)
setObjectScale(reshetkaBanka1, 1.15)
setElementDimension(reshetkaBanka1, dimension)
local zaReshetkaBanka1 = createObject (1649, 157.66019, 123.55991, 988.76074, 0, 0, 270, false) --int="3" breakable="false"
setElementInterior (zaReshetkaBanka1, 3)
setObjectBreakable (zaReshetkaBanka1, false)
setElementDimension(zaReshetkaBanka1, dimension)
end

for i=60,62 do
	spawnBanks(i)	
end

--Банкоматы
local bankomat1  = createObject (2942, 1810.7738, -1876.8755, 13.22667, 0, 0, 90, false)     setObjectBreakable(bankomat1, false)
local bankomat2  = createObject (2942, 2106.4626, -1790.7151, 13.20375, 0, 0, 180, false)    setObjectBreakable(bankomat2, false)
local bankomat3  = createObject (2942, 1172.0609, -1328.3214, 15.04501, 0, 0, 90, false)     setObjectBreakable(bankomat3, false)
local bankomat4  = createObject (2942, 809.21277, -1627.0999, 13.02571, 0, 0, 0, false)      setObjectBreakable(bankomat4, false)
local bankomat5  = createObject (2942, 456.79239, -1486.5398, 30.7116, 0, 0, 288, false)     setObjectBreakable(bankomat5, false)
local bankomat6  = createObject (2942, 387.20917, -1819.4468, 7.476, 0, 0, 270, false)       setObjectBreakable(bankomat6, false)
local bankomat7  = createObject (2942, 1012.1252, -928.9527, 41.97102, 0, 0, 8, false)       setObjectBreakable(bankomat7, false)
local bankomat8  = createObject (2942, 565.5979, -1293.9883, 16.89114, 0, 0, 180, false)     setObjectBreakable(bankomat8, false)
local bankomat9  = createObject (2942, 2233.2847, -1161.9957, 25.53352, 0, 0, 270, false)    setObjectBreakable(bankomat9, false)
local bankomat10 = createObject (2942, 1111.9341, -1804.1937, 16.23665, 0, 0, 270, false)    setObjectBreakable(bankomat10, false)
local bankomat11 = createObject (2942, -1934.335, -869.39246, 31.86946, 0, 0, 90, false)     setObjectBreakable(bankomat11, false)
local bankomat12 = createObject (2942, -2674.6514, 259.93521, 4.27571, 0, 0, 180, false)     setObjectBreakable(bankomat12, false)
local bankomat13 = createObject (2942, -1980.6024, 134.46049, 27.3304, 0, 0, 270, false)     setObjectBreakable(bankomat13, false)
local bankomat14 = createObject (2942, -1696.5206, 953.62616, 24.53352, 0, 0, 315, false)    setObjectBreakable(bankomat14, false)
local bankomat15 = createObject (2942, -2420.1562, 987.52881, 44.93977, 0, 0, 90, false)     setObjectBreakable(bankomat15, false)
local bankomat16 = createObject (2942, -2670.9177, 636.39935, 14.09603, 0, 0, 90, false)     setObjectBreakable(bankomat16, false)
local bankomat17 = createObject (2942, -1642.0093, 1207.6759, 6.82259, 0, 0, 135, false)     setObjectBreakable(bankomat17, false)
local bankomat18 = createObject (2942, -1694.5989, 413.74347, 6.82259, 0, 0, 45, false)      setObjectBreakable(bankomat18, false)
local bankomat19 = createObject (2942, -2025.1102, -102.0574, 34.80696, 0, 0, 180, false)    setObjectBreakable(bankomat19, false)
local bankomat20 = createObject (2942, -2620.9819, 1415.158, 6.73665, 0, 0, 70, false)       setObjectBreakable(bankomat20, false)
local bankomat21 = createObject (2942, 2108.5615, 896.75323, 10.82259, 0, 0, 180, false)     setObjectBreakable(bankomat21, false)
local bankomat22 = createObject (2942, 1956.2568, 2041.8752, 10.7039, 0, 0, 0, false)        setObjectBreakable(bankomat22, false)
local bankomat23 = createObject (2942, 2187.6982, 2478.8291, 10.88509, 0, 0, 90, false)      setObjectBreakable(bankomat23, false)
local bankomat24 = createObject (2942, 1146.787, 2075.1511, 10.7054, 0, 0, 0, false)         setObjectBreakable(bankomat24, false)
local bankomat25 = createObject (2942, 2141.0601, 2733.8459, 10.81925, 0, 0, 180, false)     setObjectBreakable(bankomat25, false)
local bankomat26 = createObject (2942, 1601.986, 2227.4482, 10.7054, 0, 0, 0, false)         setObjectBreakable(bankomat26, false)
local bankomat27 = createObject (2942, 2467.7671, 2032.1564, 10.7054, 0, 0, 270, false)      setObjectBreakable(bankomat27, false)
local bankomat28 = createObject (2942, 2830.6448, 2403.0273, 10.7054, 0, 0, 315, false)      setObjectBreakable(bankomat28, false)
local bankomat29 = createObject (2942, 2649.5955, 1129.6785, 10.82259, 0, 0, 0, false)       setObjectBreakable(bankomat29, false)
local bankomat30 = createObject (2942, 1626.782, 1814.4011, 10.46321, 0, 0, 180, false)      setObjectBreakable(bankomat30, false)
local bankomat31 = createObject (2942, 2334.2827, 57.6267, 26.12629, 0, 0, 90, false)        setObjectBreakable(bankomat31, false)
local bankomat32 = createObject (2942, 1380.5818, 259.76767, 19.20983, 0, 0, 156, false)     setObjectBreakable(bankomat32, false)
local bankomat33 = createObject (2942, 192.47028, -188.40575, 1.22102, 0, 0, 270, false)     setObjectBreakable(bankomat33, false)
local bankomat34 = createObject (2942, -2169.3289, -2409.2654, 30.2679, 0, 0, 142, false)    setObjectBreakable(bankomat34, false)
local bankomat35 = createObject (2942, -2511.929, 2340.8066, 4.62727, 0, 0, 0, false)        setObjectBreakable(bankomat35, false)
local bankomat36 = createObject (2942, -1505.5959, 2611.8164, 55.47884, 0, 0, 90, false)     setObjectBreakable(bankomat36, false)
local bankomat37 = createObject (2942, -80.80491, 1187.1248, 19.29967, 0, 0, 90, false)      setObjectBreakable(bankomat37, false)












