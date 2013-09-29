Class = require "Lib.hump.class"

BattleReward = Class{
	init = function (self)
		local card
		local healthImage = love.graphics.newImage("Images/health-01.png")
		self.rewards = {};
		for i = 1, 30 do
			card = Square()
			self.rewards[i] = function ()
				cards:addCard("Square")
				return {
					image = card.image,
					text = "You received one square card."
				}
			end
		end
		for i = 31, 60 do
			card = Triangle()
			self.rewards[i] = function ()
				card = Triangle()
				cards:addCard("Triangle")
				return {
					image = card.image,
					text = "You received one triangle card."
				}
			end
		end
		for i = 61, 90 do
			card = Circle()
			self.rewards[i] = function ()
				cards:addCard("Circle")
				return {
					image = card.image,
					text = "You received one circle card."
				}
			end
		end
		for i = 91, 100 do
			self.rewards[i] = function () 
				player.health = player.health + 1
				return {
					image = healthImage,
					text = "Your health increased by one."
				}
			end
		end
	end,
	chooseReward = function (self, min, max)
		return self.rewards[math.random(min, max)]
	end
}