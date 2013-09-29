Camera = require "Lib.hump.camera"
require "IfiWorld"
require "TopFloorWorld"
require "Monster"

IFI_WORLD = 0
TOP_FLOOR_WORLD = 1

local worlds = {}
local activeWorld = IFI_WORLD
local camera = Camera()
local fogImg

StateExplore = {}

function StateExplore:init()
  worlds[IFI_WORLD] = IfiWorld()
  worlds[TOP_FLOOR_WORLD] = TopFloorWorld()
  worlds[activeWorld]:loadMap()
  fogImg = love.graphics.newImage("Images/fog.png")
end

function StateExplore:enter(previousState)
	Sound:playMusic(MusicTypes.Exploration)
	Sound:playEffect(EffectTypes.Transition)
	love.graphics.setBackgroundColor(100, 100, 100)
end

function StateExplore:update(dt)
  worlds[activeWorld]:update(dt)
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
	worlds[activeWorld]:draw(camera:pos())
  player:draw()
  camera:detach()
  --love.graphics.draw(fogImg, 0, 0)
  love.graphics.setColor(0, 0, 0)
  state.button.inventory:draw()
  love.graphics.setColor(255,255,255) 
  --cards:draw(0, WINDOW_HEIGHT - 200)
  love.graphics.setColor(255,255,255) 
end

function StateExplore:mousepressed(x,y,button)
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
      elseif n == "inventory" then
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
  		Gamestate.switch(StateBattle, 22)
  	end
end

function movePlayer(dx, dy)
  local newPlayerX = player:getX() + dx
  local newPlayerY = player:getY() + dy
  if activeWorld == IFI_WORLD then
    local ifiWorld = worlds[IFI_WORLD]
    if ifiWorld:tileIsFree(newPlayerX, newPlayerY) then
      player:setPos(newPlayerX, newPlayerY)
      -- check for battle
      if ifiWorld:isMonster(newPlayerX, newPlayerY) then
        Gamestate.switch(StateBattle, ifiWorld:getMonsterId(newPlayerX, newPlayerY))
      end
      -- check for nut
      local pickableLayerId = ifiWorld:getLayerId("pickable")
      local pickableId = ifiWorld:getTileId(newPlayerX, newPlayerY, pickableLayerId)
      if pickableId == IFI_NUT_TILE then
        ifiWorld:setTileId(newPlayerX, newPlayerY, pickableLayerId, IFI_EMPTY_TILE)
        local newCollectedNuts = player:getCollectedNuts() + 1
        player:setCollectedNuts(newCollectedNuts)
      end
    else
      local templateLayerId = ifiWorld:getLayerId("template")
      if ifiWorld:getTileId(newPlayerX, newPlayerY, templateLayerId) == IFI_METAL_DOOR then
        local killedMonsters = player:getKilledMonsters()
        if 5 < killedMonsters and not ifiWorld:isDoorOpen(1) then
          ifiWorld:openDoor(1)
        elseif 10 < killedMonsters and not ifiWorld:isDoorOpen(2) then
          ifiWorld:openDoor(2)
        elseif 17 < killedMonsters and not ifiWorld:isDoorOpen(3) then
          ifiWorld:openDoor(3)
        elseif ifiWorld:isElevator(newPlayerX, newPlayerY) then
          if activeWorld == IFI_WORLD then
            activeWorld = TOP_FLOOR_WORLD
            player:teleportToPos(12, 8)
          else
            activeWorld = IFI_WORLD
            player:teleportToPos(90, 11)
          end
          worlds[activeWorld]:loadMap()
        else
          ifiWorld:setDoorBubbleTimer(5)
        end
      end
    end
  else
    local topFloorWorld = worlds[TOP_FLOOR_WORLD]
    if topFloorWorld:tileIsFree(newPlayerX, newPlayerY) then
      player:setPos(newPlayerX, newPlayerY)
      -- check for battle
      if topFloorWorld:isMonster(newPlayerX, newPlayerY) then
        Gamestate.switch(StateBattle, topFloorWorld:getMonsterId(newPlayerX, newPlayerY))
      end
    else
      if topFloorWorld:isElevator(newPlayerX, newPlayerY) then
        if activeWorld == IFI_WORLD then
          activeWorld = TOP_FLOOR_WORLD
          player:teleportToPos(12, 8)
        else
          activeWorld = IFI_WORLD
          player:teleportToPos(90, 11)
        end
        worlds[activeWorld]:loadMap()
      end
    end
  end
end