screenW, screenH = guiGetScreenSize()
_scrRT = dxCreateRenderTarget(screenW,screenH)
_smallRt = dxCreateRenderTarget(500,500)

function getScreenRTs()
	return {_scrRT,_smallRt}
end

patternEbdTex = dxCreateTexture(":Draws/Elements/Pattern/patternEBDA.png","argb")
patternEbdTex2 = dxCreateTexture(":Draws/Elements/Pattern/patternEBDA2.png","argb")

function getPatternsTex()
	return {patternEbdTex = patternEbdTex,
			patternEbdTex2 =patternEbdTex2}
end