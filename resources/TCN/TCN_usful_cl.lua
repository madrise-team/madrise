function usfulTCN_cl()
-------------------------------------------------------------------------------------------------------------------------------------
TCN = exports.TCN 
------------------------------------


addEvent("tcnTransmit",true)
function TCNtrasmit(info,callback)
	
	local key
	local wasTransmited
	wasTransmited = function(tcnTransmitedKey)
		if key ~= tcnTransmitedKey then return end
		
		if callback then callback() end	
		removeEventHandler("tcnTransmit",root,wasTransmited)
	end
	addEventHandler("tcnTransmit",root,wasTransmited)
	key = TCN:TcnWaiter(info)
end
	


-------------------------------------------------------------------------------------------------------------------------------------
end
return usfulTCN_cl