local mp = {
    images = {},      
    intImages = false,
    selectedIdx = 1,
    timer = 0,
    brushSize = 10,
    color = {1, 1, 1},
    mode = "brush", -- "brush", "eraser", "rect", "circle"
    canvasSize = 500,
    palette = {
        {1,1,1}, {0,0,0}, {1,0,0}, {0,1,0}, {0,0,1}, {1,1,0}, {1,0,1}, {0,1,1}
    }
}

local function create_empty_canvas()
    local c = love.graphics.newCanvas(mp.canvasSize, mp.canvasSize)
    love.graphics.setCanvas(c)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setCanvas()
    return c
end

function mp.start(inputImages)
    mp.images = {}
    local list = type(inputImages) == "table" and inputImages or {inputImages}
    
    local XX, YY = love.graphics.getDimensions()
    local koshylX = 1600 / XX
    local koshylY = 900 / YY
    
    for _, img in ipairs(list) do
        local c = create_empty_canvas()
        local w, h = img:getDimensions()
        local sw = (500 / w) * koshylX
        local sh = (500 / h) * koshylY
        
        table.insert(mp.images, { 
            canvas = c, 
            source = img, 
            isReady = false, 
            scaleX = sw,
            scaleY = sh
        })
    end
    
    if #mp.images == 0 then
        table.insert(mp.images, { canvas = create_empty_canvas(), isReady = true })
    end


    mp.selectedIdx = 1
    mp.intImages = false 
    mp.loadTimer = 0    
end



function mp.update(dt)
    if not mp.intImages and #mp.images > 0 then
        mp.loadTimer = mp.loadTimer + dt
        
        if mp.loadTimer >= 0.1 then 
            mp.loadTimer = 0
            if mp.selectedIdx < #mp.images then
                mp.selectedIdx = mp.selectedIdx + 1
            else
                
                mp.intImages = true
                mp.selectedIdx = 1
            end
        end
        return 
    end


    local realX, realY = love.mouse.getPosition()
    local screenW, screenH = love.graphics.getDimensions()
    local mx, my = realX * (1600 / screenW), realY * (900 / screenH)
    local isClick = love.mouse.isDown(1)
    local item = mp.images[mp.selectedIdx]

    if isClick and mx > 1300 then

        if mx > 1350 and mx < 1550 and my > 50 and my < 300 then
            local col = math.floor((mx - 1350) / 50) + 1
            local row = math.floor((my - 50) / 50) + 1
            local idx = (row - 1) * 4 + col
            if mp.palette[idx] then mp.color = mp.palette[idx] end
        end

        if my > 350 and my < 600 then
            if my < 400 then mp.mode = "brush"
            elseif my < 450 then mp.mode = "eraser"
            elseif my < 500 then mp.mode = "rect"
            elseif my < 550 then mp.mode = "circle"
            end
        end

        if my > 650 and my < 700 then
            mp.brushSize = math.max(1, math.min(100, (mx - 1350) / 2))
        end
    end

    if isClick and my > 820 and mx > 410 and mx < 1600 then
        local results = {}
        for i, itm in ipairs(mp.images) do
            results[i] = itm.canvas:newImageData()
        end
        return results, mp.selectedIdx
    end


    if isClick and mx < 400 and my > 820 then
        table.insert(mp.images, { canvas = create_empty_canvas(), isReady = true })
        mp.selectedIdx = #mp.images
        love.timer.sleep(0.15) 
    end


    if isClick and mx < 400 and my < 800 then
        local idx = math.floor(my / 110) + 1
        if mp.images[idx] then mp.selectedIdx = idx end
    end


    if item and isClick then
        local ox, oy = 750, 100
        local cx, cy = mx - ox, my - oy
        if cx >= 0 and cx <= 500 and cy >= 0 and cy <= 500 then
            love.graphics.setCanvas(item.canvas)
            if mp.mode == "eraser" then
                love.graphics.setBlendMode("replace")
                love.graphics.setColor(0,0,0,0)
            else
                love.graphics.setBlendMode("alpha")
                love.graphics.setColor(mp.color)
            end
            local s = mp.brushSize
            if mp.mode == "brush" or mp.mode == "eraser" or mp.mode == "circle" then
                love.graphics.circle("fill", cx, cy, s)
            elseif mp.mode == "rect" then
                love.graphics.rectangle("fill", cx - s, cy - s, s*2, s*2)
            end
            love.graphics.setCanvas()
            love.graphics.setBlendMode("alpha")
            love.graphics.setColor(1, 1, 1)
        end
    end
    return nil
