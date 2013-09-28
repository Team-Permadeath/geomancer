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
	Sound:playMusic(MusicTypes.Exploration)
	Sound:playEffect(EffectTypes.Transition)
	love.graphics.setBackgroundColor(100, 100, 100)
  --love.graphics.setColor(255,255,255,255)
end

function StateExplore:update(dt)
  ifiWorld:update(dt)
  for n,b in pairs(state.button) do
    b:update(dt)
  end
end

function StateExplore:draw()
	ifiWorld:draw()
  --love.graphics.draw(fogImg, 0, 0)
  for n,b in pairs(state.button) do
    if  n == "testButton" then b:draw() end
  end
  love.graphics.setColor(255,255,255) 

end

function StateExplore
  :mousepressed(x,y,button)
  
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
        Gamestate.switch(StateInventory)
      end
    end
  end
  
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
