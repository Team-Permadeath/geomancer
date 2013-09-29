StateBattleVictory = {}

function StateBattleVictory:enter(previousState, player, enemy, label)
    self.player = player
    self.enemy = enemy
    self.label = label
end

function StateBattleVictory:draw()
    self.player:draw()
    self.enemy:drawDefeat()
    self.label:draw("Victory ^_^", 100)
end

function StateBattleVictory:keyreleased(key)
    if key == "return" then
        Gamestate.switch(StateExplore)
    end
end