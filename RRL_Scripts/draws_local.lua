patternEbdTex = dxCreateTexture(":Draws/Elements/Pattern/patternEBDA.png","argb")
patternEbdTex2 = dxCreateTexture(":Draws/Elements/Pattern/patternEBDA2.png","argb")

Textures = {}
Textures.triangleTex = dxCreateTexture(":Draws/Elements/Misc/Triangle.png","argb")
Textures.test = dxCreateTexture(":Draws/win/winTest.png","dxt5")


screenW, screenH = guiGetScreenSize()
_scrRT = dxCreateRenderTarget(screenW,screenH,true)
_scrRT2 = dxCreateRenderTarget(screenW,screenH,true)

function getTxture(name)
	return Textures[name]
end


function getPatternsTex()
	return {patternEbdTex  = patternEbdTex,
			patternEbdTex2 = patternEbdTex2}
end
function getScreenRTs()
	return {_scrRT,_scrRT2}
end



addCommandHandler("clrt",function()
	removeEventHandler("onClientRender",root,blR)	
end)
function blR()
	--dxDrawRectangle(0,0,2000,1200,tocolor(0,0,0,255))
end
addEventHandler("onClientRender",root,blR)
outputChatBox("risuyu back rect fullscreen in draws_local RRL_Scr")