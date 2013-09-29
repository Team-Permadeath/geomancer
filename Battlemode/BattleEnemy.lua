Class = require "Lib.hump.class"

require "Battlemode.BattleHealth"

BattleEnemy = Class{
	init = function(self, enemy, player, map, startX, startY)
		self.enemy = enemy
		self.player = player
		self.map = map
		self.x = startX
		self.y = startY
		self.imagePosX = WINDOW_WIDTH - 400
		self.health = BattleHealth(self.imagePosX, 440)
	end,
	draw = function (self)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(self.enemy.image, self.imagePosX, self.map.grid.tileSize, 0, 5)
		self.health:draw(self.enemy.health)
	end,
	drawDefeat = function (self)
		love.graphics.setColor(0, 0, 0)
		love.graphics.draw(self.enemy.image, self.imagePosX, self.map.grid.tileSize, 0, 5)
	end,
	drawMove = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(0, 150, 0)
	    love.graphics.rectangle("fill", pos.x, pos.y, self.map.grid.tileSize, self.map.grid.tileSize)
	end,
	drawResolve = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(0, 255, 0)
	    love.graphics.rectangle("fill", pos.x, pos.y, self.map.grid.tileSize, self.map.grid.tileSize)
	end,
	resolve = function (self)
		local newPos = self.enemy:move(self.map, self.player, self.x, self.y)
		self.x = newPos.x
		self.y = newPos.y
		self.map:register(self, self.x, self.y)
		local attacks = self.enemy:attack(self.player, self.x, self.y)
		for i, v in ipairs(attacks) do
			self.map:resolveDamage(v.x, v.y)
		end
	end,
	takeDamage = function (self, damage)
		self.enemy.health = self.enemy.health - damage
	end,
	isDead = function (self)
		return self.enemy.health < 1
	end
}