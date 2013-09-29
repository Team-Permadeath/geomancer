
StateInventory = {}
function StateInventory:init()
--self.cardsS=

end

function StateInventory:enter()
	invButtons=StateInventory:create()

end

function StateInventory:create()
	local cards=player:getCards()
	local temp = {}
	setmetatable(temp, StateInventory)
	temp.button = {	testButton = Button.create("Exit", 100,100)--,
					--test2 = Button.create("Remove", 500,500) 
				}
	--test3 = Button.create("Remove", 500,600)
	--table.insert(temp.button,test3)

	--print("DERP2")
	u=0
	for i, v in ipairs(cards) do
		local tempp = {}
		--setmetatable(tempp, StateInventory)
     	tempp = Button.create("Rmv",350+ 110*((i-1)%7), 275+(u*200), i)
     	table.insert(temp.button, tempp)
     	--love.graphics.draw(v.image, 300+ 110*(i%7), 300+(u*200))
     	--print("DERP")
     	if i%7==0 then u=u+1 end
    end	




		--temp.button
	return temp
end


function StateInventory:addButton(posx, posy)
	local temp = {}
	setmetatable(temp, StateInventory)
	--temp.button = {	
	tempButton = Button.create("Remove", posx,posy) 
	--}	
	return tempButton
end


	--init stuff for buttons

function StateInventory.update(dt)
		
	for n,b in pairs(invButtons.button) do
		b:update(dt)
	end
end


function StateInventory:draw()
		--nrcards=ifiWorld:getPlayerAmountCards()
		--draw buttons
		for n,b in pairs(invButtons.button) do
		b:draw()
		end
		love.graphics.setColor(255, 255, 255)



		--draw cards
		cards=player:getCards()
	
		u=0
		for i, v in ipairs(cards) do				
     			love.graphics.draw(v.image, 300+ 110*((i-1)%7), 100+(u*200))
     			if i%7==0 then u=u+1 end

    	end
		--for n,b in cards do
		--	print(n)
		--end

	--for n,b in cards do
	--
	--end
	
end

function StateInventory:keyreleased(key, unicode)
    if key == "return" then
	--Sound:playmusic(MusicTypes.Exploration)
        Gamestate.switch(StateExplore)
	end
end

function StateInventory:mousepressed(x,y,button)
	
	for n,b in pairs(invButtons.button) do
		if b:mousepressed(x,y,button) then
				if b.text == "Rmv" then
				--print(" ->")--love.event.push("quit")
					print(" ->" , b.cardIndex)--love.event.push("quit")
					--if cards.size()>
					player:rmvCard(b.cardIndex)

					Gamestate.switch(StateInventory)
				end

			if b.text == "Exit" then
					--love.event.push("quit")
					--print(" <->") --love.event.push("quit")
					Gamestate.switch(StateExplore)
					 end
			
		end
	end
	
end
