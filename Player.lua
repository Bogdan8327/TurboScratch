local function cEmptyMap()
    ret = {}
    for i = 1,481 do
        ret[i] = {}
        for mi = 1,301 do
            ret[i][mi] = false
        end
    end
    return ret
end
local function checkTouching(sprite1, sprite2)
    local map = cEmptyMap()
    
    -- Оптимизация Sprite1
    local tarr1 = sprite1.costumesColMaps[sprite1.costumeNumber]
    local s1 = sprite1.size / 100
    local rad1 = math.rad(sprite1.rotation)
    local cos1, sin1 = math.cos(rad1) * s1, math.sin(rad1) * s1
    local w1 = #tarr1
    local cx1, cy1 = w1 / 2, w1 / 2
    local px1, py1 = sprite1.pos.x + 240, sprite1.pos.y + 150

    for i = 1, w1 do
        local row = tarr1[i]
        local dy = i - cy1
        for ii = 1, #row do
            if row[ii] then
                local dx = ii - cx1
                local x = math.floor(px1 + dx * cos1 - dy * sin1)
                local y = math.floor(py1 + dx * sin1 + dy * cos1)
                local mrow = map[x]
                if mrow then mrow[y] = true end
            end
        end
    end

    -- Оптимизация Sprite2
    local tarr2 = sprite2.costumesColMaps[sprite2.costumeNumber]
    local s2 = sprite2.size / 100
    local rad2 = math.rad(sprite2.rotation)
    local cos2, sin2 = math.cos(rad2) * s2, math.sin(rad2) * s2
    local w2 = #tarr2
    local cx2, cy2 = w2 / 2, w2 / 2
    local px2, py2 = sprite2.pos.x + 240, sprite2.pos.y + 150

    for i = 1, w2 do
        local row = tarr2[i]
        local dy = i - cy2
        for ii = 1, #row do
            if row[ii] then
                local dx = ii - cx2
                local x = math.floor(px2 + dx * cos2 - dy * sin2)
                local y = math.floor(py2 + dx * sin2 + dy * cos2)
                local mrow = map[x]
                if mrow and mrow[y] then return true end
            end
        end
    end

    return false
end

function init()
    Player = {}
    Player.canvasPoss = {0,0,0,0}
    Player.canvas = love.graphics.newCanvas(480, 300)
    Player.canvas:setFilter("nearest", "nearest")
    Player.fullscr = false
    Player.execution = {} -- Спрайт, скрипт, блок, пауза bool, блок или счёт
    Player.pressedKeys = {}
    Player.asking = {}
    Player.asking.response = ""
    Player.asking.allowask = true
end
function GenerateCanvas() --ВСЕ ПОЗИЦИИ X  НУЖНО +240 а Y +150
    local function drawSprite(sprite)
        love.graphics.setColor(1, 1, 1, 1) 
        local size = sprite.size / 100 / 10
        local ox = sprite.costumes[sprite.costumeNumber]:getWidth() / 2 
        local oy = sprite.costumes[sprite.costumeNumber]:getHeight() / 2 
        love.graphics.draw(sprite.costumes[sprite.costumeNumber],sprite.pos.x+240,sprite.pos.y+150,math.rad(sprite.rotation),size,size,ox,oy)
    end
    local function drawVar(var)
        var.x = var.x +240
        var.y = var.y +150
        print(json.encode(var, { indent = true }))
        love.graphics.setColor(color.accent) 
        if var.size == 1 then
            love.graphics.setFont(FontBlocks)
            love.graphics.rectangle("fill",var.x,var.y,FontBlocks:getWidth(var.var..game.vars[var.var]),20)
            love.graphics.setColor(1, 1, 1, 1) 
            love.graphics.print(game.vars[var.var],var.x+FontBlocks:getWidth(var.var),var.y)
            love.graphics.setColor(0, 0, 0) 
            love.graphics.print(var.var,var.x,var.y)
            love.graphics.setFont(Font)
        else
            love.graphics.setFont(Font)            
            love.graphics.setColor(0, 0, 0) 
            love.graphics.print(game.vars[var.var],var.x,var.y)
        end
        var.x = var.x -240
        var.y = var.y -150
    end
    love.graphics.setCanvas(Player.canvas)
    love.graphics.clear(1, 1, 1) 
    --НАЧАЛО КАНВАСА
        love.graphics.setColor(0,0,0)
        --ОТОБРАЖЕНИЕ ВСЕХ СПРАЙТОВ
        local sprites = game.sprites
        for i = 1,#sprites do
        if sprites[i].show then
        drawSprite(sprites[i])
        end
        end
        --РИСУЕМ ПЕРЕМЕННЫЕ
        for i = 1,#game.shownVars do
        drawVar(game.shownVars[i])
        end
    --КОНЕЦ КАНВАСА
    love.graphics.setCanvas()
