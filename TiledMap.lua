Class = require "Lib.hump.class"
love.filesystem.load("Lib/TiledMapLoader.lua")()

TiledMap = Class{
  init = function(self, tiledMapFilename, tileSize)
    TiledMap_Load(tiledMapFilename, tileSize)
  end,
  -- checks if tile is free to walk into
  isFree = function(self, x, y)
    if TiledMap_GetMapTile(x, y, 1) ~= 1 then
      return false
    end
    for z = 2, #gMapLayers do
      if TiledMap_GetMapTile(x, y, z) ~= 0 then
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