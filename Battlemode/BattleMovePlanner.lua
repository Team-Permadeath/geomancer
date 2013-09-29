Class = require "Lib.hump.class"

BattleMovePlanner = Class{
	init = function (self, map, player)
		self.map = map
		self.player = player
	end,
	enter = function (self) 
		self.x = self.player.x
		self.y = self.player.y
	end,
	drawMove = function (self)
		local pos = self.map:getPosition(self)
	    love.graphics.setColor(255, 255, 255)
	    love.graphics.draw(player.image, pos.x, pos.y, 0, self.map.grid.tileSize / player.imageSize)
	end,
	keyreleased = function (self, key)
	    if key == "up" or key == "w" then
	        move(self, 0, -1)
	    elseif key == "down" or key == "s" then
	    	move(self, 0, 1)
	    elseif key == "left" or key == "a" then
	    	move(self, -1, 0)
	    elseif key == "right" or key == "d" then
	    	move(self, 1, 0)
	    end
	end
}

function move(planner, x, y)
	local testX = planner.x + x
	local testY = planner.y + y
    if planner.map:test(testX, testY) ~= 1 and isValidMove(planner.player, testX, testY) then
    	planner.x = testX
        planner.y = testY
    end	
end

function isValidMove(player, x, y)
	return math.abs(x - player.x) < 2 and math.abs(y - player.y) < 2
end