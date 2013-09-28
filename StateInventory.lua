
StateInventory = {}
function StateInventory:init()
--self.cardsS=


end

function StateInventory:enter()

	
end
	

	--init stuff for buttons



function StateInventory.update(dt)
		
	for n,b in pairs(state.button) do
		b:update(dt)
	end
end

function StateInventory:draw()
		--nrcards=ifiWorld:getPlayerAmountCards()
		cards=ifiWorld:getPlayerCards()
		if cards == nil then
			print("nil")
			else
				print("not nil")
		end
		u=0
		for i, v in ipairs(cards) do
     			love.graphics.draw(v.image, 300+ 110*(i%7), 300+(u*200))
     			if i%7==7 then u=u+1 end
    		end
		--for n,b in cards do
		--	print(n)
		--end

	--for n,b in cards do
	--
	--end
	for n,b in pairs(state.button) do
		b:draw()
	end
end

function StateInventory:keyreleased(key, unicode)
    if key == "return" then
	--Sound:playmusic(MusicTypes.Exploration)
        Gamestate.switch(StateExplore)
	end
end

function StateInventory:mousepressed(x,y,button)
	
	for n,b in pairs(state.button) do
		if b:mousepressed(x,y,button) then
			if n == "new" then
				--state = Game.create()
				love.graphics.setColor(unpack(color["text"])) 
				Gamestate.switch(StateExplore)
			elseif n == "instructions" then
				state = Instructions.create()
			elseif n == "options" then
				state = Options.create()
			elseif n == "quit" then
				love.event.push("quit")
			elseif n == "testButton" then
				love.event.push("quit")
			end
		end
	end
	
end
