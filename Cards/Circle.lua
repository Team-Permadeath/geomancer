Class = require "Lib.hump.class"

Circle = Class{
	init = function (self)
		self.image = love.graphics.newImage("Images/cards-06.png")
		self.x = 0
		self.y = 0
	end,
	drawAction = function (self, map, player)
	    love.graphics.setColor(200, 200, 0)
	    love.graphics.circle("line", 
	    	map:getRealX(self.x) + map.grid.tileSize / 2, 
	    	map:getRealY(self.y) + map.grid.tileSize / 2, 
	    	map.grid.tileSize * 1.5, 
	    	100)
	end,
	relocate = function (self, player, x, y)
		self.x = player.x
		self.y = player.y
	end,
	move = function (self, player, x, y)
	end
}