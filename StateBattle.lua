require "Battlemode.BattleMap"
require "Battlemode.BattleEnemy"
require "Battlemode.BattlePlayer"

StateBattle = {}

-- local settings
local gridFactor = 0.7
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

function StateBattle:update(dt)
    battlePlayer:update(dt)
end

function StateBattle:draw()
    battleMap:draw()
    battlePlayer:draw()
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