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
local playerStartX = math.random(3, 7)
local playerStartY = 3
local enemyStartX = math.random(3, 7)
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
local enemy = Skeleton()

function StateBattle:enter(previousState)
	Sound:playEffect(EffectTypes.Transition)
	Sound:playMusic(MusicTypes.Combat)

    map = BattleMap(gridStartX, gridStartY, gridFactor)
    player = BattlePlayer(map, playerStartX, playerStartY)
    enemy = BattleEnemy(enemy, player, map, enemyStartX, enemyStartY)
    cards = BattleCards(cardsStartX, cardsStartY, cardsWidth, cardsHeight)
    movePlanner = BattleMovePlanner(map, player)
    actionPlanner = BattleActionPlanner(map, player, cards)
    label = BattleModeLabel(map)

    Gamestate.switch(StateBattleMove, map, player, enemy, cards, movePlanner, actionPlanner, label)
end
