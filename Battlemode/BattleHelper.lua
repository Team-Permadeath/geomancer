Class = require "Lib.hump.class"

BattleHelper = Class{
	init = function (self, x, y)
		self.x = x
		self.y = y
	end,
	drawMove = function (self)
		local bubble = love.graphics.newImage("Bubbles/move_bubble.png")
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(bubble, self.x, self.y)
	end,
	drawAction = function (self)
		local bubble = love.graphics.newImage("Bubbles/action-04.png")
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(bubble, self.x, self.y)
	end,
	drawResolve = function (self)
		local bubble = love.graphics.newImage("Bubbles/resolve_bubble.png")
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(bubble, self.x, self.y)
	end,
	drawVictory = function (self)
		local bubble = love.graphics.newImage("Bubbles/victory_bubble.png")
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(bubble, self.x, self.y)
	end,
}