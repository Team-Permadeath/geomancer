require "World"
require "Monster"

local world
local fogImg

StateExplore = {}

function StateExplore:init()
  load_ifi()
  fogImg = love.graphics.newImage("Images/fog.png")
end

function StateExplore:enter(previousState)
  love.graphics.setBackgroundColor(100, 100, 100)
end

function StateExplore:update(dt)
  world:update(dt)
end

function StateExplore:draw()
	world:draw()
  --love.graphics.draw(fogImg, 0, 0)
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
  		Gamestate.switch(StateBattle)
  	end
end

function load_ifi()
  -- init tiled map
  -- set free tiles where player can walk into
  freeTiles = {}
  for i = 0, 27 do
    freeTiles[i] = false
  end
  freeTiles[0] = true
  freeTiles[1] = true
  freeTiles[10] = true
  freeTiles[13] = true
  local tiledMap = TiledMap("Maps/ifi.tmx", TILE_SIZE, freeTiles)
  tiledMap:setLayerInvisible("monsters")
  -- init player
  local animSpriteImg = love.graphics.newImage("Characters/main_char_anim-05.png")
  local animSprite = newAnimation(animSpriteImg, TILE_SIZE, TILE_SIZE, 0.15, 0)
  local player = Player(15, 15, TILE_SIZE, animSprite, 2)
  -- init monsters
  local monstersImg = {}
  monstersImg["skeleton_sword"] = love.graphics.newImage("Characters/monsters/monster_movement1-35.png")
  monstersImg["skeleton_m_mage"] = love.graphics.newImage("Characters/monsters/moster_movement4-06.png")
  monstersImg["skeleton_f_mage"] = love.graphics.newImage("Characters/monsters/monster_movement5-06.png")
  monstersImg["slime_small"] = love.graphics.newImage("Characters/monsters/monster_movement3-07.png")
  monstersImg["slime_big"] = love.graphics.newImage("Characters/monsters/monster_movement2-34.png")
  local monsterAnims = {}
  monsterAnims["skeleton_sword"] = newAnimation(monstersImg["skeleton_sword"], TILE_SIZE, TILE_SIZE, 2, 0)
  monsterAnims["skeleton_m_mage"] = newAnimation(monstersImg["skeleton_m_mage"], TILE_SIZE, TILE_SIZE, 3, 0)
  monsterAnims["skeleton_f_mage"] = newAnimation(monstersImg["skeleton_f_mage"], TILE_SIZE, TILE_SIZE, 3, 0)
  monsterAnims["slime_small"] = newAnimation(monstersImg["slime_small"], TILE_SIZE, TILE_SIZE, 3, 0)
  monsterAnims["slime_big"] = newAnimation(monstersImg["slime_big"], TILE_SIZE, TILE_SIZE, 1, 0)
  local monstersLayerId = tiledMap:getLayerId("monsters")
  local monsters = {}
  for x = 1, tiledMap:getWidth() do
    for y = 1, tiledMap:getHeight() do
      local tileId = tiledMap:getTileId(x, y, monstersLayerId)
      if tileId == 20 then
        table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims["skeleton_m_mage"]))
      elseif tileId == 21 then
        table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims["skeleton_f_mage"]))
      elseif tileId == 22 then
        table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims["skeleton_sword"]))
      elseif tileId == 23 then
        table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims["slime_big"]))
      elseif tileId == 24 then
        table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims["slime_small"]))
      end
    end
  end
  -- init world
  world = World(tiledMap, player, monsters, TILE_SIZE)
end
