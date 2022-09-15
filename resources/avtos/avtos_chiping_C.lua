import('avtos/avtos_chips.lua')()

automobiles_C = automobiles

function setHandl_C(avto)
-----------------------------------------------------------------------------
		if avto[38] == nil then
			avto[38] = getVehicleModelWheelSize(avto[2], "front_axle")
		end
		if avto[39] == nil then
			avto[39] = getVehicleModelWheelSize(avto[2], "rear_axle")
		end
		setVehicleModelWheelSize (avto[2], "front_axle", avto[38])
		setVehicleModelWheelSize (avto[2], "rear_axle", avto[39])
-----------------------------------------------------------------------------
end

for marka, auto in pairs(automobiles_C) do
	setHandl_C(auto)
end