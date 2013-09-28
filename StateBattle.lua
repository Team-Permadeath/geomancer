require "StateBattleMove"
require "Battlemode.BattleMap"
require "Battlemode.BattlePlayer"
require "Battlemode.BattleCards"
require "Battlemode.BattleMovePlanner"
require "Battlemode.BattleActionPlanner"

StateBattle = {}

-- local settings
local gridFactor = 0.7
local gridStartX = ((WINDOW_WIDTH - TILE_SIZE * gridFactor * 10) / 2)
local gridStartY = TILE_SIZE * gridFactor * -1
local playerStartX = 3
local playerStartY = 3
local cardsWidth = WINDOW_WIDTH / 2
local cardsHeight = 200
local cardsStartX = 0
local cardsStartY = WINDOW_HEIGHT - cardsHeight

local battleMap
local battlePlayer
local battleMovePlanner
local battleActionPlanner
local battleEnemy
local battleCards


function StateBattle:enter(previousState)
	Sound:playEffect(EffectTypes.Transition)
	Sound:playMusic(MusicTypes.Combat)

    battleMap = BattleMap(gridStartX, gridStartY, gridFactor)
    battlePlayer = BattlePlayer(battleMap, playerStartX, playerStartY)
    battleCards = BattleCards(cardsStartX, cardsStartY, cardsWidth, cardsHeight)
    battleMovePlanner = BattleMovePlanner(battleMap, battlePlayer)
    battleActionPlanner = BattleActionPlanner(battleMap, battlePlayer, battleCards)

    Gamestate.switch(StateBattleMove, battleMap, battlePlayer, battleCards, battleMovePlanner, battleActionPlanner)
end
