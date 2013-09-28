require "Battlemode.BattleActionPlanner"

StateBattleAction = {}

function StateBattleAction:enter(previousState, battleMap, battlePlayer, battleEnemy, battleCards, battleMovePlanner, battleActionPlanner, battleModeLabel)
    self.battleMap = battleMap
    self.battlePlayer = battlePlayer
    self.battleEnemy = battleEnemy
    self.battleCards = battleCards
    self.battleCards:enter(battlePlayer)
    self.battleMovePlanner = battleMovePlanner
    self.battleActionPlanner = battleActionPlanner
    self.battleModeLabel = battleModeLabel
end

function StateBattleAction:draw()
    self.battleMap:draw()
    self.battlePlayer:drawAction()
    self.battleEnemy:draw()
    self.battleCards:drawAction(self.battleMap, self.battlePlayer)
    self.battleMovePlanner:drawAction()
    self.battleModeLabel:draw("Choose a spell", 200)
end

function StateBattleAction:keypressed(key)
    self.battleActionPlanner:keypressed(key)
    if key == "return" then
        Gamestate.switch(StateBattleExecute, self.battleMap, self.battlePlayer, self.battleEnemy, self.battleCards, self.battleMovePlanner, self.battleActionPlanner, self.battleModeLabel)
    elseif key == "backspace" then
        local tmpX = self.battleMovePlanner.x
        local tmpY = self.battleMovePlanner.y
        self.battleMovePlanner.x = self.battlePlayer.x
        self.battleMovePlanner.y = self.battlePlayer.y
        self.battlePlayer.x = tmpX
        self.battlePlayer.y = tmpY
        Gamestate.switch(StateBattleMove, self.battleMap, self.battlePlayer, self.battleEnemy, self.battleCards, self.battleMovePlanner, self.battleActionPlanner, self.battleModeLabel)
    end
end