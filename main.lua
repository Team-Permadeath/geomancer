Gamestate = require "Lib.hump.gamestate"
Camera = require "Lib.hump.camera"

require "Sound"
Sound = SoundSystem()
require "Player"

-- game states
require "StateMenu"
require "StateExplore"
require "StateBattle"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(StateMenu)
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
