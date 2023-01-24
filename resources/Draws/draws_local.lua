screenW, screenH = guiGetScreenSize()
_scrRT = dxCreateRenderTarget(screenW,screenH,true)
_scrRT2 = dxCreateRenderTarget(screenW,screenH,true)


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
perlinNoise = dxCreateTexture("sampleMaps/perlin0.png","argb")

local replaceSoup = 11401
engineReplaceModel (engineLoadDFF("fx/soupdiv.dff") , replaceSoup, true)

local wawesShader = dxCreateShader("fx/wawes.fx")
local drawPatternShader = dxCreateShader("fx/drawPatternEDBA.fx") 
dxSetShaderValue(drawPatternShader,"noiseTex", perlinNoise)
dxSetShaderValue(drawPatternShader,"screenW", screenW)
dxSetShaderValue(drawPatternShader,"screenH", screenH)
-- dxSetShaderTessellation ( drawPatternShader, 100, 100 )

bindKey("-","down",function()
	if drawPatternShader then
		dxSetShaderValue(drawPatternShader,"timeKey",getRealTime().timestamp)
	end
end)


statet = false
bindKey("0","down",function()
	if statet then return end
	statet = true
	-- local rendere = dxCreateRenderTarget(screenW,screenH,false)
	--[[
	local rendere = dxCreateRenderTarget(500,500,false)
	dxSetRenderTarget(rendere,true)----------------
	for i=1,30 do
		local xexe = -100 + 20*i
		dxDrawLine(xexe,0,xexe+100,500,tocolor(255,255,255,255),4)	
	end	
	dxSetRenderTarget()-----------------------------]]

	local eventer = -10
	addEventHandler("onClientRender",root,function()
		eventer = eventer - 0.01
		dxSetShaderValue(drawPatternShader,"efxPos",eventer)
		--dxDrawImage(0,0,screenW,screenH, wawesShader)
	end)

	function eventGenerate()
		efxColType = 1
		if math.random(0,100) > 90 then efxColType = 0 end
		dxSetShaderValue(drawPatternShader,"efxColType",efxColType)

		eventer = 1.6
	end

	setTimer(function()
		if math.random(0,100) > 70 then eventGenerate() end
	end,5000,0)

	--do return end

	local x,y,z = getElementPosition(localPlayer)
	local mdel = createObject(replaceSoup,x + 2,y,z)
	setElementCollisionsEnabled(mdel,false)
	setObjectScale(mdel,0.05)	

	engineApplyShaderToWorldTexture (wawesShader, "*", mdel)
end)