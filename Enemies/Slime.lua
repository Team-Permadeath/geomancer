Class = require "Lib.hump.class"

require "Enemies.Enemy"

Slime = Class {
	__includes = Enemy,
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-29.png")
    	self.bigImage = love.graphics.newImage("Characters/monsters/big_size_chars-02.png")
		self.health = 1
	end
}