require "World"

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
end

function StateExplore:draw()
	world:draw()
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
