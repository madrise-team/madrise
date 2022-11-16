local marker = createMarker ( 1415.7043457031,  -1641.0914306641,  37.308795928955, "cylinder", 2, 255, 255, 0, 170,root)					 --
function handlePlayerMarker()					 --
	triggerClientEvent ( "Marker", root)					 --
end					 --
addEventHandler("onMarkerHit", marker, handlePlayerMarker)					 --
