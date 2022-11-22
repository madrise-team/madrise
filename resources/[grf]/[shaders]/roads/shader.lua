function onDataChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "roads") then
        if newValue == true then
		startRoadTexture()
	else
		stopRoadTexture()
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange)

local tableTexuresName = {
	"vegasdirtyroad3_256",
	"vegasdirtyroad3_256",
	"Tar_1line256HVblend2",
	"Tar_1line256HVblenddrt",
	"Tar_1line256HVblenddrtdot",
	"Tar_1line256HVblenddrtdot",
	"Tar_1line256HVgtravel",
	"Tar_1line256HVlightsand",
	"Tar_lineslipway",
	"Tar_venturasjoin",
	"conc_slabgrey_256128",
	"ws_freeway3blend",
	"snpedtest1BLND",
	"vegastriproad1_256",
	"desert_1line256",
	"desert_1linetar",
	"roaddgrassblnd",
	"crossing2_law",
	"lasunion994",
	"motocross_256",
	"crossing_law",
	"crossing_law2",
	"crossing_law3",
	"sf_junction5",
	"craproad2_lae",
	"dt_road_stoplinea",
	"Tar_freewyleft",
	"Tar_freewyright",
	"Tar_1line256HV",
	"Tar_1linefreewy",
	"des_1line256",
	"des_1lineend",
	"des_1linetar",
	"sf_junction2",
	"vegastriproad1_256",
	"ws_freeway3",
	"cuntroad01_law",
	"roadnew4blend_256",
	"sf_road5",
	"sl_roadbutt1",
	"snpedtest1",
	"vegastriproad1_256",
	"ws_freeway3",
	"cuntroad01_law",
	"roadnew4blend_256",
	"sf_road5",
	"sl_roadbutt1",
	"snpedtest1",
	"sl_freew2road1",
	"snpedtest1blend",
	"ws_carpark3",
	"cos_hiwaymid_256",
	"sf_road5",
	"hiwayend_256",
	"hiwaymidlle_256",
	"vegasroad2_256",
	"roadnew4_256",
	"roadnew4_512",
	"vegasroad1_256",
	"dt_road",
	"vgsN_road2sand01",
	"hiwayoutside_256",
	"vegasdirtyroad1_256",
	"vegasdirtyroad2_256",
	"vegasroad3_256",
	"craproad7_lae7",
	"craproad1_lae",
	"sf_junction1",
	"sf_junction3",
	"des_oldrunway",
	"des_panelconc",
	"plaintarmac1",
	"bow_abattoir_conc2",
	"snpdwargrn1",
	"tar_1line256hvblend",
}

function startRoadTexture ()
	if road then return end

	texture = dxCreateTexture("img/road.png", "dxt3")
	shader = dxCreateShader("shader.fx")
	dxSetShaderValue(shader, "gTexture", texture)

	for i = 1, #tableTexuresName do
		engineApplyShaderToWorldTexture(shader, tableTexuresName[i])
	end

	road = true
end

function stopRoadTexture ()
	if not road then return end

	for i = 1, #tableTexuresName do
		engineRemoveShaderFromWorldTexture(shader, tableTexuresName[i])
	end

	destroyElement (texture)
	destroyElement (shader)

	road = false
end

function isRoads( ... )
	return road
end