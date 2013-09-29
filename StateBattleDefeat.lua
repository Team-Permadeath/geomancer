StateBattleDefeat = {}

function StateBattleDefeat:enter(previousState, player, enemy, label)
    self.player = player
    self.enemy = enemy
    self.label = label
end

function StateBattleDefeat:draw()
    self.player:drawDefeat()
    self.enemy:draw()
    self.label:draw("You were defeated =(", 300)
end

function StateBattleDefeat:keypressed(key)
    if key == "return" then
    	love.event.push("quit")
    end
end