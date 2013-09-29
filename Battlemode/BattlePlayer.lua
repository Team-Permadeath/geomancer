Class = require "Lib.hump.class"

BattlePlayer = Class{
	init = function (self, map, startX, startY)
		self.map = map
        self.x = startX + 1
        self.y = startY + 1
		self.speed = 10
	end,
	drawAction = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(255, 255, 255)
	    love.graphics.rectangle("fill", pos.x, pos.y, self.map.grid.tileSize, self.map.grid.tileSize)
	end,
	drawMove = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(125, 125, 125)
	    love.graphics.rectangle("fill", pos.x, pos.y, self.map.grid.tileSize, self.map.grid.tileSize)
	end,
	move = function (self, x, y)
		local testX = self.x + x
		local testY = self.y + y
	    if self.map:test(testX, testY) ~= 1 then
	    	self.x = testX
	        self.y = testY
	    end	
	end,
	update = function (self, dt)
		--self.x = (self.x - (self.x - self.map.grid.x)) * self.speed * dt;
		--self.y = (self.y - (self.y - self.map.grid.y)) * self.speed * dt;
	end
}