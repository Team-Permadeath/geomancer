Class = require "Lib.hump.class"

BattleEnemy = Class{
	init = function(self, enemy, battleMap, x, y)
		self.enemy = enemy
		self.battleMap = battleMap
		self.x = x * TILE_SIZE
		self.y = y * TILE_SIZE
	end,
	draw = function (self)
		self.x = self.x + 1
		self.y = self.y + 1
	end
}