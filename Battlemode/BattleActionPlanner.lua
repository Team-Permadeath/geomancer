Class = require "Lib.hump.class"

BattleActionPlanner = Class{
	init = function (self, map, player, cards)
		self.map = map
		self.player = player
		self.x = player.x
		self.y = player.y
		self.cards = cards
		self.cards:enter(player)
	end,
	drawAction = function (self)
	end,
	drawMove = function (self)
	end,
	keypressed = function (self, key)
		if (key == "1") then
			self.cards:selectCard(self.player, 1)
		elseif (key == "2") then
			self.cards:selectCard(self.player, 2)
		elseif (key == "3") then
			self.cards:selectCard(self.player, 3)
		elseif (key == "4") then
			self.cards:selectCard(self.player, 4)
		elseif (key == "5") then
			self.cards:selectCard(self.player, 5)
		elseif (key == "left") then
			self.cards:move(self.player, -1, 0)
		elseif (key == "right") then
			self.cards:move(self.player, 1, 0)
		elseif (key == "up") then
			self.cards:move(self.player, 0, -1)
		elseif (key == "down") then
			self.cards:move(self.player, 0, 1)
		end
	end
}