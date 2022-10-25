function standarty()
--------------------------------------

--- Global sources --------------------------------------------------
screenW, screenH = guiGetScreenSize()
msw = screenW/1920		--;msw = 1
msh = screenH/1080		--;msw = 0.71145833333
						--;msw = 0.5

rlsc = exports.RRL_Scripts
local scrRts = rlsc:getScreenRTs()
_scrRT = scrRts[1]
_scrRT2 = scrRts[2] ; scrRts = nil

_PatternShT =  rlsc:getPatternsTex()
patternEbdTex = _PatternShT.patternEbdTex
patternEbdTex2 = _PatternShT.patternEbdTex2

triangleTex = rlsc:getTxture("triangleTex")

whiteCol = tocolor(255,255,255,255)
blackCol = tocolor(0,0,0,255)

--- -------------  --------------------------------------------------
------------------ Stantarts --------------------------------------------
----- Fonts
SFonts = {}
	SFonts.ebda = {}
		SFonts.ebda.h1 = {font = dxCreateFont (":Draws/Fonts/Jost-Light.ttf",math.floor(48*msw),false,"cleartype_natural"),["scaleFont"] = true,scaleXY = 1,scaleY = 0.9}
		SFonts.ebda.h2 = {font = dxCreateFont (":Draws/Fonts/Jost-Regular.ttf",math.floor(24*msw),false,"cleartype_natural"),["scaleFont"] = false}
		SFonts.ebda.text = {font = dxCreateFont (":Draws/Fonts/Jost-Regular.ttf",math.floor(18*msw),false,"cleartype_natural"),["scaleFont"] = false}
		SFonts.ebda.listBut1 = {font = dxCreateFont (":Draws/Fonts/Jost-Light.ttf",math.floor(22*msw),false,"cleartype_natural"),["scaleFont"] = false}
		SFonts.ebda.But1 = {font = dxCreateFont (":Draws/Fonts/Jost-Regular.ttf",math.floor(22*msw),false,"cleartype_natural"),["scaleFont"] = false}

	SFonts.medium10 = {font = dxCreateFont (":Draws/Fonts/Jost-Medium.ttf",math.floor(10*msw),false,"cleartype_natural"),["scaleFont"] = false}
	SFonts.medium12 = {font = dxCreateFont (":Draws/Fonts/Jost-Medium.ttf",math.floor(12*msw),false,"cleartype_natural"),["scaleFont"] = false}
	SFonts.medium14 = {font = dxCreateFont (":Draws/Fonts/Jost-Medium.ttf",math.floor(14*msw),false,"cleartype_natural"),["scaleFont"] = false}
	SFonts.semiBold18 = {font = dxCreateFont (":Draws/Fonts/Jost-SemiBold.ttf",math.floor(18*msw),false,"cleartype_natural"),["scaleFont"] = false}

	--	SFonts.ebda.text = {font = "default",["scaleFont"] = false,["scaleFont"] = true,["scaleXY"] = 2,["scaleY"] = 2}
--Jost-Regular.ttf




----- Elements

SWins = {}
SWins["big1"] = {x = 148,y = 0,w = 1402,h = 792,
			tl = {w = 22,h = 22},
			tr = {w = 22,h = 22},
			bl = {w = 22,h = 22},
			br = {w = 22,h = 22},
			t = {space = 22},
			l = {space = 22},
			r = {space = 22},
			b = {space = 22},
			size = {w = 1402,h = 792},
			img = ":Draws/Elements/Win/Win.png"}
SWins["big1"].noShadow = {w = 1394,h = 784}


SWins["miniwin"] = { w = 508,h = 257,
			tl = {w = 120,h = 85},
			tr = {w = 120,h = 85},
			bl = {w = 120,h = 45},
			br = {w = 120,h = 45},
			t = {space = 85},
			l = {space = 120},
			r = {space = 120},
			b = {space = 45},
			size = {w = 508,h = 257},
			img = ":Draws/Elements/MiniWin/MiniWin.png"}
SWins["miniwin"].ineterOffset = {x = 33/msw,y = -75/msw,wd = -43}

SWins["miniwin2"] = { w = 405,h = 679,
			tl = {w = 130,h = 130},
			tr = {w = 130,h = 130},
			bl = {w = 130,h = 130},
			br = {w = 130,h = 130},
			t = {space = 130},
			l = {space = 130},
			r = {space = 130},
			b = {space = 130},
			size = {w = 405,h = 679},
			img = ":Draws/Elements/MiniWin/MiniWin2.png"}
