-- FILE: 	mapEditorScriptingExtension_s.lua					 --
-- PURPOSE:	Prevent the map editor feature set being limited by what MTA can load from a map file by adding a script file to maps					 --
-- VERSION:	RemoveWorldObjects (v1) AutoLOD (v1)					 --
					 --
local usedLODModels = {}					 --
					 --
function onResourceStartOrStop ( )					 --
	for _, object in ipairs ( getElementsByType ( "removeWorldObject", source ) ) do					 --
		local model = getElementData ( object, "model" )					 --
		local lodModel = getElementData ( object, "lodModel" )					 --
		local posX = getElementData ( object, "posX" )					 --
		local posY = getElementData ( object, "posY" )					 --
		local posZ = getElementData ( object, "posZ" )					 --
		local interior = getElementData ( object, "interior" ) or 0					 --
		local radius = getElementData ( object, "radius" )					 --
		if ( eventName == "onResourceStart" ) then					 --
			removeWorldModel ( model, radius, posX, posY, posZ, interior )					 --
			removeWorldModel ( lodModel, radius, posX, posY, posZ, interior )					 --
		else					 --
			restoreWorldModel ( model, radius, posX, posY, posZ, interior )					 --
			restoreWorldModel ( lodModel, radius, posX, posY, posZ, interior )					 --
		end					 --
	end					 --
	if (eventName == "onResourceStart" and get(getResourceName(getThisResource())..".useLODs")) then					 --
		for i, object in ipairs(getElementsByType("object", source)) do					 --
			local objID = getElementModel(object)					 --
			local lodModel = LOD_MAP[objID]					 --
			if (lodModel) then					 --
				local x,y,z = getElementPosition(object)					 --
				local rx,ry,rz = getElementRotation(object)					 --
				local lodObj = createObject(lodModel,x,y,z,rx,ry,rz,true)					 --
				setElementInterior(lodObj, getElementInterior(object) )					 --
				setElementDimension(lodObj, getElementDimension(object) )					 --
				setElementParent(lodObj, object)					 --
				setLowLODElement(object, lodObj)					 --
				usedLODModels[lodModel] = true					 --
			end					 --
		end					 --
	end					 --
end					 --
addEventHandler ( "onResourceStart", resourceRoot, onResourceStartOrStop )					 --
addEventHandler ( "onResourceStop", resourceRoot, onResourceStartOrStop )					 --
					 --
function receiveLODsClientRequest()					 --
	triggerClientEvent(client, "setLODsClient", resourceRoot, usedLODModels)					 --
end					 --
addEvent("requestLODsClient", true)					 --
addEventHandler("requestLODsClient", resourceRoot, receiveLODsClientRequest)					 --
					 --
