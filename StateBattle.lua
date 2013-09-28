require "Battlemode.BattleMap"
require "Battlemode.BattleEnemy"
require "Battlemode.BattlePlayer"

StateBattle = {}

-- local settings
local gridFactor = 1.5
local gridStartX = ((WINDOW_WIDTH - TILE_SIZE * gridFactor * 10) / 2)
local gridStartY = TILE_SIZE * gridFactor * -1
local playerStartX = 3
local playerStartY = 3
local battleMap
local battlePlayer
local battleEnemy

function StateBattle:enter(previousState)
    battleMap = BattleMap(gridStartX, gridStartY, gridFactor)
    battlePlayer = BattlePlayer(battleMap, playerStartX, playerStartY)
    battleEnemy = BattleEnemy(Nil, battleMap, 8, 8)
end

--function StateBattle:update(dt)
 --   battlePlayer.act_y = battlePlayer.act_y - ((battlePlayer.act_y - battlePlayer.grid_y) * battlePlayer.speed * dt)
 --   battlePlayer.act_x = battlePlayer.act_x - ((battlePlayer.act_x - battlePlayer.grid_x) * battlePlayer.speed * dt)
--end

function StateBattle:draw()
    battleMap:draw()
    battlePlayer:draw()
    --drawPlayer()
    --drawbattleEnemy()
end

function StateBattle:keypressed(key)
    if key == "up" then
        battlePlayer:move(0, -1)
    elseif key == "down" then
        battlePlayer:move(0, 1)
    elseif key == "left" then
        battlePlayer:move(-1, 0)
    elseif key == "right" then
        battlePlayer:move(1, 0)
	elseif key == "e" then
		Gamestate.switch(StateExplore)
    end
end

--function drawbattleEnemy()
--    love.graphics.setColor(255, 255, 0)
--    love.graphics.rectangle("fill", battleEnemy.x, battleEnemy.y, gridSize, gridSize)
--end

--function testbattleMap(x, y)
--    local dtX = x - gridStartX + 1
--    local dtY = y - gridStartY + 1
--    if battleMap[(battlePlayer.grid_y / gridSize) + dtY][(battlePlayer.grid_x / gridSize) + dtX] == 1 then
--        return 1
--    end
--	if battleMap[(battlePlayer.grid_y / gridSize) + dtY][(battlePlayer.grid_x / gridSize) + dtX] == 2 then
--        return 2
--    end
--    return 0
--end