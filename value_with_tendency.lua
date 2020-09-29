value = 0

valueDiff = 0

prevValue = 0

function onTick()
	value = input.getNumber(1)
	
	valueDiff = (value - prevValue) * 60
	
	prevValue = value
end

function onDraw()
	screen.setColor(255,255,255)
	screen.drawTextBox(0,13,32,5,tostring(math.floor(value + 0.5)),0,0)
	
	if speedDiff >= 1 then
		screen.drawTextBox(0,7,32,5,"+",0,0)
		screen.drawTextBox(0,1,32,5,tostring(math.floor(valueDiff + 0.5)),0,0)
	elseif speedDiff <= -1 then
		screen.drawTextBox(0,19,32,5,"-",0,0)
		screen.drawTextBox(0,25,32,5,tostring(math.floor(math.abs(valueDiff) + 0.5)),0,0)
	end
	
end

function httpReply(port, request_body, response_body)
end

