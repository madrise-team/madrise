patternEbdTex = dxCreateTexture(":Draws/Elements/Pattern/patternEBDA.png","argb")
patternEbdTex2 = dxCreateTexture(":Draws/Elements/Pattern/patternEBDA2.png","argb")


screenW, screenH = guiGetScreenSize()
_scrRT = dxCreateRenderTarget(screenW,screenH)


function getPatternsTex()
	return {patternEbdTex = patternEbdTex,
			patternEbdTex2 =patternEbdTex2}
end
function getScreenRTs()
	return {_scrRT}
end
