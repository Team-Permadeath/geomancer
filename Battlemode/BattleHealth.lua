Class = require "Lib.hump.class"

BattleHealth = Class {
	init = function (self, x, y)
		self.x = x
		self.y = y
		self.image = love.graphics.newImage("Images/health-01.png")
	end,
	draw = function (self, maxHealth)
		love.graphics.setColor(255, 255, 255)
		for i=1, maxHealth do
			love.graphics.draw(self.image, self.x + i * 30, self.y)
		end
	end
}