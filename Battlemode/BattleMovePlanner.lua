Class = require "Lib.hump.class"

BattleMovePlanner = Class{
	init = function (self, map, player)
		self.map = map
		self.player = player
		self.x = player.x
		self.y = player.y
	end,
	drawAction = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(200, 200, 200)
	    love.graphics.rectangle("fill", pos.x, pos.y, self.map.grid.tileSize, self.map.grid.tileSize)
	end,
	drawMove = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(255, 255, 0)
	    love.graphics.rectangle("fill", pos.x, pos.y, self.map.grid.tileSize, self.map.grid.tileSize)
	end,
	move = function (self, x, y)
		local testX = self.x + x
		local testY = self.y + y
	    if self.map:test(testX, testY) ~= 1 and isValidMove(self.player, testX, testY) then
	    	self.x = testX
	        self.y = testY
	    end	
	end
}

function isValidMove(player, x, y)
	return math.abs(x - player.x) < 2 and math.abs(y - player.y) < 2
end