Class = require "Lib.hump.class"
require "Lib.AnAL"

Monster = Class{
  init = function(self, x, y, tileSize, animSprite)
    self.x = x
    self.y = y
    self.tileSize = tileSize
    self.animSprite = animSprite
  end,
  getX = function(self)
    return self.x
  end,
  getY = function(self)
    return self.y
  end,
  update = function(self, dt)
    self.animSprite:update(dt)
  end,
  draw = function(self)
    self.animSprite:draw(self.x * self.tileSize, self.y * self.tileSize)
  end
}