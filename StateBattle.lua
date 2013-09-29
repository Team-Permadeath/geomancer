require "StateBattleAction"
require "StateBattleMove"
require "StateBattleResolve"
require "StateBattleVictory"
require "StateGameOver"

require "Battlemode.BattleMap"
require "Battlemode.BattlePlayer"
require "Battlemode.BattleEnemy"
require "Battlemode.BattleCards"
require "Battlemode.BattleMovePlanner"
require "Battlemode.BattleActionPlanner"
require "Battlemode.BattleModeLabel"
require "Battlemode.BattleHelper"
require "Battlemode.BattleReward"
require "Enemies.HugeSlime"
require "Enemies.Skeleton"
require "Enemies.SkeletonMage"
require "Enemies.SkeletonVerdande"
require "Enemies.Slime"

StateBattle = {}

-- local settings
local gridFactor = 0.7
local gridStartX = ((WINDOW_WIDTH - TILE_SIZE * gridFactor * 10) / 2)
local gridStartY = TILE_SIZE * gridFactor * 0
local playerStartY = 4
local enemyStartY = 7
local cardsWidth = WINDOW_WIDTH / 2
local cardsHeight = 200
local cardsStartX = 0
local cardsStartY = WINDOW_HEIGHT - cardsHeight

local map
local player
local movePlanner
local actionPlanner
local enemy
local cards
local label
local helper
local reward

-- an enemy for testing

function StateBattle:enter(previousState, monsterId)
	Sound:playEffect(EffectTypes.Transition)
	Sound:playMusic(MusicTypes.Combat)

    if monsterId == 20 then
        enemy = SkeletonMage()
    elseif monsterId == 21 then
        enemy = SkeletonVerdande()
    elseif monsterId == 22 then
        enemy = Skeleton()
    elseif monsterId == 23 then
        enemy = HugeSlime()
    elseif monsterId == 24 then
        enemy = Slime()
    end

    map = BattleMap(gridStartX, gridStartY, gridFactor)
    player = BattlePlayer(map, math.random(4, 7), playerStartY)
    enemy = BattleEnemy(enemy, player, map, math.random(4, 7), enemyStartY, BattleReward())
    cards = BattleCards(cardsStartX, cardsStartY, cardsWidth, cardsHeight)
    movePlanner = BattleMovePlanner(map, player)
    actionPlanner = BattleActionPlanner(map, player, cards)
    label = BattleModeLabel(map)
    helper = BattleHelper(WINDOW_WIDTH - 489, WINDOW_HEIGHT - 200)

    Gamestate.switch(StateBattleMove, map, player, enemy, cards, movePlanner, actionPlanner, label, helper)
end