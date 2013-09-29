Class = require "Lib.hump.class"

local gridSize = TILE_SIZE

BattleMap = Class{
	init = function(self, startX, startY, gridFactor)
		self.map = {
	        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }	
	    }
        self.max = 10
	    local gridTileSize = TILE_SIZE * gridFactor
	    self.grid = {
	    	x = startX - gridTileSize,
	    	y = startY - gridTileSize,
	    	tileSize = gridTileSize
		}
        self.registers = {}
        self.hits = {}
	end,
    draw = function (self)
        local gridPosX
        local gridPosY
        local tileSize = 70
        local imageFactor = self.grid.tileSize / tileSize
        local groundImage = love.graphics.newImage("Tiles/background_tile.png")
        local wallImage = love.graphics.newImage("Tiles/stone_tile.png")
        for y=1, #self.map do
            for x=1, #self.map[y] do
                gridPosX = self:getRealX(x)
                gridPosY = self:getRealY(y)
                if self.map[y][x]== 0 then
                    love.graphics.setColor(62, 62, 62)
                    love.graphics.draw(groundImage, gridPosX, gridPosY, 0, imageFactor)
                elseif self.map[y][x] == 1 then
                    love.graphics.setColor(255, 255, 255)
                    love.graphics.draw(wallImage, gridPosX, gridPosY, 0, imageFactor)
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
                elseif self.map[y][x] == 1 then
                   love.graphics.setColor(255, 255, 255)
                    love.graphics.rectangle("line", gridPosX, gridPosY, self.grid.tileSize, self.grid.tileSize)
                end
            end
        end
    end,
    drawResolve = function (self)
        for i, v in ipairs(self.hits) do
            love.graphics.setColor(255, 0, 0)
            love.graphics.circle("line", self:getRealX(v.x + 0.5), self:getRealY(v.y + 0.5), 0.5 * self.grid.tileSize, 10)
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
    end,
    register = function (self, unit, x, y)
        table.insert(self.registers, {
            unit = unit,
            x = x,
            y = y
        })
    end,
    resetHits = function (self)
        self.hits = {}
    end,
    resetRegisters = function (self)
        self.registers = {}
    end,
    resolveDamage = function (self, x, y)
        for i, v in ipairs(self.registers) do
            if (v.x == x and v.y == y) then
                v.unit:takeDamage(1)
                table.insert(self.hits, v)
            end
        end
    end,
    isAvailable = function (self, x, y)
        if x < 1 or x >= self.max or y < 1 or y >= self.max then
            return false
        end
        for i, v in ipairs(self.registers) do
            if (v.x == x and v.y == y) then
                return false
            end
        end
        return true
    end
}