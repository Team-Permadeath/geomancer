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
    self.imageSize = 71
    self.bigImage = love.graphics.newImage("Characters/big_size_chars-01.png")
    ------
    self.speed = speed
    self.health = health
    self.killedMonsters = 0
    self.collectedNuts = 0
    self.playerCards = { 
                      Circle(), Circle(), Circle(), Circle() ,Square(), Circle(), Circle(), 
                      Circle() ,Square(), Circle(), Circle(), Circle() ,Square(), Triangle(),
                      Triangle(), Triangle(), Triangle(), Triangle(), Triangle(), Triangle(), Triangle()}
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
  ---org
    return self.playerCards
    --new
    --self.playerCards=cards:getAllCards()
    --return self.playerCards

  end,
  rmvCard = function(self,index)
    table.remove(self.playerCards, index)
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
  teleportToPos = function(self, x, y)
    self.x = x
    self.gridPixelX = x * self.tileSize
    self.actPixelX = x * self.tileSize
    self.y = y
    self.gridPixelY = y * self.tileSize
    self.actPixelY = y * self.tileSize
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
  almostInDestination = function(self)
    if  Vector.dist(self.actPixelX, self.actPixelY, self.gridPixelX, self.gridPixelY) < 0.05 * self.tileSize then
      return true
    else
      return false
    end
  end,
  distToDestination = function(self)
    return Vector.dist(self.actPixelX, self.actPixelY, self.gridPixelX, self.gridPixelY)
  end,
  update = function(self, dt)
    print(self:distToDestination())
    if self.speed * dt < self:distToDestination() then
      local dx, dy = Vector.mul(self.speed * dt, Vector.normalize(self.gridPixelX - self.actPixelX, self.gridPixelY - self.actPixelY))
      self.actPixelX = self.actPixelX + dx
      self.actPixelY = self.actPixelY + dy
    else
      self.actPixelX = self.gridPixelX
      self.actPixelY = self.gridPixelY
    end
    -- some threshold for animation
    if not self:almostInDestination() then
      self.animSprite:update(dt)
    end
  end,
  draw = function(self)
    self.animSprite:draw(self.actPixelX, self.actPixelY)
  end,
  isDead = function (self)
    return self.health < 1
  end
}