
StateInventory = {}
function StateInventory:init()	
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
