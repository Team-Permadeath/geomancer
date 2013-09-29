Class = require "Lib.hump.class"
require "TiledMap"

IFI_EMPTY_TILE = 0
IFI_BACKGROUND_TILE = 1
IFI_STONE_TILE = 2
IFI_METAL_DOOR = 3
IFI_NUT_TILE = 6
IFI_WHITEBOARD = 10
IFI_WHITEBOARD2 = 13
IFI_SKELETON_M_MAGE = 20
IFI_SKELETON_F_MAGE = 21
IFI_SKELETON_SWORD = 22
IFI_SLIME_BIG = 23
IFI_SLIME_SMALL = 24

IfiWorld = Class{
	init = function(self)
		-- init tiled map
		-- set free tiles where player can walk into
		self:loadMap()
		-- init monsters
		local monstersImg = {}
		monstersImg[IFI_SKELETON_SWORD] = love.graphics.newImage("Characters/monsters/monster_movement1-35.png")
		monstersImg[IFI_SKELETON_M_MAGE] = love.graphics.newImage("Characters/monsters/moster_movement4-06.png")
		monstersImg[IFI_SKELETON_F_MAGE] = love.graphics.newImage("Characters/monsters/monster_movement5-06.png")
		monstersImg[IFI_SLIME_SMALL] = love.graphics.newImage("Characters/monsters/monster_movement3-07.png")
		monstersImg[IFI_SLIME_BIG] = love.graphics.newImage("Characters/monsters/monster_movement2-34.png")
		local monsterAnims = {}
		monsterAnims[IFI_SKELETON_SWORD] = newAnimation(monstersImg[IFI_SKELETON_SWORD], TILE_SIZE, TILE_SIZE, 2, 0)
		monsterAnims[IFI_SKELETON_M_MAGE] = newAnimation(monstersImg[IFI_SKELETON_M_MAGE], TILE_SIZE, TILE_SIZE, 3, 0)
		monsterAnims[IFI_SKELETON_F_MAGE] = newAnimation(monstersImg[IFI_SKELETON_F_MAGE], TILE_SIZE, TILE_SIZE, 3, 0)
		monsterAnims[IFI_SLIME_SMALL] = newAnimation(monstersImg[IFI_SLIME_SMALL], TILE_SIZE, TILE_SIZE, 3, 0)
		monsterAnims[IFI_SLIME_BIG] = newAnimation(monstersImg[IFI_SLIME_BIG], TILE_SIZE, TILE_SIZE, 1, 0)
		local monstersLayerId = self.tiledMap:getLayerId("monsters")
		local monsters = {}
		for x = 1, self.tiledMap:getWidth() do
			for y = 1, self.tiledMap:getHeight() do
				local tileId = self.tiledMap:getTileId(x, y, monstersLayerId)
				if tileId == IFI_SKELETON_M_MAGE then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[IFI_SKELETON_M_MAGE]))
				elseif tileId == IFI_SKELETON_F_MAGE then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[IFI_SKELETON_F_MAGE]))
				elseif tileId == IFI_SKELETON_SWORD then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[IFI_SKELETON_SWORD]))
				elseif tileId == IFI_SLIME_BIG then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[IFI_SLIME_BIG]))
				elseif tileId == IFI_SLIME_SMALL then
					table.insert(monsters, Monster(x, y, TILE_SIZE, monsterAnims[IFI_SLIME_SMALL]))
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
			door = love.graphics.newImage("Bubbles/speech_bubbles-02.png"),
			simen = love.graphics.newImage("Bubbles/speech_bubbles-06.png"),
			jon = love.graphics.newImage("Bubbles/speech_bubbles-05.png"),
			kyre = love.graphics.newImage("Bubbles/speech_bubbles-04.png")
		}
		-- init world
		self.doorBubbleTimer = -1
		self.introBubblesTimer = 15
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
		local templateLayerId = self.tiledMap:getLayerId("template")
		for i, v in ipairs(self.doors[id]) do
			self.tiledMap:setTileId(v[1], v[2], templateLayerId, IFI_BACKGROUND_TILE)
		end
	end,
	isElevator = function(self, x, y)
		if x == 91 or x == 92 then
			if y == 11 or y == 12 then
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
	loadMap = function(self)
		local freeTiles = {}
		for i = 0, 27 do
			freeTiles[i] = false
		end
		freeTiles[IFI_EMPTY_TILE] = true
		freeTiles[IFI_BACKGROUND_TILE] = true
		freeTiles[IFI_NUT_TILE] = true
		freeTiles[IFI_WHITEBOARD] = true
		freeTiles[IFI_WHITEBOARD2] = true
		local tiledMap = TiledMap("Maps/ifi.tmx", TILE_SIZE, freeTiles)
		tiledMap:setLayerInvisible("monsters")
		self.tiledMap = tiledMap
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
		-- update intro bubbles timer
		if 0 < self.introBubblesTimer then
			self.introBubblesTimer = self.introBubblesTimer - dt
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
		if 10 < self.introBubblesTimer then
			love.graphics.draw(self.bubbles.simen, 14 * self.tileSize - 140, 12 * self.tileSize - 100)
		elseif 5 < self.introBubblesTimer then
			love.graphics.draw(self.bubbles.jon, 14 * self.tileSize - 140, 13 * self.tileSize - 100)
		elseif 0 < self.introBubblesTimer then
			love.graphics.draw(self.bubbles.kyre, 14 * self.tileSize - 140, 14 * self.tileSize - 100)
		end
	end
}
