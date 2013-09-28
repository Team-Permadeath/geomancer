Gamestate = require "Lib.hump.gamestate"
Camera = require "Lib.hump.camera"

require "Player"

-- globals being used in different game states
camera = Camera() -- camera
world = nil -- representation of whole game's world

-- game states
require "StateMenu"
require "StateExplore"
require "StateBattle"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(StateMenu)
end

function love.update(dt)
end

function love.keyreleased(key, unicode)
  	if key == "escape" then
    	love.event.push("quit")   -- actually causes the app to quit
  	end
end