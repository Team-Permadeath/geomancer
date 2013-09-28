Class = require "Lib.hump.class"
Camera = require "Lib.hump.camera"
require "TiledMap"

IfiWorld = Class{
	init = function(self)
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
		--world = World(tiledMap, player, monsters, TILE_SIZE)
		self.tiledMap = tiledMap
		self.player = player
		self.monsters = monsters
		self.tileSize = TILE_SIZE
		self.camera = Camera()
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
