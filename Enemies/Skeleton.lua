Class = require "Lib.hump.class"

Skeleton = Class {
	init = function (self)
		self.image = love.graphics.newImage("Characters/monsters/monster-27.png")
		self.health = 3
	end
}