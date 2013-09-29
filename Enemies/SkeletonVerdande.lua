Class = require "Lib.hump.class"

require "Enemies.Enemy"

SkeletonVerdande = Class {
	__includes = Enemy,
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-26.png")
		self.imageSize = 71
    	self.bigImage = love.graphics.newImage("Characters/monsters/big_size_chars-05.png")
		self.health = 5
	end,
	reward = function (self, reward)
		return {
			reward:chooseReward(1, 60),
			reward:chooseReward(31, 90),
			reward:chooseReward(31, 90),
			reward:chooseReward(31, 100)
		}
	end
}