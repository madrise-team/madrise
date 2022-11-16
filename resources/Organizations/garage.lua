--setElementInterior ( element theElement, int interior [, float x, float y, float z] )					 --
--setElementDimension ( element theElement, int dimension )					 --
--setObjectScale(session.kirka, 0.8)					 --
					 --
function spawnGarages()					 --
function spawnGosPark(dimension)					 --
	gosPark1 = createObject(7244, 2339.3398, 2416.2861, 2000, 0, 0, 0)       setElementInterior(gosPark1, 1) setObjectScale(gosPark1, 1.0)  setElementDimension(gosPark1, dimension)					 --
	gosPark2 = createObject(3037, 2321.6416, 2450.9668, 2003.7334, 0, 0, 0)  setElementInterior(gosPark2, 1) setObjectScale(gosPark2, 1.01) setElementDimension(gosPark2, dimension) 					 --
	gosPark3 = createObject(3037, 2321.6416, 2450.9668, 2008.1848, 0, 0, 0)  setElementInterior(gosPark3, 1) setObjectScale(gosPark3, 1.01) setElementDimension(gosPark3, dimension)					 --
	gosPark4 = createObject(8947, 2345.2871, 2411.2109, 1993.9199, 0, 0, 90) setElementInterior(gosPark4, 1) setObjectScale(gosPark4, 1.21) setElementDimension(gosPark4, dimension)					 --
end					 --
					 --
					 --
function spawnCrimePark(dimension)					 --
	crimePark1 = createObject(6387, 2352.1426, 2412.5498, 2028.7963, 0, 0, 0)    setElementInterior(crimePark1, 1) setObjectScale(crimePark1, 1.0)  setElementDimension(crimePark1, dimension)					 --
	crimePark2 = createObject(6387, 2370.2813, 2369.8848, 2028.7998, 0, 0, 90)  setElementInterior(crimePark2, 1) setObjectScale(crimePark2, 1.0)  setElementDimension(crimePark2, dimension)  setElementDoubleSided(crimePark2, true) 					 --
	crimePark3 = createObject(6387, 2370.3564, 2369.877, 2028.071, 0, 0, 90)    setElementInterior(crimePark3, 1) setObjectScale(crimePark3, 1.0)  setElementDimension(crimePark3, dimension)  setElementDoubleSided(crimePark3, true)					 --
	crimePark4 = createObject(3037, 2354.9355, 2445.5234, 2027.3879, 0, 0, 90)  setElementInterior(crimePark4, 1) setObjectScale(crimePark4, 1.01) setElementDimension(crimePark4, dimension)					 --
	crimePark5 = createObject(3037, 2354.9355, 2445.5244, 2031.8407, 0, 0, 90)  setElementInterior(crimePark5, 1) setObjectScale(crimePark5, 1.01) setElementDimension(crimePark5, dimension)					 --
	crimePark6 = createObject(1497, 2368.667, 2397.9824, 2025.5596, 0, 0, 90)   setElementInterior(crimePark6, 1) setObjectScale(crimePark6, 1.0)  setElementDimension(crimePark6, dimension)					 --
end					 --
					 --
					 --
function spawnGosAmmo(dimension)					 --
	gosAmmo1 = createObject(18065, 300.36795, -186.8632, 1001.9913, 0, 0,  0)    setElementInterior(gosAmmo1, 6)   setElementDimension(gosAmmo1, dimension)					 --
	gosAmmo2 = createObject(18064, 304.83942, -187.07899, 1001.7151, 0, 0, 0)    setElementInterior(gosAmmo2, 6)   setElementDimension(gosAmmo2, dimension) 					 --
	gosAmmo3 = createObject(18105, 315.0433, -186.06364, 1001.6763, 0, 0,  0)    setElementInterior(gosAmmo3, 6)   setElementDimension(gosAmmo3, dimension)					 --
	gosAmmo4 = createObject(2358, 308.85272, -192.32407, 999.88068, 0, 0,  177)  setElementInterior(gosAmmo4, 6)   setElementDimension(gosAmmo4, dimension)					 --
	gosAmmo5 = createObject(2358, 309.69885, -192.32422, 999.88068, 0, 0,  177)  setElementInterior(gosAmmo5, 6)   setElementDimension(gosAmmo5, dimension)					 --
	gosAmmo6 = createObject(2358, 310.64914, -192.32422, 999.88068, 0, 0,  177)  setElementInterior(gosAmmo6, 6)   setElementDimension(gosAmmo6, dimension) 					 --
	gosAmmo7 = createObject(2358, 311.49081, -192.32422, 999.88068, 0, 0,  177)  setElementInterior(gosAmmo7, 6)   setElementDimension(gosAmmo7, dimension)					 --
	gosAmmo8 = createObject(2358, 311.49121, -192.32422, 1000.1159, 0, 0,  177)  setElementInterior(gosAmmo8, 6)   setElementDimension(gosAmmo8, dimension)					 --
	gosAmmo9 = createObject(2358, 310.63651, -192.32422, 1000.1159, 0, 0,  177)  setElementInterior(gosAmmo9, 6)   setElementDimension(gosAmmo9, dimension)					 --
	gosAmmo10 = createObject(2358, 309.6994, -192.32422, 1000.1159, 0, 0,  177)  setElementInterior(gosAmmo10, 6)  setElementDimension(gosAmmo10, dimension) 					 --
	gosAmmo11 = createObject(2358, 308.862, -192.32422, 1000.1159, 0, 0,   177)  setElementInterior(gosAmmo11, 6)  setElementDimension(gosAmmo11, dimension)					 --
	gosAmmo12 = createObject(2358, 308.8623, -192.32422, 1000.3497, 0, 0,  177)  setElementInterior(gosAmmo12, 6)  setElementDimension(gosAmmo12, dimension)					 --
	gosAmmo13 = createObject(2358, 309.70441, -192.32422, 1000.3497, 0, 0, 177)  setElementInterior(gosAmmo13, 6)  setElementDimension(gosAmmo13, dimension)					 --
	gosAmmo14 = createObject(2358, 310.63791, -192.32422, 1000.3497, 0, 0, 177)  setElementInterior(gosAmmo14, 6)  setElementDimension(gosAmmo14, dimension) 					 --
	gosAmmo15 = createObject(2358, 311.48889, -192.32422, 1000.3497, 0, 0, 177)  setElementInterior(gosAmmo15, 6)  setElementDimension(gosAmmo15, dimension)					 --
	gosAmmo16 = createObject(3089, 317.66257, -193.15718, 1001.0859, 0, 0, 0)    setElementInterior(gosAmmo16, 6)  setElementDimension(gosAmmo16, dimension)					 --
