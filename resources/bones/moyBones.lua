function attachElmToPedHand(elm,Ped)
	function seset()
	 	setElementPosition(elm,getPedBonePosition(25))
	end 
	addEventHandler("onClientRender",getRootElement(),seset)
end