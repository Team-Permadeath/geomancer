Class = require "Lib.hump.class"

require "Enemies.Enemy"

SkeletonVerdande = Class {
	__includes = Enemy,
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-26.png")
    	self.bigImage = love.graphics.newImage("Characters/monsters/big_size_chars-05.png")
		self.health = 5
	end
}