Class = require "Lib.hump.class"

BattleActionPlanner = Class{
	init = function (self, map, player, cards)
		self.map = map
		self.player = player
		self.x = player.x
		self.y = player.y
		self.cards = cards
		self.selectedCard = cards.selected
	end,
	drawAction = function (self)

	end,
	drawMove = function (self)
	
	end,
	keypressed = function (self, key)
		if (key == "1") then
			self.selectedCard = self.cards:selectCard(1)
		elseif (key == "2") then
			self.selectedCard = self.cards:selectCard(2)
		elseif (key == "3") then
			self.selectedCard = self.cards:selectCard(3)
		elseif (key == "4") then
			self.selectedCard = self.cards:selectCard(4)
		elseif (key == "5") then
			self.selectedCard = self.cards:selectCard(5)
		end
	end
}