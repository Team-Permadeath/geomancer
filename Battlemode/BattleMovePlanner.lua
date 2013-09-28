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
	keypressed = function (self, key)
	    if key == "up" then
	        move(self, 0, -1)
	    elseif key == "down" then
	    	move(self, 0, 1)
	    elseif key == "left" then
	    	move(self, -1, 0)
	    elseif key == "right" then
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