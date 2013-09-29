Class = require "Lib.hump.class"

require "Cards.Circle"
require "Cards.Square"
require "Cards.Triangle"

local cards = {}
cards[1] = Circle
cards[2] = Square
cards[3] = Triangle

CardsRepository = Class{
	init = function (self, startSquare, startCircle, startTriangle)
		self.circles = populate(Circle, startCircle)
		self.squares = populate(Square, startSquare)
		self.triangles = populate(Triangle, startTriangle)

	end,
	draw = function (self, x, y)
		local width = 100
		local padding = 50
		local offset = width + padding
		local textOffsetX = 42
		local textOffsetY = 55
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(self.circles[1].image, x, y)
		love.graphics.draw(self.squares[1].image, x + offset, y)
		love.graphics.draw(self.triangles[1].image, x + offset * 2, y)
		love.graphics.setColor(0, 0, 0)
		love.graphics.print(#self.circles, x + textOffsetX, y + textOffsetY)
		love.graphics.print(#self.squares, x + offset + textOffsetX, y + textOffsetY)
		love.graphics.print(#self.triangles, x + offset * 2 + textOffsetX, y + textOffsetY)
	end,
	drawCards = function(self, amount)
		a = {}
		for i = 1, amount do
			a[i] = cards[math.random(1, 3)]()
		end
		return a
	end
}

function populate(card, number)
	local list = {}
	for i = 1, number do
		list[i] = card()
	end
	return list
end