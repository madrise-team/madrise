Terrytorys = {}

Terrytory = {}
function Terrytory:create(tPointsT,index,aviableConnectionsT,atrbs)
	local this = {}
		this.index = index
		this.tPoints = {}
			for k,v in pairs(tPointsT) do
				this.tPoints[k] = TPoints[v]
			end
		this.connections = aviableConnectionsT

		this.atrbs = atrbs

	setmetatable(this, self)
	self.__index = self

	Terrytorys[this.index] = this
	
	return this
end





 TPoints = {}
 function createTPoint(figmaX,figmaY,index)
	TPoint = {x = figmaX-3000,y=  -figmaY+3000,index = index}

 	if TPoints[index] then
 		outputDebugString("!!WARING!!!  Terrytory point with index ".. index.." already exist!")
 	else
 		TPoints[index] = TPoint
 	end
 end


--- ----------------------- Terrytory Points -------------------------
createTPoint(4831,4037,1);
createTPoint(4860,4034,2)
createTPoint(4955,4034,3)
createTPoint(5064,4034,4)
createTPoint(5064,4143,5)
createTPoint(4872,4143,6)
createTPoint(4872,4172,7)
createTPoint(4831,4172,8)
createTPoint(4997,3944,9)
createTPoint(5114,3944,10)
createTPoint(5173,3955,11)
createTPoint(5169,4014,12)
createTPoint(5193,4061,13)
createTPoint(5227,4101,14)
createTPoint(5227,4124,15)
createTPoint(5171,4095,16)
createTPoint(5128,4076,17)
createTPoint(4862,4186,18)
createTPoint(4862,4250,19)
createTPoint(5064,4253,20)
createTPoint(5064,4344,21)
createTPoint(4862,4344,22)
createTPoint(4984,4344,23)
createTPoint(4984,4475,24)
createTPoint(4858,4475,25)
createTPoint(4863,4454,26)
createTPoint(5068,4383,27)
createTPoint(5108,4386,28)
createTPoint(5108,4475,29)
createTPoint(5108,4606,30)
createTPoint(5003,4606,31)
createTPoint(4993,4627,32)
createTPoint(4945,4627,33)
createTPoint(4929,4606,34)
createTPoint(4833,4606,35)
createTPoint(4833,4746,36)
createTPoint(4993,4747,37)
createTPoint(5089,4747,38)
createTPoint(5108,4687,39)
createTPoint(4970,4746,40)
createTPoint(4826,4940,41)
createTPoint(4833,4929,42)
createTPoint(4817,4961,43)
createTPoint(4817,5047,44)
createTPoint(4970,4940,46)
createTPoint(5088,4940,47)
createTPoint(4970,4856,48)
createTPoint(4970,5047,49)
createTPoint(4970,5159,50)
createTPoint(4662,5159,51)
createTPoint(4662,5069,52)
createTPoint(4817,5069,53)
createTPoint(5077,4785,54)
createTPoint(5223,4940,55)
createTPoint(5223,4966,56)
createTPoint(5323,4966,57)
createTPoint(5323,4877,58)
createTPoint(5088,4859,59)
createTPoint(5421,4966,60)
createTPoint(5421,5044,61)
createTPoint(5309,5044,62)
createTPoint(5285,5062,63)
createTPoint(5223,5000,64)
createTPoint(5421,4923,65)
createTPoint(5543,4923,66)
createTPoint(5543,5044,67)
createTPoint(5711,5044,68)
createTPoint(5711,4923,69)
createTPoint(5812,5044,70)
createTPoint(5812,4904,71)
createTPoint(5711,4904,72)
createTPoint(5684,4894,73)
createTPoint(5648,4863,74)
createTPoint(5633,4825,75)
createTPoint(5543,4825,76)
createTPoint(5543,4723,77)
createTPoint(5421,4723,78)
createTPoint(5421,4825,79)
createTPoint(5323,4825,80)
createTPoint(5209,4723,81)
createTPoint(5209,4863,82)
createTPoint(5543,4642,83)
createTPoint(5543,4631,84)
createTPoint(5333,4631,85)
createTPoint(5333,4723,86)
createTPoint(5633,4394,87)
createTPoint(5673,4401,88)
createTPoint(5685,4417,89)
createTPoint(5685,4442,90)
createTPoint(5688,4487,91)
createTPoint(5696,4497,92)
createTPoint(5828,4187,93)
createTPoint(5714,4642,94)
createTPoint(5812,4642,95)
createTPoint(5848,4550,96)
createTPoint(5857,4498,97)
createTPoint(5829,4497,98)
createTPoint(5714,4497,99)
createTPoint(5865,4448,100)
createTPoint(5857,4332,101)
createTPoint(5844,4269,102)
createTPoint(5714,4269,103)
createTPoint(5625,4825,104)
createTPoint(5625,4923,105)
createTPoint(5625,5044,106)
createTPoint(4833,4806,107)
createTPoint(4970,4835,108)
createTPoint(5009,4845,109)
createTPoint(5077,4845,110)
createTPoint(4833,4824,111)
createTPoint(4970,4961,112)
createTPoint(4841,4569,113)
createTPoint(4864,4555,114)
createTPoint(4898,4544,115)
createTPoint(4915,4533,116)
createTPoint(4989,4533,117)
createTPoint(5007,4537,118)
createTPoint(5019,4547,119)
createTPoint(5026,4562,120)
createTPoint(5052,4562,121)
createTPoint(5049,4549,122)
createTPoint(5042,4533,123)
createTPoint(5058,4533,124)
createTPoint(5090,4540,125)
createTPoint(5108,4547,126)
createTPoint(4911,4824,127)
createTPoint(5209,4914,128)
createTPoint(5201,4930,129)
createTPoint(5192,4940,130)
createTPoint(5209,4840,131)
createTPoint(5543,4881,132)
createTPoint(5633,4527,133)
createTPoint(5626,4599,134)
createTPoint(5828,4132,135)
createTPoint(5751,4140,136)
createTPoint(5714,4141,137)
createTPoint(5714,4038,138)
createTPoint(5828,4038,139)
createTPoint(5828,3879,140)
createTPoint(5714,3899,141)
createTPoint(5637,3915,142)
createTPoint(5603,3915,143)
createTPoint(5603,4038,144)
createTPoint(5502,4038,145)
createTPoint(5460,4025,146)
createTPoint(5418,4025,147)
createTPoint(5418,3918,148)
createTPoint(5422,3915,149)
createTPoint(5352,3969,150)
createTPoint(5303,4034,151)
createTPoint(5303,4068,152)
createTPoint(5350,4066,153)
createTPoint(5388,4045,154)
createTPoint(5252,4038,155)
createTPoint(5223,4015,156)
createTPoint(5170,3998,157)
createTPoint(5240,3969,158)
createTPoint(5541,4038,159)
createTPoint(5541,4140,160)
createTPoint(5303,4145,161)
createTPoint(5171,4215,162)
createTPoint(5064,4215,163)
createTPoint(5278,4215,164)
createTPoint(5160,4386,168)
createTPoint(5278,4140,165)
createTPoint(5278,4119,166)
createTPoint(5294,4119,167)
createTPoint(5160,4293,169)
createTPoint(5165,4257,170)
createTPoint(5278,4386,171)
createTPoint(5276,4460,172)
createTPoint(5247,4545,173)
createTPoint(5144,4505,174)
createTPoint(5207,4386,175)
createTPoint(5207,4530,176)
createTPoint(5264,4505,177)
createTPoint(5134,4550,178)
createTPoint(5226,4594,179)
createTPoint(5195,4677,180)
createTPoint(5214,4669,181)
createTPoint(5193,4747,182)
createTPoint(5193,4843,183)
createTPoint(5165,4843,184)
createTPoint(5142,4833,185)
createTPoint(5077,4833,186)
createTPoint(5238,4599,187)
createTPoint(5346,4878,188)
createTPoint(5196,4859,190)
createTPoint(5196,4917,191)
createTPoint(5186,4932,192)
createTPoint(5176,4940,193)
createTPoint(5352,4389,194)
createTPoint(5295,4389,195)
createTPoint(5288,4456,196)
createTPoint(5279,4500,197)
createTPoint(5261,4551,198)
createTPoint(5352,4555,199)
createTPoint(5377,4555,200)
createTPoint(5405,4571,201)
createTPoint(5418,4571,202)
createTPoint(5443,4581,203)
createTPoint(5443,4450,204)
createTPoint(5384,4450,205)
createTPoint(5384,4389,206)
createTPoint(5303,4292,207)
createTPoint(5380,4292,208)
createTPoint(5380,4389,209)
createTPoint(5380,4143,210)
createTPoint(5633,4250,211)
createTPoint(5519,4250,212)
createTPoint(5519,4436,213)
createTPoint(5633,4436,214)
createTPoint(5633,4460,215)
createTPoint(5580,4460,216)
createTPoint(5580,4494,217)
createTPoint(5570,4530,218)
createTPoint(5546,4570,219)
createTPoint(5543,4591,220)
createTPoint(5469,4591,221)
createTPoint(5443,4497,222)
createTPoint(5544,4497,223)
createTPoint(5544,4436,224)
createTPoint(5443,4354,225)
createTPoint(5519,4354,226)
createTPoint(5714,4250,227)
createTPoint(5443,4314,228)
createTPoint(5380,4314,229)
createTPoint(5443,4142,230)
createTPoint(5443,4250,231)
createTPoint(5380,4250,232)
createTPoint(5458,4141,233)
createTPoint(5458,4250,234)
createTPoint(5458,4181,235)
createTPoint(5564,4181,236)
createTPoint(5564,4250,237)
createTPoint(5659,4250,238)
createTPoint(5659,4181,239)
createTPoint(5714,4181,240)


