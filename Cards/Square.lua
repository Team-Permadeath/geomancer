Class = require "Lib.hump.class"

Square = Class{
	init = function (self)
		self.image = love.graphics.newImage("Images/cards-02.png")
		self.x = 0
		self.y = 0
	end,
	drawAction = function (self, map)
	    love.graphics.setColor(200, 200, 0)
	    love.graphics.rectangle("line", map:getRealX(self.x), map:getRealY(self.y), map.grid.tileSize, map.grid.tileSize)
	end,
	relocate = function (self, player, x, y)
		if (x == player.x and y == player.y) then
			self.x = player.x + 1
			self.y = player.y + 1
		else
			self.x = x
			self.y = y
		end
	end,
	move = function (self, player, x, y)
		if (player.x == x and player.y == y) then
			return
		end
		if (math.abs(player.x - x) < 3) then
			self.x = x
		end
		if (math.abs(player.y - y) < 3) then
			self.y = y
		end
	end
}