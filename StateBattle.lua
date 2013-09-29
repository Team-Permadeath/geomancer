require "StateBattleAction"
require "StateBattleDefeat"
require "StateBattleMove"
require "StateBattleResolve"
require "StateBattleVictory"
require "Battlemode.BattleMap"
require "Battlemode.BattlePlayer"
require "Battlemode.BattleEnemy"
require "Battlemode.BattleCards"
require "Battlemode.BattleMovePlanner"
require "Battlemode.BattleActionPlanner"
require "Battlemode.BattleModeLabel"
require "Enemies.Skeleton"

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

-- an enemy for testing
local enemy

function StateBattle:enter(previousState)
	Sound:playEffect(EffectTypes.Transition)
	Sound:playMusic(MusicTypes.Combat)

    enemy = Skeleton()

    map = BattleMap(gridStartX, gridStartY, gridFactor)
    player = BattlePlayer(map, math.random(4, 7), playerStartY)
    enemy = BattleEnemy(enemy, player, map, math.random(4, 7), enemyStartY)
    cards = BattleCards(cardsStartX, cardsStartY, cardsWidth, cardsHeight)
    movePlanner = BattleMovePlanner(map, player)
    actionPlanner = BattleActionPlanner(map, player, cards)
    label = BattleModeLabel(map)

    Gamestate.switch(StateBattleMove, map, player, enemy, cards, movePlanner, actionPlanner, label)
end