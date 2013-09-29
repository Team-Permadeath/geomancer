Class = require "Lib.hump.class"

require "Enemies.Enemy"

Skeleton = Class {
	__includes = Enemy,
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-27.png")
		self.health = 3
	end
}