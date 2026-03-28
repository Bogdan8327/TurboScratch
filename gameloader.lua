---@diagnostic disable: need-check-nil
local function AskFile(defaultName)
    -- Команда PowerShell для открытия диалога
    -- [Console]::Write возвращает путь без лишних переносов строк (\r\n)
-- Экранируем одинарные кавычки в имени, если они там есть
    local safeName = defaultName:gsub("'", "''")

    local psCommand = [[powershell -NoProfile -WindowStyle Hidden -Command "]] ..
        [[$OutputEncoding = [System.Text.Encoding]::UTF8; ]] ..
        [[Add-Type -AssemblyName System.Windows.Forms; ]] ..
        [[$s = New-Object System.Windows.Forms.SaveFileDialog; ]] ..
        [[$s.InitialDirectory = 'C:\'; ]] ..
        [[$s.FileName = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(']] .. love.data.encode("string", "base64", safeName) .. [[')); ]] ..
        [[$s.Filter = 'All Files (*.*)|*.*'; ]] ..
        [[$s.Title = 'Save File'; ]] ..
        [[$gui = New-Object System.Windows.Forms.Form; $gui.TopMost = $true; ]] ..
        [[if($s.ShowDialog($gui) -eq 'OK') { Write-Host -NoNewline $s.FileName }"]]

    local handle = io.popen(psCommand)
    local rawPath = handle:read("*a")
    handle:close()

    -- Жесткая очистка пути от спецсимволов и BOM-метки UTF-8
    local filePath = rawPath:gsub("[\239\187\191]", ""):gsub("[%c]", ""):match("^%s*(.-)%s*$")

    if filePath and filePath ~= "" then
        return filePath
    else
        return nil -- Если пользователь нажал "Отмена"
    end
end
function impfileask()
    -- Команда PowerShell для открытия диалога
    -- [Console]::Write возвращает путь без лишних переносов строк (\r\n)
local psCommand = [[powershell -NoProfile -WindowStyle Hidden -Command "]] ..
        [[Add-Type -AssemblyName System.Windows.Forms; ]] ..
        [[$s = New-Object System.Windows.Forms.OpenFileDialog; ]] ..
        [[$s.InitialDirectory = 'C:\'; ]] ..
        [[$s.Filter = 'All Files (*.*)|*.*'; ]] ..
        [[$s.Title = 'Select File'; ]] ..
        -- Этот трюк заставляет окно быть поверх остальных
        [[if($s.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost=$true})) -eq 'OK') { Write-Host -NoNewline $s.FileName }"]]

    local handle = io.popen(psCommand)
    local rawPath = handle:read("*a")
    handle:close()
    -- Жесткая очистка пути от спецсимволов и BOM-метки UTF-8
    local filePath = rawPath:gsub("[\239\187\191]", ""):gsub("[%c]", ""):match("^%s*(.-)%s*$")

    if filePath and filePath ~= "" then
        return filePath
    else
        return nil -- Если пользователь нажал "Отмена"
    end
    
end
function impfile(filepath)
    if not filepath then
        return
    end
            local file = io.open(filepath, "rb")
            local content
        if file then
            content = file:read()
            file:close()
            local chunk = load(content)
            game = chunk()
            for i=1,#game.sprites do
                for ii = 1 ,#game.sprites[i].costumes do --
                game.sprites[i].costumes[ii] = love.graphics.newImage(love.image.newImageData(love.filesystem.newFileData(love.data.decode("string", "base64", game.sprites[i].costumesIMGDAT[ii]), "i.png")))
                game.sprites[i].costumesIMGDAT[ii] = love.image.newImageData(love.filesystem.newFileData(love.data.decode("string", "base64", game.sprites[i].costumesIMGDAT[ii]), "i.png"))
                end
            end
            return "suc"
        else
            love.window.showMessageBox( "ОШИБКА В ПУТИ", "ОШИБКА: ВЫБЕРИТЕ ПУТЬ ДЛЯ ЗАГРУЗКИ ФАЙЛА БЕЗ РУССКИХ БУКВ, НАПРИМЕР C:\\games\\My game 123 \n если в файле есть кракозябры то переименуйте файл в чтонибуть на английском")
        end

end
function exp(ext)
    local path = AskFile(game.name)
    if path then
        path = path.."."..ext
        local gamecln = deepcopy(game)
        --123
        for i=1,#gamecln.sprites do
            for ii = 1 ,#gamecln.sprites[i].costumesIMGDAT do --
                gamecln.sprites[i].costumesIMGDAT[ii] = love.data.encode("string", "base64", game.sprites[i].costumesIMGDAT[ii] :encode("png"):getString())
            end
        end
        local str = serpent.dump(gamecln, {nocode = true, sparse = true})
        local file = io.open(path, "wb")
        if file then
            file:write(str)
            file:close()
            love.window.showMessageBox("ГОТОВО!","СОХРАНЕНО, но учитывайте что если в названии игры есть русские буквы, они поменяются на кракозябры, переименуйте сохранённый файл \n в чтонибуть на английском")
        else
            love.window.showMessageBox( "ОШИБКА В ПУТИ", "ОШИБКА: ВЫБЕРИТЕ ПУТЬ ДЛЯ СОХРАНЕНИЯ ФАЙЛА БЕЗ РУССКИХ БУКВ И НЕ В КОРНЕ ДИСКА C:\\, НАПРИМЕР C:\\games\\My game 123")
            exp(ext)
        end
    end
end
return {exp,impfileask,impfile}