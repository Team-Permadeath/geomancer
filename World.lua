Class = require "Lib.hump.class"
Camera = require "Lib.hump.camera"
require "TiledMap"

World = Class{
	init = function(self, tiledMap, player, monsters, tileSize)
		self.tiledMap = tiledMap
		self.player = player
		self.monsters = monsters
		self.tileSize = tileSize
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