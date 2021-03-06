Class = require "Lib.hump.class"

require "Enemies.Enemy"

HugeSlime = Class {
	__includes = Enemy,
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-28.png")
		self.imageSize = 71
    	self.bigImage = love.graphics.newImage("Characters/monsters/big_size_chars-03.png")
		self.health = 10
	end,
	reward = function (self, reward)
		return {
			reward:chooseReward(1, 90),
			reward:chooseReward(31, 90),
			reward:chooseReward(61, 90),
			reward:chooseReward(61, 100),
			reward:chooseReward(91, 100)
		}
	end
}