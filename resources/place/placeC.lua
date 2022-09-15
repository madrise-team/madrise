addEvent("radioCreate",true)
addEvent("radioUpadte",true)
addEvent("raioInterface",true)


function stopSoundSlowly (sElement_)
    local sElement = sElement_
    if not isElement(sElement) then return false end

    local slowlyStop = setTimer(function()
    	outputChatBox(tostring(getSoundVolume(sElement)))
        local newSoundVolume = getSoundVolume(sElement) - 0.5
        if newSoundVolume <= 0 then
        	stopSound(sElement)
        else
        	setSoundVolume(sElement,newSoundVolume)
        end
	end,300,2)
end


addEventHandler('radioCreate',root,function(tab)
	local marka = tab[1]
	local showing = false
	local x,y,z = getElementPosition(marka)
	x = x+0.2
	y = y-0.1
	z = z+0.9

	local timem = "none"
	local gruzit = false

	local vklichino = tab[2]
	local radioNum = tab[3]
	local radios = tab[4]

	local musica = "none"
	local light = "none"

	function gruzka(perekl)
		if light ~= "none" then
			exports.lights:destroyLight(light)
			light = "none"
		end
		if vklichino then
			gruzit = true
			if perekl ~= nil then gruzit = perekl end
			if timem ~= "none" then
				killTimer(timem)
			end
		end
		if musica ~= "none" then
			stopSoundSlowly(musica)
			musica = "none"
		end
		timem = setTimer(function()
			gruzit = false
			timem = 'none'
			---- music
				if vklichino then
					light =  exports.lights:createPointLight(1411, -1640, 38.455, 16,15,230,255,2)

					musica = playSound3D("http://radiorecord.hostingradio.ru/lofi96.aacp",x,y-1,z)
					setSoundVolume(musica, 0.5)
					setSoundMinDistance(musica, 9)
					setSoundMaxDistance(musica, 27)
				end
			----
		end,400,1)
	end

	addEventHandler('radioUpadte',marka,function(vkl,RadioNum,Radios)
		local perekl = true
		if vklichino == (not vkl) then perekl = false end
		vklichino = vkl
		radioNum = RadioNum
		radios = Radios

		gruzka(perekl)
	end)
	addEventHandler('raioInterface',marka,function(show)
		showing = show
	end)

	local sp = [[\]]
	local sims = {"|","/","---",sp}
	local sim = 1

	local colorR = tocolor(245,200,45,250)
	local colorL = tocolor(45,200,245,250)

	addEventHandler("onClientRender",root,function()
		if showing then
			local px,py,pz = getElementPosition(localPlayer)
			local radx,rady,radz = getElementPosition(tab[1])
			if getDistanceBetweenPoints3D(px, py, pz, radx, rady, radz) > 2 then
				showing = false
				return
			end


			local sx,sy = getScreenFromWorldPosition(x,y,z)

			if (not sx) or (not sy) then return end

			

			if not gruzit then
				if vklichino then
					dxDrawText ("   выключить", sx, sy-50, sx , sy, colorR, 1, 1 ,"default","center","center")
					dxDrawText ("   пред.             след.", sx, sy+62, sx , sy, colorR, 0.8, 0.8 ,"default","center","center")
					dxDrawText (" < . > \n < [ >   < ] > ", sx, sy, sx , sy, colorR, 1.5, 1.5 ,"default","center","center")
					dxDrawText ("  "..radioNum..": "..radios[radioNum].name, sx, sy + 100, sx , sy, colorR, 1.22, 1.22 ,"default","center","center")
				else
					dxDrawText ("   включить радио", sx, sy-27, sx , sy, colorL, 1, 1 ,"default","center","center")
					dxDrawText (" < . > \n", sx, sy, sx , sy, colorL, 1.5, 1.5 ,"default","center","center")
				end
			else
				sim = sim + 0.5
				if sim > #sims then
					sim = 1
				end
				dxDrawText (sims[math.floor(sim)], sx, sy-10, sx , sy, tocolor(55,180,245,250), 2.5, 2.5 ,"default","center","center")
			end
		end
	end)
	--bindKey('[',"down",gruzka)
	--bindKey(']',"down",gruzka)

end)

triggerServerEvent ("getRadios",root)


local px,py,pz = getElementPosition(localPlayer)
bindKey('h','down',function()
	outputChatBox(px.." "..py.." "..pz)
end)

exports.lights:createPointLight(1409.8, -1644.3, 41.4 + 0.1, 160,130,70,167,6)
exports.lights:createPointLight(1409.8, -1640.3, 41.4 + 0.1, 160,130,70,167,6)				
exports.lights:createPointLight(1414.2, -1636.1, 41.5 + 0.1, 160,130,70,167,6)
exports.lights:createPointLight(1418.4, -1636.1, 41.6 + 0.1, 160,130,70,167,6)



local coloreL = tocolor(45,200,245,250)
stulia = {}
function updateStul(zanat,elm)
	local marka = elm or source
	local key = tostring(marka)
	stulia[key] = zanat
	outputChatBox(tostring(key))
	outputChatBox(tostring(stulia[key]))
	return key
end
addEvent('stulUpdate',true)
addEvent('stulInterface',true)
addEventHandler('stulInterface',root,function(element,zanat)
	local key = updateStul(zanat,element)

	local remover
	local framer
	remover = function()
		setElementCollidableWith(localPlayer,element,true)
		removeEventHandler("onClientRender",root,framer)
		removeEventHandler('stulUpdate',element,updateStul)
	end
	framer = function()
		local px,py,pz = getElementPosition(localPlayer)
		local stlx,stly,stlz = getElementPosition(element)
		if getDistanceBetweenPoints3D(px, py, pz, stlx, stly, stlz) > 1.2 then
			remover()
			return
		end
		if not stulia[key] then
			local sx,sy = getScreenFromWorldPosition(stlx,stly,stlz + 0.3)
			if sx and sy then
				dxDrawText ("сесть", sx, sy-30, sx , sy, coloreL, 1, 1 ,"default","center","center")
				dxDrawText ("< . >", sx, sy, sx , sy, coloreL, 1.5, 1.5 ,"default","center","center")
			end
		end
	end
	addEventHandler("onClientRender",root,framer)
	addEventHandler('stulUpdate',element,updateStul)
end)

addEvent("disCol",true)
addEventHandler("disCol",root,function(elem,dis)
	setElementCollidableWith(localPlayer,elem,dis)
	outputChatBox("disabled")
end)