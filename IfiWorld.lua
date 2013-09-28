Class = require "Lib.hump.class"
Camera = require "Lib.hump.camera"
require "TiledMap"

local EMPTY_TILE = 0
local BACKGROUND_TILE = 1
local STONE_TILE = 2
local METAL_DOOR = 3
local WHITEBOARD = 10
local WHITEBOARD2 = 13
local SKELETON_M_MAGE = 20
local SKELETON_F_MAGE = 21
local SKELETON_SWORD = 22
local SLIME_BIG = 23
local SLIME_SMALL = 24

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
		freeTiles[WHITEBOARD] = true
		freeTiles[WHITEBOARD2] = true
		local tiledMap = TiledMap("Maps/ifi.tmx", TILE_SIZE, freeTiles)
		tiledMap:setLayerInvisible("monsters")
		-- init player
		local animSpriteImg = love.graphics.newImage("Characters/main_char_anim-05.png")
		local animSprite = newAnimation(animSpriteImg, TILE_SIZE, TILE_SIZE, 0.15, 0)
		local player = Player(15, 15, TILE_SIZE, animSprite, 2)
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
		local doors = {}
		table.insert(doors, {{32, 5}, {32, 6}, {32, 7}, {32, 8}})
		table.insert(doors, {{52, 3}, {52, 4}, {52, 5}, {52, 6}, {52, 7}, {52, 8}})
		table.insert(doors, {{79, 3}, {79, 4}, {79, 5}, {79, 6}, {79, 7}, {79, 8}})
		-- init world
		self.tiledMap = tiledMap
		self.player = player
		self.monsters = monsters
		self.doors = doors
		self.tileSize = TILE_SIZE
		self.camera = Camera()
	end,
	openDoor = function(self, id)
		local templateLayerId = self.tiledMap:getLayerId("template")
		for i, v in ipairs(self.doors[id]) do
			self.tiledMap:setTileId(v[1], v[2], templateLayerId, BACKGROUND_TILE)
		end
	end,
	playerIncrKilledMonster = function(self)
		local newKilledMonsters = self.player:getKilledMonsters() + 1
		self.player:setKilledMonster(newKilledMonsters)
		if newKilledMonsters == 6 then
			openDoor(1)
		elseif newKilledMonsters == 11 then
			openDoor(2)
		elseif newKilledMonsters == 18 then
			openDoor(3)
		end
	end,
	movePlayer = function(self, dx, dy)
		local newPlayerX = self.player:getX() + dx
  		local newPlayerY = self.player:getY() + dy
  		if self.tiledMap:isFree(newPlayerX, newPlayerY) then
  			self.player:setPos(newPlayerX, newPlayerY)
  			local monstersLayerId = self.tiledMap:getLayerId("monsters")
  			local monsterId = self.tiledMap:getTileId(newPlayerX, newPlayerY, monstersLayerId)
  			if monsterId ~= 0 then
  				Gamestate.switch(StateBattle)
  			end
  		end
	end,
	update = function(self, dt)
		self.tiledMap:update(dt)
		self.player:update(dt)
		for i = 1, #self.monsters do
			self.monsters[i]:update(dt)
		end
		-- update camera
		local playerActPixelX, playerActPixelY = self.player:getActPixelPos()
		-- camera should be focused on the middle of the player character
		playerActPixelX = playerActPixelX + self.tileSize / 2
		playerActPixelY = playerActPixelY + self.tileSize / 2
		self.camera:lookAt(playerActPixelX, playerActPixelY)
	end,
	draw = function(self)
		self.camera:attach()
		self.tiledMap:draw(self.camera:pos())
		for i = 1, #self.monsters do
			self.monsters[i]:draw()
		end
		self.player:draw()
		self.camera:detach()
	end
}