SWins["miniwin2"].offset = {x=9}

SWins.BS = {}
	SWins.BS.miniwin = { w = 366,h = 636,
			tl = {w = 40,h = 40},
			tr = {w = 120,h = 40},
			bl = {w = 40,h = 40},
			br = {w = 120,h = 45},
			t = {space = 40},
			l = {space = 40},
			r = {space = 120},
			b = {space = 45},
			size = {w = 366,h = 636},
			img = ":Draws/Elements/BS/MiniWin/MiniWin.png"}

SPattern = {}
SPattern["EDBA"] = {x = 375,y = 353,w = 1028,h = 440,["img"] = ":Draws/Elements/Pattern/Pattern.png",["color"] = tocolor(255,255,255,160)}



SButton = {}
SButton.button1small = {w = 229,h = 72,tx = 0,ty = 0,tw = 220,th = 64,
	imgN = ":Draws/Elements/Button1/Button1_norm.png",
	imgH = ":Draws/Elements/Button1/Button1_hover.png",
	imgD = ":Draws/Elements/Button1/Button1_down.png",
	textAlignX = "center",
	textAlignY = "center",
	font = SFonts.ebda.But1,
	originalSize = {w=229,h=72}
}
	
SButton.close1 = {['w'] = 102,['h'] = 64,
	imgN = ":Draws/Elements/Close/Close_norm.png",
	imgH = ":Draws/Elements/Close/Close_hover.png",
	imgD = ":Draws/Elements/Close/Close_down.png",
	originalSize = {w=102,h=64}
}



SListButton = {}
SListButton.list1 = {['w'] = 385,['h'] = 74,["tx"] = 38,["ty"] = 0,["tw"] = 275,["th"] = 67,
	imgN = ":Draws/Elements/ListButton/ListButton_norm.png",
	imgH = ":Draws/Elements/ListButton/ListButton_hover.png",
	imgD = ":Draws/Elements/ListButton/ListButton_down.png",
	imgS = ":Draws/Elements/ListButton/ListButton_selected.png",
	textAlignX = "left",
	textAlignY = "center",
	font = SFonts.ebda.listBut1,
	originalSize = {w=385,h=74}
}








S_BS = {}
S_BS.darkGray1 = tocolor(37,37,37,255)
S_BS.gray1 = tocolor(179,179,179,255)
S_BS.gray2 = tocolor(220,220,220,255)
S_BS.panel = {w = 273, h = 125, th = 113, tw = 264,
	img = ":Draws/Elements/BS/Panel/Panel.png",
	tl = {w = 40,h = 40},
	tr = {w = 40,h = 40},
	bl = {w = 40,h = 40},
	br = {w = 40,h = 40},
	t = {space = 40},
	l = {space = 40},
	r = {space = 40},
	b = {space = 45},
	size = {w = 273,h = 125},
}

S_BS.button1 = {w = 154,h = 39,
	imgN = ":Draws/Elements/BS/Button1/Button1_norm.png",
	imgH = ":Draws/Elements/BS/Button1/Button1_hover.png",
	imgD = ":Draws/Elements/BS/Button1/Button1_down.png",
	textAlignX = "center",
	textAlignY = "center",
	font = SFonts.medium14,
	originalSize = {w=154,h=39},
	textPDown = {color = blackCol}
}
S_BS.operButs = {}
S_BS.operButs.AddBut = {w = 11,h = 11,
	imgN = ":Draws/Elements/BS/OperButs/AddBut_norm.png",
	imgH = ":Draws/Elements/BS/OperButs/AddBut_norm.png",
	imgD = ":Draws/Elements/BS/OperButs/AddBut_down.png",
	originalSize = {w=11,h=11},
}
S_BS.operButs.SubBut = {w = 11,h = 11,
	imgN = ":Draws/Elements/BS/OperButs/SubBut_norm.png",
	imgH = ":Draws/Elements/BS/OperButs/SubBut_norm.png",
	imgD = ":Draws/Elements/BS/OperButs/SubBut_down.png",
	originalSize = {w=11,h=11},
}





-------------------------------------------------------------------------
end
return standarty