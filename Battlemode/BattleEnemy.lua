Class = require "Lib.hump.class"

require "Battlemode.BattleHealth"

BattleEnemy = Class{
	init = function(self, enemy, player, map, startX, startY)
		self.enemy = enemy
		self.player = player
		self.map = map
		self.x = startX
		self.y = startY
		self.imagePosX = WINDOW_WIDTH - 400
		self.health = BattleHealth(self.imagePosX, 440)
	end,
	draw = function (self)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(self.enemy.image, self.imagePosX, self.map.grid.tileSize, 0, 5)
		self.health:draw(self.enemy.health)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(0, 255, 0)
	    love.graphics.rectangle("fill", pos.x, pos.y, self.map.grid.tileSize, self.map.grid.tileSize)
	end
}