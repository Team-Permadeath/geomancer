Class = require "Lib.hump.class"

local numberOfCards = 5

BattleCards = Class{
	init = function (self, x, y, width, height)
		self.cards = cards:drawCards(numberOfCards)
		self.selected = 1
		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.dimensions = {
			slot = width / numberOfCards,
			card = {
				x = width / numberOfCards * 0.05,
				y = width * 0.05,
				width = width / numberOfCards * 0.9,
				height = height * 0.9
			}
		}
	end,
	drawAction = function (self)
	    love.graphics.setColor(150, 150, 150)
	    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	    for i=1, numberOfCards do
	    	if (i == self.selected) then
	    		love.graphics.setColor(0, 0, 0)
	    		love.graphics.rectangle("fill", self.x + (i - 1) * self.dimensions.slot, self.y, self.dimensions.slot, self.height)
	    	end
	    	love.graphics.setColor(150, 150, 150)
	    	love.graphics.draw(self.cards[i].image, self.x + (i - 1) * self.dimensions.slot + self.dimensions.card.x, self.y + self.dimensions.card.y)
	    end
	end,
	drawMove = function (self)

	end,
	selectCard = function (self, selected)
		if (selected ~= 0 and selected < numberOfCards + 1) then
			self.selected = selected
		end
		return self.selected
	end
}