Gamestate = require "Lib.hump.gamestate"
math.randomseed( os.time() )

require "Sound"
Sound = SoundSystem()
require "Player"
require("lua/button")

-- globals being used in different game states
cards = nil -- representation of cards

-- game states
require "StateMenu"
require "StateExplore"
require "StateBattle"
require "StateInventory"
-- cards
require "Cards.CardsRepository"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(StateMenu)
    cards = CardsRepository(5, 2, 2)
end

function love.update(dt)
	Sound:update(dt)
end

function love.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
  	if key == "escape" then
    	love.event.push("quit")   -- actually causes the app to quit
  	end
end
