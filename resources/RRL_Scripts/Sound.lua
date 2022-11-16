---Server====================================================vvvvvvvvvvv					 --
function createSound(file,x,y,z,MaxDis,MinDis,dim,volm,elm)					 --
	triggerClientEvent(getRootElement(),"Plasaund",getRootElement(),file,x,y,z,MaxDis,MinDis,dim,volm,elm)					 --
end					 --
addEvent("createSound",true)					 --
addEventHandler("createSound",getRootElement(),createSound)					 --
function deSound(file,elm)					 --
	triggerClientEvent(getRootElement(),"DesaSaund",getRootElement(),file,elm)					 --
end					 --
addEvent("deSound",true)					 --
addEventHandler("deSound",getRootElement(),deSound)					 --
---Client=====================================================vvvvvvvvvvv					 --
sasy = {}					 --
function aSaas(fil,target)					 --
	for k,v in pairs(sasy) do					 --
		if v.file == fil and v.elem == target then					 --
			stopSound(v.sas)					 --
			sasy[k] = nil					 --
		end					 --
	end					 --
end					 --
					 --
function PlaySond3d(fil,x,y,z,MaxDis,MinDis,dim,volm,elm,destroy)					 --
	if destroy then aSaas(fil,elm) end					 --
					 --
	local saus = playSound3D(fil,x,y,z)					 --
	setSoundMinDistance(saus,MinDis)					 --
	setSoundMaxDistance(saus,MaxDis)					 --
	setElementDimension(saus,dim or 0)					 --
	if volm then setSoundVolume(saus,volm) end					 --
					 --
	sasy[#sasy + 1] = {file = fil,sas = saus,elem = elm}					 --
					 --
	if elm then attachElements(saus,elm) end					 --
					 --
	return saus					 --
end					 --
addEvent("Plasaund",true)					 --
addEventHandler("Plasaund",getRootElement(),PlaySond3d)					 --
					 --
function deSas(file,elm)					 --
	for k,v in pairs(sasy) do					 --
		if v.file == file and v.elem == elm then					 --
			if getElementType(v.sas) == "sound" then stopSound(v.sas) end					 --
			sasy[k] = nil					 --
		end					 --
	end					 --
end					 --
addEvent("DesaSaund",true)					 --
addEventHandler("DesaSaund",getRootElement(),deSas)					 --
---====================================================					 --
