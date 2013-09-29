Class = require "Lib.hump.class"

require "Enemies.Enemy"

Skeleton = Class {
	__includes = Enemy,
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-27.png")
    	self.bigImage = love.graphics.newImage("Characters/monsters/big_size_chars-06.png")
		self.health = 3
	end,
	reward = function (self, reward)
		return {
			reward:chooseReward(1, 30),
			reward:chooseReward(1, 60),
			reward:chooseReward(1, 90)
		}
	end
}