end					 --
					 --
					 --
function spawnCrimeStorage(dimension)					 --
	crimeStorage1 = createObject(3089, 2577.2688, -1301.8907, 1061.3134, 0, 0, 90)  setElementInterior(crimeStorage1, 2) setElementDimension(crimeStorage1, dimension)					 --
	crimeStorage2 = createObject(3089, 2577.2727, -1298.9027, 1061.3134, 0, 0, 270) setElementInterior(crimeStorage2, 2) setElementDimension(crimeStorage2, dimension)					 --
	removeWorldModel(14449, 1000, 2567.6172, -1294.6328, 1061.25)   					 --
end					 --
					 --
					 --
function spawnBandStorage(dimension)					 --
	bandStorage1  = createObject(3037, 2214.8591, 1585.1136, 1001.175, 0, 0, 0)   setElementInterior(bandStorage1, 1)   setObjectScale(bandStorage1, 1.0)   setElementDimension(bandStorage1, dimension)					 --
	bandStorage2  = createObject(3037, 2220.2803, 1572.6139, 1001.469, 0, 0, 90)  setElementInterior(bandStorage2, 1)   setObjectScale(bandStorage2, 1.2)   setElementDimension(bandStorage2, dimension)					 --
	bandStorage3  = createObject(3089, 2223.5879, 1598.223, 1000.3055, 0, 0, 0)   setElementInterior(bandStorage3, 1)   setObjectScale(bandStorage3, 1.0)   setElementDimension(bandStorage3, dimension)					 --
	bandStorage4  = createObject(1649, 2224.4456, 1598.2095, 1000.6423, 0, 0, 0)  setElementInterior(bandStorage4, 1)   setObjectScale(bandStorage4, 1.0)   setElementDimension(bandStorage4, dimension)					 --
	bandStorage5  = createObject(1649, 2224.4453, 1598.21, 1000.6423, 0, 0, 0)    setElementInterior(bandStorage5, 1)   setObjectScale(bandStorage5, 1.0)   setElementDimension(bandStorage5, dimension)					 --
	bandStorage6  = createObject(1649, 2224.4453, 1598.21, 1000.6423, 0, 0, 0)    setElementInterior(bandStorage6, 1)   setObjectScale(bandStorage6, 1.0)   setElementDimension(bandStorage6, dimension)  					 --
	bandStorage7  = createObject(1649, 2224.4453, 1598.21, 1000.6423, 0, 0, 0)    setElementInterior(bandStorage7, 1)   setObjectScale(bandStorage7, 1.0)   setElementDimension(bandStorage7, dimension)					 --
	bandStorage8  = createObject(1649, 2224.4453, 1598.1931, 1000.6423, 0, 0, 0)  setElementInterior(bandStorage8, 1)   setObjectScale(bandStorage8, 1.0)   setElementDimension(bandStorage8, dimension)					 --
	bandStorage9  = createObject(937, 2233.3152, 1588.8298, 999.43018, 0, 0, 90)  setElementInterior(bandStorage9, 1)   setObjectScale(bandStorage9, 1.0)   setElementDimension(bandStorage9, dimension)					 --
	bandStorage10 = createObject(937, 2233.3152, 1591.3999, 999.43018, 0, 0, 90)  setElementInterior(bandStorage10, 1)  setObjectScale(bandStorage10, 1.0)  setElementDimension(bandStorage10, dimension)					 --
	bandStorage11 = createObject(937, 2233.3152, 1586.2649, 999.43018, 0, 0, 90)  setElementInterior(bandStorage11, 1)  setObjectScale(bandStorage11, 1.0)  setElementDimension(bandStorage11, dimension)					 --
	bandStorage12 = createObject(937, 2233.3152, 1583.7258, 999.43018, 0, 0, 90)  setElementInterior(bandStorage12, 1)  setObjectScale(bandStorage12, 1.0)  setElementDimension(bandStorage12, dimension)					 --
	bandStorage13 = createObject(937, 2233.3154, 1581.3253, 999.43018, 0, 0, 90)  setElementInterior(bandStorage13, 1)  setObjectScale(bandStorage13, 1.0)  setElementDimension(bandStorage13, dimension)					 --
	bandStorage14 = createObject(937, 2233.3154, 1578.8563, 999.43018, 0, 0, 90)  setElementInterior(bandStorage14, 1)  setObjectScale(bandStorage14, 1.0)  setElementDimension(bandStorage14, dimension)					 --
end					 --
					 --
end					 --
return spawnGarages					 --
