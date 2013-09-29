Class = require "Lib.hump.class"

Triangle = Class{
	init = function (self)
		self.image = love.graphics.newImage("Images/cards-04.png")
		self.x = 0
		self.y = 0
	end,
	drawAction = function (self, map, player)
		local diffX = self.x - player.x
		local diffY = self.y - player.y
		local x1 = map:getRealX(player.x) + map.grid.tileSize / 2
		local y1 = map:getRealY(player.y) + map.grid.tileSize / 2
		local x2
		local y2
		local x3
		local y3
		if (diffX == 1) then
			--print("RIGHT")
			x2 = map:getRealX(player.x + 2)
			y2 = map:getRealY(player.y - 1)
			x3 = map:getRealX(player.x + 2)
			y3 = map:getRealY(player.y + 2)
		elseif(diffX == -1) then
			--print("LEFT")
			x2 = map:getRealX(player.x - 1)
			y2 = map:getRealY(player.y - 1)
			x3 = map:getRealX(player.x - 1)
			y3 = map:getRealY(player.y + 2)
		elseif(diffY == 1) then
			--print("DOWN")
			x2 = map:getRealX(player.x - 1)
			y2 = map:getRealY(player.y + 2)
			x3 = map:getRealX(player.x + 2)
			y3 = map:getRealY(player.y + 2)
		elseif(diffY == -1) then
			--print("UP")
			x2 = map:getRealX(player.x - 1)
			y2 = map:getRealY(player.y - 1)
			x3 = map:getRealX(player.x + 2)
			y3 = map:getRealY(player.y - 1)
		end
	    love.graphics.setColor(200, 200, 0)
		love.graphics.triangle("line", x1, y1, x2, y2, x3, y3)
	end,
	relocate = function (self, player, x, y)
		if (math.abs(player.x - x) > 1) then
			x = (player.x + x) / 2
		end
		if (math.abs(player.y - y) > 1) then
			y = (player.y + y) / 2
		end
		if ((math.abs(player.x - x) + math.abs(player.y - y)) > 1) then
			x = player.x
		end
		if (player.x == x and player.y == y) then
			self.x = player.x + 1
			self.y = player.y
		else
			self.x = x
			self.y = y
		end
	end,
	move = function (self, player, x, y)
		local moveX = self.x - x
		local diffX = self.x - player.x
		local moveY = self.y - y
		local diffY = self.y - player.y
		if (math.abs(diffX) == math.abs(moveY) and diffX == 0) then
			self.x = player.x - moveX
			self.y = player.y
		end
		if (math.abs(diffX) == math.abs(moveY) and diffX ~= 0) then
			self.x = player.x
			self.y = player.y - moveY
		end
		if (moveX == diffX and moveX ~= 0) then
			self.x = self.x - moveX * 2
		end
		if (moveY == diffY and moveY ~= 0) then
			self.y = self.y - moveY * 2
		end
	end,
	resolveDamage = function (self, map)
		print("DAMAGE TRIANGLE")
	end
}