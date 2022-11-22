--// Client (vk.com/studioskynet) //--
--// Расширение экрана
local screenW, screenH = guiGetScreenSize()
--// Оптимизация экрана
local render = 1
if screenW < 1920 then
    render = math.min(2, 1920 / screenW)
end
--// Настройка
local graphics = {
    visible = false,
    pos = {
        w = 350,
        h = 415,
        x = screenW/2-350/2,
        y = screenH/2-415/2
    },
    fonts = {
        [1] = dxCreateFont("assets/fonts/gotham-bold.ttf", 11),
        [2] = dxCreateFont("assets/fonts/gotham-bold.ttf", 13),
    },
    shaders = {
        [1] = {"Улучшенное небо", "sky"},
        [2] = {"Улучшенная вода", "water"},
        [3] = {"HD Дороги", "roads"},
        [4] = {"Детализация", "detail"},
        [5] = {"Эффект HDR", "hdr"},
        [6] = {"Эффект DOF", "dof"},
        [7] = {"Зимний мод", "snowmod"},
        [8] = {"Снегопад", "snegmod"},
        [9] = {"Оклюзия", "occlusions"},
        [10] = {"Птицы", "birds"},
        [11] = {"Размытие при движении", "blur"},
        [12] = {"Облака", "clouds"},
    },
}

--// Анимация 
function updateAnimData()
    targetAnimData = {
        ['allalpha']={0, 0.05},
    }
    curAnimData = {}
    for k,v in pairs(targetAnimData) do
        curAnimData[k] = 0
    end
end

local step
function updateAnimationValues()
    for k,v in pairs(targetAnimData) do
        if v[1] and v[2] then
            step = (v[1] - curAnimData[k]) / (1 / (v[2]))
            curAnimData[k] = curAnimData[k] + step
        end
    end
end

--// Рендер меню
addEventHandler("onClientRender", root, function ()
    if graphics.visible then
        updateAnimationValues()
        uiCreateWindow(graphics.pos.x, graphics.pos.y, graphics.pos.w, graphics.pos.h, "Настройка игры ("..skynet.key..")", graphics.fonts[2])
        --// Графика
        for i,v in pairs(graphics.shaders) do
            dxDrawText(v[1], graphics.pos.x + 40, ((graphics.pos.y + 20 + 35) + 25 * (i-1))*2, 20, 20, tocolor(255, 255, 255, 200*curAnimData['allalpha']), 1, graphics.fonts[1], "left", "center")
            dxDrawRectangle(graphics.pos.x + 15, (graphics.pos.y + 20 + 33) + 25 * (i-1), 20, 20, tocolor(35, 35, 35, 220*curAnimData['allalpha']))
            dxDrawRectangle(graphics.pos.x + 17, (graphics.pos.y + 20 + 35) + 25 * (i-1), 16, 16, tocolor(55, 55, 55, 220*curAnimData['allalpha']))
            if getElementData(localPlayer, v[2]) then
                dxDrawRectangle(graphics.pos.x + 17, (graphics.pos.y + 20 + 35) + 25 * (i-1), 16, 16, tocolor(40, 140, 255, 200*curAnimData['allalpha']))
            end
        end
        --// Сброс
        uiCreateButton(graphics.pos.x + 15, graphics.pos.y + 380, graphics.pos.w - 30, 25, "По умолчанию", graphics.fonts[1], "Standart")
    end
end)

addEventHandler("onClientClick", root, function (btn, state)
    if btn == "left" and state == "down" then
        if graphics.visible then
           for i,v in pairs(graphics.shaders) do
                if cursorPosition(graphics.pos.x + 15, (graphics.pos.y + 20 + 35) + 25 * (i-1), 20, 20) then
                    playSound("assets/sounds/select.wav")
                    setElementData(localPlayer, v[2], not getElementData(localPlayer, v[2]))
                    saveSettings()
                end
            end
            if cursorPosition(graphics.pos.x + 15, graphics.pos.y + 380, graphics.pos.w - 30, 25) then
                playSound("assets/sounds/select.wav")
                resetSettings()
            end
        end
    end
end)

--// Открытие
bindKey(skynet.key, "down", function ()
    if graphics.visible then
        if isTimer(timer) then
            killTimer(timer)
        end
    else
        updateAnimData()
        timer = setTimer(function()
            graphics.visible = true

            targetAnimData['allalpha'][1] = 1
            curAnimData['allalpha'] = 0
        end, 100, 1)
    end
    graphics.visible = not graphics.visible
    showCursor(graphics.visible)
end)

function graphics.toggle()
    graphics.visible = not graphics.visible
    showCursor(graphics.visible)
end

--// Сохранение.
local settignsPath = "@sgraphics.json"

function loadFile(path, count)
    if not fileExists(path) then
        return false
    end
    local file = fileOpen(path)
    if not file then
        return false
    end
    if not count then
        count = fileGetSize(file)
    end
    local data = fileRead(file, count)
    fileClose(file)
    return data
end

function saveFile(path, data)
    if not path then
        return false
    end
    if fileExists(path) then
        fileDelete(path)
    end
    local file = fileCreate(path)
    fileWrite(file, data)
    fileClose(file)
    return true
end

function saveSettings()
    if not graphics.shaders then
        if fileExists(settignsPath) then
            fileDelete(settignsPath)
        end
        return
    end
    local table = {}
    for i,v in pairs(graphics.shaders) do
        table[v[2]] = getElementData(localPlayer, v[2]) or false
    end
    saveFile(settignsPath, toJSON(table))
end

function resetSettings()
    for i,v in pairs(graphics.shaders) do
        setElementData(localPlayer, tostring(v[2]), false)
    end
    saveSettings()
end

function loadSettings()
    local jsonData = loadFile(settignsPath)
    if not jsonData then
        resetSettings()
        return
    end
    local settings = fromJSON(jsonData)
    if not settings then
        resetSettings()
        return
    end
    if not graphics.shaders then
        resetSettings()
        return
    end
    for i,v in pairs(settings) do
        setElementData(localPlayer, i, v)
    end
end
addEventHandler("onClientResourceStart", resourceRoot, loadSettings)