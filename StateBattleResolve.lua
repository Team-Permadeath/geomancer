StateBattleResolve = {}

function StateBattleResolve:enter(previousState, battleMap, battlePlayer, battleEnemy, battleCards, battleMovePlanner, battleActionPlanner, battleModeLabel)
    self.battleMap = battleMap
    self.battlePlayer = battlePlayer
    self.battleEnemy = battleEnemy
    self.battleCards = battleCards
    self.battleCards:resolve()
    self.battleMovePlanner = battleMovePlanner
    self.battleActionPlanner = battleActionPlanner
    self.battleModeLabel = battleModeLabel
end

function StateBattleResolve:draw()
    self.battleMap:draw()
    self.battlePlayer:draw()
    self.battlePlayer:drawAction()
    self.battleEnemy:draw()
    self.battleCards:drawResolve()
    self.battleModeLabel:draw("Outcome", 150)
end

function StateBattleResolve:keypressed(key)
    self.battleActionPlanner:keypressed(key)
    if key == "return" then
        Gamestate.switch(StateBattleMove, self.battleMap, self.battlePlayer, self.battleEnemy, self.battleCards, self.battleMovePlanner, self.battleActionPlanner, self.battleModeLabel)
    end
end