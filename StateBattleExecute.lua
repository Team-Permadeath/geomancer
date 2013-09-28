StateBattleExecute = {}

function StateBattleExecute:enter(previousState, battleMap, battlePlayer, battleEnemy, battleCards, battleMovePlanner, battleActionPlanner, battleModeLabel)
    self.battleMap = battleMap
    self.battlePlayer = battlePlayer
    self.battleEnemy = battleEnemy
    self.battleCards = battleCards
    self.battleCards:enter(battlePlayer)
    self.battleMovePlanner = battleMovePlanner
    self.battleActionPlanner = battleActionPlanner
    self.battleModeLabel = battleModeLabel
end

function StateBattleExecute:draw()
    self.battleMap:draw()
    self.battlePlayer:drawAction()
    self.battleEnemy:draw()
    self.battleCards:drawMove(self.battleMap, self.battlePlayer)
    self.battleModeLabel:draw("Outcome", 150)
end

function StateBattleExecute:keypressed(key)
    self.battleActionPlanner:keypressed(key)
    if key == "return" then
        Gamestate.switch(StateBattleMove, self.battleMap, self.battlePlayer, self.battleEnemy, self.battleCards, self.battleMovePlanner, self.battleActionPlanner, self.battleModeLabel)
    end
end