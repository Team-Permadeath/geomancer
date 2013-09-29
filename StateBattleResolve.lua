StateBattleResolve = {}

function StateBattleResolve:enter(previousState, map, player, enemy, cards, movePlanner, actionPlanner, label, helper)
    self.map = map
    self.map:reset()
    self.player = player
    self.enemy = enemy
    self.enemy:resolve()
    self.movePlanner = movePlanner
    self.actionPlanner = actionPlanner
    self.actionPlanner:resolve()
    self.label = label
    self.cards = cards
    self.cards:resolve()
    self.helper = helper
end

function StateBattleResolve:draw()
    self.map:draw()
    self.player:draw()
    self.player:drawAction()
    self.enemy:draw()
    self.enemy:drawResolve()
    self.cards:drawResolve()
    self.map:drawResolve()
    self.label:draw("Outcome", 150)
    self.helper:drawResolve()
end

function StateBattleResolve:keyreleased(key)
    if key == "return" then
        if (self.player:isDead()) then
            Gamestate.switch(StageGameOver)
        elseif (self.enemy:isDead()) then
            Gamestate.switch(StateBattleVictory, self.player, self.enemy, self.label, self.helper)
        else
            Gamestate.switch(StateBattleMove, 
                self.map, 
                self.player, 
                self.enemy, 
                self.cards, 
                self.movePlanner, 
                self.actionPlanner, 
                self.label, 
                self.helper)
        end
    end
end