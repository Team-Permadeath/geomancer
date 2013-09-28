Class = require "Lib.hump.class"

local gridSize = TILE_SIZE

BattleMap = Class{
	init = function(self, startX, startY, gridFactor)
		self.battleMap = {
	        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	        { 1, 2, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }	
	    }
	    local gridTileSize = TILE_SIZE * gridFactor
	    self.grid = {
	    	x = startX - gridTileSize,
	    	y = startY - gridTileSize,
	    	tileSize = gridTileSize
		}
	end
}
function BattleMap:draw()
	local gridPosX
	local gridPosY
    for y=1, #self.battleMap do
        for x=1, #self.battleMap[y] do
            gridPosX = self.grid.x + x * self.grid.tileSize
            gridPosY = self.grid.y + y * self.grid.tileSize
            if self.battleMap[y][x]== 0 then
                love.graphics.setColor(62, 62, 62)
                love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                love.graphics.setColor(255, 255, 255)
            elseif self.battleMap[y][x] == 1 then
                love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
            elseif self.battleMap[y][x]== 2 then
                love.graphics.setColor(255, 0, 0)
                love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                love.graphics.setColor(255, 255, 255)
                
            end
        end
    end
    for y=1, #self.battleMap do
        for x=1, #self.battleMap[y] do
            gridPosX = self.grid.x + x * self.grid.tileSize
            gridPosY = self.grid.y + y * self.grid.tileSize
            if self.battleMap[y][x]== 0 then
                love.graphics.setColor(62, 62, 62)
                love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                love.graphics.setColor(255, 255, 255)
            elseif self.battleMap[y][x] == 1 then
                love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
            elseif self.battleMap[y][x]== 2 then
                love.graphics.setColor(255, 0, 0)
                love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                love.graphics.setColor(255, 255, 255)   
            end
        end
    end
end
function BattleMap:test(x, y)
    if self.battleMap[y][x] == 1 then
        return 1
    end
	if self.battleMap[y][x] == 2 then
        return 2
    end
    return 0
end