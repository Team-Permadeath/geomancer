Class = require "Lib.hump.class"
Vector = require "Lib.hump.vector-light"
require "Lib.AnAL"

Player = Class{
  init = function(self, x, y, tileSize, animSprite, speed)
    self.x = x
    self.y = y
    self.tileSize = tileSize
    self.animSprite = animSprite
    self.speed = speed
    self.gridPixelX = x * tileSize
    self.gridPixelY = y * tileSize
    self.actPixelX = x * tileSize
    self.actPixelY = y * tileSize
  end,
  getX = function(self)
    return self.x
  end,
  getY = function(self)
    return self.y
  end,
  setX = function(self, x)
    self.x = x
    self.gridPixelX = x * self.tileSize
  end,
  setY = function(self, y)
    self.y = y
    self.gridPixelY = y * self.tileSize
  end,
  getPos = function(self)
    return self.x, self.y
  end,
  setPos = function(self, x, y)
    self:setX(x)
    self:setY(y)
  end,
  getActPixelPos = function(self)
    return self.actPixelX, self.actPixelY
  end,
  update = function(self, dt)
    self.actPixelX = self.actPixelX - ((self.actPixelX - self.gridPixelX) * self.speed * dt)
    self.actPixelY = self.actPixelY - ((self.actPixelY - self.gridPixelY) * self.speed * dt)
    -- some threshold for animation
    if 0.05 * self.tileSize < Vector.dist(self.actPixelX, self.actPixelY, self.gridPixelX, self.gridPixelY) then
      self.animSprite:update(dt)
    end
  end,
  draw = function(self)
    --love.graphics.draw(self.sprite, self.actPixelX, self.actPixelY)
    self.animSprite:draw(self.actPixelX, self.actPixelY)
  end,
}