-- MTA LOD Table [object] = [lodmodel]					 --
LOD_MAP = { [17697] = 17768;					 --
[8476] = 8905;	[9476] = 9263;	[4339] = 4472;	[8654] = 8751;	[7465] = 7795;	[8465] = 8744;	[11114] = 11052;	[13872] = 13884;	[6999] = 7120;					 --
[7999] = 8098;	[6959] = 7343;	[9733] = 9644;	[10927] = 11356;	[10759] = 10804;	[8445] = 8478;	[7445] = 7761;	[10928] = 11065;	[9266] = 9475;	[13676] = 13870;					 --
[8554] = 8804;	[5745] = 5827;	[10855] = 11187;	[4813] = 4903;	[8439] = 8910;	[7439] = 7757;	[7043] = 7059;	[8043] = 8111;	[9043] = 9134;	[10384] = 10548;					 --
[9745] = 9873;	[4833] = 4943;	[6979] = 7006;	[13692] = 13766;	[7454] = 7784;	[8454] = 8599;	[11132] = 11208;	[10843] = 10892;	[8513] = 8820;	[13732] = 13770;					 --
[9139] = 9145;	[10903] = 10907;	[5759] = 5917;	[8343] = 8363;	[10948] = 11021;	[4303] = 4437;	[9215] = 9460;	[8533] = 8817;	[17671] = 17788;	[9303] = 9372;					 --
[4533] = 4532;	[8625] = 8794;	[4244] = 4379;	[9613] = 9875;	[13739] = 13772;	[5145] = 5235;	[10793] = 11330;	[9899] = 9635;	[4315] = 4449;	[7315] = 7316;					 --
[6315] = 6424;	[9315] = 9375;	[10833] = 10896;	[4243] = 4378;	[7633] = 7764;	[8633] = 8802;	[8244] = 8024;	[13715] = 13782;	[8525] = 8902;	[5166] = 5336;					 --
[4344] = 4477;	[10823] = 11248;	[4335] = 4468;	[10559] = 10724;	[9065] = 9068;	[5123] = 5213;	[9705] = 9772;	[5028] = 5029;	[9028] = 9179;	[10763] = 10884;					 --
[7045] = 7063;	[8045] = 8011;	[4165] = 4166;	[8512] = 8759;	[8344] = 8364;	[8543] = 8604;	[9039] = 9040;	[6879] = 6891;	[4879] = 4921;	[4345] = 4478;					 --
[9223] = 9406;	[10939] = 11370;	[8868] = 9085;	[10758] = 10923;	[4868] = 5045;	[9345] = 9377;	[11255] = 11262;	[8212] = 8220;	[6065] = 6082;	[7443] = 7859;					 --
[8443] = 8914;	[13672] = 13832;	[13741] = 13765;	[10870] = 11204;	[4366] = 4496;	[4245] = 4380;	[9579] = 9626;	[8611] = 8917;	[8245] = 8025;	[10861] = 11169;					 --
[10352] = 10715;	[4365] = 4529;	[9743] = 9872;	[9066] = 9067;	[13784] = 13836;	[5679] = 5680;	[11254] = 11268;	[9235] = 9450;	[5805] = 5912;	[9711] = 9774;					 --
[13752] = 13876;	[8627] = 8968;	[11120] = 11196;	[9026] = 9178;	[9232] = 9359;	[10018] = 10170;	[10601] = 10730;	[10795] = 11329;	[7368] = 7376;	[8368] = 8367;					 --
[10983] = 11143;	[10752] = 11355;	[13726] = 13786;	[13730] = 13844;	[13801] = 13880;	[7320] = 7322;	[4320] = 4454;	[5021] = 5022;	[9021] = 9181;	[4286] = 4420;					 --
[5109] = 5193;	[8468] = 8972;	[4299] = 4433;	[9286] = 9464;	[9299] = 9374;	[8501] = 9075;	[10817] = 10877;	[6501] = 6504;	[10959] = 10963;	[10905] = 10908;					 --
[7420] = 7812;	[8420] = 9063;	[7321] = 7323;	[4321] = 4455;	[11299] = 11298;	[4847] = 4933;	[10492] = 10729;	[4295] = 4429;	[11332] = 11333;	[9928] = 10002;					 --
[9001] = 9010;	[5034] = 5035;	[8034] = 8126;	[17524] = 17730;	[6488] = 6492;	[8520] = 8829;	[9488] = 9780;	[10932] = 11217;	[7947] = 7948;	[11130] = 11207;					 --
[4268] = 4402;	[7099] = 7112;	[7459] = 7789;	[8459] = 8767;	[11337] = 11358;	[4267] = 4401;	[11256] = 11264;	[9267] = 9477;	[13707] = 13839;	[8588] = 8786;					 --
[11098] = 11177;	[7559] = 7743;	[10753] = 11206;	[10867] = 11185;	[4367] = 4497;	[7367] = 7372;	[8288] = 8289;	[11303] = 11304;	[17606] = 17718;	[10941] = 11167;					 --
[13795] = 13796;	[4828] = 4942;	[4259] = 4393;	[11006] = 11151;	[7101] = 7142;	[9006] = 9015;	[17535] = 17970;	[7388] = 7285;	[7539] = 7959;	[8539] = 8790;					 --
[13820] = 13822;	[6913] = 7178;	[9487] = 9640;	[11126] = 11212;	[11125] = 10802;	[6888] = 7138;	[10864] = 11407;	[5859] = 5903;	[8587] = 8788;	[9587] = 9621;					 --
[8628] = 8799;	[11121] = 11068;	[11138] = 11198;	[8859] = 8861;	[9616] = 9887;	[8616] = 8974;	[13718] = 13888;	[7992] = 8022;	[13826] = 13830;	[9137] = 9143;					 --
[4822] = 4980;	[8137] = 8197;	[5137] = 5195;	[6948] = 7005;	[5472] = 5564;	[8377] = 8021;	[7636] = 7724;	[10966] = 11050;	[8472] = 8912;	[9690] = 9686;					 --
[9919] = 9937;	[13810] = 13812;	[7417] = 7726;	[4294] = 4428;	[4851] = 4902;	[10489] = 10602;	[9256] = 9393;	[5871] = 5970;	[13736] = 13778;	[8256] = 8257;					 --
[4831] = 4950;	[9597] = 9844;	[4256] = 4390;	[7536] = 7821;	[6951] = 7002;	[6991] = 7176;	[10936] = 11158;	[7991] = 8088;	[3992] = 4037;	[4991] = 5012;					 --
[3991] = 4043;	[5752] = 5833;	[13678] = 13853;	[9571] = 9650;	[13716] = 13833;	[7730] = 7780;	[5748] = 5907;	[9730] = 9792;	[17686] = 17914;	[7604] = 7808;					 --
[13733] = 13780;	[13682] = 13868;	[9836] = 9841;	[9490] = 9809;	[8490] = 8703;	[8217] = 8223;	[9719] = 9779;	[9217] = 9449;	[6217] = 6086;	[10766] = 10880;					 --
[9716] = 9773;	[5504] = 5548;	[4363] = 4494;	[9037] = 9038;	[8037] = 8103;	[10904] = 10906;	[8677] = 8752;	[10408] = 10689;	[9351] = 9421;	[13813] = 13815;					 --
[13717] = 13785;	[8351] = 8347;	[7557] = 7816;	[7602] = 7810;	[7317] = 7318;	[4351] = 4483;	[6952] = 7003;	[4317] = 4451;	[7263] = 7279;	[13680] = 13869;					 --
[8352] = 8359;	[4263] = 4397;	[10930] = 11054;	[4331] = 4465;	[4872] = 4924;	[8521] = 8830;	[9216] = 9457;	[11351] = 11222;	[11288] = 10895;	[6324] = 6380;					 --
[4897] = 4905;	[6897] = 6902;	[8451] = 8973;	[7451] = 7815;	[4884] = 5054;	[6884] = 6896;	[6236] = 6240;	[9236] = 9402;	[4324] = 4458;	[9304] = 9376;					 --
[13723] = 13819;	[7470] = 7799;	[8630] = 8798;	[7452] = 7794;	[8452] = 8606;	[8421] = 8692;	[7421] = 7809;	[8380] = 8381;	[10940] = 11191;	[13742] = 13764;					 --
[11363] = 11398;	[7591] = 7830;	[9224] = 9394;	[9551] = 9883;	[9083] = 9084;	[7997] = 8362;	[4352] = 4484;	[17597] = 17837;	[10362] = 10325;	[11113] = 11197;					 --
[5117] = 5194;	[9136] = 9142;	[9330] = 9432;	[4330] = 4464;	[9552] = 9884;	[8552] = 8763;	[8531] = 8775;	[7337] = 7338;	[4664] = 4665;	[9337] = 9433;					 --
[5156] = 5162;	[4156] = 4157;	[4337] = 4470;	[10363] = 10326;	[7651] = 7699;	[4890] = 4946;	[8857] = 8862;	[9617] = 9888;	[17683] = 17720;	[9492] = 9794;					 --
[13882] = 13842;	[9652] = 9799;	[8631] = 8800;	[7631] = 7744;	[13713] = 13843;	[8056] = 8028;	[4316] = 4375;	[4296] = 4430;	[10769] = 10894;	[13691] = 13745;					 --
[9316] = 9428;	[11104] = 11341;	[7990] = 8015;	[4283] = 4417;	[10751] = 10798;	[10934] = 11219;	[4990] = 5010;	[4336] = 4469;	[9957] = 9972;	[10151] = 10161;					 --
[6301] = 6500;	[4301] = 4435;	[4371] = 4501;	[8148] = 8273;	[5148] = 5359;	[4242] = 4377;	[7242] = 7140;	[9022] = 9182;	[9242] = 9401;	[4282] = 4416;					 --
[7464] = 7782;	[8040] = 8104;	[7371] = 7373;	[8464] = 9157;	[5119] = 5245;	[7450] = 7814;	[8450] = 8479;	[10969] = 11166;	[17677] = 17908;	[7484] = 7773;					 --
[11107] = 11108;	[9484] = 9869;	[10407] = 10688;	[8091] = 8101;	[13709] = 13835;	[7248] = 7256;	[8382] = 8384;	[4585] = 4626;	[4248] = 4383;	[6122] = 6182;					 --
[11342] = 11344;	[7963] = 7964;	[4332] = 4466;	[10418] = 10727;	[9071] = 9073;	[10819] = 10881;	[7071] = 7183;	[8071] = 8106;	[4262] = 4396;	[10294] = 10299;					 --
[4550] = 4561;	[11287] = 11286;	[5151] = 5241;	[9585] = 9619;	[6188] = 6190;	[5188] = 5240;	[13690] = 13773;	[9219] = 9452;	[8219] = 8222;	[4843] = 4931;					 --
[4131] = 4132;	[4885] = 5053;	[7042] = 7066;	[4260] = 4394;	[7863] = 7876;	[8240] = 8241;	[10017] = 9989;	[10945] = 11016;	[8586] = 8789;	[4863] = 4934;					 --
[10562] = 10598;	[6280] = 6437;	[4291] = 4425;	[7251] = 7259;	[7432] = 7738;	[13751] = 13781;	[9260] = 9380;	[4297] = 4431;	[9291] = 9447;	[7048] = 7107;					 --
[9248] = 9408;	[11077] = 11058;	[4271] = 4405;	[10087] = 10168;	[4322] = 4456;	[5160] = 5335;	[9231] = 9363;	[9140] = 9146;	[4168] = 4169;	[8446] = 8605;					 --
[9486] = 9641;	[10351] = 10719;	[8486] = 8749;	[4280] = 4414;	[8350] = 8358;	[8532] = 8771;	[4240] = 4450;	[4350] = 4482;	[9683] = 9866;	[7984] = 8124;					 --
[6984] = 7282;	[10957] = 11378;	[11229] = 11216;	[8391] = 8696;	[10066] = 10090;	[4845] = 4914;	[11115] = 11171;	[7548] = 7774;	[11367] = 11368;	[7864] = 7875;					 --
[6864] = 6870;	[7865] = 7874;	[13677] = 13867;	[13710] = 13840;	[8610] = 8918;	[7632] = 7745;	[8632] = 8801;	[8850] = 8965;	[8519] = 8897;	[8983] = 9018;					 --
[8845] = 8848;	[6983] = 7283;	[7983] = 8107;	[6916] = 7225;	[9954] = 10106;	[8079] = 8110;	[4563] = 4566;	[11012] = 11270;	[5115] = 5252;	[5002] = 4939;					 --
[9115] = 9161;	[10638] = 10640;	[4883] = 4929;	[10491] = 10725;	[6883] = 7114;	[7854] = 7853;	[17685] = 17742;	[4854] = 5050;	[4348] = 4480;	[10971] = 11064;					 --
[9946] = 10257;	[4810] = 4915;	[4832] = 4948;	[7463] = 7793;	[7057] = 7126;	[4319] = 4453;	[7383] = 7384;	[8383] = 8385;	[4852] = 4918;	[7485] = 7776;					 --
[11345] = 11346;	[7852] = 7851;	[11080] = 11178;	[4846] = 4953;	[7448] = 7817;	[10938] = 11144;	[13757] = 13881;	[11137] = 11203;	[7965] = 7966;	[5003] = 4956;					 --
[10694] = 10728;	[9584] = 9620;	[8584] = 8732;	[7584] = 7716;	[9348] = 9429;	[8824] = 8903;	[8003] = 8092;	[10028] = 9967;	[7475] = 7804;	[11252] = 11267;					 --
[8475] = 8915;	[8678] = 8777;	[4835] = 4941;	[4349] = 4481;	[11135] = 11200;	[11111] = 11175;	[10955] = 11397;	[8523] = 8900;	[10386] = 10731;	[13673] = 13850;					 --
[7444] = 7873;	[8444] = 8908;	[9735] = 9802;	[7969] = 7970;	[10840] = 10912;	[7449] = 7813;	[8449] = 8907;	[4869] = 4954;	[8466] = 8745;	[6869] = 6995;					 --
[5744] = 5826;	[9744] = 9871;	[10943] = 11142;	[4275] = 4409;	[9174] = 8831;	[13693] = 13774;	[7174] = 7366;	[10083] = 10169;	[6878] = 6890;	[17607] = 17810;					 --
[9723] = 9781;	[8149] = 8274;	[13738] = 13771;	[9858] = 9811;	[8858] = 8864;	[7433] = 7740;	[11083] = 11153;	[4249] = 4384;	[4535] = 4536;	[9901] = 9963;					 --
[11134] = 11278;	[7249] = 7257;	[10405] = 10687;	[5801] = 5828;	[4666] = 4667;	[7544] = 7752;	[8544] = 8739;	[11117] = 11069;	[8422] = 8693;	[11116] = 11053;					 --
[9601] = 9807;	[6989] = 6906;	[4374] = 4503;	[9225] = 9409;	[5313] = 5316;	[4313] = 4447;	[9313] = 9396;	[8313] = 8316;	[4302] = 4436;	[6054] = 6177;					 --
[7054] = 7339;	[8054] = 8018;	[9721] = 9638;	[6233] = 6242;	[4233] = 4234;	[8433] = 8736;	[7603] = 7807;	[10917] = 10918;	[3689] = 3690;	[4325] = 4459;					 --
[9715] = 9776;	[10942] = 11168;	[8154] = 8279;	[9689] = 9687;	[8049] = 8026;	[11127] = 11180;	[5333] = 5334;	[4333] = 4467;	[9205] = 9358;	[8133] = 8144;					 --
[13756] = 13879;	[10354] = 10332;	[6502] = 6506;	[11343] = 11357;	[9615] = 9658;	[7254] = 7262;	[10359] = 10692;	[9276] = 9453;	[4305] = 4439;	[4254] = 4388;					 --
[5033] = 5055;	[11123] = 11192;	[10929] = 11055;	[9233] = 9356;	[10767] = 10879;	[3489] = 3490;	[11118] = 11194;	[4274] = 4408;	[6213] = 6206;	[8213] = 8224;					 --
[9213] = 9455;	[9489] = 9782;	[8489] = 8700;	[8515] = 8754;	[4354] = 4486;	[5176] = 5237;	[9703] = 9785;	[7967] = 7968;	[9004] = 9013;	[7950] = 7949;					 --
[7945] = 7946;	[8004] = 8161;	[5004] = 5008;	[7938] = 7937;	[7889] = 7890;	[10365] = 10328;	[7882] = 7883;	[7324] = 7325;	[7880] = 7887;	[7868] = 7870;					 --
[7867] = 7871;	[7866] = 7872;	[7849] = 7850;	[7011] = 7121;	[10852] = 11186;	[7755] = 7856;	[7731] = 7781;	[7729] = 7779;	[7661] = 7723;	[7660] = 7721;					 --
[7650] = 7700;	[11283] = 11361;	[7635] = 7725;	[9210] = 9465;	[8210] = 8272;	[7634] = 7775;	[7630] = 7722;	[7629] = 7777;	[7616] = 7728;	[4310] = 4444;					 --
[7605] = 7739;	[7601] = 7811;	[7600] = 7806;	[7593] = 7831;	[7592] = 7828;	[7585] = 7594;	[13825] = 13829;	[7579] = 7825;	[7558] = 7742;	[7555] = 7668;					 --
[7553] = 7824;	[4289] = 4423;	[7552] = 7749;	[7551] = 7750;	[9289] = 9454;	[7550] = 7751;	[4288] = 4422;	[7547] = 7748;	[7546] = 7732;	[7545] = 7747;					 --
[17675] = 17811;	[7537] = 7822;	[13684] = 13776;	[7486] = 7869;	[10859] = 10803;	[7483] = 7772;	[8517] = 8898;	[7482] = 7771;	[7481] = 7770;	[7480] = 7769;					 --
[7479] = 7768;	[8039] = 8100;	[8172] = 8094;	[7476] = 7765;	[7474] = 7803;	[4247] = 4382;	[7472] = 7801;	[7471] = 7800;	[8128] = 8129;	[7468] = 7888;					 --
[6957] = 7293;	[7466] = 7796;	[5314] = 5315;	[9064] = 9069;	[7460] = 7790;	[8002] = 8142;	[13702] = 13885;	[11258] = 11265;	[9211] = 9466;	[7457] = 7787;					 --
[9722] = 9783;	[7455] = 7785;	[7453] = 7783;	[9036] = 9147;	[8036] = 8102;	[10413] = 10330;	[7447] = 7763;	[7446] = 7762;	[7442] = 7760;	[7441] = 7759;					 --
[7440] = 7758;	[7438] = 7756;	[7437] = 7754;	[7436] = 7858;	[7435] = 7746;	[10958] = 11201;	[7431] = 7737;	[10935] = 11220;	[7430] = 7736;	[7429] = 7735;					 --
[7428] = 7734;	[9246] = 9403;	[7424] = 7702;	[7422] = 7805;	[7419] = 7487;	[11105] = 11213;	[7416] = 7727;	[8378] = 8379;	[9057] = 9061;	[8356] = 8105;					 --
[6974] = 7113;	[6915] = 7181;	[8354] = 8348;	[8353] = 8365;	[11097] = 11157;	[8333] = 8280;	[8315] = 8318;	[11230] = 11276;	[8314] = 8317;	[8311] = 8312;					 --
[5795] = 5921;	[13821] = 13849;	[7051] = 7060;	[8510] = 8760;	[8305] = 8304;	[8469] = 8747;	[11073] = 11172;	[8300] = 8301;	[10815] = 11373;	[8283] = 8284;					 --
[8480] = 8690;	[6900] = 6901;	[8263] = 8267;	[4278] = 4412;	[8262] = 8270;	[8260] = 8261;	[9553] = 9845;	[4285] = 4419;	[5749] = 5918;	[8254] = 8113;					 --
[11364] = 11141;	[8498] = 8705;	[8246] = 8031;	[10967] = 11066;	[8236] = 8238;	[8232] = 8233;	[8228] = 8234;	[4292] = 4426;	[11071] = 11173;	[8216] = 8227;					 --
[10792] = 11218;	[4258] = 4392;	[8215] = 8226;	[17673] = 17787;	[4369] = 4499;	[6871] = 7122;	[9234] = 9397;	[8202] = 8203;	[10403] = 10690;	[8201] = 8239;					 --
[10865] = 11325;	[6917] = 7180;	[8200] = 8205;	[8199] = 8204;	[9000] = 9009;	[10794] = 11331;	[8186] = 8191;	[7477] = 7766;	[8477] = 8602;	[13720] = 13837;					 --
[4849] = 5018;	[8171] = 8361;	[7998] = 8095;	[8165] = 8266;	[8155] = 8276;	[11095] = 11350;	[9056] = 9060;	[8152] = 8278;	[8151] = 8268;	[8150] = 8275;					 --
[8147] = 8271;	[4357] = 4488;	[4358] = 4489;	[8136] = 8138;	[8135] = 8140;	[8357] = 8360;	[7469] = 7798;	[11075] = 11062;	[8080] = 8096;	[8072] = 8143;					 --
[11088] = 11282;	[8070] = 8141;	[10946] = 11403;	[13887] = 13788;	[8052] = 8017;	[8051] = 8032;	[4266] = 4400;	[8048] = 8020;	[4328] = 4462;	[8046] = 8019;					 --
[7478] = 7767;	[8577] = 8743;	[7549] = 7753;	[10863] = 10922;	[8035] = 8112;	[6094] = 6144;	[9094] = 9096;	[11072] = 11061;	[11260] = 11266;	[11335] = 11109;					 --
[6130] = 6255;	[8010] = 8090;	[8009] = 8030;	[8008] = 8296;	[4304] = 4438;	[8006] = 8211;	[8005] = 8097;	[8458] = 8598;	[7458] = 7788;	[8001] = 8093;					 --
[8585] = 8733;	[7996] = 8099;	[7995] = 8029;	[9732] = 9791;	[17676] = 17727;	[7989] = 8014;	[7988] = 8089;	[7987] = 8109;	[7985] = 8258;	[7978] = 8108;					 --
[10860] = 10805;	[7370] = 7374;	[7369] = 7375;	[7364] = 7365;	[7362] = 7363;	[9578] = 9627;	[8398] = 8778;	[10364] = 10327;	[7359] = 7360;	[7357] = 7358;					 --
[11122] = 11193;	[6981] = 7281;	[9302] = 9371;	[7347] = 7346;	[7336] = 7119;	[7335] = 7341;	[4276] = 4410;	[7327] = 7328;	[9062] = 8773;	[7881] = 7855;					 --
[6881] = 6892;	[4269] = 4403;	[6899] = 6904;	[7098] = 7152;	[7253] = 7261;	[9710] = 9806;	[8448] = 8906;	[11128] = 11349;	[7203] = 6895;	[10230] = 10141;					 --
[9173] = 8750;	[4840] = 4911;	[13818] = 13886;	[7240] = 7241;	[7220] = 7182;	[7218] = 7136;	[7217] = 7130;	[9929] = 10251;	[8609] = 8919;	[10854] = 11188;					 --
[7247] = 7255;	[4364] = 4495;	[7192] = 7194;	[7191] = 7195;	[8634] = 8967;	[4346] = 4531;	[4293] = 4427;	[7100] = 7143;	[11003] = 11057;	[13683] = 13859;					 --
[9725] = 9646;	[9949] = 9964;	[4253] = 4530;	[9708] = 9810;	[7056] = 7125;	[7055] = 7116;	[7053] = 7067;	[4306] = 4440;	[4841] = 4959;	[8461] = 8766;					 --
[9306] = 9398;	[8306] = 8307;	[8629] = 8796;	[7049] = 7108;	[6880] = 7106;	[9254] = 9364;	[7044] = 7168;	[10926] = 11165;	[10937] = 11067;	[7036] = 7137;					 --
[7022] = 7193;	[4355] = 4534;	[5355] = 5356;	[7013] = 7348;	[6990] = 7008;	[8612] = 8779;	[4246] = 4381;	[5347] = 5348;	[6988] = 6992;	[9726] = 9867;					 --
[9900] = 9936;	[6982] = 7284;	[7355] = 7356;	[8355] = 8349;	[6971] = 7174;	[8860] = 8863;	[7467] = 7797;	[6956] = 7110;	[7427] = 7733;	[6950] = 7001;					 --
[9002] = 9011;	[9206] = 9467;	[6945] = 7109;	[8467] = 8753;	[4834] = 4922;	[9264] = 9474;	[13689] = 13856;	[8460] = 8756;	[17944] = 17945;	[6912] = 7177;					 --
[8264] = 8265;	[7264] = 7278;	[5882] = 5884;	[6882] = 6894;	[6898] = 6903;	[10965] = 11051;	[6886] = 6911;	[6885] = 7007;	[6887] = 6893;	[4842] = 4932;					 --
[8053] = 8016;	[8626] = 8797;	[17678] = 17707;	[11100] = 11183;	[8255] = 8159;	[7047] = 7061;	[8047] = 8013;	[9255] = 9392;	[10849] = 10853;	[5143] = 5242;					 --
[8672] = 8768;	[9117] = 9148;	[4284] = 4418;	[4862] = 4935;	[6877] = 6889;	[6876] = 7135;	[10454] = 10732;	[10818] = 10876;	[9214] = 9463;	[8214] = 8225;					 --
[6867] = 6939;	[4340] = 4473;	[9709] = 9805;	[13703] = 13857;	[10871] = 10902;	[11302] = 11309;	[4264] = 4398;	[9261] = 9400;	[4314] = 4448;	[5147] = 5263;					 --
[6863] = 6927;	[9119] = 9155;	[13823] = 13827;	[9284] = 9469;	[7353] = 7354;	[13737] = 13767;	[5353] = 5354;	[8542] = 8785;	[5995] = 5997;	[4353] = 4485;					 --
[4341] = 4474;	[9116] = 9156;	[10961] = 10964;	[9265] = 9473;	[7514] = 7680;	[8514] = 8776;	[17582] = 17745;	[6227] = 6244;	[8440] = 8920;	[13711] = 13883;					 --
[5758] = 5915;	[13814] = 13787;	[10768] = 10882;	[7064] = 7068;	[10933] = 11216;	[8562] = 8784;	[9135] = 9141;	[11106] = 11336;	[8932] = 8933;	[8411] = 8413;					 --
[17594] = 17759;	[8209] = 8269;	[11005] = 11161;	[10821] = 11250;	[13816] = 13877;	[9581] = 9629;	[17670] = 17786;	[6234] = 6241;	[13824] = 13828;	[9095] = 9097;					 --
[8055] = 8027;	[4360] = 4491;	[4343] = 4476;	[10848] = 11190;	[10777] = 11375;	[4312] = 4446;	[9082] = 8949;	[10778] = 11227;	[9727] = 9789;	[9076] = 9077;					 --
[9072] = 8694;	[8485] = 8699;	[7580] = 7778;	[9706] = 9803;	[9580] = 9628;	[10305] = 10304;	[7461] = 7791;	[4540] = 4541;	[5747] = 5908;	[4326] = 4460;					 --
[4361] = 4492;	[4342] = 4475;	[10822] = 11251;	[9243] = 9378;	[7326] = 7329;	[9249] = 9451;	[8134] = 8139;	[8153] = 8277;	[13706] = 13838;	[10956] = 11377;					 --
[9342] = 9471;	[3755] = 3756;	[9042] = 9158;	[8342] = 8366;	[13719] = 13841;	[4362] = 4493;	[4827] = 4960;	[9090] = 9091;	[9714] = 9775;	[4287] = 4421;					 --
[10301] = 10302;	[17684] = 17721;	[9024] = 9183;	[9023] = 9180;	[5807] = 5910;	[8522] = 8899;	[4298] = 4432;	[4373] = 4537;	[4020] = 4061;	[5105] = 5246;					 --
[9908] = 9970;	[8447] = 8601;	[13871] = 13873;	[8655] = 8762;	[7186] = 7185;	[9712] = 9800;	[11124] = 11189;	[9226] = 9470;	[7434] = 7741;	[11131] = 10800;					 --
[8482] = 8691;	[3814] = 3815;	[9287] = 9461;	[9003] = 9012;	[8442] = 8909;	[10353] = 10331;	[6949] = 7000;	[8198] = 8298;	[9120] = 9160;	[8882] = 8924;					 --
[9212] = 9456;	[8867] = 8950;	[4334] = 4528;	[9614] = 9662;	[9570] = 9796;	[4323] = 4457;	[9251] = 9355;	[4829] = 4951;	[4273] = 4407;	[7462] = 7792;					 --
[8710] = 8711;	[11094] = 11152;	[4309] = 4443;	[7046] = 7062;	[8511] = 8761;	[5046] = 5047;	[8671] = 8769;	[8664] = 8755;	[5276] = 5284;	[8547] = 8742;					 --
[8663] = 8704;	[7334] = 7340;	[9582] = 9755;	[10816] = 10878;	[5134] = 5321;	[4809] = 4904;	[10834] = 10899;	[8637] = 8772;	[8050] = 8012;	[9290] = 9448;					 --
[8462] = 8757;	[7050] = 7065;	[6290] = 6505;	[10862] = 11159;	[8290] = 8291;	[10451] = 10726;	[10931] = 11221;	[8624] = 8793;	[10295] = 10298;	[8622] = 8780;					 --
[9493] = 9636;	[4265] = 4399;	[9530] = 9843;	[7069] = 7070;	[8000] = 8164;	[8455] = 8894;	[17674] = 17800;	[8583] = 8731;	[8582] = 8730;	[11084] = 11170;					 --
[8564] = 8803;	[4368] = 4498;	[8561] = 8783;	[5112] = 5255;	[4129] = 4130;	[8555] = 8709;	[8553] = 8764;	[11074] = 11056;	[4261] = 4395;	[4327] = 4461;					 --
[8541] = 8787;	[8394] = 8823;	[6873] = 6918;	[8540] = 8791;	[9222] = 9360;	[8033] = 8346;	[8524] = 8901;	[9138] = 9144;	[4281] = 4415;	[5746] = 5830;					 --
[10962] = 11338;	[5860] = 5920;	[10820] = 11249;	[7041] = 7058;	[8499] = 8929;	[8497] = 8748;	[4279] = 4413;	[9070] = 9074;	[17672] = 17789;	[10866] = 11184;					 --
[8281] = 8282;	[9118] = 9149;	[8474] = 8916;	[8471] = 8600;	[8470] = 8746;	[5118] = 5209;	[8463] = 8765;	[10960] = 11415;	[4230] = 4229;	[7052] = 7129;					 --
[6914] = 7179;	[8453] = 8603;	[8457] = 8904;	[7250] = 7258;	[9301] = 9373;	[9250] = 9354;	[10036] = 10272;	[8441] = 8895;	[9600] = 9643;	[9262] = 9472;					 --
[9285] = 9462;	[9025] = 9177;	[10954] = 11049;	[10409] = 10495;	[9591] = 9784;	[10851] = 10909;	[4250] = 4385;	[5250] = 5251;	[8392] = 8698;	[10027] = 9939;					 --
[4257] = 4391;	[13735] = 13779;	[13845] = 13847;	[5038] = 5039;	[8393] = 8697;	[8396] = 8708;	[8038] = 8125;	[4370] = 4500;	[13708] = 13834;	[8390] = 8695;					 --
[9288] = 9458;	[10869] = 11181;	[9747] = 9651;	[13740] = 13750;	[9736] = 9637;	[7994] = 8297;	[9150] = 9151;	[5994] = 5996;	[9731] = 9790;	[9338] = 9399;					 --
[11139] = 11160;	[10300] = 10303;	[13674] = 13848;	[10756] = 10924;	[13789] = 13851;	[9724] = 9788;	[4241] = 4376;	[7456] = 7786;	[4338] = 4471;	[9269] = 9478;					 --
[4870] = 4944;	[9300] = 9370;	[8456] = 8758;	[11112] = 11063;	[11129] = 11348;	[10857] = 11205;	[7993] = 8023;	[5270] = 5281;	[4252] = 4387;	[9208] = 9446;					 --
[4300] = 4434;	[9005] = 9014;	[4318] = 4452;	[9252] = 9357;	[4307] = 4441;	[7252] = 7260;	[11297] = 11300;	[9602] = 9648;	[10755] = 10883;	[4359] = 4490;					 --
[9696] = 9695;	[10850] = 10919;	[13698] = 13763;	[13675] = 13852;	[11136] = 11202;	[5296] = 5307;	[4875] = 4916;	[8438] = 8770;	[9693] = 9691;	[9685] = 9684;					 --
[9609] = 9877;	[5146] = 5236;	[4277] = 4411;	[4653] = 4655;	[9207] = 9468;	[11306] = 11310;	[9653] = 9654;	[4308] = 4442;	[9593] = 9813;	[5754] = 5909;					 --
[8844] = 8847;	[8308] = 8309;	[13704] = 13846;	[11253] = 11263;	[4844] = 4957;	[8189] = 8193;	[10771] = 10901;	[4207] = 4036;	[9729] = 9787;	[10296] = 10297;					 --
[4838] = 4940;	[9491] = 9645;	[4356] = 4487;	[8473] = 8913;	[7473] = 7802;	[11365] = 11366;	[11362] = 11399;	[4538] = 4539;	[9720] = 9639;	[11010] = 11048;					 --
[5767] = 5964;	[8538] = 8792;	[11326] = 11328;	[11308] = 11307;	[4866] = 4937;	[6953] = 7004;	[6866] = 7139;	[5866] = 5880;	[6507] = 6512;	[5757] = 5914;					 --
[4255] = 4389;	[11133] = 11210;	[5802] = 5832;	[11119] = 11195;	[10385] = 10721;	[9008] = 9017;	[4107] = 4035;	[5107] = 5365;	[5106] = 5264;	[8518] = 8896;					 --
[5862] = 5923;	[9694] = 9692;	[11096] = 11211;	[11079] = 11059;	[4820] = 4952;	[11078] = 11070;	[13700] = 13775;	[10788] = 11369;	[11076] = 11176;	[5756] = 5913;					 --
[9209] = 9459;	[10970] = 11174;	[8638] = 8911;	[9027] = 9176;	[4272] = 4406;	[5796] = 5922;	[9007] = 9016;	[8007] = 8295;	[9907] = 9935;	[4311] = 4445;					 --
[9218] = 9445;	[6048] = 6131;	[5108] = 5211;	[5861] = 5899;	[4329] = 4463;	[6292] = 6503;	[10858] = 11179;	[8218] = 8221;	[13686] = 13769;	[4867] = 4938;					 --
[3816] = 3817;	[5009] = 4955;	[10868] = 11182;	[13688] = 13854;	[9529] = 9531;	[8529] = 8774;	[5797] = 5925;	[10404] = 10577;	[10791] = 10801;	[10790] = 11209;					 --
[4290] = 4424;	[4251] = 4386;	[5167] = 5159;	[13809] = 13811;	[10750] = 10799;	[4270] = 4404;	[10453] = 10733;	[4372] = 4502;	[9707] = 9804;	[5753] = 5834;					 --
[10387] = 10329;	[6229] = 6246;	[5707] = 5905;	[13685] = 13858;	[5297] = 5320;	[4163] = 4164;	[10968] = 11199;	[13734] = 13768;	[3707] = 3708;	[6189] = 6191;					 --
[9718] = 9778;	[4865] = 4936;	[9608] = 9657;	[6944] = 7111;					 --
}					 --
