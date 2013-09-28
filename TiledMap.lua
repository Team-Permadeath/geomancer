Class = require "Lib.hump.class"
love.filesystem.load("Lib/TiledMapLoader.lua")()

TiledMap = Class{
  -- @param freeTiles: 2D array of booleans, tells if player can walk into the tile,
  -- first dimension represents layer, second tile id
  init = function(self, tiledMapFilename, tileSize, freeTiles)
    TiledMap_Load(tiledMapFilename, tileSize)
    self.freeTiles = freeTiles
  end,
  -- checks if tile is free to walk into
  isFree = function(self, x, y)
    for z = 1, #gMapLayers do
      if not self.freeTiles[z][TiledMap_GetMapTile(x, y, z)] then
        return false
      end
    end
    return true
  end,
  update = function(self, dt)
  end,
  draw = function(self, cameraX, cameraY)
    TiledMap_DrawNearCam(cameraX, cameraY)
  end
}