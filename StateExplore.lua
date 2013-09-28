require "IfiWorld"
require "Monster"

local ifiWorld
local fogImg

StateExplore = {}

function StateExplore:init()
  ifiWorld = IfiWorld()
  fogImg = love.graphics.newImage("Images/fog.png")
end

function StateExplore:enter(previousState)
  love.graphics.setBackgroundColor(100, 100, 100)
end

function StateExplore:update(dt)
  ifiWorld:update(dt)
end

function StateExplore:draw()
	ifiWorld:draw()
  --love.graphics.draw(fogImg, 0, 0)
end

function StateExplore:keyreleased(key, unicode)
	if key == "up" then
    	ifiWorld:movePlayer(0, -1)
  	end
  	if key == "down" then
    	ifiWorld:movePlayer(0, 1)
  	end
  	if key == "left" then
    	ifiWorld:movePlayer(-1, 0)
  	end
  	if key == "right" then
    	ifiWorld:movePlayer(1, 0)
  	end
  	if key == "b" then
  		Gamestate.switch(StateBattle)
  	end
end
