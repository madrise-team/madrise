lsArmy1Pos = {x = 2720.2371,y = -2405.0867,z = 13.63359}
lsArmy2Pos = {x = 2720.2373,y = -2503.7751,z = 13.63359}
lsArmy1 = createObject(975, lsArmy1Pos.x,lsArmy1Pos.y,lsArmy1Pos.z, 0, 0, 90) setObjectScale(lsArmy1, 1.0)			-- Ворота 1
lsArmy2 = createObject(975, lsArmy2Pos.x,lsArmy2Pos.y,lsArmy2Pos.z, 0, 0, 90) setObjectScale(lsArmy2, 1.0)			-- Ворота 2




--vlls_portVorota
createMovebleObjectInteraction(lsArmy1,{
	rootT = {rootK = "vlls_portVorota"},
	size = 10,
	targety =  lsArmy1Pos.y + 8,
	strEasingType = "InOutQuad"
	--time = 500,
	--waitToCloseTime = 400

})
createMovebleObjectInteraction(lsArmy2,{
	rootT = {rootK = "vlls_portVorota"},
	size = 10,
	targety =  lsArmy2Pos.y + 8,
	strEasingType = "InOutQuad"
	--time = 500,
	--waitToCloseTime = 400

})