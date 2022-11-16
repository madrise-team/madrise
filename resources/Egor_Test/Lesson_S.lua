----------------------------------------------URON PEDOV---------------------------------------------------------------------------------					 --
function HPDiller(Element)					 --
	 HP = getElementHealth(Element)					 --
	outputChatBox("HP "..tostring(HP))					 --
	return HP					 --
end					 --
					 --
addCommandHandler("lloh",					 --
	function (player)					 --
		local x,y,z = getElementPosition(player)					 --
		local pedr = createPed(0,x+1,y+2,z,0)					 --
		triggerClientEvent("pedAdd",root,pedr)					 --
end)					 --
					 --
function Loss(loss)					 --
	Health = HPDiller(source)					 --
	outputChatBox(tostring(loss).." Damaged")					 --
end					 --
					 --
					 --
addEventHandler("onPedDamage",root,Loss)					 --
					 --
----------------------------------------------SMERT PEDOV------------------------------------------------------------------------					 --
					 --
function DiedPed ()					 --
	outputChatBox( tostring(player) .. " Died ".. tostring(source) .. " killer")					 --
	PositionPed = getElementPosition(source)					 --
					 --
	triggerClientEvent("pedDied",source)					 --
end					 --
addEventHandler("onPedWasted", root, DiedPed)					 --
					 --
----------------------------------------------PED DVIZHETSIA--------------------------------------------------------------------------------					 --
addCommandHandler("car",function(player)					 --
					 --
	local x,y,z = getElementPosition(player)					 --
	local rx, ry, rz = getElementRotation(player)					 --
    local matriza = Matrix(x,y,z,rx,ry,rz)					 --
					 --
    local spasPoint = matriza.position + matriza.forward*5 +matriza.up*5					 --
    					 --
	Car = createVehicle(490,spasPoint.x ,spasPoint.y ,spasPoint.z,0,0,rz)					 --
					 --
end)					 --
--------------------------------------------zad_mastera------------------------------------------------------------------------------					 --
