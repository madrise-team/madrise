--// Utils (vk.com/studioskynet) //--
--// Данные экрана
local screenW, screenH = guiGetScreenSize ()
--// Оптимизация экрана
local render = 1
if screenW < 1920 then
    render = math.min(2, 1920 / screenW)
end

--// Window
function uiCreateWindow(x, y, w, h, text, font)
    dxDrawRectangle(x, y, w, h, tocolor(55, 55, 55, 200*curAnimData['allalpha'] ))
    dxDrawRectangle(x+2, y+2, w-4, h-4, tocolor(25, 25, 25, 200*curAnimData['allalpha']))
    dxDrawRectangle(x+2, y+2, w-4, 40, tocolor(40, 140, 255, 200*curAnimData['allalpha']))
    dxDrawText(text, x, y + 22, w + x, y + 22, tocolor(255, 255, 255, 255*curAnimData['allalpha']), 1, font, "center", "center")
end

--// Button
local buttonAlplha = {}
function uiCreateButton(x, y, w, h, text, font, ID)
    if not buttonAlplha[ID] then buttonAlplha[ID] = 0 end
    if buttonAlplha[ID] ~= 0 then
        dxDrawRectangle(x, y, w, h, tocolor(40, 140, 255, buttonAlplha[ID]*curAnimData['allalpha']))
    else
        dxDrawRectangle(x, y, w, h, tocolor(50, 50, 50, 200*curAnimData['allalpha']))
    end
    dxDrawRectangle(x+2, y+2, w-4, h-4, tocolor(25, 25, 25, 200*curAnimData['allalpha']))
    if cursorPosition(x, y, w, h) then
        buttonAlplha[ID] = math.min(buttonAlplha[ID]+10, 200)
    else
        buttonAlplha[ID] = math.max(buttonAlplha[ID]-15, 0)
    end
    dxDrawText(text, x, y, w + x, h + y, tocolor(255, 255, 255, 255*curAnimData['allalpha']), 1, font, "center", "center")
end

--// Cursor
function cursorPosition(x, y, w, h)
    if (not isCursorShowing()) then
        return false
    end
    local mx, my = getCursorPosition()
    local fullx, fully = guiGetScreenSize()
    cursorx, cursory = mx*fullx, my*fully
    if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
        return true
    else
        return false
    end
end
