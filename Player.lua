Class = require "Lib.hump.class"
Vector = require "Lib.hump.vector-light"
require "Lib.AnAL"
require "Cards.Circle"
require "Cards.CardsRepository"

Player = Class{
  init = function(self, x, y, tileSize, animSprite, speed, health)
    self.x = x
    self.y = y
    self.tileSize = tileSize
    self.animSprite = animSprite
    self.image = love.graphics.newImage("Characters/main_char.png")
    ------
    self.speed = speed
    self.health = health
    self.killedMonsters = 0
    self.collectedNuts = 0
    self.playerCards = { Circle(), Circle(), Circle(), Circle() ,Square(), Circle(), Circle(), Circle() ,Square(), Circle(), Circle(), Circle() ,Square()}
    ------
    self.gridPixelX = x * tileSize
    self.gridPixelY = y * tileSize
    self.actPixelX = x * tileSize
    self.actPixelY = y * tileSize
  end,
  --getAmountCards = function(self)
  --  return self.playerCards:size()
 -- end,
  getCards = function(self)
    return self.playerCards
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
  getCollectedNuts = function(self)
    return self.collectedNuts
  end,
  setCollectedNuts = function(self, n)
    self.collectedNuts = n
  end,
  getKilledMonsters = function(self)
    return self.killedMonsters
  end,
  setKilledMonsters = function(self, n)
    self.killedMonsters = n
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
    self.animSprite:draw(self.actPixelX, self.actPixelY)
  end,
}