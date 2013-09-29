StateBattleMove = {}

function StateBattleMove:enter(previousState, map, player, enemy, cards, movePlanner, actionPlanner, label)
    self.map = map
    self.player = player
    self.enemy = enemy
    self.cards = cards
    self.movePlanner = movePlanner
    self.actionPlanner = actionPlanner
    self.label = label
end

function StateBattleMove:draw()
    self.map:draw()
    self.player:draw()
    self.player:drawMove()
    self.enemy:draw()
    self.enemy:drawMove()
    self.cards:drawMove()
    self.movePlanner:drawMove()
    self.label:draw("Make a move", 200)
end

function StateBattleMove:keyreleased(key)
    self.movePlanner:keyreleased(key)
    if key == "return" then
        local tmpX = self.movePlanner.x
        local tmpY = self.movePlanner.y
        self.movePlanner.x = self.player.x
        self.movePlanner.y = self.player.y
        self.player.x = tmpX
        self.player.y = tmpY
        self.player:register()
        Gamestate.switch(StateBattleAction, self.map, self.player, self.enemy, self.cards, self.movePlanner, self.actionPlanner, self.label)
    end
end