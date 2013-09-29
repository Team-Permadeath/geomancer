Class = require "Lib.hump.class"

require "Battlemode.BattleHealth"

BattleEnemy = Class{
	init = function(self, enemy, player, map, startX, startY, reward, exploreX, exploreY)
		self.enemy = enemy
		self.player = player
		self.map = map
		self.x = startX
		self.y = startY
		self.imagePosX = WINDOW_WIDTH - 400
		self.health = BattleHealth(self.imagePosX, 440)
		self.rewards = enemy:reward(reward)
		self.spoils = {}
		self.exploreX = exploreX
		self.exploreY = exploreY
	end,
	draw = function (self)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(self.enemy.bigImage, self.imagePosX, self.map.grid.tileSize)
		self.health:draw(self.enemy.health)
	end,
	drawDefeat = function (self)
		love.graphics.setColor(0, 0, 0)
		love.graphics.draw(self.enemy.bigImage, self.imagePosX, self.map.grid.tileSize)

	    local x = (WINDOW_WIDTH - 500) / 2
	    local y = 100
	    love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(globalFontSmall)
	    for i, v in ipairs(self.spoils) do
	    	love.graphics.draw(v.image, x, y + i * 100)
	    	love.graphics.print(v.text, x + 150, y + i * 100)
	    end
		love.graphics.setFont(globalFont)
	end,
	drawMove = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(150, 150, 150)
		love.graphics.draw(self.enemy.image, pos.x, pos.y, 0, self.map.grid.tileSize / self.enemy.imageSize)
	end,
	drawResolve = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(150, 150, 150)
		love.graphics.draw(self.enemy.image, pos.x, pos.y, 0, self.map.grid.tileSize / self.enemy.imageSize)
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
	reward = function (self)
		for i, r in ipairs(self.rewards) do
			table.insert(self.spoils, r())
		end
	end,
	takeDamage = function (self, damage)
		self.enemy.health = self.enemy.health - damage
	end,
	isDead = function (self)
		return self.enemy.health < 1
	end
}