StateBattleVictory = {}

function StateBattleVictory:enter(previousState, player, enemy, label, helper)
    self.player = player
    player:increaseMonsterKill()
    self.enemy = enemy
    enemy:reward()
    self.label = label
    self.helper = helper
end

function StateBattleVictory:draw()
    self.player:draw()
    self.enemy:drawDefeat()
    self.label:draw("Victory ^_^", 100)
    self.helper:drawVictory()
end

function StateBattleVictory:keyreleased(key)
    if key == "return" then
        Gamestate.switch(StateExplore)
    end
end