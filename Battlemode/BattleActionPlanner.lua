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
		if (key == "left") then
			self.selectedCard = self.cards:selectCard(self.selectedCard - 1)
		elseif (key == "right") then
			self.selectedCard = self.cards:selectCard(self.selectedCard + 1)
		end
	end
}