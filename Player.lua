Class = require "Lib.hump.class"

Player = Class{
  init = function(self, x, y, tileSize, sprite, speed)
    self.x = x
    self.y = y
    self.tileSize = tileSize
    self.sprite = sprite
    self.speed = speed
    self.gridPixelX = x * tileSize
    self.gridPixelY = y * tileSize
    self.actPixelX = x * tileSize
    self.actPixelY = y * tileSize
    self.tmpAnimSprite1 = love.graphics.newImage("Images/river.png")
    self.tmpAnimSprite2 = sprite
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
    dist = self:tmpDistToGo()
    if (0.1 * self.tileSize < dist and dist < 0.25 * self.tileSize) or (0.5 * self.tileSize < dist and dist < 0.75 * self.tileSize) then
      self.sprite = self.tmpAnimSprite1
    else
      self.sprite = self.tmpAnimSprite2
    end
  end,
  draw = function(self)
    love.graphics.draw(self.sprite, self.actPixelX, self.actPixelY)
  end,

  tmpDistToGo = function(self)
    return math.sqrt(math.pow(self.actPixelX - self.gridPixelX, 2) + math.pow(self.actPixelY - self.gridPixelY, 2))
  end
}