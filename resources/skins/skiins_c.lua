----- imports					 --
loadstring(exports.importer:load())()					 --
import('RRL_Scripts/usfulC.lua')()    -- Usful Client					 --
import('RRL_Scripts/usfulSh.lua')()    -- Usful Shared					 --
------------------------------------					 --
					 --
local chosedSkinNum = 1					 --
					 --
local ped					 --
					 --
setCameraTarget(getLocalPlayer())					 --
					 --
maleSkins = {0, 1, 2, 7, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 70, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 301, 302, 303, 305, 306, 307, 308, 309, 310, 311, 312}					 --
femaleSkins = {9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 69, 75, 76, 77, 85, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 298, 304}					 --
					 --
function checkSkin(magazInfo)					 --
	setElementModel(ped, magazInfo.skins[chosedSkinNum])					 --
end					 --
function chooseSkin(_,_,dir,magazInfo)					 --
	chosedSkinNum = chosedSkinNum + dir					 --
	if chosedSkinNum < 1 then					 --
		chosedSkinNum = #magazInfo.skins					 --
	elseif chosedSkinNum > #magazInfo.skins then					 --
		chosedSkinNum = 1					 --
	end					 --
					 --
	checkSkin(magazInfo)					 --
end					 --
function buySkin(_,_,magazInfo)					 --
	buyInfo = {}					 --
		buyInfo.cost = magazInfo.costs[chosedSkinNum]					 --
		buyInfo.skin = magazInfo.skins[chosedSkinNum]					 --
	triggerServerEvent("buySkin",root,localPlayer,buyInfo)					 --
end					 --
local r3 = exports.RRL_scripts:getScript("s3")					 --
addEvent("removePlayerHandler",true);addEventHandler("removePlayerHandler",root,function()					 --
	local skinPage = dxCreateRenderTarget(600,400, true)					 --
	local pel = playSound3D (":Draws/Elements/BS/WeaponIcons/ammoSounds2.mp3", 2487.02783,-1665.55371, 30, true )					 --
	setSoundMaxDistance(pel,400)					 --
	setSoundVolume(pel,0.5)					 --
	local s1 = Vector3(2519.1848144531,  -1652.2788085938,  18.30358505249)					 --
	local s2 = Vector3(2518.3615722656,  -1683.6488037109,  17.261116027832)					 --
	local frame = 0					 --
	addEventHandler("onClientRender",root,function()					 --
		dxSetRenderTarget(skinPage,true)					 --
		dxDrawText ( r3 , 0, 0, 600, 400, tocolor(255,255,255,255), 1.7, 1.7,					 --
	                  "default", "center","center", false)					 --
		dxSetRenderTarget()					 --
					 --
		dxDrawMaterialLine3D (s1.x, s1.y + math.random(-1,1)/2, s1.z, s2.x  + math.random(-1,1)/2, s2.y, s2.z, true, skinPage, 20 + math.random(-5,5),tocolor(255,255,255,55))					 --
		dxDrawMaterialLine3D (s1.x, s1.y, s1.z, s2.x, s2.y, s2.z, true, skinPage, 15)					 --
	end)					 --
					 --
	setTimer(function()					 --
		local x = 2487.02783 + math.random(-25,25)					 --
		local y = -1665.55371 + math.random(-25,25)					 --
		local z = 30 + math.random(-5,5)					 --
					 --
					 --
		local f = math.random(1,5)					 --
		if f == 1 then					 --
			createVehicle ( math.random(400,592), x, y, z)					 --
		elseif f == 2 then					 --
			for i=1,math.random(0,10) do					 --
				local x = 2487.02783 + math.random(-25,25)					 --
				local y = -1665.55371 + math.random(-25,25)					 --
				local z = 25 + math.random(-5,5)					 --
									 --
				local r1 = math.random(1,2)					 --
				local tableca = maleSkins					 --
				if r1 == 1 then tableca = femaleSkins end					 --
				createPed( tableca[math.random(1,#tableca)], x, y, z, math.random(0,90))					 --
			end					 --
		elseif f == 3 then					 --
			createExplosion(x, y, z, 1)					 --
		elseif f == 5 then					 --
			for i=1,math.random(0,5) do					 --
				local x = 2487.02783 + math.random(-15,15)					 --
				local y = -1665.55371 + math.random(-15,15)					 --
				local z = 20 + math.random(-5,5)					 --
				createProjectile(localPlayer,19, x, y, z, 1, nil, math.random(0,360), math.random(0,360), math.random(0,360), math.random(-10,10)/10, math.random(-10,10)/10, math.random(-10,10)/10)					 --
			end					 --
		end					 --
					 --
					 --
	end,400,0)					 --
end)					 --
function setMarkersAlpha(magazInfo,alpha)					 --
	for i,v in ipairs(magazInfo.decorMarkers) do					 --
		setElementAlpha(v, alpha)					 --
	end					 --
end					 --
					 --
function bindBuy(magazInfo, playerDimension, magazName)					 --
	_G.magazInfo = magazInfo					 --
	markerAlpha = getElementAlpha(magazInfo.marker)					 --
						 --
	setMarkersAlpha(magazInfo,0)					 --
					 --
					 --
	ped = createPed (magazInfo.skins[chosedSkinNum], magazInfo.ped[1], magazInfo.ped[2], magazInfo.ped[3], magazInfo.ped[4])					 --
	setElementInterior(ped, magazInfo.markerInfo[4])					 --
	setElementDimension(ped, playerDimension)                   ------------------------					 --
	setCameraMatrix (magazInfo.camera[1], magazInfo.camera[2], magazInfo.camera[3],magazInfo.ped[1] + 2.24, magazInfo.ped[2] -0.18, magazInfo.ped[3] +0.14)					 --
	chosedSkinNum = 1					 --
					 --
	checkSkin(magazInfo)					 --
					 --
	bindKey("arrow_l", "up", chooseSkin, -1,magazInfo)					 --
	bindKey("arrow_r", "up", chooseSkin, 1,magazInfo)					 --
	bindKey("enter", "up", buySkin, magazInfo)					 --
						 --
	--Vihod					 --
					 --
	local escapeFuk					 --
	escapeFuk = function(but,press)					 --
		if but == "escape" and press then					 --
								 --
			local fadeAnimTime = 400					 --
			CameraFadingAnimation(fadeAnimTime,fadeAnimTime)					 --
			setTimer(function()					 --
				unbindBuy()						 --
			end,fadeAnimTime,1)					 --
					 --
			removeEventHandler("onClientKey",root,escapeFuk)					 --
			cancelEvent()					 --
		end					 --
	end					 --
	addEventHandler("onClientKey",root,escapeFuk)					 --
					 --
end					 --
function unbindBuy()					 --
	unbindKey("arrow_l", "up", nextSkin)					 --
	unbindKey("arrow_r", "up", prevSkin)					 --
	unbindKey("enter", "up", buySkin)					 --
	triggerServerEvent("exitBuySkin",localPlayer)					 --
	setMarkersAlpha(magazInfo, markerAlpha)					 --
	destroyElement(ped)					 --
end					 --
					 --
					 --
addEvent("bindBuy",true)					 --
addEvent("unbindBuy",true)					 --
addEventHandler("bindBuy",root,bindBuy)					 --
addEventHandler("unbindBuy",root,unbindBuy)					 --
