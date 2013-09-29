StateBattleAction = {}

function StateBattleAction:enter(previousState, map, player, enemy, cards, movePlanner, actionPlanner, label)
    self.map = map
    self.player = player
    self.enemy = enemy
    self.cards = cards
    self.cards:enter(player)
    self.movePlanner = movePlanner
    self.actionPlanner = actionPlanner
    self.label = label
end

function StateBattleAction:draw()
    self.map:draw()
    self.player:draw()
    self.player:drawAction()
    self.enemy:draw()
    self.enemy:drawMove()
    self.cards:drawAction(self.map, self.player)
    --self.movePlanner:drawAction()
    self.label:draw("Choose a spell", 200)
end

function StateBattleAction:keypressed(key)
    self.actionPlanner:keypressed(key)
    if key == "return" then
        Gamestate.switch(StateBattleResolve, self.map, self.player, self.enemy, self.cards, self.movePlanner, self.actionPlanner, self.label)
    elseif key == "backspace" then
        local tmpX = self.movePlanner.x
        local tmpY = self.movePlanner.y
        self.movePlanner.x = self.player.x
        self.movePlanner.y = self.player.y
        self.player.x = tmpX
        self.player.y = tmpY
        Gamestate.switch(StateBattleMove, self.map, self.player, self.enemy, self.cards, self.movePlanner, self.actionPlanner, self.label)
    end
end