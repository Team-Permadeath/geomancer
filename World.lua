Class = require "Lib.hump.class"
Camera = require "Lib.hump.camera"
require "TiledMap"

World = Class{
	init = function(self, tiledMap, player, tileSize)
		self.tiledMap = tiledMap
		self.player = player
		self.tileSize = tileSize
		self.camera = Camera()
	end,
	movePlayer = function(self, dx, dy)
		local newPlayerX = self.player:getX() + dx
  		local newPlayerY = self.player:getY() + dy
  		if self.tiledMap:isFree(newPlayerX, newPlayerY) then
  			self.player:setPos(newPlayerX, newPlayerY)
  		end
	end,
	update = function(self, dt)
		self.tiledMap:update(dt)
		self.player:update(dt)
		-- update camera
		local playerActPixelX, playerActPixelY = self.player:getActPixelPos()
		-- camera should be focused on the middle of the player character
		playerActPixelX = playerActPixelX + self.tileSize / 2
		playerActPixelY = playerActPixelY + self.tileSize / 2
		self.camera:lookAt(playerActPixelX, playerActPixelY)
	end,
	draw = function(self)
		self.camera:attach()
		self.tiledMap:draw(self.camera:pos())
		self.player:draw()
		self.camera:detach()
	end
}

function World:load()
	-- init tiled map
	local tiledMap = TiledMap("Maps/ifi.tmx", TILE_SIZE)
	-- init player
	local animSpriteImg = love.graphics.newImage("Images/main_char_anim.png")
	local animSprite = newAnimation(animSpriteImg, TILE_SIZE, TILE_SIZE, 0.15, 0)
	local player = Player(15, 15, TILE_SIZE, animSprite, 2)
	-- init world
	world = World(tiledMap, player, TILE_SIZE)
end