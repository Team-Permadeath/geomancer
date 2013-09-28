require "Battlemode.BattleActionPlanner"

StateBattleAction = {}

function StateBattleAction:enter(previousState, battleMap, battlePlayer, battleCards, battleMovePlanner, battleActionPlanner)
    self.battleMap = battleMap
    self.battlePlayer = battlePlayer
    self.battleCards = battleCards
    self.battleCards:enter(battlePlayer)
    self.battleMovePlanner = battleMovePlanner
    self.battleActionPlanner = battleActionPlanner
end

function StateBattleAction:draw()
    self.battleMap:draw()
    self.battlePlayer:drawAction()
    self.battleCards:drawAction(self.battleMap, self.battlePlayer)
    self.battleMovePlanner:drawAction()
end

function StateBattleAction:keypressed(key)
    self.battleActionPlanner:keypressed(key)
    if key == "backspace" then
        local tmpX = self.battleMovePlanner.x
        local tmpY = self.battleMovePlanner.y
        self.battleMovePlanner.x = self.battlePlayer.x
        self.battleMovePlanner.y = self.battlePlayer.y
        self.battlePlayer.x = tmpX
        self.battlePlayer.y = tmpY
        Gamestate.switch(StateBattleMove, self.battleMap, self.battlePlayer, self.battleCards, self.battleMovePlanner, self.battleActionPlanner)
    end
end