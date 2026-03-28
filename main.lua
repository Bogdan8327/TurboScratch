utf8 = require("utf8")
local micropaint = require("Micropaint")
local PlayerApis = require("Player")
json = require("dkjson")
local tmp = require("BlockList")
serpent = require("serpent")
local gload = require("gameloader")
local Timer = require "timer" -- БИБЛИОТЕКА hump timer
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            -- Рекурсивно копируем ключи и значения
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        -- Копируем метатаблицу (если она есть)
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- Числа, строки, булевы значения копируются просто так
        copy = orig
    end
    return copy
end
function FlattenEditorBlocks(argsArray) --ЭТО ТА САМАЯ ФУНЦИЯ ЧТО ПОМОЖЕТ МНЕ ПРАВИЛЬНО РЕНДЕРИТЬ И ОБРАБАТЫВАТЬ БЛОКИ ДАННЫХ И САМИ text
    local result = {}

    local function traverse(currentArgs)
        if not currentArgs or type(currentArgs) ~= "table" then return end

        for i = 1, #currentArgs do
            local item = currentArgs[i]
            
            -- 1. Добавляем сам объект (хоть text, хоть block), если у него есть тип
            if type(item) == "table" and item.type then
                table.insert(result, item)
                
                -- 2. Если это блок, у него есть поле data, в котором СЛЕДУЮЩИЙ блок
                if item.type == "block" and item.data then
                    local innerBlock = item.data
                    
                    -- 3. А у этого внутреннего блока есть свои args. Идем в них.
                    if innerBlock.args then
                        traverse(innerBlock.args)
                    end
                end
            end
        end
    end

    traverse(argsArray)
    return result
end
BlockList = tmp[1]
BlockRender = tmp[2]
function love.errorhandler(msg)
    function saveerrorreport(msg)
    local timestamp = os.date("%Y_%m_%d_%H_%M")
    local filename = "Report" .. timestamp .. ".txt"
    love.filesystem.write(filename, msg .. "\n" .. debug.traceback())
    local rawPath = love.filesystem.getSaveDirectory() .. "/" .. filename
    local winPath = rawPath:gsub("/", "\\")
    return winPath
    end
    
    love.window.showMessageBox("Игра была крашнута","Чтото пошло не так и редактор крашнулся, сохраните игру; ОТЧЁТ СОХРАНЁН ПУТЬ:" .. saveerrorreport(msg))
    print(msg)
    if GameLoaded then
        gload[1]("TS"..tostring(Editor.version))
    end
end
Ask = {}
Ask.mode = false
Ask.text = ""
Editor = {}
Editor.version = 10 -- !!!! МЕНЯТЬ КАЖДЫЙ РАЗ ПРИ ВЫПУСКЕ НОВОЙ ВЕРСИИ НУЖНО !!!!
Editor.isPaint = false
Editor.paintingSprite = 0
Editor.x = 0
Editor.y = 0
Editor.movingSpritesZone = nil
Editor.targetSprite = 1
Editor.pageSprite = 1
Editor.askingspritesparamssprite = 0
Editor.BlockListS = 0
Editor.movingScripts = {}
Editor.movingScriptsBlocks = {}
Editor.movingScriptsST = 0
Editor.movingScriptsST2 = 0
Editor.movingScriptsErrorCleaner = 0
Editor.AllowSpriteMoving = false
Editor.blocksRemoving = false
Editor.timer = 0
Editor.menuwin = {}
function love.load() --LOVE LUA
    PlayerApis.init()
    Editor.newSpriteImage = love.graphics.newImage("Empty.png")
    Editor.newSpriteImageData = love.image.newImageData("Empty.png")
    game = {}
    Debugtimer = 0
    DebugConsole = {}
    Font = love.graphics.newFont("FONT.ttf", 24)
    FontBlocks = love.graphics.newFont("FONT2.ttf", 14)
    BigFont = love.graphics.newFont("FONT.ttf", 72)
    love.window.setMode(1280, 720, {resizable = true})
    love.window.setTitle("TurboScratch")
    love.filesystem.setIdentity("Turbo_Scratch")
    color = {}
    color.background = {0.12, 0.0, 0.30} 
    color.accent = {0.4, 0.7, 1.0}
    GameLoaded = false
    love.math.setRandomSeed(os.time())
end
function removeScript(id)
    table.remove(game.sprites[Editor.targetSprite].scripts, id)
    local arr = Player.execution
    for i = #arr,1,-1 do
        local scriptID = arr[i][2]
        if scriptID > id then
            scriptID = scriptID -1
        elseif scriptID == id then
            table.remove(arr, i)
        end
    end
end
function createNewGame()
    game = {}
    local function q(text)
        if text == "" then
            game.name = "No name"
        else
            game.name = text
        end
        
        love.window.showMessageBox( "ГОТОВО!","Игра с именем "..game.name.." создана")
        GameLoaded = true
    end
    game.sprites = {}
    game.vars = {}
    game.shownVars = {} -- var перменная x и y size
    game.version = 10
    newSprite()
    Debuguser("Введите имя игры")
    Debugtimer = -1
    Ask.ask(q)
