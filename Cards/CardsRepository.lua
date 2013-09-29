Class = require "Lib.hump.class"

require "Cards.Circle"
require "Cards.Square"
require "Cards.Triangle"

local cards = { 
	["Circle"] = Circle, 
	["Square"] = Square, 
	["Triangle"] = Triangle 
}

CardsRepository = Class{
	init = function (self, startSquare, startCircle, startTriangle)
		self.card = {Circle(), Square(), Triangle()}
		self.deck = {startCircle, startSquare, startTriangle}
		self.max = {startCircle, startSquare, startTriangle}
	end,
	draw = function (self, x, y)
		local width = 100
		local padding = 50
		local offset = width + padding
		local textOffsetX = 42
		local textOffsetY = 55
		love.graphics.setColor(255, 255, 255)
		for i, v in ipairs(self.card) do
			love.graphics.draw(v.image, x + offset * (i - 1), y)
		end
		love.graphics.setColor(0, 0, 0)
		for i, v in ipairs(self.deck) do
			love.graphics.print(v, x + offset * (i - 1) + textOffsetX, y + textOffsetY)
		end
	end,
	drawCards = function(self, amount)
		a = {}
		for i = 1, amount do
			a[i] = getCard(self)
			reshuffle(self)
		end
		return a
	end,
	addCard = function(self, cardType)
		local card = cards[cardType]()
		self.deck[card.i] = self.deck[card.i] + 1
		self.max[card.i] = self.max[card.i] + 1 
	end
}

function getCard(repo)
	local index = math.random(1, 3)
	if (repo.deck[index] > 0) then
		repo.deck[index] = repo.deck[index] - 1
		return repo.card[index]
	else
		return getCard(repo)
	end
end

function reshuffle(repo)
	local cardsLeft = 0
	for i, v in ipairs(repo.deck) do
		cardsLeft = cardsLeft + v
	end
	if cardsLeft == 0 then
		for i, v in ipairs(repo.max) do
			repo.deck[i] = v - repo.deck[i]
		end
	end
end