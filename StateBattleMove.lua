require "StateBattleAction"
require "Battlemode.BattleMovePlanner"

StateBattleMove = {}

function StateBattleMove:enter(previousState, battleMap, battlePlayer, battleCards, battleMovePlanner, battleActionPlanner)
    self.battleMap = battleMap
    self.battlePlayer = battlePlayer
    self.battleCards = battleCards
    self.battleMovePlanner = battleMovePlanner
    self.battleActionPlanner = battleActionPlanner
end

function StateBattleMove:draw()
    self.battleMap:draw()
    self.battlePlayer:drawMove()
    self.battleCards:drawMove()
    self.battleMovePlanner:drawMove()
end

function StateBattleMove:keypressed(key)
    self.battleMovePlanner:keypressed(key)
    if key == "return" then
        local tmpX = self.battleMovePlanner.x
        local tmpY = self.battleMovePlanner.y
        self.battleMovePlanner.x = self.battlePlayer.x
        self.battleMovePlanner.y = self.battlePlayer.y
        self.battlePlayer.x = tmpX
        self.battlePlayer.y = tmpY
        Gamestate.switch(StateBattleAction, self.battleMap, self.battlePlayer, self.battleCards, self.battleMovePlanner, self.battleActionPlanner)
    end
end