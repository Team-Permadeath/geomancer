require "Battlemode.BattleMap"
require "Battlemode.BattleEnemy"
require "Battlemode.BattlePlayer"
require "Battlemode.BattleMovePlanner"

StateBattle = {}

-- local settings
local gridFactor = 0.7
local gridStartX = ((WINDOW_WIDTH - TILE_SIZE * gridFactor * 10) / 2)
local gridStartY = TILE_SIZE * gridFactor * -1
local playerStartX = 3
local playerStartY = 3

local battleMap
local battlePlayer
local battleMovePlanner
local battleEnemy

local stages = {
    ["PlanMove"] = 1;
    ["PlanAction"] = 2;
    ["Execute"] = 3;
}
local currentStage
local currentMover

function StateBattle:enter(previousState)
    currentStage = stages.PlanMove
    battleMap = BattleMap(gridStartX, gridStartY, gridFactor)
    battlePlayer = BattlePlayer(battleMap, playerStartX, playerStartY)
    battleMovePlanner = BattleMovePlanner(battleMap, battlePlayer)
    battleEnemy = BattleEnemy(Nil, battleMap, 8, 8)
    currentMover = battleMovePlanner
end

function StateBattle:update(dt)
    battlePlayer:update(dt)
end

function StateBattle:draw()
    battleMap:draw()
    if currentStage == stages.PlanMove then
        battlePlayer:drawMove()
        battleMovePlanner:drawMove()
    elseif currentStage == stages.PlanAction then
        battlePlayer:drawAction()
        battleMovePlanner:drawAction()
    end
end

function StateBattle:keypressed(key)
    if key == "up" then
        currentMover:move(0, -1)
    elseif key == "down" then
        currentMover:move(0, 1)
    elseif key == "left" then
        currentMover:move(-1, 0)
    elseif key == "right" then
        currentMover:move(1, 0)
    elseif key == "return" and currentStage == stages.PlanMove then
        currentStage = stages.PlanAction
        local tmpX = battleMovePlanner.x
        local tmpY = battleMovePlanner.y
        battleMovePlanner.x = battlePlayer.x
        battleMovePlanner.y = battlePlayer.y
        battlePlayer.x = tmpX
        battlePlayer.y = tmpY
    elseif key == "backspace" and currentStage == stages.PlanAction then
        currentStage = stages.PlanMove
        local tmpX = battleMovePlanner.x
        local tmpY = battleMovePlanner.y
        battleMovePlanner.x = battlePlayer.x
        battleMovePlanner.y = battlePlayer.y
        battlePlayer.x = tmpX
        battlePlayer.y = tmpY
	elseif key == "e" then
		Gamestate.switch(StateExplore)
    end
end