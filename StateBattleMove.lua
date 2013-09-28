require "Battlemode.BattleMovePlanner"

StateBattleMove = {}

function StateBattleMove:enter(previousState, battleMap, battlePlayer, battleEnemy, battleCards, battleMovePlanner, battleActionPlanner, battleModeLabel)
    self.battleMap = battleMap
    self.battlePlayer = battlePlayer
    self.battleEnemy = battleEnemy
    self.battleCards = battleCards
    self.battleMovePlanner = battleMovePlanner
    self.battleActionPlanner = battleActionPlanner
    self.battleModeLabel = battleModeLabel
end

function StateBattleMove:draw()
    self.battleMap:draw()
    self.battlePlayer:drawMove()
    self.battleEnemy:draw()
    self.battleCards:drawMove()
    self.battleMovePlanner:drawMove()
    self.battleModeLabel:draw("Make a move", 200)
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
        Gamestate.switch(StateBattleAction, self.battleMap, self.battlePlayer, self.battleEnemy, self.battleCards, self.battleMovePlanner, self.battleActionPlanner, self.battleModeLabel)
    end
end