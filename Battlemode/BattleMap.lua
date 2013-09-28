Class = require "Lib.hump.class"

local gridSize = TILE_SIZE

BattleMap = Class{
	init = function(self, startX, startY, gridFactor)
		self.map = {
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
	end,
    draw = function (self)
        local gridPosX
        local gridPosY
        for y=1, #self.map do
            for x=1, #self.map[y] do
                gridPosX = self.grid.x + x * self.grid.tileSize
                gridPosY = self.grid.y + y * self.grid.tileSize
                if self.map[y][x]== 0 then
                    love.graphics.setColor(62, 62, 62)
                    love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                    love.graphics.setColor(255, 255, 255)
                elseif self.map[y][x] == 1 then
                    love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                elseif self.map[y][x]== 2 then
                    love.graphics.setColor(255, 0, 0)
                    love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                    love.graphics.setColor(255, 255, 255)
                    
                end
            end
        end
        for y=1, #self.map do
            for x=1, #self.map[y] do
                gridPosX = self.grid.x + x * self.grid.tileSize
                gridPosY = self.grid.y + y * self.grid.tileSize
                if self.map[y][x]== 0 then
                    love.graphics.setColor(62, 62, 62)
                    love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                    love.graphics.setColor(255, 255, 255)
                elseif self.map[y][x] == 1 then
                    love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                elseif self.map[y][x]== 2 then
                    love.graphics.setColor(255, 0, 0)
                    love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                    love.graphics.setColor(255, 255, 255)   
                end
            end
        end
    end,
    test = function (self, x, y)
        return self.map[y][x]
    end,
    getPosition = function (self, unit)
        return {
            x = self:getRealX(unit.x),
            y = self:getRealY(unit.y)
        }
    end,
    getRealX = function (self, x)
        return self.grid.x + x * self.grid.tileSize
    end,
    getRealY = function (self, y)
        return self.grid.y + y * self.grid.tileSize
    end
}