Class = require "Lib.hump.class"

Map = Class{
  init = function(self, width, height, tileSize, tileIds, tileSprites)
    self.width = width
    self.height = height
    self.tileSize = tileSize
    self.tileIds = tileIds
    self.tileSprites = tileSprites
  end,
  getWidth = function(self)
    return self.width
  end,
  getHeight = function(self)
    return self.height
  end,
  getTileId = function(self, x, y)
    return self.tileIds[x][y]
  end,
  setTileId = function(self, x, y, id)
    self.tileIds[x][y] = id
  end,
  update = function(self, dt)
  end,
  draw = function(self)
    for x = 1, self.width do
      for y = 1, self.height do
        local posX = (x - 1) * self.tileSize
        local posY = (y - 1) * self.tileSize
        local sprite = self.tileSprites[self.tileIds[y][x]]
        love.graphics.draw(sprite, posX, posY)
      end
    end
  end
}