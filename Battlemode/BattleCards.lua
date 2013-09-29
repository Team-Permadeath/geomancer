Class = require "Lib.hump.class"

local numberOfCards = 5

BattleCards = Class{
	init = function (self, x, y, width, height)
		self.cards = cards:drawCards(numberOfCards)
		self.selected = 1
	    self.selectionImage = love.graphics.newImage("Images/card_bg-10.png")
	    self.selectionImageWidth = 116
	    self.selectionImageHeight = 154
	    self.cardWidth = 103
	    self.cardHeight = 141
		self.x = x
		self.y = WINDOW_HEIGHT - self.selectionImageHeight
		self.width = self.selectionImageWidth * numberOfCards
		self.height = self.selectionImageHeight
		self.dimensions = {
			slot = self.width / numberOfCards,
			card = {
				x = (self.selectionImageWidth - self.cardWidth) / 2,
				y = (self.selectionImageHeight - self.cardHeight) / 2,
				width = self.cardWidth,
				height = self.cardHeight
			}
		}
	end,
	enter = function (self, player)
		self.cards[self.selected]:relocate(player, player.x, player.y)
	end,
	drawAction = function (self, map, player)
	    love.graphics.setColor(150, 150, 150)
	    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	    love.graphics.setColor(100, 100, 100)
	    love.graphics.draw(self.selectionImage, self.x + (self.selected - 1) * self.dimensions.slot, self.y)
    	love.graphics.setColor(255, 255, 255)
	    for i=1, numberOfCards do
	    	love.graphics.draw(self.cards[i].image, self.x + (i - 1) * self.dimensions.slot + self.dimensions.card.x, self.y + self.dimensions.card.y)
	    end
	    self.cards[self.selected]:drawAction(map, player)
	end,
	drawMove = function (self)
	    love.graphics.setColor(100, 100, 100)
	    --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	    for i=1, numberOfCards do
	    	love.graphics.draw(self.cards[i].image, self.x + (i - 1) * self.dimensions.slot + self.dimensions.card.x, self.y + self.dimensions.card.y)
	    end
	end,
	drawResolve = function (self)
	    --love.graphics.setColor(100, 100, 100)
	    --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	    for i=1, numberOfCards do
	    	love.graphics.setColor(100, 100, 100)
	    	if (i == self.selected) then
		    	love.graphics.setColor(255, 255, 255)
	    	end
	    	love.graphics.draw(self.cards[i].image, self.x + (i - 1) * self.dimensions.slot + self.dimensions.card.x, self.y + self.dimensions.card.y)
	    end
	end,
	resolve = function (self)
		local newCard = cards:drawCards(1)[1]
		self.cards[self.selected] = newCard
	end,
	resolveDamage = function (self, map)
		self.cards[self.selected]:resolveDamage(map)
	end,
	selectCard = function (self, player, selected)
		local curX = self.cards[self.selected].x
		local curY = self.cards[self.selected].y
		if (selected ~= 0 and selected < numberOfCards + 1) then
			self.selected = selected
		end
		self.cards[self.selected]:relocate(player, curX, curY)
		return self.selected
	end,
	move = function (self, player, x, y)
		local newX = self.cards[self.selected].x + x
		local newY = self.cards[self.selected].y + y
		self.cards[self.selected]:move(player, newX, newY)
	end
}