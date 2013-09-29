StateInventory = {}

function StateInventory:init()
	nutImg = love.graphics.newImage("Tiles/decorative/nut-10.png")
end

function StateInventory:enter()
	invButtons=StateInventory:create()
end

function StateInventory:create()
	--making cards
	invCards=cards:getAllCards()
	local temp = {}
	setmetatable(temp, StateInventory)
	temp.button = {	testButton = Button.create("Exit", 100,100) }
	---making buttons
	u=0
	for i, v in ipairs(invCards) do
		local tempp = {}
     	tempp = Button.create("Rmv",350+ 110*((i-1)%7), 275+(u*200), i)
     	table.insert(temp.button, tempp)
     	if i%7==0 then u=u+1 end
    end
	return temp
end
function StateInventory.update(dt)
	for n,b in pairs(invButtons.button) do
		b:update(dt)
	end
end

function StateInventory:draw()
	--draw nuts
 	for i = player:getCollectedNuts(), 1, -1 do
    	love.graphics.draw(nutImg, love.graphics.getWidth() - i * 10 - TILE_SIZE, 10)
  	end
	--draw buttons
	for n,b in pairs(invButtons.button) do
		b:draw()
	end
	love.graphics.setColor(255, 255, 255)

	--draw invCards
	invCards=cards:getAllCards()

	u=0
	for i, v in ipairs(invCards) do				
		love.graphics.draw(v.image, 300+ 110*((i-1)%7), 100+(u*200))
		if i%7==0 then u=u+1 end
	end
end

function StateInventory:keyreleased(key, unicode)
    if key == "return" then
        Gamestate.switch(StateExplore)
	end
	if key == "i" then
      Gamestate.switch(StateExplore)
    end
end


function StateInventory:mousepressed(x,y,button)
	for n,b in pairs(invButtons.button) do
		if b:mousepressed(x,y,button) then
			if b.text == "Rmv" then
				cards:removeCard(invCards[b.cardIndex].type)
				Gamestate.switch(StateInventory)
			end

			if b.text == "Exit" then
				Gamestate.switch(StateExplore)
			end			
		end
	end
end
