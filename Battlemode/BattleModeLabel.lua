Class = require "Lib.hump.class"

BattleModeLabel = Class {
	init = function (self, map)
		self.map = map
	end,
	draw = function (self, text, width)
		local labelY = self.map.grid.y + self.map.grid.tileSize
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 
			self.map.grid.x + self.map.grid.tileSize, 
			labelY, 
			self.map.grid.tileSize * 10, 
			self.map.grid.tileSize)
		local textX = (WINDOW_WIDTH - width) / 2
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(text, textX, labelY + 5)
	end
}