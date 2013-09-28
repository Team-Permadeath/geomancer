Class = require "Lib.hump.class"

World = Class{
	init = function(self, map, player, tileSize)
		self.map = map
		self.player = player
		self.tileSize = tileSize
	end,
	getPlayerActPixelPos = function(self)
		return self.player:getActPixelPos()
	end,
	movePlayer = function(self, dx, dy)
		local newPlayerX = self.player:getX() + dx
  		local newPlayerY = self.player:getY() + dy
  		if newPlayerX < 0 or self.map:getWidth() - 1 < newPlayerX or newPlayerY < 0 or self.map:getHeight() - 1 < newPlayerY then
    		return
  		end
  		-- bit unintuitive!
  		if self.map:getTileId(newPlayerY + 1, newPlayerX + 1) ~= TILE_RIVER then
    		self.player:setPos(newPlayerX, newPlayerY)
  		end
	end,
	update = function(self, dt)
		self.map:update(dt)
		self.player:update(dt)
	end,
	draw = function(self)
		self.map:draw()
		self.player:draw()
	end
}