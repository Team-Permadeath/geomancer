Class = require "Lib.hump.class"
require "TiledMap"

EMPTY_TILE = 0
BACKGROUND_TILE = 1
STONE_TILE = 2
METAL_DOOR = 3
NUT_TILE = 6
WHITEBOARD = 10
WHITEBOARD2 = 13
SKELETON_M_MAGE = 20
SKELETON_F_MAGE = 21
SKELETON_SWORD = 22
SLIME_BIG = 23
SLIME_SMALL = 24

IfiWorld = Class{
	init = function(self)
		-- init tiled map
		-- set free tiles where player can walk into
		freeTiles = {}
		for i = 0, 27 do
			freeTiles[i] = false
		end
		freeTiles[EMPTY_TILE] = true
		freeTiles[BACKGROUND_TILE] = true
		freeTiles[NUT_TILE] = true
		freeTiles[WHITEBOARD] = true
		freeTiles[WHITEBOARD2] = true
		local tiledMap = TiledMap("Maps/ifi.tmx", TILE_SIZE, freeTiles)
		tiledMap:setLayerInvisible("monsters")
		-- init monsters
		local monstersImg = {}
		monstersImg[SKELETON_SWORD] = love.graphics.newImage("Characters/monsters/monster_movement1-35.png")
		monstersImg[SKELETON_M_MAGE] = love.graphics.newImage("Characters/monsters/moster_movement4-06.png")
		monstersImg[SKELETON_F_MAGE] = love.graphics.newImage("Characters/monsters/monster_movement5-06.png")
		monstersImg[SLIME_SMALL] = love.graphics.newImage("Characters/monsters/monster_movement3-07.png")
		monstersImg[SLIME_BIG] = love.graphics.newImage("Characters/monsters/monster_movement2-34.png")
		local monsterAnims = {}
		monsterAnims[SKELETON_SWORD] = newAnimation(monstersImg[SKELETON_SWORD], TILE_SIZE, TILE_SIZE, 2, 0)
		monsterAnims[SKELETON_M_MAGE] = newAnimation(monstersImg[SKELETON_M_MAGE], TILE_SIZE, TILE_SIZE, 3, 0)
		monsterAnims[SKELETON_F_MAGE] = newAnimation(monstersImg[SKELETON_F_MAGE], TILE_SIZE, TILE_SIZE, 3, 0)
		monsterAnims[SLIME_SMALL] = newAnimation(monstersImg[SLIME_SMALL], TILE_SIZE, TILE_SIZE, 3, 0)
		monsterAnims[SLIME_BIG] = newAnimation(monstersImg[SLIME_BIG], TILE_SIZE, TILE_SIZE, 1, 0)
		local monstersLayerId = tiledMap:getLayerId("monsters")
		local monsters = {}
		for x = 1, tiledMap:getWidth() do
			for y = 1, tiledMap:getHeight() do
				local tileId = tiledMap:getTileId(x, y, monstersLayerId)
				if tileId == SKELETON_M_MAGE then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[SKELETON_M_MAGE]))
				elseif tileId == SKELETON_F_MAGE then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[SKELETON_F_MAGE]))
				elseif tileId == SKELETON_SWORD then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[SKELETON_SWORD]))
				elseif tileId == SLIME_BIG then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[SLIME_BIG]))
				elseif tileId == SLIME_SMALL then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[SLIME_SMALL]))
				end
			end
		end
		-- init doors
		local openDoors = {false, false, false}
		local doors = {}
		table.insert(doors, {{32, 5}, {32, 6}, {32, 7}, {32, 8}})
		table.insert(doors, {{52, 3}, {52, 4}, {52, 5}, {52, 6}, {52, 7}, {52, 8}})
		table.insert(doors, {{79, 3}, {79, 4}, {79, 5}, {79, 6}, {79, 7}, {79, 8}})
		-- init bubbles
		local bubbles = {
			door = love.graphics.newImage("Bubbles/speech_bubbles-02.png")
		}
		-- init world
		self.tiledMap = tiledMap
		self.templateLayerId = self.tiledMap:getLayerId("template")
		self.monstersLayerId = self.tiledMap:getLayerId("monsters")
		self.pickableLayerId = self.tiledMap:getLayerId("pickable")
		self.doorBubbleTimer = -1
		self.monsters = monsters
		self.openDoors = openDoors
		self.doors = doors
		self.bubbles = bubbles
		self.tileSize = TILE_SIZE
	end,
	tileIsFree = function(self, x, y)
		return self.tiledMap:isFree(x, y)
	end,
	getTileId = function(self, x, y, z)
    	return self.tiledMap:getTileId(x, y, z)
  	end,
  	setTileId = function(self, x, y, z, v)
    	self.tiledMap:setTileId(x, y, z, v)
  	end,
  	getLayerId = function(self, layerName)
  		return self.tiledMap:getLayerId(layerName)
  	end,
  	setDoorBubbleTimer = function(self, sec)
  		self.doorBubbleTimer = sec
  	end,
  	isDoorOpen = function(self, id)
  		return self.openDoors[id]
  	end,
	openDoor = function(self, id)
		self.openDoors[id] = true
		for i, v in ipairs(self.doors[id]) do
			self.tiledMap:setTileId(v[1], v[2], self.templateLayerId, BACKGROUND_TILE)
		end
	end,
	update = function(self, dt)
		self.tiledMap:update(dt)
		for i = 1, #self.monsters do
			self.monsters[i]:update(dt)
		end
		-- update door bubble timer
		if 0 < self.doorBubbleTimer then
			self.doorBubbleTimer = self.doorBubbleTimer - dt
		end
	end,
	draw = function(self, cameraX, cameraY)
		self.tiledMap:draw(cameraX, cameraY)
		for i = 1, #self.monsters do
			self.monsters[i]:draw()
		end
		if 0 < self.doorBubbleTimer then
			love.graphics.draw(self.bubbles.door, cameraX - 140, cameraY - 150)
		end
	end
}
