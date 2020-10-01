
sx = 5
sy = -10


function onTick()
    isPressed1 = input.getBool(1)
    
    input1X = input.getNumber(3)
    input1Y = input.getNumber(4)
    
    gpsX = input.getNumber(7)
    gpsY = input.getNumber(8)
    heading = input.getNumber(9)
    
    targetX = input.getNumber(10)
    targetY = input.getNumber(11)
    
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	w2 = math.floor(w/2)
	h2 = math.floor(h/2)
	
    screen.setColor(255,255,255)
    --screen.drawCircle(15,15,15)
    
    tx = w2+sx
    ty = h2+sy
    
    screen.setColor(100,100,100)
    screen.drawLine(0,h2,w,h2)
    screen.drawLine(w2,0,w2,h)
    
    
    
    
    
    if tx < 0 or tx > w or ty < 0 or ty > h then
    	screen.setColor(255,40,40)		
    else
    	screen.setColor(0,255,0)
    end
    screen.drawLine(w2,h2,tx,ty)
    screen.drawLine(tx-1,ty,tx+1,ty)
    screen.drawLine(tx,ty-1,tx,ty+1)
end

function httpReply(port, request_body, response_body)
end

