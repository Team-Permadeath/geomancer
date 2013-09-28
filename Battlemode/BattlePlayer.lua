Class = require "Lib.hump.class"

BattlePlayer = Class{
	init = function (self, battleMap, startX, startY)
		self.battleMap = battleMap
        self.x = startX + 1
        self.y = startY + 1
		self.speed = 10
	end
}

function BattlePlayer:draw()
	local posX = self.battleMap.grid.x + self.x * self.battleMap.grid.tileSize;
	local posY = self.battleMap.grid.y + self.y * self.battleMap.grid.tileSize;
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", posX, posY, self.battleMap.grid.tileSize, self.battleMap.grid.tileSize)
end

function BattlePlayer:move(x, y)
	local testX = self.x + x
	local testY = self.y + y
    if self.battleMap:test(testX, testY) ~= 1 then
    	self.x = testX
        self.y = testY
    end	
end