end
function DrawCanvas(x,y,xx,yy)
    Player.canvasPoss = {x,y,xx,yy}
    local targetW, targetH = xx, yy
    local scaleX = targetW / Player.canvas:getWidth() 
    local scaleY = targetH / Player.canvas:getHeight() 

    love.graphics.setColor(1, 1, 1, 1) 
    love.graphics.draw(Player.canvas, x, y, 0, scaleX, scaleY)
end
function axxx()
    function execArgs(name, args,path)
local function askk(q)
    -- Кодируем вопрос в Base64, чтобы избежать кракозябр и ошибок парсинга
    local b64q = love.data.encode("string", "base64", q)
    local title = "TurboScratch" -- Твой заголовок
    
    -- Команда: устанавливаем UTF8, декодируем вопрос и выводим окно
    local cmd = 'powershell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; ' ..
                '[void][System.Reflection.Assembly]::LoadWithPartialName(\'Microsoft.VisualBasic\'); ' ..
                '$q = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(\''..b64q..'\')); ' ..
                '[Microsoft.VisualBasic.Interaction]::InputBox($q, \''..title..'\')"'
    
    local f = io.popen(cmd)
    if not f then return nil end -- Страховка, если PowerShell не открылся
    
    local r = f:read("*a")
    f:close()

    -- Если r пустой или nil (нажали Cancel), сразу выходим
    if not r or r == "" then return nil end

    -- Обрезаем лишние пробелы/переносы от PowerShell
    r = r:gsub("^%s*(.-)%s*$", "%1")
    
    return r
end



    local sprites = game.sprites
    local sprite = sprites[path[1]]
    local script = sprite.scripts[path[2]]
    local block = script[path[3]]
    --name args[1].data
    if name == "getX" then
        return sprite.pos.x
    elseif name == "getY" then
        return sprite.pos.y
    elseif name == "random" then
        return love.math.random(tonumber(args[1].data),tonumber(args[2].data))
    elseif name == "getrotation" then
        return sprite.rotation
    elseif name == "getcostume" then
        return sprite.costumeNumber
    elseif name == "getsize" then
        return sprite.size
    elseif name == "mathplus" then
        return tonumber(args[1].data) + tonumber(args[2].data)
    elseif name == "mathminus" then
        return tonumber(args[1].data) - tonumber(args[2].data)
    elseif name == "mathmultiply" then
        return tonumber(args[1].data) * tonumber(args[2].data)
    elseif name == "mathdivide" then
        return tonumber(args[1].data) / tonumber(args[2].data)
    elseif name == "equals" then
        if args[1].data == args[2].data then return "true" else return "false" end
    elseif name == "and" then
        if (args[1].data == "true" or  args[1].data == "True" or args[1].data == "1") and (args[2].data == "true" or  args[2].data == "True" or args[2].data == "1") then return "true" else return "false" end
    elseif name == "or" then
        if (args[1].data == "true" or  args[1].data == "True" or args[1].data == "1") or (args[2].data == "true" or  args[2].data == "True" or args[2].data == "1") then return "true" else return "false" end
    elseif name == "glue" then
        return args[1].data..args[2].data
    elseif name == "getletter" then
        local word = args[2].data
        local n = tonumber(args[1].data)
