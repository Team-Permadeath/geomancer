Class = require "Lib.hump.class"

require "Enemies.Enemy"

HugeSlime = Class {
	__includes = Enemy,
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-28.png")
    	self.bigImage = love.graphics.newImage("Characters/monsters/big_size_chars-03.png")
		self.health = 10
	end
}