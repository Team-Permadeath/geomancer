Class = require "Lib.hump.class"

BattleEnemy = Class{
	init = function(self, enemy, player, map, startX, startY)
		self.enemy = enemy
		self.player = player
		self.map = map
		self.x = startX
		self.y = startY
	end,
	draw = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(0, 255, 0)
	    love.graphics.rectangle("fill", pos.x, pos.y, self.map.grid.tileSize, self.map.grid.tileSize)
	end
}