--- ----------------------- /Terrytory Points -------------------------
--- ----------------------- Terrytorys  -------------------------
		-- #### Terrytory:create({1,2,3,4,5,1},1,{2})
		-- #### Terrytory:create({3,4,7,6,3},2,{1})

	Terrytory:create({1,2,3,4,5,6,7,8,1},									"BASE B",{1,11,19})
	Terrytory:create({3,4,17,16,15,14,13,12,157,11,10,9,3},					1,{"BASE B",2})
	Terrytory:create({11,158,151,152,155,156,157,11},						2,{1,3})
	Terrytory:create({157,156,155,152,161,167,166,165,15,14,13,12,157},		3,{2,4,12})
	Terrytory:create({151,150,148,147,154,153,152,151},						4,{3,5})
	Terrytory:create({152,153,154,147,146,145,159,160,233,230,210,161,152},	5,{4,6,13,14,16})
	Terrytory:create({148,149,143,144,159,145,146,147,148},					6,{5,7})
	Terrytory:create({143,142,141,138,144,143},								7,{6,8})
	Terrytory:create({141,140,139,138,141},									8,{7,10})
	Terrytory:create({159,144,138,137,160,159},								9,{5,16,10})
	Terrytory:create({138,139,135,136,137,138},								10,{8,18,17,9})
	Terrytory:create({4,17,16,162,163,5,4},									11,{"BASE B",12})
	Terrytory:create({16,15,165,164,162,16},								12,{11,3,22})
	Terrytory:create({161,210,232,208,207,161},								13,{5,23})
	Terrytory:create({210,230,231,232,210},									14,{5,24})
	Terrytory:create({235,236,237,212,234,235},								15,{25,16})
	Terrytory:create({233,160,137,240,239,238,211,237,236,235,233},			16,{5,9,17,27,26,15})
	Terrytory:create({239,240,227,238,239},									17,{16,10,27})
	Terrytory:create({137,136,93,102,103,227,240,137},						18,{10,28})
	Terrytory:create({6,5,163,20,19,18,7,6},								19,{"BASE B",20})
	Terrytory:create({19,20,21,23,22,19},									20,{19,21,32,31})
	Terrytory:create({163,162,170,169,168,28,27,21,20,163},					21,{20,22})
	Terrytory:create({162,164,171,175,168,169,170,162},						22,{12,23,34,21})
	Terrytory:create({207,208,229,209,194,195,207},							23,{22,13,29})
	Terrytory:create({232,231,228,229,208,232},								24,{14})
	Terrytory:create({230,233,235,234,212,226,225,228,231,230},				25,{5,15,30,29})
	Terrytory:create({212,237,211,87,214,224,213,226,212},					26,{16,30})
	Terrytory:create({211,238,227,103,99,92,91,90,89,88,87,211},			27,{16,17,38})
	Terrytory:create({103,102,101,100,97,98,99,103},						28,{18,"BASE V"})
	Terrytory:create({229,228,225,204,205,206,209,229},						29,{23,25,30,36})
	Terrytory:create({225,226,213,224,223,222,204,225},						30,{29,25,26,37})
	Terrytory:create({22,23,24,25,26,22},									31,{20,39})
	Terrytory:create({23,21,27,28,29,24,23},								32,{20,33})
	Terrytory:create({28,168,175,176,174,29,28},							33,{32,34,42})
	Terrytory:create({175,171,172,177,173,176,175},							34,{33,22,35})
	Terrytory:create({195,194,199,198,197,196,195},							35,{34,36,43})
	Terrytory:create({194,209,206,205,204,222,203,202,201,200,199,194},		36,{35,29,37})
	Terrytory:create({222,223,224,214,215,216,217,218,219,220,221,203,222},	37,{36,30,"BASE G"})
	Terrytory:create({87,88,89,90,91,92,99,300,134,133,215,214,87},			38,{27,"BASE V"})
	Terrytory:create({99,98,97,96,95,94,300,99},							"BASE V",{28,38,57})
	Terrytory:create({113,114,115,116,117,118,119,120,121,122,123,124,125,126,30,31,32,33,34,35,113},	39,{31,41,40})
	Terrytory:create({35,34,33,32,37,40,36,35},								40,{39,45,44})
	Terrytory:create({32,31,30,39,38,37,32},								41,{39,42})
	Terrytory:create({126,178,179,180,182,38,39,30,126},					42,{33,43,46,41})
	Terrytory:create({179,187,85,86,81,181,179},							43,{35,"BASE G",47,46,42})
	Terrytory:create({85,84,83,77,78,86,85},								"BASE G",{43,37,48})
	Terrytory:create({36,40,108,127,107,36},								44,{40,49})
	Terrytory:create({40,37,38,54,186,110,109,108,40},						45,{40,46})
	Terrytory:create({38,182,183,184,185,186,54,38},						46,{45,42,43,51})
	Terrytory:create({81,86,78,79,80,131,81},								47,{43,48,52})
	Terrytory:create({78,77,76,79,78},										48,{"BASE G",47})
	Terrytory:create({111,48,46,41,42,111},									49,{44,50,58})
	Terrytory:create({48,59,47,46,48},										50,{49,51})
	Terrytory:create({59,190,191,192,193,47,59},							51,{50,46,52})
	Terrytory:create({82,58,57,56,55,130,129,128,82},						52,{51,53,55,54})
	Terrytory:create({58,188,132,66,65,60,57,58},							53,{52,55})
	Terrytory:create({56,57,60,61,62,63,64,56},								54,{52,55})
	Terrytory:create({65,66,67,61,60,65},									55,{52,53,54,56})
	Terrytory:create({105,69,68,106,105},									56,{55,57})
	Terrytory:create({72,71,70,68,69,72},									57,{56,"BASE V"})
	Terrytory:create({43,112,49,44,43},										58,{49,"BASE A"})
	Terrytory:create({52,53,44,49,50,51,52},								"BASE A",{58})

























	












--- ----------------------- /Terrytorys  -------------------------

setTimer(function()
	triggerClientEvent(root,"debugPoints",root,TPoints)	
	triggerClientEvent(root,"debugTerritory",root,Terrytorys)
end,1000,1)
