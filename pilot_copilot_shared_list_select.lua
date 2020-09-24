channels = {}
channels[1] = {name="Flight"}
channels[2] = {name="Ground"}
channels[3] = {name="Winch"}

headerHeight = 9
channelLineHeight = 9


inputPrevPilotChannel = 1
inputPrevCopilotChannel = 2
pilotSelection = 1
copilotSelection = 2


function isWithin(v,mi,ma)
    if v >= mi then
        if v <= ma then
            return true
        end
    end
    return false
end

function onTick()
    isPressed1 = input.getBool(1)
    
    screenWidth = input.getNumber(1)
    screenHeight = input.getNumber(2)
    
    input1X = input.getNumber(3)
    input1Y = input.getNumber(4)

    -- inputPrevPilotChannel = input.getNumber(7)
    -- inputPrevCopilotChannel = input.getNumber(8)
    pilotSelection = inputPrevPilotChannel
    copilotSelection = inputPrevCopilotChannel
    
    if not isPressed1
    then
        output.setNumber(7, inputPrevPilotChannel)
        output.setNumber(8, inputPrevCopilotChannel)
        return
    end

    if isWithin(input1X, 0, screenWidth / 3)
    then
        for i=1,#channels do
            sy = (i-1)*channelLineHeight + headerHeight+1 
            ey = sy + channelLineHeight
            if isWithin(input1Y, sy, ey)
            then
                pilotSelection = i
                break
            end
        end    
    elseif isWithin(input1X, screenWidth - screenWidth / 3, screenWidth)
    then
        for i=1,#channels do
            sy = (i-1)*channelLineHeight + headerHeight+1
            ey = sy + channelLineHeight
            if isWithin(input1Y, sy, ey)
            then
                if pilotSelection ~= i
                then
                    copilotSelection = i
                    break
                end
            end
        end   
    end

    if pilotSelection == copilotSelection
    then
        if copilotSelection < #channels
        then
            copilotSelection = copilotSelection + 1
        else
            copilotSelection = 1
        end
    end

    output.setNumber(7, pilotSelection)
    output.setNumber(8, copilotSelection)
    inputPrevPilotChannel = pilotSelection
    inputPrevCopilotChannel = copilotSelection
end    
        
function onDraw()
    screen.setColor(0,80,0)
    screen.drawRectF(0,0,screenWidth / 4, headerHeight)
    
    screen.drawRectF(screenWidth / 4+1,0,screenWidth / 2 - 2, headerHeight)
    
    screen.drawRectF(screenWidth - (screenWidth / 4),0,screenWidth / 4, headerHeight)
    
    screen.setColor(255,255,255)
    screen.drawTextBox(0,0,screenWidth / 4, headerHeight, "Pil", 0,0)
    screen.drawTextBox(screenWidth / 4+1,0,screenWidth / 2 - 2, headerHeight, "Ctrl", 0,0)
    screen.drawTextBox(screenWidth - (screenWidth / 4),0,screenWidth / 4, headerHeight, "Cop", 0,0)

    for i=1,#channels do
        screen.drawTextBox(screenWidth / 4+1,headerHeight +1 + (i-1)*channelLineHeight,screenWidth / 2-2, channelLineHeight, channels[i].name, 0,0)
    end    
    screen.setColor(0,255,0)
    screen.drawRectF(0, headerHeight+1  + (pilotSelection-1)*channelLineHeight, screenWidth / 4, channelLineHeight)
    screen.drawRectF(screenWidth - screenWidth / 4, headerHeight+1  + (copilotSelection-1)*channelLineHeight, screenWidth / 4, channelLineHeight)
    screen.setColor(0,0,0)
    screen.drawTextBox(0, headerHeight+1  + (pilotSelection-1)*channelLineHeight, screenWidth / 4, channelLineHeight, "SEL", 0,0)
    screen.drawTextBox(screenWidth - screenWidth / 4, headerHeight+1  + (copilotSelection-1)*channelLineHeight, screenWidth / 4, channelLineHeight, "SEL", 0,0)
end
