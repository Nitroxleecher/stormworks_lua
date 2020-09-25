numChannels = 9

activeChannel = 1

btnWidth = 6
btnHeight = 7
pos = 1

function onTick()
    isPressed1 = input.getBool(1)
    
    w = input.getNumber(1)
    h = input.getNumber(2)
    
    input1X = input.getNumber(3)
    input1Y = input.getNumber(4)
    
    activeChannel = input.getNumber(7)
    pos = input.getNumber(8)
    numChannels = input.getNumber(9)
    
    newChannel = activeChannel
    
    if isPressed1 then
        y = 0
        if pos == 1 or pos == 2 then  -- top
            y = 0
        elseif pos == 3 or pos == 4 then -- bottom
            y = h - btnHeight       
        end
        
        
        for i=1,numChannels do
            if pos == 1 or pos == 3 then  -- left
                x=(i-1) * (btnWidth + 1) + 1
            else -- right
                x=w - numChannels*(btnWidth + 1) + (i-1) * (btnWidth + 1)
            end
            
            
            if input1X >= x and input1X <= x+btnWidth and input1Y >=y and input1Y <= y+btnHeight then
                newChannel = i
                break
            end
        end
    end
    
    if newChannel ~= activeChannel then
        output.setBool(1, true)
        output.setNumber(1, newChannel)
        activeChannel = newChannel
    else
        output.setBool(1, false)    
        output.setNumber(1, activeChannel)
    end
    
end    
        
function onDraw()
    w=screen.getWidth()
    h=screen.getHeight()
    
    screen.setColor(30,30,30)
    
    sx = numChannels*btnWidth + (numChannels + 1)
    sy = btnHeight+1
    if pos == 1 then  -- top left
        screen.drawRectF(0, 0, sx, sy)
    elseif pos == 2 then -- top right
        screen.drawRectF(w-sx, 0, sx, sy)
    elseif pos == 3 then -- bottom left
        screen.drawRectF(0, h-sy, sx, sy)
    else -- bottom right
        screen.drawRectF(w-sx, h-sy, sx, sy)
    end
    
    
    
    y = 0
    if pos == 1 or pos == 2 then  -- top
        y = 0
    elseif pos == 3 or pos == 4 then -- bottom
        y = h - btnHeight       
    end
    
    for i=1,numChannels do
        if pos == 1 or pos == 3 then  -- left
            x=(i-1) * (btnWidth + 1) + 1
        else -- right
            x=w - numChannels*(btnWidth + 1) + (i-1) * (btnWidth + 1)
        end
        
        if activeChannel == i then
            screen.setColor(0,255,0)
            screen.drawRectF(x, y, btnWidth, btnHeight)
        else
            screen.setColor(100,100,100)
            screen.drawRectF(x, y, btnWidth, btnHeight)
        end
        
        screen.setColor(0,0,0)
        screen.drawTextBox(x, y, btnWidth, btnHeight, tostring(i), 0, 0)
    end
end
