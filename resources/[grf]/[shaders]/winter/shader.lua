local shaderMap = {
	['img/1.jpg'] = {
		'grassgrn256',
		'brngrss2stonesb',
		'grass128hv_blend_',
		'sfn_rockgrass1',
		'ws_drysand2grass',
		'grass43',
		'sfn_rock2',
		'golf_fairway2',
		'veg_bevtreebase',
		'lodgrass_128hv',
		'desgrassbrnsnd',
		'sfn_rockgrass10',
		'ws_football_lines2',
		'bow_church_dirt_to_grass_side_t',
		'sandstonemixb',
		'grasspatch_64hv',
		'desmuddesgrsblend_sw',
		'grasstype7',
		'grasspave256',
		'trainground1',
		'scumtiles3_lae',
		'grassgrnbrnx256',
		'forestfloorblendb',
		'ws_drysand',
		'forestfloor256mudblend',
		'ws_wetdryblendsand',
		'ws_wetsand',
		'hiwayinsideblend1_256',
		'greyground2sand',
		'grassdirtblend',
		'ws_patchygravel',
		'grasstype4_staw',
		'grassshort2long256',
		'grassdeep256',
		'forestfloor4',
		'grasstype3dirt',
		'grassdeep256',
		'ws_alley_conc1',
		'grass_lawn_128hv',
		'tenniscourt1_256',
		'hiwayinsideblend2_256',
		'hiwayblend1_256',
		'desegravelgrassroadla',
		'dirtblendlit',
		'sl_sfngrssdrt01',
		'sl_sfngrass01',
		'golf_greengrass',
		'golf_fairway3',
		'golf_fairway1',
		'golf_heavygrass',
		'golf_hvygras_cpark',
		'grass_dirt_64hv',
		'grassdead1blnd',
		'pavebsandend',
		'grass_dry_64hv',
		'grassdeadbrn256',
		'grass10_stones256',
		'sjmlahus28',
		'sjmscorclawn3',
		'grasstype510',
		'grasstype510_10',
		'desmudgrass',
		'grass10dirt',
		'roadblendcunt',
		'ws_patchygravel',
		'brngrss2stones',
		'pavetilealley256128',
		'grasstype4-3',
		'grasstype3',
		'grasstype5_desdirt',
		'dirtkb_64hv',
		'desertgryard256grs2',
		'des_dirt2grass',
		'des_dirt1',
		'grass',
		'pavemiddirt_law',
		'hllblf2_lae',
		'forestfloorgrass',
		'des_dirt1_glfhvy',
		'hiwayinside5_256',
		'des_dirt1_grass',
		'grass_128hv',
		'ffbranch_mountdirt',
		'desmud2forstfloor',
		'forestfloorblend',
		'cw2_mountdirt2forest',
		'rocktbrn128blnd',
		'forest_rocks',
		'desmud',
		'grass10dirt',
		'con2sand1b',
		'vgsroadirt1_256',
		'vgsroadirt2_256',
		'con2sand1a',
		'desgrassbrn_grn',
		'des_dirt2gygrass',
		'ws_traingravelblend',
		'sw_stones',
		'sw_sand',
		'sw_crops',
		'newcrop3',
		'sjmscorclawn',
		'dirtgaz64b',
		'bow_church_grass_gen',
		'hiwayinside4_256',
		'grasstype10_4blend',
		'forestfloor256_blenddirt',
		'desertstones256forestmix',
		'dirt64b2',
		'grifnewtex1x_las',
		'grassdry_128hv',
		'grass4dirtytrans',
		'bow_church_dirt',
		'grasstype5_4',
		'sw_grass01a',
		'sw_grassb01',
		'sw_grass01d',
		'sw_dirt01',
		'sfn_rocktbrn128',
		'sfn_rockhole',
		'sfncn_rockgrass3',
		'sfn_grass1',
		'des_dirtgrassmixbmp',
		'grasstype4',
		'grasstype4_forestblend',
		'forestfloor256',
		'grasstype4_10',
		'grasstype10',
		'des_dirtgrassmix_grass4',
		'grass4dirty',
		'dt_road2grasstype4',
		'sw_grass01',
		'grassdead1',
		'bow_church_grass_alt',
		'desertstones256',
		'forestfloorblendded',
		'grasstype4blndtodirt',
		'grasstype4_mudblend',
		'desertgryard256',
		'desgreengrassmix',
		'desertgravelgrass256',
		'sw_stonesgrass',
		'desgreengrass',
		 'yardgrass1', 
		 'grassgrnbrn256', 
		 'des_grass2scrub', 
		 'des_scrub1_dirt1b', 
		 'des_scrub1_dirt1a', 
		 'vgs_rockbot1a', 
		 'vgs_rockmid1a', 
		'des_ripplsand',
		'des_rocky1_dirt1',
		'des_scrub1_dirt1',
		'des_scrub1',
		'desstones_dirt1',
		'des_dirt2dedgrass',
		'des_dirt2',
		'des_dirtgravel',
		'des_dirt2blend',
		'des_rocky1',
		'des_roadedge1',
		'des_roadedge2',
		'des_panelconc',
		'des_oldrunwayblend',
		'desertstones256',
		'grasstype5',
		'grasstype5_dirt',
		'desgrassbrn',
		'des_grass2dirt1',
		'des_yelrock',
		'cw2_mountdirt',
		'hiway2sand1a',
		'hiwaygravel1_256',
		'hiwaygravel1_lod',
		'hiwayinside2_256',
		'des_oldrunway',
		'ws_rotten_concrete1',
		'cw2_mountrock',
		'cw2_mountdirtscree',
		'grass4_des_dirt2',
		'forestfloorbranch256',
		'forestfloor3',
		'des_dirt2grgrass',
		'forestfloor3_forest',
		'forestfloor_sones256',
		'sw_sandgrass',
		'sw_sandgrass4',
		'sw_rockgrassb1',
		'sw_rockgrass1',
		'sw_rockgrassb2',
		'des_dirt2 trackl',
		'des_dirtgrassmixb',
		'des_dirtgrassmixc',
		'desertstones256grass',
		'desmuddesgrsblend',
		'hiwayinsideblend3_256',
		'grasslong256',
		'sf_garden3',
		'golfcourselod_sfs_b',
		'redcliffroof_la',
		'grass10forest',
		'sw_dirt01_forestblend',
		'cs_rockdetail',
		'desertgravelgrassroad',
		'des_dirttrack1r',
	},
	['img/2.jpg'] = {
        'tar_1line256hvtodirt',
		'dirttracksgrass256',
		'grifnewtex1b',
		--'des_dirttrack1r', 
	},
	['img/5.jpg'] = {
		 'tar_venturasjoin',
		'desert_1linetar',
		'desert_1line256',
		'dt_roadblend',
		'tar_1line256hvgtravel',
		'tar_1line256hvlightsand',
		'snpdwargrn1',
		'tar_1line256hvblenddrtdot',
		'tar_1line256hvblenddrt',
		'tar_1line256hvblend2',
		'tar_freewyleft',
		'tar_freewyright',
		'tar_lineslipway',
		'lod_des_road1',
		'des_1line256',
		'des_1lineend',
		'des_1linetar',
		'tar_1line256hv',
		'tar_1line256hvblend',
		'roaddgrassblnd',
		'tar_1linefreewy',
		'vegasdirtyroad3_256',
	},
		['img/20.png'] = {
		 '',
		 'grassbrn2rockbrng2',
		'mudyforest256',
		'ws_sub_pen_conc2',
		'mountainskree_stones256',
		'rocktq128blender',
		'concretemanky',
		'des_dirt2trackr',
		'carpark_128',
		'sf_pave2',
		'stones256128',
		'bow_abpave_gen',
		'sf_pave3',
		'macpath_lae',
		'sf_pave5',
		'drvin_ground1',
		'obhilltex1',
		'des_dustconc',
		'des_dirt2track',
		'cos_hiwayout_256',
		'con2sand1c',
		'hiwayinside3_256',
		--'hiwayoutside_256',
		--'concretedust2_256128',
		'stormdrain6',
		'des_dirt2stones',
		'vgs_rockwall01_128',
		'des_dam_wall',
		'sandgrnd128',
		--'vgs_shopwall01_128',
		'grassbrn2rockbrn',
		'parking2plain',
		'parking2',
		'rocktbrn128',
		'rocktbrn128blndlit',
		'cuntroad01_law',
		'fancy_slab128',
		'cst_rock_coast_sfw',
		'venturas_fwend',
		'desgrasandblend',
		'cw2_mounttrailblank',
		'rocktq128_forestblend2',
		'rocktq128',
		'desclifftypebs',
		'cs_rockdetail2',
		'cuntbrnclifftop',
		'cuntbrncliffbtmbmp',
		'cunt_botrock',
		'stones256',
		'grasstype4blndtomud',
	},
	

	
	['img/35.png'] = {
		 'cloudmasked',
	},
	
	['img/21.png'] = {
         'rocktq128_dirt',
		'newrockgrass_sfw',
		'rocktq128_forestblend',
		'grassbrn2rockbrng',
		'desclifftypebsmix',
		'lasclifface',
		'des_dirt1grass',
		'cunt_toprock',
		--'desertgravelgrassroad',
		'rocktq128_grass4blend',
	},
	['img/24.jpg'] = {
         'des_crackeddirt1',
		'des_redrock1',
		'des_redrock2',
		'cw2_mounttrail',
		'redclifftop256',
		'greyrockbig',
		'rocktb128',
		'hiwayoutside_256',
		'desgrns256',
	},
	
	['img/32.png'] = {
		 'sw_farmroad01',
		'desmudtrail2',
		'desmudtrail3',
		'cw2_weeroad1',
		'dirttracksforest',
		'desmudtrail',
		'dirttracksgrass256',
	},
	['img/33.png'] = {
         'desgreengrasstrckend',
	},
	['img/14.jpg'] = {
		 'ws_traintrax1',
	},

	['img/15.jpg'] = {
		'trainground2',
		'concrete_64hv',
		'concretenewb256',
		'conchev_64hv',
		'rail_stones256',
		'sw_traingravelb1',
		'ws_traingravel',
		--'heliconcrete',
		'metpat64',
	},

	['img/3.jpg'] = {
		 'des_redrockmid',
		'rockwall2_lae2',
		'rocktbrn_dirt2',
		'rock_country128',
		'golf_grassrock',
	},
	['img/loolll.png'] = { 
		 'txgrass0_1',
		'sm_des_bush1',
		'sm_des_bush2',
		'sm_des_bush3',
		'txgrass1_1',
		'newtreeleaves128',
		'coasty_bit4_sfe',
	},

	['img/4.jpg'] = {
		'des_redrockbot',
		'rockwall1_lae2',
		'blendrock2grgrass',
		'stonesandkb2_128',
	},
	['img/19.png'] = {
		 'des_dirttrackx',
	},
--	['img/64.png'] = {
		--'ws_castironwalk',
--		'ws_rottenwall',
		--'ws_sandstone1',
--		'ws_altz_wall10',
--		'3a516e58',
--		'sam_camo',
--		'mp_brick_128',
--		'mp_guardtowerthin_128',
--		'bonyrd_skin2',
--	},
--	['img/ws_wangcar1.jpg'] = { 
--		 'ws_wangcar1',
--	},

--	['img/ws_wangcar2.jpg'] = {
--		 'ws_wangcar2',
--	},
	['img/treeleaves1.png'] = {
		 'treeleaves1',
	},
	['img/txgrassbig0.png'] = {
		'txgrassbig0',
	},

	['img/txgrassbig1.png'] = {
		'txgrassbig1',
	},

	['img/bloodpool_64a.png'] = {
		'bloodpool_64a',
	},
	
	['img/22.png'] = {
		'golf_gravelpath',
		'grass_path_128hv',
		'des_quarryrd',
		'des_quarryrdr',
		'des_quarryrdl',
		'cw2_mounttrail',
		'cw2_mountroad',
		'des_dirttrack1',
	},
	
	['img/2.jpg'] = {
		'des_dirttrack1',
		'des_dirttrackl',
	},
	
	['img/52.png'] = {
		'cw2_mountdirt2grass',
	},
	
	['img/loolll.png'] = {
		'custom_roadsign_text',
		'bullethitsmoke',
		'shad_exp',
		'sm_agave_1',
		'sm_agave_2',
		'sm_minipalm1',
	},
	
	-- ['img/bild.jpg'] = {
		-- 'kaccdepot_256',
		-- 'victim_bboard',
		-- 'semi3dirty',
		-- 'homies_1',
		-- 'heat_04',
		-- 'vgsn_emerald',
		-- 'vgnammuwal2',
	-- },
	
	['img/58.png'] = {
		'ws_sub_pen_conc3',
		'motocross_256',
		'concretenew256128',
		'craproad6_lae',
		'sf_junction5',
		'parking1plain',
		'sidewgrass4',


		'_CMS_T006',
		'terra84',

		'sf_pave4',
		'beachwalk_law',
		'pavebsand256grassblended',
		'ws_woodyhedge',
		'rodeo3sjm',
		'sf_junction3',
		'newpavement',
		'sidewgrass2',
		'sidelatino1_lae',
		'anwfrntbev6',
		'sidewgrass1',
		'carpark_256128',
		'nicepavegras_la',
		'ws_nicepave',
		'yardgrass2',
		'grifnewtex1b',
		'sidewgrass_fuked',
		'concroadslab_256',
		'sl_plazatile01',
		'ap_tarmac',
		'sjmhoodlawn42',
		'sidewgrass5',
		'dockpave_256',
		'grass_concpath_128hv',
		'crossing2_law',
		'laroad_centre1',
		'faketurf_law',
		'sidewgrass3',
		'sjmndukwal2',
		'kbpavement_test',
		'newhedgea',
		'kbpavementblend',
		'backalley1_lae',
		'golf_hedge1',
		'boardwalk_la',
		'cos_hiwayins_256',
		'redstones01_256',
		'pierplanks02_128',
		'greyground256128',
		'rebrckwall_128',
		'luxorfloor02_128',
		'ws_floortiles4',
		'highshopwall1256',
		'crossing_law3',
		'block',
		'crossing_law',
		'ws_carparknew2c',
		'greycrossing',
		'gb_nastybar05',
		--'dt_road_stoplinea',
		'veg_hedge1_256',
		'curb_64h',
		'ws_whitewall2_bottom',
		'plaintarmac1',
		'greyground256',
		'bow_abattoir_conc2',
		'lasunion994',
		'crossing_law2',
		'ws_airpt_concrete',
		'ws_runwaytarmac',
		'ws_carpark2',
		'dustyconcrete',
		'ws_carparknew2a',
		'ws_carparknew2',
		'tarmacplain_bank',
		'monobloc_256128',
		'ws_carparknew2b',
		'concretedust2_256128',
		'concretedust2_line',
		'ws_carparknew1',
		'ws_carpark1',
		'ws_carpark3',
		'bow_grass_gryard',
		'heliconcrete',
		'ws_asphalt2',
	},
	
	['img/98.png'] = {
		'sandnew_law',
		'desertgravel256',
	},
	
	['img/ws_floortiles2.png'] = {
		'ws_floortiles2',
		'brickred2',
		'brickred',
		'indund_64',
		'badmarb1_lan',
	},
	
	
	['img/ashbrnch.png'] = {
		'ashbrnch',
	},
	
	['img/cedarbare.png'] = {
		'cedarbare',
	},
	
	['img/cedarwee.png'] = {
		'cedarwee',
	},
	
	['img/cypress1.png'] = {
		'cypress1',
	},
	
	['img/cypress2.png'] = {
		'cypress2',
	},
	
	['img/Elm_treegrn.png'] = {
		'Elm_treegrn',
	},
	
	['img/Elm_treegrn2.png'] = {
		'Elm_treegrn2',
	},
	
	['img/Elm_treegrn4.png'] = {
		'Elm_treegrn4',
	},
	
	['img/elmtreered.png'] = {
		'elmtreered',
	},
	
	['img/foliage256.png'] = {
		'foliage256',
	},
	
	['img/elmdead.png'] = {
		'elmdead',
	},
	
	['img/Newtreed256.png'] = {
		'Newtreed256',
		'fuzzyplant256',
		'plantc256',
	},
	
	['img/newtreeleavesb128.png'] = {
		'sm_josh_leaf',
		'newtreeleavesb128',
	},
	
	['img/newtreeleaves128.png'] = {
		'newtreeleaves128',
	},
	
	['img/hazelbranch.png'] = {
		'hazelbranch',
	},
	
	['img/hazelbrnch.png'] = {
		'hazelbrnch',
	},
	
	['img/kb_ivy2_256.png'] = {
		'kb_ivy2_256',
	},
	
	['img/kbtree4_test.png'] = {
		'kbtree4_test',
	},
	
	['img/leaf_af_palmtree_b_de.png'] = {
		'sm_minipalm1',
	},
	
	['img/Locustbra.png'] = {
		'Locustbra',
	},
	
	['img/oak2b.png'] = {
		'oak2b',
	},
	
	['img/oakleaf1.png'] = {
		'oakleaf1',
	},
	
	['img/pinebrnch1.png'] = {
		'pinebrnch1',
	},
	
	['img/pinelo128.png'] = {
		'pinelo128',
	},
	
	['img/sm_pinetreebit.png'] = {
		'sm_pinetreebit',
	},
	
	['img/starflower1.png'] = {
		'starflower1',
	},
	
	['img/starflower2.png'] = {
		'starflower2',
	},
	
	['img/starflower3.png'] = {
		'starflower3',
	},
	
	['img/veg_bush2.png'] = {
		'veg_bush2',
	},
	
	['img/veg_bush3.png'] = {
		'veg_bush3',
	},
	
	['img/veg_bush3red.png'] = {
		'veg_bush3red',
	},
	
	['img/veg_bushgrn.png'] = {
		'veg_bushgrn',
	},
	
	['img/veg_bushred.png'] = {
		'veg_bushred',
	},
	
	['img/veg_leaf.png'] = {
		'veg_leaf',
	},
	
	['img/veg_leafred.png'] = {
		'veg_leafred',
	},
	
	['img/weeelm.png'] = {
		'weeelm',
	},
	
	['img/starflower4.png'] = {
		'starflower4',
	},
	
	['img/trunk3.png'] = {
		'trunk3',
	},
	
	['img/sprucbr.png'] = {
		'sprucbr',
	},
	
	['img/spruce1.png'] = {
		'spruce1',
	},
	
	['img/planta256.png'] = {
		'planta256',
	},
	
	['img/plantb256.png'] = {
		'plantb256',
	},
	
	['img/oakleaf2.png'] = {
		'oakleaf2',
	},
	
	['img/pinebranch2.png'] = {
		'pinebranch2',
	},
	
	['img/sf_pave6.png'] = {
		'sf_pave6',
		'pavebsand256',
		'vegaspavement2_256',
		'vegasdirtypave1_256',
		'vegasdirtypave2_256',
		'sl_pavebutt2',
		'blendpavement2b_256',
		'sjmhoodlawn41',
		'craproad5_lae',
	},
	
	['img/sf_tramline2.jpg'] = {
		'sf_tramline2',
	},
	['img/13.jpg'] = {
		 'ws_freeway3blend',
		'ws_freeway3',
		'vegasdirtyroad2_256',
		'vegasroad3_256',
		'sf_road5',
		'laroad_centre1',
		'vegastriproad1_256',
		'vegasroad2_256',
		'hiwayend_256',
		'hiwaymidlle_256',
		'vegasroad1_256',
		'vegasdirtyroad1_256',
		'cos_hiwaymid_256',
		'sl_freew2road1',
		'roadnew4_512',
		'roadnew4_256',
		'dt_road',
		'sl_roadbutt1',
		'craproad1_lae',
		'snpedtest1',
		'roadnew4blend_256',
		'snpedtest1blend',
		'craproad7_lae7',
		'dt_road_stoplinea',
	},
	
	['img/kbplanter_plants1.png'] = {
		'dead_fuzzy',
		'kbplanter_plants1',
		'sm_agave_2',
	},
	
	['img/gras07Si.png'] = {
		'gras07Si',
		'txgrass0_1',
		'txgrass0_2',
		'txgrass0_3',
		'txgrass1_0',
		'txgrass1_1',
		'txgrass1_2',
		'txgrass1_3',
		'sm_des_bush3',
		'sm_agave_1',
	},
	
	['img/dead_agave.png'] = {
		'sm_des_bush2',
		'dead_agave',
		'sm_des_bush1',
	},
}


local toggle = false

shader = {}
for path,texstures in pairs (shaderMap) do
	shader[path] = dxCreateShader("shader.fx")
	texture = dxCreateTexture(path)
	if (shader[path] and texture) then
		dxSetShaderValue(shader[path], "gTexture", texture)
	end
end

function toggleWinter(bool)
	toggle = bool
	for path,texstures in pairs (shaderMap) do
		if bool then
		    for i,txd in ipairs (texstures) do
				engineApplyShaderToWorldTexture(shader[path], txd)
			end
		else
			for i,txd in ipairs (texstures) do
				engineRemoveShaderFromWorldTexture(shader[path], txd)
			end
		end
	end
end

function onDataChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and source == localPlayer and (theKey == "snowmod") then
        if newValue == true then
		toggleWinter(true)
	else
		toggleWinter(false)
        end
    end
end
addEventHandler("onClientElementDataChange", root, onDataChange)

function isWinter()
	return toggle
end