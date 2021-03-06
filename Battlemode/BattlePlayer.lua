Class = require "Lib.hump.class"

require "Battlemode.BattleHealth"

BattlePlayer = Class{
	init = function (self, map, startX, startY)
		self.map = map
		self.type = "Player"
        self.x = startX
        self.y = startY
		self.speed = 10
		self.health = player.health
		self.healthBar = BattleHealth(self.map.grid.tileSize, 440)
	end,
	draw = function (self)
	    love.graphics.setColor(255, 255, 255)
		love.graphics.draw(player.bigImage, self.map.grid.tileSize, self.map.grid.tileSize)
		self.healthBar:draw(self.health)
	end,
	drawDefeat = function (self)
		love.graphics.setColor(0, 0, 0)
		love.graphics.draw(player.image, self.map.grid.tileSize, self.map.grid.tileSize, 0, 5)
	end,
	drawAction = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(255, 255, 255)
	    love.graphics.draw(player.image, pos.x, pos.y, 0, self.map.grid.tileSize / player.imageSize)
	end,
	drawMove = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(125, 125, 125)
	    love.graphics.draw(player.image, pos.x, pos.y, 0, self.map.grid.tileSize / player.imageSize)
	end,
	move = function (self, x, y)
		local testX = self.x + x
		local testY = self.y + y
	    if self.map:test(testX, testY) ~= 1 then
	    	self.x = testX
	        self.y = testY
	    end	
	end,
	update = function (self, dt)
		--self.x = (self.x - (self.x - self.map.grid.x)) * self.speed * dt;
		--self.y = (self.y - (self.y - self.map.grid.y)) * self.speed * dt;
	end,
	register = function (self)
		self.map:register(self, self.x, self.y)
	end,
	takeDamage = function (self, damage)
		self.health = self.health - damage
	end,
	isDead = function (self)
		return player:isDead()
	end,
	increaseMonsterKill = function (self)
		player.killedMonsters = player.killedMonsters + 1
	end
}