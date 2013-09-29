Class = require "Lib.hump.class"

require "Enemies.Enemy"

SkeletonMage = Class {
	__includes = Enemy,
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-25.png")
    	self.bigImage = love.graphics.newImage("Characters/monsters/big_size_chars-04.png")
		self.health = 5
	end
}