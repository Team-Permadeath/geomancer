Class = require "Lib.hump.class"
love.filesystem.load("Lib/TiledMapLoader.lua")()

TiledMap = Class{
  -- @param freeTiles: array of booleans, tells if player can walk into the tile
  init = function(self, tiledMapFilename, tileSize, freeTiles)
    TiledMap_Load(tiledMapFilename, tileSize)
    self.freeTiles = freeTiles
  end,
  getWidth = function(self)
    return TiledMap_GetMapW()
  end,
  getHeight = function(self)
    return TiledMap_GetMapH()
  end,
  setLayerInvisible = function(self, layerName)
    TiledMap_SetLayerInvisByName(layerName)
  end,
  getLayerId = function(self, layerName)
    return TiledMap_GetLayerZByName(layerName)
  end,
  getTileId = function(self, x, y, z)
    return TiledMap_GetMapTile(x, y, z)
  end,
  -- checks if tile is free to walk into
  isFree = function(self, x, y)
      for z = 1, #gMapLayers do
        if (TiledMap_IsLayerVisible(z)) then
          if not self.freeTiles[TiledMap_GetMapTile(x, y, z)] then
            return false
          end
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