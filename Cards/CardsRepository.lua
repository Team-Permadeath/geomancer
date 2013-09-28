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