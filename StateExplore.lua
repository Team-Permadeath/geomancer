require "World"

camera = Camera() -- camera
world = nil -- representation of whole game's world

StateExplore = {}

function StateExplore:init()
  World:load()
end

function StateExplore:enter(previousState)
  love.graphics.setBackgroundColor(100, 100, 100)
end

function StateExplore:update(dt)
  world:update(dt)
    -- update camera
	local playerActPixelX, playerActPixelY = world:getPlayerActPixelPos()
	-- camera should be focused on the middle of the player character
	playerActPixelX = playerActPixelX + TILE_SIZE / 2
	playerActPixelY = playerActPixelY + TILE_SIZE / 2
	camera:lookAt(playerActPixelX, playerActPixelY)
end

function StateExplore:draw()
	camera:attach()
	world:draw()
	camera:detach()
end

function StateExplore:keyreleased(key, unicode)
	if key == "up" then
    	world:movePlayer(0, -1)
  	end
  	if key == "down" then
    	world:movePlayer(0, 1)
  	end
  	if key == "left" then
    	world:movePlayer(-1, 0)
  	end
  	if key == "right" then
    	world:movePlayer(1, 0)
  	end
  	if key == "b" then
		Sound:playmusic(MusicTypes.Combat)
		Sound:playeffect(EffectTypes.Transition)
  		Gamestate.switch(StateBattle)
  	end
end
