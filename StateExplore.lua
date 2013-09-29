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
local nutImg

StateExplore = {}

function StateExplore:init()
  worlds[IFI_WORLD] = IfiWorld()
  worlds[TOP_FLOOR_WORLD] = TopFloorWorld()
  worlds[activeWorld]:loadMap()
  fogImg = love.graphics.newImage("Images/fog.png")
  nutImg = love.graphics.newImage("Tiles/decorative/nut-10.png")
end

function StateExplore:enter(previousState, enemyX, enemyY)
	Sound:playMusic(MusicTypes.Exploration)
	Sound:playEffect(EffectTypes.Transition)
	love.graphics.setBackgroundColor(100, 100, 100)
  if enemyX ~= nil and enemyY ~= nil then
    worlds[activeWorld]:removeMonster(enemyX, enemyY)
  end
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
  for i = player:getCollectedNuts(), 1, -1 do
    love.graphics.draw(nutImg, love.graphics.getWidth() - i * 10 - TILE_SIZE, 10)
  end
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
    if activeWorld == TOP_FLOOR_WORLD then
      if worlds[activeWorld]:isRogerAwake() then
        return
      end
    end
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
    if key == "i" then
      Gamestate.switch(StateInventory)
    end
  	-- if key == "b" then
  	-- 	Gamestate.switch(StateBattle, 22)
  	-- end

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
        Gamestate.switch(StateBattle, ifiWorld:getMonsterId(newPlayerX, newPlayerY), newPlayerX, newPlayerY)
      end
      -- check for nut
      local nutId = ifiWorld:getNutId(newPlayerX, newPlayerY)
      if 0 < nutId then
        ifiWorld:pickupNut(nutId)
        local newCollectedNuts = player:getCollectedNuts() + 1
        player:setCollectedNuts(newCollectedNuts)
      end
    else
      local doorId = ifiWorld:getDoorId(newPlayerX, newPlayerY)
      if 0 < doorId then
        local killedMonsters = player:getKilledMonsters()
        if ifiWorld:getDoorKills(doorId) <= killedMonsters then
          ifiWorld:openDoor(doorId)
        else
          ifiWorld:setDoorBubbleTimer(5)
        end
      end
      if ifiWorld:isElevator(newPlayerX, newPlayerY) then
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
  else
    local topFloorWorld = worlds[TOP_FLOOR_WORLD]
    if topFloorWorld:tileIsFree(newPlayerX, newPlayerY) then
      player:setPos(newPlayerX, newPlayerY)
      -- check for battle
      if topFloorWorld:isMonster(newPlayerX, newPlayerY) then
        Gamestate.switch(StateBattle, topFloorWorld:getMonsterId(newPlayerX, newPlayerY), newPlayerX, newPlayerY)
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
      elseif topFloorWorld:isRoger(newPlayerX, newPlayerY) then
        -- roger interaction
        if player:getCollectedNuts() == 5 then
          topFloorWorld:wakeRoger()
        else
          topFloorWorld:setRogerBubbleTimer(5)
        end
      end
    end
  end
end