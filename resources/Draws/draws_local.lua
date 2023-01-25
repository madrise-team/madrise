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
dxSetShaderValue(wawesShader,"noiseTex", perlinNoise)
dxSetShaderValue(wawesShader,"screenW", screenW)
dxSetShaderValue(wawesShader,"screenH", screenH)

statet = false
bindKey("0","down",function()
	if statet then return end
	statet = true
	local rendere = dxCreateRenderTarget(screenW,screenH,false)
	local eventer = -10
	addEventHandler("onClientRender",root,function()
		eventer = eventer - 0.01
		dxSetShaderValue(wawesShader,"efxPos",eventer)
	end)

	function eventGenerate()
		efxColType = 1
		if math.random(0,100) > 90 then efxColType = 0 end
		dxSetShaderValue(wawesShader,"efxColType",efxColType)

		eventer = 1.6
	end
	bindKey("0","down",eventGenerate)
	setTimer(function()
		if math.random(0,100) > 70 then eventGenerate() end
	end,5000,0)

	if not wawesShader then return end

	local x,y,z = getElementPosition(localPlayer)
	local mdel = createObject(replaceSoup,x + 15,y,z - 2)
	setElementCollisionsEnabled(mdel,false)
	setObjectScale(mdel,0.5)	

	engineApplyShaderToWorldTexture (wawesShader, "*", mdel)
end)

------------------------------------------------------------------------------------------------
local shaderParametrs = {}

function bakeParam(name, val, step, minVal, maxVal)
	return {
		name = name, 
		val = val, step = step, 
		minVal = minVal, maxVal = maxVal
	}
end
function addShaderParam(name, val, step, minVal, maxVal)
	table.insert(shaderParametrs, bakeParam(name, val, step, minVal, maxVal) )
end
function addShaderParamComponentParam(paramName, name, val, step, minVal, maxVal)
	local sh_param 
	for k,v in pairs(shaderParametrs) do
		if v.name == paramName then
			sh_param = v
			break
		end
	end

	if not sh_param then
		outputChatBox("no Parametr [ "..paramName.." ]")
		return
	end

	table.insert(sh_param.val,bakeParam(name, val, step, minVal, maxVal) )
end
function applyParametrs(paramName)
	for k,v in ipairs(shaderParametrs) do
		if type(v.val) == "table" then
			local values = {}
			for ck,cv in ipairs(v.val) do
				table.insert(values, cv.val) 	
			end 
			dxSetShaderValue(shaderParametrs.shader, v.name, unpack(values))
		else
			dxSetShaderValue(shaderParametrs.shader, v.name, v.val) 
		end
	end
end

local selected = 0
local selectedComponent = 1

function drawParam(name,val,yPos, selected)
	local col = tocolor(10,10,10,100)
	if selected then
		col = tocolor(255,160,10,100)
	end
	dxDrawRectangle(100, yPos, 200, 15, col)
	dxDrawText(name, 100, yPos)
	dxDrawText(val, 250, yPos)
end

addEventHandler('onClientRender',root,function()
	if shaderParametrs.shaderName then
		dxDrawRectangle(100,85,200,15, tocolor(10,10,10,50))

		dxDrawRectangle(100,85,200,2, tocolor(10,10,100,100))
		dxDrawRectangle(100,100,200,-2,tocolor(10,10,100,100))
		dxDrawText(shaderParametrs.shaderName, 125, 85)
	end 
	local ystep = 15
	local yPos = 100
	for k,v in ipairs(shaderParametrs) do		
		local selected = selected == k
		if type(v.val) == "table" then
			yPos = yPos + ystep
			drawParam(v.name, "", yPos, selected)
			for ck,cv in ipairs(v.val) do
				yPos = yPos + ystep
				local selectedComp = (selectedComponent == ck) and selected
				drawParam(" . > "..cv.name, cv.val, yPos, selectedComp)
			end
		else
			drawParam(v.name, v.val, yPos, selected)
		end

		yPos = yPos + ystep
	end
end)
function chooseParam(dir)
	selected = selected + dir
	if selected > #shaderParametrs then selected = 1 end
	if selected < 1 then selected = #shaderParametrs end
	chooseParamComponent(0)
end
function chooseParamComponent(dir)
	local prm = shaderParametrs[selected]
	if type(prm.val) == "table" then
		selectedComponent = selectedComponent + dir
		if selectedComponent > #prm.val then selectedComponent = 1 end
		if selectedComponent < 1 then selectedComponent = #prm.val end
	end
end

function modifyParam(dir)
	local prm = shaderParametrs[selected]

	local prmTable = false	
	if type(prm.val) == "table" then
		prmTable = prm
		prm = prm.val[selectedComponent]
	end
	if prm then
		prm.val = prm.val + prm.step*dir
		if prm.minVal then if prm.val < prm.minVal then prm.val = prm.minVal end end
		if prm.maxVal then if prm.val > prm.maxVal then prm.val = prm.maxVal end end 
		
		applyParametrs()
	end
end
bindKey("num_2","down",function() chooseParam(1) end)
bindKey("num_8","down",function() chooseParam(-1) end)
bindKey("num_7","down",function() chooseParamComponent(-1) end)
bindKey("num_9","down",function() chooseParamComponent(1) end)

bindKey("num_4","down",function() modifyParam(-1) end)
bindKey("num_6","down",function() modifyParam(1) end)
----------------------------------------------------------------
shaderParametrs.shaderName = "WAWES"
shaderParametrs.shader = wawesShader


function addWaveParam(waveName, dirX,dirY,Steepness,WaveLenght) 
	addShaderParam(waveName, {})
	addShaderParamComponentParam(waveName, "dirX", 		 dirX, 	 	0.25, 	-1,1)
	addShaderParamComponentParam(waveName, "dirY", 		 dirY, 	 	0.25,	-1,1)
	addShaderParamComponentParam(waveName, "Steepness",  Steepness ,0.1,	0, 1)
	addShaderParamComponentParam(waveName, "WaveLenght", WaveLenght,1)
end

addShaderParam("timeSpeedK", 0.03, 0.01)

addWaveParam("WaveA",1,0.25,  0.3, 21)
addWaveParam("WaveB",0.5,1,  0.4, 47.5)
addWaveParam("WaveC",0.25,-1, 0.15, 16)

applyParametrs()