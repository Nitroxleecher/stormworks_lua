currLength = 0
maxLength = 1
targetLength = 0

btnSize = 9
arrowMrgn = 2
b1x = 10
b2x = 22
by = 22

bUpActive = false
bDownActive = false

positionWindow = 0.1

function within(v,a,b)
    return v >= a and v < b 
end

function onTick()
    isPressed1 = input.getBool(1)
    
    input1X = input.getNumber(3)
    input1Y = input.getNumber(4)
    
    currLength = input.getNumber(7)
    maxLength = input.getNumber(8)
    targetLength = input.getNumber(9)
	positionWindow = input.getNumber(10)
	bMoveFactor = input.getNumber(11)

	if positionWindow == nil or positionWindow == 0 then
        positionWindow = 0.1
    end

	if bMoveFactor == nil  or bMoveFactor == 0 then
	    bMoveFactor = 1
	end
	
	bMoveFactor = bMoveFactor / 60
	
	origTargetLength = targetLength
	
    
    bDownActive = isPressed1 and within(input1X,b1x,b1x+btnSize) and within(input1Y,by,by+btnSize)
    bUpActive = isPressed1 and within(input1X,b2x,b2x+btnSize) and within(input1Y,by,by+btnSize)
    
    if bDownActive then
        targetLength = targetLength + bMoveFactor
    elseif bUpActive then
        targetLength = targetLength - bMoveFactor
    end

    if targetLength < 0 then
        targetLength = 0
    elseif targetLength > maxLength then
        targetLength = maxLength
    end
    
    output.setNumber(9, targetLength)
    output.setBool(5, origTargetLength ~= targetLength)

    moveUp = (targetLength - currLength) < 0 - positionWindow
    moveDown = (targetLength - currLength) > positionWindow

    output.setBool(3, moveUp)
    output.setBool(4, moveDown)
    
end

function onDraw()
    w = screen.getWidth()
    h = screen.getHeight()
    
    current = math.floor(currLength / maxLength * (h - 3) + 0.5)
    target = math.floor(targetLength / maxLength * (h - 3) + 0.5)

    screen.setColor(60,60,255)
    screen.drawRectF(4,3,2,current)

	screen.setColor(255,255,255)
    screen.drawRect(3,2,3,29)

    screen.setColor(255,255,255)
    screen.drawTriangleF(1,target-2 + 3,3,target + 3,1,target+2 + 3)
    
    screen.drawTextBox(7, 2, 25, 7, tostring(math.floor((currLength*10))/10),1,0)

    screen.drawTextBox(7, 12, 25, 7, tostring(math.floor((targetLength*10))/10),1,0)


    if bDownActive then
    screen.setColor(0,255,0)    
    else
    screen.setColor(255,255,255)    
    end
    
    screen.drawRectF(b1x,by, btnSize,btnSize)
    
    if bUpActive then
    screen.setColor(0,255,0)    
    else
    screen.setColor(255,255,255)    
    end
    screen.drawRectF(b2x,by, btnSize,btnSize)
    
    screen.setColor(0,0,0)
	screen.drawLine(b1x+arrowMrgn, by+arrowMrgn, b1x+arrowMrgn, by+arrowMrgn+2)
	screen.drawLine(b1x+arrowMrgn+1, by+arrowMrgn, b1x+arrowMrgn+1, by+arrowMrgn+4)
	screen.drawLine(b1x+arrowMrgn+2, by+arrowMrgn, b1x+arrowMrgn+2, by+arrowMrgn+6)
	screen.drawLine(b1x+arrowMrgn+3, by+arrowMrgn, b1x+arrowMrgn+3, by+arrowMrgn+4)
	screen.drawLine(b1x+arrowMrgn+4, by+arrowMrgn, b1x+arrowMrgn+4, by+arrowMrgn+2)
    

	screen.drawLine(b2x+arrowMrgn, by+arrowMrgn+3, b2x+arrowMrgn, by+arrowMrgn+5)
	screen.drawLine(b2x+arrowMrgn+1, by+arrowMrgn+1, b2x+arrowMrgn+1, by+arrowMrgn+5)
	screen.drawLine(b2x+arrowMrgn+2, by+arrowMrgn-1, b2x+arrowMrgn+2, by+arrowMrgn+5)
	screen.drawLine(b2x+arrowMrgn+3, by+arrowMrgn+1, b2x+arrowMrgn+3, by+arrowMrgn+5)
	screen.drawLine(b2x+arrowMrgn+4, by+arrowMrgn+3, b2x+arrowMrgn+4, by+arrowMrgn+5)
end

function httpReply(port, request_body, response_body)
end

