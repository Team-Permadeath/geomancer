Camera = require "Lib.hump.camera"
require "IfiWorld"
require "Monster"

local ifiWorld
local camera = Camera()
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
  player:update(dt)
  -- update camera
  local playerActPixelX, playerActPixelY = player:getActPixelPos()
  -- camera should be focused on the middle of the player character
  playerActPixelX = playerActPixelX + TILE_SIZE / 2
  playerActPixelY = playerActPixelY + TILE_SIZE / 2
  camera:lookAt(playerActPixelX, playerActPixelY)

  for n,b in pairs(state.button) do
    b:update(dt)
  end
end

function StateExplore:draw()
  camera:attach()
	ifiWorld:draw(camera:pos())
  player:draw()
  camera:detach()
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
    	movePlayer(0, -1)
  	end
  	if key == "down" then
    	movePlayer(0, 1)
  	end
  	if key == "left" then
    	movePlayer(-1, 0)
  	end
  	if key == "right" then
    	movePlayer(1, 0)
  	end
  	if key == "b" then
  		Gamestate.switch(StateBattle)
  	end
end

function movePlayer(dx, dy)
  local newPlayerX = player:getX() + dx
  local newPlayerY = player:getY() + dy
  if ifiWorld:tileIsFree(newPlayerX, newPlayerY) then
    player:setPos(newPlayerX, newPlayerY)
    -- check for battle
    local monstersLayerId = ifiWorld:getLayerId("monsters")
    local monsterId = ifiWorld:getTileId(newPlayerX, newPlayerY, monstersLayerId)
    if monsterId ~= 0 then
      Gamestate.switch(StateBattle)
    end
    -- check for nut
    local pickableLayerId = ifiWorld:getLayerId("pickable")
    local pickableId = ifiWorld:getTileId(newPlayerX, newPlayerY, pickableLayerId)
    if pickableId == NUT_TILE then
      ifiWorld:setTileId(newPlayerX, newPlayerY, pickableLayerId, EMPTY_TILE)
      local newCollectedNuts = player:getCollectedNuts() + 1
      player:setCollectedNuts(newCollectedNuts)
    end
  else
    local templateLayerId = ifiWorld:getLayerId("template")
    if ifiWorld:getTileId(newPlayerX, newPlayerY, templateLayerId) == METAL_DOOR then
      ifiWorld:setDoorBubbleTimer(3)
    end
  end
end