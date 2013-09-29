StateBattleResolve = {}

function StateBattleResolve:enter(previousState, map, player, enemy, cards, movePlanner, actionPlanner, label)
    self.map = map
    self.player = player
    self.enemy = enemy
    self.enemy:resolve()
    self.movePlanner = movePlanner
    self.actionPlanner = actionPlanner
    self.actionPlanner:resolve()
    self.label = label
    self.cards = cards
    self.cards:resolve()
    self.map:clearRegister()
end

function StateBattleResolve:draw()
    self.map:draw()
    self.player:draw()
    self.player:drawAction()
    self.enemy:draw()
    self.enemy:drawResolve()
    self.cards:drawResolve()
    self.label:draw("Outcome", 150)
end

function StateBattleResolve:keypressed(key)
    if key == "return" then
        if (self.player:isDead()) then
            Gamestate.switch(StateBattleDefeat, self.player, self.enemy, self.label)
        elseif (self.enemy:isDead()) then
            Gamestate.switch(StateBattleVictory, self.player, self.enemy, self.label)
        else
            Gamestate.switch(StateBattleMove, 
                self.map, 
                self.player, 
                self.enemy, 
                self.cards, 
                self.movePlanner, 
                self.actionPlanner, 
                self.label)
        end
    end
end