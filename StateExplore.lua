require "World"

local world
local fogImg

StateExplore = {}

function StateExplore:init()
  load_world()
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
  love.graphics.draw(fogImg, 0, 0)
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

function load_world()
  -- init tiled map
  freeTiles = {}
  freeTiles[1] = {}
  freeTiles[1][0] = false
  freeTiles[1][1] = true
  freeTiles[1][2] = false
  local tiledMap = TiledMap("Maps/ifi.tmx", TILE_SIZE, freeTiles)
  -- init player
  local animSpriteImg = love.graphics.newImage("Images/main_char_anim.png")
  local animSprite = newAnimation(animSpriteImg, TILE_SIZE, TILE_SIZE, 0.15, 0)
  local player = Player(15, 15, TILE_SIZE, animSprite, 2)
  -- init world
  world = World(tiledMap, player, TILE_SIZE)
end