end
function makecolmap(img)
    local width, height = img:getDimensions()
    local ret = {}
    for y = 0, height - 1,10 do
        local ys = {}
        for x = 0, width - 1,10 do
            local r, g, b, a = img:getPixel(x, y)
            if a == 0 then
                ys[#ys+1] = false
            else
                ys[#ys+1] = true
            end
        end
        ret[#ret+1] = ys
    end
    return ret
end
function newSprite()
    game.sprites[#game.sprites+1] = {} -- НОВЫЙ МАССИВ СПРАЙТА
    game.sprites[#game.sprites].costumes = {} -- КОСТЮМЫ В ФОРМАТЕ IMAGE
    game.sprites[#game.sprites].costumes[1] = Editor.newSpriteImage -- НОВЫЙ КОСТЮМ С ЧЕЛОВЕЧКОМ
    game.sprites[#game.sprites].costumesIMGDAT = {}
    game.sprites[#game.sprites].costumesIMGDAT[1]  = Editor.newSpriteImageData -- НОВЫЙ КОСТЮМ С ЧЕЛОВЕЧКОМ В IMAGE DATA
    game.sprites[#game.sprites].costumesColMaps = {}
    game.sprites[#game.sprites].costumesColMaps[1] = makecolmap(game.sprites[#game.sprites].costumesIMGDAT[1])
    game.sprites[#game.sprites].pos = {} -- ПОЗИЦИЯ
    game.sprites[#game.sprites].vars = {} -- ПЕРЕМЕННЫЕ
    game.sprites[#game.sprites].pos.x = 0 -- ПОЗИЦИЯ x
    game.sprites[#game.sprites].pos.y = 0 -- ПОЗИЦИЯ y
    game.sprites[#game.sprites].name = "Спрайт номер" .. #game.sprites -- ИМЯ
    game.sprites[#game.sprites].size = 100 -- РАЗМЕР СПРАЙТА (на будущее)
    game.sprites[#game.sprites].show = true
    game.sprites[#game.sprites].costumeNumber = 1 -- НОМЕР КОСТЮМА (на будущее)
    game.sprites[#game.sprites].rotation = 0 -- ПОВОРОТ (на будущее)
    game.sprites[#game.sprites].scripts = {} -- СКРИПТЫ СПРАЙТА    
end
function SetVirtualScissor(x, y, w, h)
    if x == nil then 
        love.graphics.setScissor() -- Выключаем, если вызвали без аргументов
    else
        local sw = love.graphics.getWidth() / 1600 -- TARGET_W
        local sh = love.graphics.getHeight() / 900 -- TARGET_H
        love.graphics.setScissor(x * sw, y * sh, w * sw, h * sh)
    end
end

local TARGET_W, TARGET_H = 1600, 900
function Debuguser(text)
    Debugtimer = 0
    DebugConsole[#DebugConsole + 1] = text
    if #DebugConsole > 25 then
        for i = 1,10 do
            table.remove(DebugConsole,1)
        end
    end
end
function Ask.ask(callback)
    if not Ask.mode then
    Ask.callback = callback
    Ask.mode = true
    Ask.text = ""
    else
    Debuguser("ОШИБКА: Невозможно начать новый ввод, нажмите ENTER и повторите попытку")
    end
end

function love.update(dt) --LOVE LUA
Timer.update(dt)
if GameLoaded then
    PlayerApis.GenerateCanvas()
    PlayerApis.tick()
    --ТАСКАТЬ УДАЛЕНИЕ ОШИБОК
    if Editor.timer > Editor.movingScriptsErrorCleaner + 0.1 then
        local CleanedBlocks = 0
        local CleanedScripts = 0
        local IsErrorsRemoved = false
        Editor.movingScriptsErrorCleaner = Editor.timer
        --СООБЩЕНИЕ
        if IsErrorsRemoved then
            Debuguser("УДАЛЕНЫ ОШИБКИ В "..CleanedBlocks .." блоках в "..CleanedScripts.." спрайтах")
        end
    end
    --ТАСКАТЬ РАЗЪЕДЕНЕНИЕ СКРИПТОВ И РАЗРЕШЕНИЕ ДВИЖЕНИЯ
    if Editor.timer - 0.15 > Editor.movingScriptsST2 and not Editor.AllowSpriteMoving then
        local scripts = game.sprites[Editor.targetSprite].scripts
        for i = 2, #Editor.movingScripts do --ЗАЩИЩАЕМ ВТОРОЙ СКРИПТ ОТ БАГА
            table.remove(Editor.movingScripts,i)
        end

        if #Editor.movingScripts == 1 and Editor.movingScriptsBlocks[1]>1 then
            local newScript = {x = 0,y = 0}
            local oldScript = scripts[Editor.movingScripts[1]]
            --ТУТ НУЖНО ПОНЯТЬ НЕ РАЗЪЕДЕНЯЕМ ЛИ МЫ БЛОК С БЛОКАМИ, ЕСЛИ ДА ТО НУЖНО БУДЕТ ВЕРНУТЬ ИХ НАЗАД
            local oldIDS = {}
            local newIDS = {}
            for i = 1,Editor.movingScriptsBlocks[1]-1 do
                if oldScript[i].id then
                    oldIDS[#oldIDS+1] = oldScript[i].id
                end
            end
            for i = Editor.movingScriptsBlocks[1],#oldScript do
                if oldScript[i].id then
                    newIDS[#newIDS+1] = oldScript[i].id
                end
            end
            local foundError = false
            local errorID = {}
            for i=1,#oldIDS do
                for ii=1,#newIDS do
                    if oldIDS[i] == newIDS[ii] then
                        foundError = true
                        errorID[#errorID+1] = oldIDS[i]
                    end
                end
            end
            table.move(oldScript, Editor.movingScriptsBlocks[1], #oldScript, #newScript + 1, newScript)
            for i = 1,#newScript do
                if newScript[i].id then
                        local ifit = false
                        for ai = 1,#errorID do  
                            if errorID[ai] == newScript[i].id then
                                ifit = true
                                break
                            end
                        end
                        if ifit then
                            table.remove(newScript, i)
                        end
                end
            end
            for i = #oldScript, Editor.movingScriptsBlocks[1], -1 do
                if oldScript[i].id then
                        local ifit = false
                        for ai = 1,#errorID do  
                            if errorID[ai] == oldScript[i].id then
                                ifit = true
                                break
                            end
                        end
                        if not ifit then
                            table.remove(oldScript, i)
                        end
                else
                    table.remove(oldScript, i)
                end
                
            end
            if #newScript > 0 then
                scripts[#scripts+1] = newScript
            end
            Editor.movingScriptsBlocks[1] = 1
            Editor.movingScripts[1] = #scripts
        end
        --КОГДА ВСЁ СДЕЛАНО РАЗРЕШАЕМ
        Editor.AllowSpriteMoving = true
        Editor.movingScriptsST2 = Editor.timer
    end
    if Editor.isPaint then
        local savedImages, activeID = micropaint.update(dt)
        local resultImages = {}
    if savedImages then
        game.sprites[Editor.paintingSprite].costumesIMGDAT = savedImages
        local parr = game.sprites[Editor.paintingSprite].costumesColMaps
        for i =1,#parr do
            parr[i] = makecolmap(savedImages[i])
        end
        for i, data in ipairs(savedImages) do
        local img = love.graphics.newImage(data)
        
        img:setFilter("nearest", "nearest") 
        
        resultImages[i] = img
        end
    

        game.sprites[Editor.paintingSprite].costumes = resultImages
        game.sprites[Editor.paintingSprite].costumeNumber = activeID
        Editor.isPaint = false
    end
        return
    end
    end
--СИСТЕМА ОТЛАДКИ
Debugtimer = Debugtimer + dt
    if Debugtimer >= 2 then
        if #DebugConsole > 0 then
            table.remove(DebugConsole, 1)
        end
        Debugtimer = 0
    end
--ТАЙМЕР
Editor.timer = Editor.timer + dt
--СИСТЕМА ПЕРЕТАСКИВАНИЯ БЛОКОВ
if Editor.AllowSpriteMoving then
local mx, my = love.mouse.getPosition()
local sw = love.graphics.getWidth() / 1600
local sh = love.graphics.getHeight() / 900
local x = mx / sw
local y = my / sh
local di = 0
while di < #Editor.movingScripts do
di = di + 1
local scr = game.sprites[Editor.targetSprite].scripts[Editor.movingScripts[di]]
scr.x = x - 330 - 10 - Editor.x
scr.y = y - 43 - 10 - Editor.y
if x < 330 then
    Editor.blocksRemoving = true
else
    Editor.blocksRemoving = false
end
end

end


if Editor.movingSpritesZone ~= nil then
if Editor.movingSpritesZone == "w" then
    Editor.y = Editor.y - 10
elseif Editor.movingSpritesZone == "a" then
    Editor.x = Editor.x - 10
elseif Editor.movingSpritesZone == "s" then
    Editor.y = Editor.y + 10
elseif Editor.movingSpritesZone == "d" then
    Editor.x = Editor.x + 10
end
end

end

function love.draw() --LOVE LUA
    -- НАЧАЛА ОТРИСОВКИ EDITOR
    love.graphics.setFont(Font)
    love.graphics.clear(color.background)
    --ВОТ ГДЕТО ТУТ БУДЕМ ГЕНЕРИРОВАТЬ КАНВАС
    local windowW, windowH = love.graphics.getDimensions()
    local scaleX = windowW / TARGET_W
    local scaleY = windowH / TARGET_H

    love.graphics.push()
    love.graphics.scale(scaleX, scaleY)
    --РИСУЕМ ПЭЙНТ
    
    if Editor.isPaint then
    micropaint.draw()
    

        
    else
    -- САМА ОТРИСОВКА РЕДАКТОРА
    if not Player.fullscr then
    if GameLoaded then
         
--ЕСЛИ ИГРА ЗАГРУЖЕНА ВСЁ ДЕЛАЕМ
love.graphics.setColor(color.accent)
love.graphics.print("TurboScratch", 10, 10)
love.graphics.setColor(1, 1, 1)
--СОЗДАЁМ ОБВОДКУ ОБЛАСТЕЙ (ОТСТУПАЕМ ОТ КРАЁВ 3)
--ВСЁ ОКНО РЕДАКТОРА
love.graphics.rectangle("line", 3, 3, 1594, 894)
--ВЕРХНЯЯ СТРОКА ОПЦИЙ
love.graphics.rectangle("line", 3, 3, 1594, 40)
--ОБЛАСТЬ ДОСТАВАНИЯ БЛОКОВ
love.graphics.rectangle("line", 3, 43, 327, 854)
--ОБЛАСТЬ РЕДАКТОРА КОДА
love.graphics.rectangle("line", 330, 43, 787, 854)
--ОБЛАСТЬ ПРЕДПРОСМОТРА ИГРЫ
love.graphics.rectangle("line", 1117, 43, 480, 300)
--ОБЛАСТЬ ВЫБОРА СПРАЙТОВ
love.graphics.rectangle("line", 1117, 343, 480, 554)
--КОНЕЦ ОБВОДКИ ОБЛАСТЕЙ
--СПИСОК СПРАЙТОВ
local spi = 0 -- НОМЕР ЦИКЛА (ЧТОБЫ НЕ ПЕРЕВАЛИЛО ЗА 10)
local spsp = Editor.pageSprite * 10 - 9 -- НАШ СПРАЙТ
local spY = 343 -- y где отобразить стпрайт
while (spi < 10) do
    spi = spi + 1
    if game.sprites[spsp] ~= nil then
    love.graphics.rectangle("line", 1117, spY, 480, 50)
    if Editor.targetSprite == spsp then
        love.graphics.setColor(color.accent)
        love.graphics.rectangle("fill", 1117, spY, 480, 50)
        love.graphics.setColor(1, 1, 1)
    else    
        love.graphics.rectangle("line", 1117, spY, 480, 50)
    end
    love.graphics.print(game.sprites[spsp].name, 1117, spY)
    love.graphics.rectangle("line", 1547, spY, 50, 50)
    love.graphics.setFont(BigFont)
    love.graphics.print("O", 1547, spY-30)
    love.graphics.setFont(Font)
    love.graphics.print(".", 1571, spY)
    spY = spY + 50
    end
    if #game.sprites + 1 == spsp then
        love.graphics.rectangle("line", 1117, spY, 480, 50)
        love.graphics.print("Создать спрайт (+)", 1117, spY)
    end
    spsp = spsp + 1
end
--КНОПКИ СНИЗУ
love.graphics.setFont(BigFont)
--КНОПКА ВПРАВО
love.graphics.print(">", 1560, 820)
love.graphics.rectangle("line", 1547, 847, 50, 50)
--КНОПКА ВЛЕВО
love.graphics.print("<", 1510, 820)
love.graphics.rectangle("line", 1497, 847, 50, 50)
--ПАНЕЛЬ С НОМЕРОМ СТРАНИЦЫ
love.graphics.setFont(Font)
love.graphics.print("Страница номер " .. Editor.pageSprite .. "/100", 1117, 850)
love.graphics.rectangle("line", 1117, 847, 380, 50)
--КОНЕЦ КНОПКИ СНИЗУ
--КОНЕЦ СПИСОК СПРАЙТОВ
--КНОПКА КОСТЮМЫ
love.graphics.print("Костюмы", 300, 3)
love.graphics.rectangle("line", 300, 3, 120, 40)
--КНОПКА СОХРАНЕНИЯ
love.graphics.print("Сохранить", 420, 3)
love.graphics.rectangle("line", 420, 3, 120, 40)
--БЛОКИ
--ОБЛАСТЬ ДОСТАВАНИЯ БЛОКОВ
SetVirtualScissor(3, 43, 327, 854)
local bly = 70 + Editor.BlockListS
local bli = 0
while bli < #BlockList do
    bli = bli + 1
    local i = 0
    local arr = {}
    while i < BlockList[bli].args do
        i = i + 1
        arr[#arr+1] = {type = "text", data = "   "}
    end
    BlockRender(BlockList[bli],arr,true,15,bly)
    bly = bly + 80
end
SetVirtualScissor()
--САМИ БЛОКИ
SetVirtualScissor(330, 43, 787, 854)
local bbi = 0
local bbspacecolor = {1, 1, 0}
local spaces = 0
while bbi < #game.sprites[Editor.targetSprite].scripts do
    bbi = bbi + 1
    local y = game.sprites[Editor.targetSprite].scripts[bbi].y
    local x = game.sprites[Editor.targetSprite].scripts[bbi].x
    local i = 0
    while i < #game.sprites[Editor.targetSprite].scripts[bbi] do
        i = i + 1
        local block = game.sprites[Editor.targetSprite].scripts[bbi][i]
        if block.name == "end" then
            spaces = spaces - 1
        end
        BlockRender(block,block.args,true,330 + Editor.x + x + (spaces * 50),43 + Editor.y + y,true)
        if block.containBlocksIn then
            spaces = spaces + 1
        end
        y = y + 50
    end
end
SetVirtualScissor()
    else
--ИГРА НЕ ЗАГРУЖЕНА, НУЖНО ЗАГРУЗИТЬ
love.graphics.print("Игра не загружена", 10, 10)
--КНОПКА: Загрузить
love.graphics.rectangle("line", 230, 10, 120, 40)
love.graphics.print("Загрузить", 240, 10)
--КНОПКА: Создать
love.graphics.rectangle("line", 360, 10, 100, 40)
love.graphics.print("Создать", 370, 10)
    end
    --КОНЕЦ


    end
    if Editor.blocksRemoving then
        local mx, my = love.mouse.getPosition()
        local sw = love.graphics.getWidth() / 1600
        local sh = love.graphics.getHeight() / 900
        local x = mx / sw
        local y = my / sh
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("УДАЛЕНИЕ БЛОКОВ", x, y-50)
    end
    end
    if GameLoaded and not Editor.isPaint and not Player.fullscr then
        PlayerApis.DrawCanvas(1117, 43, 480, 300)
    end
    if GameLoaded and not Editor.isPaint and Player.fullscr then
        PlayerApis.DrawCanvas(3, 43, 1594, 854)
    end
    -- РИСУЕМ ОТЛАДКУ
    if #DebugConsole > 0 then
        love.graphics.setColor(0, 1, 0)
        local i = 0
        while i < #DebugConsole do
            i = i + 1
            love.graphics.print(DebugConsole[i], 10, 400 + (30*i))
        end
        love.graphics.setColor(1, 1, 1)
    end
    --РИСУЕМ СПРАШИВАНИЕ
    if Ask.mode then
        love.graphics.setColor(0.1, 0.1, 1)
        love.graphics.print("Введите и нажмите enter:" .. Ask.text, 10, 850)
        love.graphics.setColor(1, 1, 1)
    end
    if (not Editor.isPaint) and GameLoaded then
    --КНОПКА ПОЛНЫЙ ЭКРАН
    love.graphics.print("ЭКРАН", 1500, 3)
    love.graphics.rectangle("line", 1500, 3, 120, 40)
    --КНОПКА ПОЛНЫЙ СТАРТ
    love.graphics.print("СТАРТ", 1117, 3)
    love.graphics.rectangle("line", 1117, 3, 100, 40)
    --КНОПКА ПОЛНЫЙ СТОП
    love.graphics.print("СТОП", 1217, 3)
    love.graphics.rectangle("line", 1217, 3, 80, 40)
    if #Editor.menuwin > 0 then
        local menu = Editor.menuwin
        local x = 300
        local y = 150
        for i =1,#menu,2 do
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill", x, y, 300, 40)
            love.graphics.setColor(1,1,1)
            love.graphics.print(menu[i], x, y)
            y = y + 40
        end
    end
    end
    love.graphics.setFont(FontBlocks)
    
    love.graphics.print("FPS: " .. love.timer.getFPS(), 1, 1)

    love.graphics.pop()
end
function love.mousepressed(fakex, fakey, button, istouch) -- LOVE KEY
    local windowW, windowH = love.graphics.getDimensions()
    local scaleX = windowW / 1600 -- TARGET_W
    local scaleY = windowH / 900  -- TARGET_H

    -- 2. Переводим реальные пиксели окна в виртуальные 1600x900
    x = fakex / scaleX
    y = fakey / scaleY
    if #Editor.menuwin > 0 then
        local menu = Editor.menuwin
        local xx = 300
        local yy = 150
        for i =1,#menu,2 do -- 300 x 40
            if x > 300 and x < 600 and y > yy and y < yy + 40 then
                menu[i + 1]()
                Editor.menuwin = {}
                break
            end
            yy = yy + 40
        end
    else
if Player.fullscr then
    PlayerApis.click(x,y)
end
if x > 1500 and x < 1620 and y > 3 and y < 43 then
    Player.fullscr = not Player.fullscr
end
if x > 1117 and x < 1217 and y > 3 and y < 43 then 
    PlayerApis.start()
end
if x > 1217 and x < 1297 and y > 3 and y < 43 then 
    Player.execution = {}
    Debuguser("Остановка скриптов игры")
end
if (not Editor.isPaint) and (not Player.fullscr) then
    if button == 1 then
        --КНОПКА 1
        --ОБРАБОТКА КНОПОК
        if not GameLoaded then
        --ОБРАБОТКА КНОПОК ИГРА НЕ ЗАГРУЖЕНА
        --КНОПКА Создать
        if x > 360 and x < 460 and y > 10 and y < 50 then
            createNewGame()
        end
        --КНОПКА ЗАГРУЗИТЬ 230, 10, 120, 40)
        if x > 230 and x < 350 and y > 10 and y < 50 then
            if gload[3](gload[2]()) == "suc" then
                GameLoaded = true 
                love.window.showMessageBox( "ГОТОВО!","Игра с именем "..game.name.." загружена")
            else
                love.window.showMessageBox( "ОШИБКА","Во время загрузки возникла ошибка")
                return
            end
            
        end
        else
        --ОБРАБОТКА КНОПОК ИГРА ЗАГРУЖЕНА
        --КНОПКА КОСТЮМЫ
        if x > 300 and x < 420 and y > 3 and y < 43 then
            micropaint.start(game.sprites[Editor.targetSprite].costumes)
            Editor.paintingSprite = Editor.targetSprite
            Editor.isPaint = true
        end
        --КНОПКА СОХРАНЕНИЯ
        if x > 420 and x < 540 and y > 3 and y < 43 then
            gload[1]("TS"..tostring(Editor.version))
            Debuguser("123SUS")
        end
        --КНОПКИ СПРАЙТОВ 
        if x > 1547 and x < 1597 and y > 847 and y < 897 then
            if Editor.pageSprite ~= 100 then
                Editor.pageSprite = Editor.pageSprite + 1
            end
        end
        if x > 1497 and x < 1547 and y > 847 and y < 897 then
            if Editor.pageSprite ~= 1 then
                Editor.pageSprite = Editor.pageSprite - 1
            end
        end
        --СПИСОК СПРАЙТОВ
        local spi = 0 -- НОМЕР ЦИКЛА (ЧТОБЫ НЕ ПЕРЕВАЛИЛО ЗА 10)
        local spsp = Editor.pageSprite * 10 - 9 -- НАШ СПРАЙТ
        local spY = 343 -- y где отобразить стпрайт
        while (spi < 10) do
            spi = spi + 1
            if game.sprites[spsp] ~= nil then
            if x > 1117 and x < 1547 and y > spY and y < spY + 50 then
                --КНОПКА СПРАЙТА
                Editor.targetSprite = spsp
            end
            if x > 1547 and x < 1597 and y > spY and y < spY + 50 then
                --КНОПКА ПАРАМЕТРОВ СПРАЙТА
                    local function one()
                        local function set(text)
                            data = tonumber(text)
                            if data == nil then
                                Debuguser("Неверное значение")
                                return
                            end
                            game.sprites[Editor.askingspritesparamssprite].pos.x = tonumber(text)
                            Debuguser("Установлено успешно")
                        end
                        Debuguser("Установите новое значение для Положение X")
                        Ask.ask(set)
                    end
                    local function two()
                        local function set(text)
                            data = tonumber(text)
                            if data == nil then
                                Debuguser("Неверное значение")
                                return
                            end
                            game.sprites[Editor.askingspritesparamssprite].pos.y = tonumber(text)
                            Debuguser("Установлено успешно")
                        end
                        Debuguser("Установите новое значение для Положение Y")
                        Ask.ask(set)
                    end
                    local function three()
                            data = tonumber(text)
                            if data == nil then
                                Debuguser("Неверное значение")
                                return
                            end
                        local function set(text)
                            game.sprites[Editor.askingspritesparamssprite].rotation = tonumber(text)
                            Debuguser("Установлено успешно")
                        end
                        Debuguser("Установите новое значение для Поворот(макс 360)")
                        Ask.ask(set)
                    end
                    local function four()
                        local function set(text)
                            game.sprites[Editor.askingspritesparamssprite].name = text
                            Debuguser("Установлено успешно")
                        end
                        Debuguser("Установите новое значение для Имя")
                        Ask.ask(set)
                    end
                    local function five()
                            data = tonumber(text)
                            if data == nil then
                                Debuguser("Неверное значение")
                                return
                            end
                        local function set(text)
                            game.sprites[Editor.askingspritesparamssprite].size = tonumber(text)
                            Debuguser("Установлено успешно")
                        end
                        Debuguser("Установите новое значение для Размер")
                        Ask.ask(set)
                    end
                    local function six()
                        local function setxx(text)
                            if text == "Y" or text == "y" then
                                Editor.targetSprite = 1
                                Player.execution = {}
                                Debuguser("Остановка скриптов игры, причина, удалён спрайт")
                                table.remove(game.sprites, Editor.askingspritesparamssprite)
                                Debuguser("Удалено")
                                
                            else
                                Debuguser("Отменено")
                            end
                        end
                        Debuguser("Вы дейтсвительно хотите удалить этот спрайт (Y/N)")
                        Ask.ask(setxx)
                    end
                    local function seven()
                        Debuguser("Отменено")
                    end
                Editor.askingspritesparamssprite = spsp
                Editor.menuwin = {
                    "1 - Положение X:" .. game.sprites[spsp].pos.x,
                    one,
                    "2 - Положение Y:" .. game.sprites[spsp].pos.y,
                    two,
                    "3 - Поворот (макс 360):" .. game.sprites[spsp].rotation,
                    three,
                    "4 - Имя:" .. game.sprites[spsp].name,
                    four,
                    "5 - Размер:" .. game.sprites[spsp].size,
                    five,
                    "6 - Удалить",
                    six,
                    "7 - Отмена",
                    seven
                }
            end
        end
            if #game.sprites + 1 == spsp then
                if x > 1117 and x < 1597 and y > spY and y < spY + 50 then
                    --КНОПКА НОВЫЙ СПРАЙТ
                    newSprite()
                    Editor.targetSprite = #game.sprites
                    spi = 10
                end
            end
            spY = spY + 50
            spsp = spsp + 1
            end

        
        --ОБРАБОТКА ДОСТАВАНИЯ БЛОКОВ
        local bly = 70 + Editor.BlockListS
        local bli = 0
        while bli < #BlockList do
            bli = bli + 1
            local i = 0
            local arr = {}
            while i < BlockList[bli].args do
                i = i + 1
                arr[#arr+1] = {type = "text", data = "   "}
            end
            local poss = BlockRender(BlockList[bli],arr,true,15,bly)
            if x > poss[1][1] and x < poss[1][1] + poss[1][3] and y > poss[1][2] and y < poss[1][2] + poss[1][4] then
                local setarr = {}
                setarr.x = 0 - Editor.x
                setarr.y = 0 - Editor.y
                setarr[1] = deepcopy(BlockList[bli]) 
                setarr[1].args = arr
                setarr[1].id = love.math.random(999999999)
                if setarr[1].containBlocksIn then
                setarr[2] = {
                type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
                isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
                DisplayName = "Конец" .. setarr[1].DisplayName, -- ОТОБРАЖАЕМОЕ ИМЯ
                endname = setarr[1].name,
                name = "end", -- СИСТЕМНОЕ ИМЯ
                args = {}, -- КОЛИЧЕСТВО АРГУМЕНТОВ
                containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
                color = setarr[1].color,
                id = setarr[1].id
                }
                end
                game.sprites[Editor.targetSprite].scripts[#game.sprites[Editor.targetSprite].scripts+1] = setarr
            end
            bly = bly + 80
        end
        --КОНЕЦ КНОПОК СПРАЙТОВ
        --КОНЕЦ КНОПОК, ОБРАБОТКА ЗАЖАТИЯ БЛОКОВ В РЕДАКТОРЕ КОДА
        local pss = {
            x,y
        }
        if button == 1 and x > 330 and y > 43 and x < 1117 and y < 897 then
        --ТАСКАТЬ СКРИПТЫ НАЖАТЫе
        local bbi = 0
        local bbspacecolor = {1, 1, 0}
        local spaces = 0
        while bbi < #game.sprites[Editor.targetSprite].scripts do
            bbi = bbi + 1
            local y = game.sprites[Editor.targetSprite].scripts[bbi].y
            local x = game.sprites[Editor.targetSprite].scripts[bbi].x
            local i = 0
            while i < #game.sprites[Editor.targetSprite].scripts[bbi] do
                i = i + 1
                local block = game.sprites[Editor.targetSprite].scripts[bbi][i]
                if block.name == "end" then
                    spaces = spaces - 1
                end
                local poss = BlockRender(block,block.args,false,330 + Editor.x + x + (spaces * 50),43 + Editor.y + y)
                if poss[1] and pss[1] > poss[1][1] and pss[1] < poss[1][1] + poss[1][3] and pss[2] > poss[1][2] and pss[2] < poss[1][2] + poss[1][4] then
                    if #poss > 1 then
                    local ArgsArr = FlattenEditorBlocks(block.args)
                    local FiltredPoss = deepcopy(poss)
                    table.remove(FiltredPoss,1)
                    table.sort(FiltredPoss, function(a, b)
                        return a[1] < b[1]
                    end)
                    for i = #FiltredPoss, 1,-1 do 
                        if pss[1] > FiltredPoss[i][1] and pss[1] < FiltredPoss[i][1] + FiltredPoss[i][3] and pss[2] > FiltredPoss[i][2] and pss[2] < FiltredPoss[i][2] + FiltredPoss[i][4] then
                            da5t13 = ArgsArr[i]
                            if da5t13.type == "text" then
                            local function setdata(text)
                                Debugtimer = 0
                                if text ~= "" then
                                    da5t13.data = text
                                end
                            end
                            Debuguser("Устнановите новое значения этого поля ввода")
                            Debuguser("Если нажать ENTER ничего не вводя - ничего не изменится")
                            Debuguser("Если нажать 3 раза ПРОБЕЛ а затем 1 ENTER - поле очистится")
                            Debugtimer = -5000
                            Ask.ask(setdata)
                            else
                            local setarr = {}
                            setarr.x = 0 - Editor.x
                            setarr.y = 0 - Editor.y
                            setarr[1] = da5t13.data
                            setarr[1].args = da5t13.data.args
                            setarr[1].id = love.math.random(999999999)
                            da5t13.data = "   "
                            da5t13.type = "text"
                            game.sprites[Editor.targetSprite].scripts[#game.sprites[Editor.targetSprite].scripts+1] = setarr
                            end
                            break
                        end
                    end
                    end
                    Editor.movingScripts[#Editor.movingScripts+1] = bbi
                    Editor.movingScriptsBlocks[#Editor.movingScriptsBlocks+1] = i
                    Editor.movingScriptsST = Editor.timer
                    Editor.AllowSpriteMoving = false
                    Editor.movingScriptsST2 = Editor.timer
                end
                if block.containBlocksIn then
                    spaces = spaces + 1
                end
                y = y + 50
            end
        end

        end
        end
end
end
end
end


function love.keypressed(key) -- LOVE KEY
    if not Ask.mode then
        --Выполнять только когда не спрашиваем
        --ОБРАБОТКА ПЕРЕМЕЩЕНИЯ В СТУДИИ
        local realX, realY = love.mouse.getPosition()
        local screenW, screenH = love.graphics.getDimensions()
        local x, y = realX * (1600 / screenW), realY * (900 / screenH)
        if x > Player.canvasPoss[1] and x < Player.canvasPoss[1] + Player.canvasPoss[3] and y > Player.canvasPoss[2] and y < Player.canvasPoss[2] + Player.canvasPoss[4] then
            PlayerApis.startName("whenkey",key)
            Player.pressedKeys[#Player.pressedKeys+1] = key
            return
        end
        Editor.movingSpritesZone = key

        --КОНЕЦ ПЕРЕМЕЩЕНИЯ В СТУДИИ
        
    else
        if key == "return" then
            Ask.mode = false
            Ask.callback(Ask.text)
        elseif key == "backspace" then
            local byteoffset = utf8.offset(Ask.text, -1) -- Находит начало последней ЦЕЛОЙ буквы
            if byteoffset then
                Ask.text = string.sub(Ask.text, 1, byteoffset - 1)
            end
        end
end
function love.keyreleased(key)
    for i=#Player.pressedKeys,1,-1 do
        if Player.pressedKeys[i] == key then
            table.remove(Player.pressedKeys,i)
        end
    end
    Editor.movingSpritesZone = nil
end
end
function love.textinput(key)  -- LOVE KEY
    Ask.text = Ask.text .. key
end

function love.mousereleased(x, y, button) -- LOVE KEY
if GameLoaded then
    --ТАСКАТЬ СЛИЯНИЕ
    local WorkSpriteScripts = game.sprites[Editor.targetSprite].scripts
    if Editor.timer - 0.1 < Editor.movingScriptsST then
    

    local FirstScript = WorkSpriteScripts[Editor.movingScripts[1]]
    local SecondScript = WorkSpriteScripts[Editor.movingScripts[2]]
    local SecondScriptID = Editor.movingScripts[2]
    local insertBlockId = Editor.movingScriptsBlocks[1] + 1
    if FirstScript and SecondScript and insertBlockId then --ПРОВЕРКА НАЛИЧИЯ ПЕРЕМЕННЫХ
    if FirstScript[1].type ~= 3 and SecondScript[1].type ~= 3 then --ПРОВЕРКА НА БЛОКИ ДАННЫХ
    if SecondScript[1].isStarter then -- РАЗВОРАЧИВАЕМ ПОСЛЕДОВАТЕЛЬНОСТЬ ЕСЛИ ВТОРОЙ СКРИПТ СТАРТОВЫЙ
        SecondScript = WorkSpriteScripts[Editor.movingScripts[1]]
        FirstScript = WorkSpriteScripts[Editor.movingScripts[2]]
        insertBlockId = Editor.movingScriptsBlocks[2] + 1
        SecondScriptID = Editor.movingScripts[1]
    end
    if #Editor.movingScripts > 2 then
        Debuguser("ПРЕДУПРЕЖДЕНИЕ: СЛИЯНИЕ СКРИПТОВ: СКРИПТОВ БОЛЬШЕ ЧЕМ 2, ВОЗМОЖНЫ ОШИБКИ В СЛИЯНИИ")
    end
    for i = 1, #SecondScript do
        table.insert(FirstScript, insertBlockId + (i - 1), SecondScript[i])
    end
    removeScript(SecondScriptID)
    --ПРОВЕРКА НА НАЛИЧИЕ НЕПРАВИЛЬНОГО Starter Блока
    for i = #FirstScript, 2, -1 do
        if FirstScript[i] and FirstScript[i].isStarter then
            table.remove(FirstScript, i)
            Debuguser("ОШИБКА: СЛИЯНИЕ СКРИПТОВ: НАЙДЕН НЕПРАВИЛЬНЫЙ STARTER БЛОК, ОН БЫЛ УДАЛЁН")
        end
    end
    elseif (FirstScript[1].type ~= 3 and SecondScript[1].type == 3) or (FirstScript[1].type == 3 and SecondScript[1].type ~= 3) then
    if FirstScript[1].type == 3 then -- РАЗВОРАЧИВАЕМ ПОСЛЕДОВАТЕЛЬНОСТЬ ЕСЛИ ВТОРОЙ СКРИПТ НЕ ДАННЫХ
        SecondScript = WorkSpriteScripts[Editor.movingScripts[1]]
        FirstScript = WorkSpriteScripts[Editor.movingScripts[2]]
        insertBlockId = Editor.movingScriptsBlocks[2] + 1
        SecondScriptID = Editor.movingScripts[1]
    end
    if #Editor.movingScripts > 2 then
        Debuguser("ПРЕДУПРЕЖДЕНИЕ: СЛИЯНИЕ СКРИПТОВ: СКРИПТОВ БОЛЬШЕ ЧЕМ 2, ВОЗМОЖНЫ ОШИБКИ В СЛИЯНИИ")
    end
    local links = FlattenEditorBlocks(FirstScript[insertBlockId-1].args)
    for i = 1, #links do
        if links[i].type == "text" and links[i].data == "   " then
            links[i].type = "block"
            links[i].data = SecondScript[1]
            break
        end
    end
    removeScript(SecondScriptID)
    end
    end
    end 
    if Editor.blocksRemoving then
        table.remove(WorkSpriteScripts,Editor.movingScripts[1])
        Editor.blocksRemoving = false
    end
    Editor.movingScripts = {}
    Editor.movingScriptsBlocks = {}
    Editor.AllowSpriteMoving = false
    Editor.movingScriptsST2 = Editor.timer
end
function love.wheelmoved(fsdfghujsf, FY)  --LOVE KEY
    local fakex, fakey = love.mouse.getPosition()
    local windowW, windowH = love.graphics.getDimensions()
    local scaleX = windowW / 1600 -- TARGET_W
    local scaleY = windowH / 900  -- TARGET_H

    -- 2. Переводим реальные пиксели окна в виртуальные 1600x900
    x = fakex / scaleX
    y = fakey / scaleY
    local IsUp
    if FY > 0 then
        IsUp = true
    else
        IsUp = false
    end
    --ПРОВЕРКА СКРОЛА В ОБЛАСТИ ДОСТАВАНИЯ БЛОКОВ 3, 43, 327, 854)
    if x > 3 and x < 330 and y > 43 and y < 897 then
        Editor.BlockListS = Editor.BlockListS + (FY * 60)
        if Editor.BlockListS > 0 then
            Editor.BlockListS = 0
        elseif Editor.BlockListS <  0 - (80 * #BlockList - 840) then
            Editor.BlockListS = 0 - (80 * #BlockList - 840)
        end
    end
end
end

