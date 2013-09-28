Class = require "Lib.hump.class"
require "Lib.AnAL"

Monster = Class{
  init = function(self, x, y, tileSize, animSprite)
    self.x = x
    self.y = y
    self.tileSize = tileSize
    self.animSprite = animSprite
  end,
  update = function(self, dt)
    self.animSprite:update(dt)
  end,
  draw = function(self)
    self.animSprite:draw(self.x * self.tileSize, self.y * self.tileSize)
  end
}