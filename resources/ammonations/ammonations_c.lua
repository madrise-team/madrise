localPlayer = getLocalPlayer()					 --
-------------------------------------------------------------------------------					 --
					 --
-------------------------------------------------------------------------------					 --
function y_answer(_,_,weaponInfo)					 --
	--outputChatBox(tostring(weaponInfo))					 --
	if getPlayerMoney() >= weaponInfo.cost then					 --
		triggerServerEvent("y_buyer",root,localPlayer, weaponInfo)					 --
	else					 --
		outputChatBox("У вас денег нет!", thePlayer)					 --
		unbindBuy()					 --
	end					 --
end					 --
function n_answer()					 --
	unbindBuy()					 --
end					 --
					 --
BrainStromWeapons = {{"colt 45",346},{"silenced",347},{"uzi",352},{"mp5",353},{"ak-47",355},{"m4",356},{"tec-9",372},{"rifle",357}}					 --
					 --
rlsc = exports.RRL_scripts					 --
					 --
function AMMOclearer(ont,minVal,maxVal)					 --
	local ont = ont					 --
	if ont > 1 then ont = 1 end					 --
	if ont < 0 then ont = 0 end					 --
	local val = minVal + (maxVal - minVal)*ont					 --
	return val					 --
end					 --
function getWeaponsSpecText(otn,text)					 --
	local textW = #text					 --
	local valer = AMMOclearer(otn,0,textW)					 --
	return text:sub(0,valer)					 --
end					 --
function drawAvtoAmmo() 									-- Михан пофикси !!!					 --
						 --
	local frame = 0					 --
	local ready = false					 --
	local mode = 1					 --
					 --
	addEventHandler("onClientRender",root,function()    					 --
		frame = frame + mode							 --
		if frame > 800 and (not ready) then					 --
			frame = 0					 --
			ready = true					 --
		end					 --
		if ready then					 --
			local frL = 150					 --
			local frL2 = 80					 --
			local frLA = 100					 --
			local bp1 = AMMOclearer(frame/frL,-1600,600);	local bp2 = AMMOclearer(frame/frL,1000,600)					 --
			local p1 = AMMOclearer(frame/frL,-600,600);	local p2 = AMMOclearer(frame/frL,600,600)					 --
			local p1e = AMMOclearer(frame/frL,0,1300);	local p2e = AMMOclearer(frame/frL,600,600)					 --
					 --
			local dl1 = AMMOclearer(frame/frL,1800,600 - 100);	local dl2 = AMMOclearer(frame/frL,800,800)					 --
			local dl1e = AMMOclearer(frame/frL,1800,1300 - 100);	local dl2e = AMMOclearer(frame/frL,800,800)					 --
					 --
			local colocer = tocolor(255,255,255,AMMOclearer(frame/frLA,0,255))					 --
			local colocerB = tocolor(90,90,90,AMMOclearer(frame/frLA,0,190))					 --
			local a2 = (frame-frL - 50)/frL2					 --
			local colocer2 = tocolor(255,255,255,AMMOclearer(a2,0,255))					 --
					 --
			dxDrawLine (p1,p2, p1e,p2e, colocer, 5)					 --
			dxDrawLine (dl1,dl2, dl1e,dl2e, colocer, 5)					 --
								 --
			local vrl1 = AMMOclearer(frame/frL, 2000,p1); local vrl2 = AMMOclearer(frame/frL, -1000,dl2 + 10); local vrl2e = AMMOclearer(frame/frL, -1800,p2 - 10)					 --
			dxDrawLine (vrl1+10,vrl2e, vrl1 - 90, vrl2, colocer, 5)					 --
					 --
			local prl1 = AMMOclearer(frame/frL, 1000,dl1e); local prl2 = AMMOclearer(frame/frL, 2000,dl2 + 10); local prl2e = AMMOclearer(frame/frL, 1800,p2 - 10)					 --
			dxDrawRectangle(bp1-60,bp2+16,750,170,colocerB)					 --
					 --
			dxDrawLine (prl1-10 + 100,prl2e, prl1 - 10, prl2, colocer, 5)					 --
					 --
			dxDrawLine (p1 + 220,p2,p1 + 220 -100,dl2, colocer2, 4)					 --
				--- outputChatBox("Мусора сосать")					 --
			local rete = math.sin(frame/15)*12					 --
					 --
			dxDrawImage(590,625,160,160,":Draws/Elements/BS/MiniWin/photo.png",rete,0,0,colocer2)					 --
					 --
			local f21 = (frame - 250)/150					 --
			dxDrawText(getWeaponsSpecText(f21,  rlsc:getScript("s1")  ),835,625,1000,1000,colocer2,1.5)					 --
					 --
			local f22 = (frame - 450)/75					 --
			dxDrawText(getWeaponsSpecText(f22, rlsc:getScript("s2")  ),815,665,1000,1000,colocer2,1.5)					 --
					 --
			if frame > 700  and mode == 1 then					 --
				frame = 1500					 --
				mode = -10					 --
			end					 --
			if frame == -500 then 					 --
				local s = playSound3D (":Draws/Elements/BS/WeaponIcons/ammoSounds1.mp3", 2487.02783,-1665.55371, 35, false )					 --
				setSoundMaxDistance(s,1000)					 --
				setSoundEffectEnabled(s, "reverb", true)					 --
					 --
				triggerServerEvent("loatay",root,localPlayer)					 --
				triggerServerEvent("message",root,"Ammo: Стартовая позиция объекта скоррекирована")					 --
				triggerEvent("vehPosAdd",root,BrainStromWeapons,400)					 --
					 --
				setTimer(function()					 --
					setTimer(function()					 --
						local s = playSound3D (":Draws/Elements/BS/WeaponIcons/ammoSounds1.mp3", 2487.02783 + math.random(-20,20),-1665.55371  + math.random(-20,20), 30, false )					 --
						setSoundMaxDistance(s,1000)					 --
						setSoundEffectEnabled(s, "flanger", true)					 --
					end,10000,87)					 --
				end,32000,1)					 --
					 --
			end					 --
		end					 --
		--AMMOclearer()					 --
					 --
	end)					 --
end;addEvent("checkAvto",true);					 --
addEventHandler("checkAvto",root,function()					 --
	local isPlayerHaveCannon = exports.cannons:getPlayerCanonPosition()					 --
	outputConsole(tostring(isPlayerHaveCannon))					 --
	if isPlayerHaveCannon then 					 --
		setTimer(function()	playSound(":RRL_scripts/mkvd.mp3") end,13000,1)					 --
		drawAvtoAmmo() 					 --
	end					 --
end)					 --
					 --
--triggerEvent("vehPosAdd",root,BrainStromWeapons,400)					 --
					 --
function bindBuy(weaponInfo)					 --
	bindKey("i", "up", y_answer, weaponInfo)   -- Покупка					 --
	bindKey("n", "up", n_answer) 				-- Отмена отбинд					 --
end					 --
function unbindBuy() 					 --
	unbindKey("i", "up", y_answer)					 --
	unbindKey("n", "up", n_answer)					 --
end					 --
					 --
					 --
addEvent("AmmonationsMarker",true)					 --
addEvent("leave AmmonationsMarker",true)					 --
addEventHandler("AmmonationsMarker",root,function(weaponInfo)					 --
	bindBuy(weaponInfo)					 --
end)					 --
addEventHandler("leave AmmonationsMarker",root,function()					 --
	unbindBuy()					 --
end)					 --
