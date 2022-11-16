sW, sH = guiGetScreenSize()					 --
setCursorAlpha(255)					 --
showCursor(false)					 --
					 --
vspomogatCursorShowed = false					 --
vspomogatCursorCount = 0					 --
					 --
cursorShowed = false					 --
showCount = 0					 --
					 --
					 --
function showCursorS(toogleContorls)					 --
	local controls = false					 --
	if toogleContorls ~= nil then controls = toogleContorls end					 --
						 --
	showCursor(true,controls)					 --
	cursorShowed = true					 --
	setCursorAlpha(255)					 --
	showCount = showCount + 1					 --
					 --
end					 --
					 --
function hideCursorS()					 --
	showCount = showCount - 1					 --
	if showCount <= 0 then					 --
		showCursor(false)					 --
		cursorShowed = false					 --
		showCount = 0						 --
	end					 --
end					 --
					 --
					 --
					 --
function showVspomogatCursorS(toogleContorls)					 --
	local controls = toogleContorls or false					 --
	showCursor(true,controls)					 --
    setCursorAlpha(0)					 --
    vspomogatCursorShowed = true					 --
    vspomogatCursorCount = vspomogatCursorCount + 1					 --
					 --
end					 --
function hideVspomogatCursorS()					 --
	showCursor(false)					 --
    setCursorAlpha(255)					 --
    vspomogatCursorShowed = false					 --
end					 --
					 --
					 --
function getVspomogatCursorSmes()					 --
	return smesVspomogatCursor					 --
end					 --
					 --
vspomogatCursorBlocked = false					 --
smesVspomogatCursor = Vector2(0,0)					 --
addEventHandler("onClientRender",root,function()					 --
	if cursorShowed or vspomogatCursorBlocked then					 --
		smesVspomogatCursor = Vector2(0,0)					 --
		return					 --
	end					 --
	if vspomogatCursorShowed then					 --
		smesVspomogatCursor = Vector2(getCursorPosition())					 --
   		smesVspomogatCursor = smesVspomogatCursor - Vector2(0.5,0.5)					 --
    	if math.abs(smesVspomogatCursor.x) < 0.001 then smesVspomogatCursor.x = 0 end					 --
    	if math.abs(smesVspomogatCursor.y) < 0.001 then smesVspomogatCursor.y = 0 end					 --
    	setCursorPosition(sW/2,sH/2)					 --
    end					 --
end)					 --
					 --
escape = false					 --
bindKey("esc","down",function()					 --
	escape = not escape					 --
					 --
	if escape then					 --
		vspomogatCursorBlocked = true					 --
	else					 --
		vspomogatCursorBlocked = false					 --
	end					 --
end)					 --
					 --
					 --
showChat(true)					 --
InterfaceHiders = 0					 --
function hideInterface()					 --
	InterfaceHiders = InterfaceHiders + 1					 --
	setPlayerHudComponentVisible ("all",false)					 --
	showChat(false)					 --
end					 --
function showInterface()					 --
	InterfaceHiders = InterfaceHiders - 1					 --
	if InterfaceHiders <= 0 then					 --
		InterfaceHiders = 0					 --
		setPlayerHudComponentVisible ("all",true)					 --
		showChat(true)					 --
	end					 --
end					 --
