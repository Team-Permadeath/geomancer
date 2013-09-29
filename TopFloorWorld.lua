Class = require "Lib.hump.class"
require "TiledMap"

TOP_EMPTY_TILE = 0
TOP_BACKGROUND_TILE = 1
TOP_STONE_TILE = 2
TOP_METAL_DOOR = 3
TOP_SLIME_BIG = 6
TOP_SLIME_SMALL = 5
TOP_ROGER = 7

TopFloorWorld = Class{
	init = function(self)
		-- init tiled map
		-- set free tiles where player can walk into
		self:loadMap()
		-- init monsters
		local monstersImg = {}
		monstersImg[TOP_SLIME_SMALL] = love.graphics.newImage("Characters/monsters/monster_movement3-07.png")
		monstersImg[TOP_SLIME_BIG] = love.graphics.newImage("Characters/monsters/monster_movement2-34.png")
		local monsterAnims = {}
		monsterAnims[TOP_SLIME_SMALL] = newAnimation(monstersImg[TOP_SLIME_SMALL], TILE_SIZE, TILE_SIZE, 3, 0)
		monsterAnims[TOP_SLIME_BIG] = newAnimation(monstersImg[TOP_SLIME_BIG], TILE_SIZE, TILE_SIZE, 1, 0)
		local monstersLayerId = self.tiledMap:getLayerId("monsters")
		local monsters = {}
		for x = 1, self.tiledMap:getWidth() do
			for y = 1, self.tiledMap:getHeight() do
				local tileId = self.tiledMap:getTileId(x, y, monstersLayerId)
				if tileId == TOP_SLIME_BIG then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[TOP_SLIME_BIG]))
				elseif tileId == TOP_SLIME_SMALL then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[TOP_SLIME_SMALL]))
				end
			end
		end
		-- init bubbles
		local bubbles = {
		 	roger = love.graphics.newImage("Bubbles/bubble_at_rogers.png"),
		 	rogerAwake = love.graphics.newImage("Bubbles/speech_bubbles-01.png")
		}
		-- init world
		self.monsters = monsters
		self.openDoors = openDoors
		self.bubbles = bubbles
		self.rogerBubbleTimer = -1
		self.rogerAwakeTimer = -1
		self.rogerAwake = false
		self.rogerAnim = newAnimation(love.graphics.newImage("Characters/npcs/roger_awake-36.png"), TILE_SIZE, TILE_SIZE, 0.1, 0)
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
	isElevator = function(self, x, y)
		if x == 11 or x == 12 or x == 13 then
			if y == 9 or y == 10 or y == 11 then
				return true
			end
		end
		return false
	end,
	isMonster = function(self, x, y)
		for i, m in ipairs(self.monsters) do
			if m:getX() == x and m:getY() == y then
				return true
			end
		end
		return false
	end,
	getMonsterId = function(self, x, y)
		local monstersLayerId = self.tiledMap:getLayerId("monsters")
		return self.tiledMap:getTileId(x, y, monstersLayerId)
	end,
	isRoger = function(self, x, y)
		local npcLayerId = self.tiledMap:getLayerId("npc")
		if self.tiledMap:getTileId(x, y, npcLayerId) == TOP_ROGER then
			return true
		end
		return false
	end,
	setRogerBubbleTimer = function(self, sec)
  		self.rogerBubbleTimer = sec
  	end,
  	wakeRoger = function(self)
  		self.rogerAwake = true
  		self.tiledMap:setLayerInvisible("npc")
  		self.rogerAwakeTimer = 5
  	end,
  	isRogerAwake = function(self)
  		return self.rogerAwake
  	end,
	loadMap = function(self)
		local freeTiles = {}
		for i = 0, 7 do
			freeTiles[i] = false
		end
		freeTiles[TOP_EMPTY_TILE] = true
		freeTiles[TOP_BACKGROUND_TILE] = true
		local tiledMap = TiledMap("Maps/8th_floor.tmx", TILE_SIZE, freeTiles)
		tiledMap:setLayerInvisible("monsters")
		self.tiledMap = tiledMap
	end,
	update = function(self, dt)
		self.tiledMap:update(dt)
		for i = 1, #self.monsters do
			self.monsters[i]:update(dt)
		end
		if 0 < self.rogerBubbleTimer then
			self.rogerBubbleTimer = self.rogerBubbleTimer - dt
		end
		if self.rogerAwake then
			self.rogerAnim:update(dt)
			if 0 < self.rogerAwakeTimer then
				self.rogerAwakeTimer = self.rogerAwakeTimer - dt
			else
				Gamestate.switch(StateCredits)
			end
		end
	end,
	draw = function(self, cameraX, cameraY)
		self.tiledMap:draw(cameraX, cameraY)
		for i = 1, #self.monsters do
			self.monsters[i]:draw()
		end
		if 0 < self.rogerBubbleTimer then
			love.graphics.draw(self.bubbles.roger, cameraX - 160, cameraY - 170)
		end
		if self.rogerAwake then
			self.rogerAnim:draw(20 * self.tileSize, 10 * self.tileSize)
			love.graphics.draw(self.bubbles.rogerAwake, cameraX - 100, cameraY - 150)
		end
	end
}