---@diagnostic disable-next-line: param-type-mismatch
        return tostring(word):sub(utf8.offset(tostring(word), n), (utf8.offset(tostring(word), n + 1) or #tostring(word) + 1) - 1)
    elseif name == "notequals" then
        if args[1].data ~= args[2].data then return "true" else return "false" end
    elseif name == "1bigger" then
        if tonumber(args[1].data) > tonumber(args[2].data) then return "true" else return "false" end
    elseif name == "1smaller" then
        if tonumber(args[1].data) < tonumber(args[2].data) then return "true" else return "false" end
    elseif name == "not" then
        if args[1].data == "true" or  args[1].data == "True" or args[1].data == "1" then
            return "false"
        elseif args[1].data == "false" or args[1].data == "false" or args[1].data == "0" then
            return "true"
        end
    elseif name == "true" then 
        return "true"
    elseif name == "false" then
        return "false"
    elseif name == "istouching" then
        for i = 1,#game.sprites do
            if game.sprites[i].name == args[1].data then
                print(checkTouching(sprite,game.sprites[i]))
                if checkTouching(sprite,game.sprites[i]) then return "true" else return "false" end
            end
        end
        return "false"
    elseif name == "getvar" then 
        return game.vars[args[1].data]
    elseif name == "response" then 
        return Player.asking.response
    elseif name == "iskeypressed" then
        for i = 1,#Player.pressedKeys do if Player.pressedKeys[i] == args[1].data then return "true" end end
        return "false"
    end
    return "true"
    end
    local function process(args,path)
    local lastResult = nil
    
    for i = 1, #args do
        -- Если это блок, копаем вглубь
        if args[i].type == "block" then
            -- РЕКУРСИЯ: идем в его собственные аргументы
            if args[i].data and args[i].data.args then
                process(args[i].data.args,path)
            end

            -- Проверяем, "созрел" ли блок (стал ли весь его внутренний мир текстом)
            local ready = true
            for j = 1, #args[i].data.args do
                if args[i].data.args[j].type ~= "text" then
                    ready = false
                    break
                end
            end

            -- Если все внутренние args теперь текст — схлопываем блок
            if ready then
                -- Вызываем твою функцию (передаем имя и готовый массив аргументов)
                local res = execArgs(args[i].data.name, args[i].data.args,path)
                
                -- Заменяем сам блок на текстовый результат
                args[i] = {
                    type = "text",
                    data = tostring(res)
                }
                lastResult = res
            end
        else
            -- Если это просто текст, запоминаем его как последний результат
            lastResult = args[i].data
        end
    end
    
    return lastResult -- Вернет результат последнего выполненного execArgs
end

return process
end
function tick()
    local function execPath(path)
        local process = axxx()
        local sprites = game.sprites
        local sprite = sprites[path[1]]
        local script = sprite.scripts[path[2]]
        local block = script[path[3]]
        --ПОДГОТОВКА ДАННЫХ -НА БУДУЩЕЕ
        local args = {}
        for i = 1,#block.args do -- json.encode(myTable, { indent = true })
            if block.args[i].type == "text" then
                args[#args+1] = block.args[i].data
            else
                args[#args+1] = process({deepcopy(block.args[i])},path)
            end
        end
        --ИСПОЛНЕНИЕ САМОГО БЛОКА
        if block.name == "rotateleft" then
            sprite.rotation = sprite.rotation - tonumber(args[1])
        elseif block.name == "rotateright" then
            sprite.rotation = sprite.rotation + tonumber(args[1])
        elseif block.name == "setrotation" then
            sprite.rotation = tonumber(args[1])
        elseif block.name == "setX" then
            sprite.pos.x = tonumber(args[1])
        elseif block.name == "setY" then
            sprite.pos.y = tonumber(args[1])
        elseif block.name == "WalkSteps" then
            sprite.pos.x = tonumber(args[1]) + sprite.pos.x
        elseif block.name == "SetRandomPos" then
            sprite.pos.x = love.math.random(-240, 240)
            sprite.pos.y = love.math.random(-150, 150)
        elseif block.name == "setpos" then
            sprite.pos.x = tonumber(args[1])
            sprite.pos.y = tonumber(args[2])
        elseif block.name == "nextcostume" then
            sprite.costumeNumber = sprite.costumeNumber+1
            if sprite.costumeNumber > #sprite.costumes then
                sprite.costumeNumber = 1
            end
        elseif block.name == "backcostume" then
            sprite.costumeNumber = sprite.costumeNumber-1
            if sprite.costumeNumber == 0 then
                sprite.costumeNumber = #sprite.costumes
            end  
        elseif block.name == "setcostume" then
            sprite.costumeNumber = tonumber(args[1])
        elseif block.name == "setsize" then
            sprite.size = tonumber(args[1])
        elseif block.name == "showme" then
            sprite.show = true
        elseif block.name == "hideme" then
            sprite.show = false
        elseif block.name == "setvar" then
            game.vars[args[1]] = args[2]
        elseif block.name == "showvar" then
            local y = -150
            local found = false
            if #game.shownVars ~= 0 then
                for i = 1,#game.shownVars do
                    if game.shownVars[i].var == args[1] then
                        found = true
                        break
                    end
                    if game.shownVars[i].x == -240 then
                        if game.shownVars[i].y == y then
                            y = y + 25
                        end
                    end
                end
            end
            if not found then
                game.shownVars[#game.shownVars+1] = {
                    var = args[1],
                    x = -240,
                    y = y,
                    size = 1
                }
            else
                Debuguser("Переменная " .. args[1].. " уже показана!")
            end
        elseif block.name == "showvarbig" then
            local y = -150
            local found = false
            if #game.shownVars ~= 0 then
                for i = 1,#game.shownVars do
                    if game.shownVars[i].var == args[1] then
                        found = true
                        break
                    end
                    if game.shownVars[i].x == -240 then
                        if game.shownVars[i].y == y then
                            y = y + 25
                        end
                    end
                end
            end
            if not found then
                game.shownVars[#game.shownVars+1] = {
                    var = args[1],
                    x = -240,
                    y = y,
                    size = 2
                }
            else
                Debuguser("Переменная " .. args[1].. " уже показана!")
            end
        elseif block.name == "hidevar" then
            for i = 1,#game.shownVars do
                if game.shownVars[i].var == args[1] then
                    table.remove(game.shownVars,i)
                    break
                end
            end
        elseif block.name == "varsetXY" then
            for i = 1,#game.shownVars do
                if game.shownVars[i].var == args[1] then
                    game.shownVars[i].x = args[2]
                    game.shownVars[i].y = args[3]
                end
            end
        elseif block.name == "clearvar" then
            game.vars[args[1]] = ""
        elseif block.name == "debug" then
            Debuguser("ИГРА: "..args[1])
        elseif block.name == "transive" then
            startbyname("recive",args[1])
        elseif block.name == "runtimes" then
            path[tostring(block.id)] = tonumber(args[1])
        elseif block.name == "if" then
            if args[1] == "true" or args[1] == "True" or args[1] == "1" then
                --НИЧЕГО, УСЛОВИЕ ПРАВИЛЬНОЕ
            else
                local searchID = block.id
                for i = 1,#script do
                    if script[i].id == searchID and script[i].name == "end" then
                    --ГЕНЕРИРУЕМ ОТВЕТКУ
                    path[3] = i
                    return path
                    end
                end
            end
        elseif block.name == "waittimes" then
            if path[4] then
                if path[5] <= 0 then
                    path[4] = false
                else
                --ГЕНЕРИРУЕМ ОТВЕТКУ
                    path[5] = path[5] - 1
                    return path
                end
            else
                path[4] = true
                path[5] = tonumber(args[1]) * 60
                return path
            end
        elseif block.name == "ask" then
            local function asd(text)
                Player.asking.response = text
                Player.execution[#Player.execution+1] = Player.asking.path
            end
            if Player.asking.allowask then
            Player.asking = {}
            Player.asking.response = ""
            Player.asking.path = path
            Player.asking.allowask = false
            Debuguser("ИГРА СПРАШИВАЕТ: "..args[1])
            Ask.ask(asd)
            return
            else
                Player.asking.allowask = true
            end
        end
        --ОБРАБОТКА БЛОКОВ КОНЦА
        local blockid = path[3] + 1
        if script and blockid and script[blockid] and script[blockid].name then
            if script[blockid].name == "end" then --ЭТО БЛОК КОНЦА
                if script[blockid].endname == "forever" then --ЭТО БЛОК КОНЦА ЦИКЛА
                    local searchID = script[path[3] + 1].id
                        for i = 1,#script do
                            if script[i].id == searchID then
                                --ГЕНЕРИРУЕМ ОТВЕТКУ
                                path[3] = i + 1
                                return path
                            end
                        end
                elseif script[blockid].endname == "runtimes" then --ЭТО БЛОК КОНЦА ПОВТОРИТЬ РАЗ
                    local searchID = script[blockid].id
                    path[tostring(searchID)] = path[tostring(searchID)] - 1
                    if path[tostring(searchID)] == 0 then
                        path[3] = blockid
                        return path
                    else
                        for i = 1,#script do
                            if script[i].id == searchID then
                                --ГЕНЕРИРУЕМ ОТВЕТКУ
                               path[3] = i + 1
                                return path
                            end
                        end
                    end
                else
                    path[3] = blockid
                    return path
            end
            else
                path[3] = blockid
                return path
            end
        end
    end
    for i = #Player.execution, 1, -1 do
        if Player.execution[i][3] > #game.sprites[Player.execution[i][1]].scripts[Player.execution[i][2]] then --ПРОВЕРЯЕМ НЕ УЛЕТЕЛИ ЛИ МЫ ЗА ГРАНИ СКРИПТА
            table.remove(Player.execution,i)
        else
        local success, ret = pcall(execPath, Player.execution[i])

        if not success then
            Debuguser("В спрайте: "..Player.execution[i][1].." блоке: "..Player.execution[i][3].." произошла ошибка, скрипт был остановлен ("..game.sprites[Player.execution[i][1]].scripts[Player.execution[i][2]][Player.execution[i][3]].DisplayName..")")
            table.remove(Player.execution,i)
            print("ERROR FROM PLAYER.LUA")
            print(ret)
        else
        if ret then
            Player.execution[i] = ret
        else
            table.remove(Player.execution,i)
        end
        end
        end
    end
end
function start()
    Debuguser("ПЕРЕЗапуск скриптов игры")
    Player.execution = {}
    startbyname("start")
end
function startbyname(name,arg)
    local sprites = game.sprites
    for spriteI = 1,#sprites do
        local sprite = sprites[spriteI]
        local scripts = sprite.scripts
        for scriptI = 1,#scripts do
            local script = sprite.scripts[scriptI]
            if script[1].name == name then
                if arg then
                    if script[1].args[1].data == arg then
                        Player.execution[#Player.execution+1] = {spriteI,scriptI,2}
                    end
                else
                    Player.execution[#Player.execution+1] = {spriteI,scriptI,2}
                end
            end
        end
    end
end
function click(x,y) --В РАЗРЕШЕНИИ 1600x900 УЖЕ НО НУЖНО ПЕРЕВЕСТИ В КАНВАСНОЕ

end
return {
    init = init,
    GenerateCanvas = GenerateCanvas,
    DrawCanvas = DrawCanvas,
    tick = tick,
    start = start,
    click = click,
    startName = startbyname
}