end

local function draw_grid(x, y, w, h, size)
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", x, y, w, h)
    love.graphics.setColor(0.5, 0.5, 0.5)
    for i = 0, w, size do
        for j = 0, h, size do
            if (i/size + j/size) % 2 == 0 then
                love.graphics.rectangle("fill", x + i, y + j, math.min(size, w-i), math.min(size, h-j))
            end
        end
    end
end

function mp.draw()
    local item = mp.images[mp.selectedIdx]
    if not item then return end


    if item.source and not item.isReady then
        love.graphics.setCanvas(item.canvas)
        love.graphics.clear(0, 0, 0, 0)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setBlendMode("alpha", "premultiplied")
        

        love.graphics.draw(item.source, 0, 0, 0, item.scaleX, item.scaleY)
        
        love.graphics.setCanvas()
        love.graphics.setBlendMode("alpha")
        item.isReady = true
    end

    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", 0, 0, 1600, 900)


    love.graphics.setColor(0.15, 0.15, 0.15)
    love.graphics.rectangle("fill", 0, 0, 400, 900)
    for i, itm in ipairs(mp.images) do
        local y = (i-1) * 110 + 10
        love.graphics.setColor(i == mp.selectedIdx and {0.3, 0.3, 0.6} or {0.2, 0.2, 0.2})
        love.graphics.rectangle("fill", 10, y, 380, 100)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(itm.canvas, 20, y+10, 0, 80/500, 80/500)
        love.graphics.print("Костюм #"..i, 120, y + 40)
    end


    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", 10, 820, 380, 70)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("НОВЫЙ КОСТЮМ", 130, 845)


    draw_grid(750, 100, 500, 500, 20)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(item.canvas, 750, 100)
    love.graphics.rectangle("line", 750, 100, 500, 500)


    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", 1300, 0, 300, 900)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("ЦВЕТ", 1350, 20)
    for i, col in ipairs(mp.palette) do
        local x = 1350 + ((i-1)%4) * 50
        local y = 50 + math.floor((i-1)/4) * 50
        love.graphics.setColor(col)
        love.graphics.rectangle("fill", x, y, 45, 45)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("ИНСТРУМЕНТ", 1350, 320)
    local modes = {brush="КИСТЬ", eraser="ЛАСТИК", rect="КВАДРАТ", circle="КРУГ"}
    local order = {"brush", "eraser", "rect", "circle"}
    for i, m in ipairs(order) do
        love.graphics.setColor(mp.mode == m and {0.4, 0.4, 1} or {0.3, 0.3, 0.3})
        love.graphics.rectangle("fill", 1350, 350 + (i-1)*50, 200, 40)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(modes[m], 1370, 360 + (i-1)*50)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("РАЗМЕР: " .. math.floor(mp.brushSize), 1350, 620)
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", 1350, 660, 200, 10)
    love.graphics.setColor(0.4, 0.4, 1)
    love.graphics.circle("fill", 1350 + mp.brushSize*2, 665, 10)


    love.graphics.setColor(0.1, 0.6, 0.1)
    love.graphics.rectangle("fill", 410, 820, 1180, 70)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("УСТАНОВИТЬ КОСТЮМ И ВЫЙТИ В РЕДАКТОР", 700, 845, 0, 1.5, 1.5)
end

return mp
