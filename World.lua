Class = require "Lib.hump.class"
require "Map"
love.filesystem.load("Lib/TiledMapLoader.lua")()

World = Class{
	init = function(self, map, player, tileSize)
		self.map = map
		self.player = player
		self.tileSize = tileSize
		self.tiledMap = TiledMap_Load("Maps/ifi.tmx", 70)
	end,
	getPlayerActPixelPos = function(self)
		return self.player:getActPixelPos()
	end,
	movePlayer = function(self, dx, dy)
		local newPlayerX = self.player:getX() + dx
  		local newPlayerY = self.player:getY() + dy
  		print(TiledMap_GetMapTile(newPlayerX,newPlayerY,1))
  		if TiledMap_GetMapTile(newPlayerX,newPlayerY,1) == 1 then
  			self.player:setPos(newPlayerX, newPlayerY)
  		end
	end,
	update = function(self, dt)
		self.map:update(dt)
		self.player:update(dt)
	end,
	draw = function(self)
		--self.map:draw()
		local playerActPixelX, playerActPixelY = world:getPlayerActPixelPos()
		-- camera should be focused on the middle of the player character
		playerActPixelX = playerActPixelX + TILE_SIZE / 2
		playerActPixelY = playerActPixelY + TILE_SIZE / 2
		TiledMap_DrawNearCam(playerActPixelX, playerActPixelY)
		-- DEBUG
		local screen_w = love.graphics.getWidth()
	    local screen_h = love.graphics.getHeight()
	    local kTileSize = 70
	    local camx = playerActPixelX
	    local camy = playerActPixelY
	    local minx,maxx = math.floor((camx-screen_w/2)/kTileSize),math.ceil((camx+screen_w/2)/kTileSize)
	    local miny,maxy = math.floor((camy-screen_h/2)/kTileSize),math.ceil((camy+screen_h/2)/kTileSize)
	    love.graphics.print(minx..", "..maxx..", "..miny..", "..maxy..":"..camx..", "..camy, camx + 50, camy)
		self.player:draw()
	end
}

function World:load()
	local tileIds = {
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }
    }
    local tileSprites = {}
    tileSprites[0] = love.graphics.newImage("Images/background_tile.png")
    tileSprites[1] = love.graphics.newImage("Images/stone_tile.png")
	local map = Map(#tileIds[1], #tileIds, TILE_SIZE, tileIds, tileSprites)
	-- init player
	local animSpriteImg = love.graphics.newImage("Images/main_char_anim.png")
	local animSprite = newAnimation(animSpriteImg, 70, 70, 0.15, 0)
	local player = Player(15, 15, TILE_SIZE, animSprite, 2)
	-- init world
	world = World(map, player, TILE_SIZE)
end