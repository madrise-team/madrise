screenW, screenH = guiGetScreenSize()
_scrRT = dxCreateRenderTarget(screenW,screenH,true)
_scrRT2 = dxCreateRenderTarget(screenW,screenH,true)

addCommandHandler("clrt",function()
	removeEventHandler("onClientRender",root,blR)	
end)
function blR()
	--dxDrawRectangle(0,0,2000,1200,tocolor(0,0,0,255))
end
addEventHandler("onClientRender",root,blR)
outputChatBox("risuyu back rect fullscreen in draws_local RRL_Scr, use command clrt to remove")



---------- export draws data
drawsData = {
	scrRts = {_scrRT,_scrRT2},
	
	LayerMaskShader = dxCreateShader(":Draws/fx/LayerMask.fx"),
	TheresholdPatternShader = dxCreateShader(":Draws/fx/TheresholdPattern.fx"),

	shaderBlurSim = dxCreateShader (":Draws/fx/blurSim.fx"),
	shaderBlurGaus = dxCreateShader (":Draws/fx/blurGaus.fx"),

	patternEbdTex = dxCreateTexture(":Draws/Elements/Pattern/patternEBDA.png","argb"),
	patternEbdTex2 = dxCreateTexture(":Draws/Elements/Pattern/patternEBDA2.png","argb"),

	triangleTex = dxCreateTexture(":Draws/Elements/Misc/Triangle.png","argb"),

	test = dxCreateTexture(":Draws/win/winTest.png","dxt5")
}
function getDrawsLocalData()
	return drawsData
end

-------------------------------------------------------------------------------------------------------------------
local replaceSoup = 11401

engineReplaceModel (engineLoadDFF("fx/soupdiv.dff") , replaceSoup, true)

local wawesShader = dxCreateShader("fx/wawes.fx")
local drawPatternShader = dxCreateShader("fx/drawPatternEDBA.fx") 
dxSetShaderValue(drawPatternShader,"screenW", screenW)
dxSetShaderValue(drawPatternShader,"screenH", screenH)

--dxSetShaderTessellation ( drawPatternShader, 100, 100 )


bindKey("0","down",function()

	-- local rendere = dxCreateRenderTarget(screenW,screenH,false)
	local rendere = dxCreateRenderTarget(500,500,false)
	dxSetRenderTarget(rendere,true)----------------

	for i=1,30 do
		local xexe = -100 + 20*i
		dxDrawLine(xexe,0,xexe+100,500,tocolor(255,255,255,255),4)	
	end	


	dxSetRenderTarget()-----------------------------
	addEventHandler("onClientRender",root,function()
		dxDrawImage(200,50,50,50,rendere)
	
		-- dxSetRenderTarget(rendere,true)
		 dxDrawImage(0,0,screenW,screenH, drawPatternShader)
		-- dxSetRenderTarget()
		
		-- dxDrawImage(0,0,screenW,screenH, rendere)



	end)

	do return end

	local x,y,z = getElementPosition(localPlayer)
	local mdel = createObject(replaceSoup,x + 2,y,z)
	setElementCollisionsEnabled(mdel,false)
	setObjectScale(mdel,0.25)

	dxSetShaderValue(wawesShader,"patternTex", rendere)
	

	engineApplyShaderToWorldTexture (wawesShader, "*", mdel)
end)