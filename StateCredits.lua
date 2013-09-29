--local background = love.graphics.newImage("Images/main_menu_bg-01.png")

StateCredits = {}

function StateCredits:init()
	y = 800
size = 20
--filename = "Century_Gothic_Bold.ttf"

monster1 = love.graphics.newImage("Characters/monsters/monster-25.png")
monster2 = love.graphics.newImage("Characters/monsters/monster-26.png")
monster3 = love.graphics.newImage("Characters/monsters/monster-27.png")
monster4 = love.graphics.newImage("Characters/monsters/monster-28.png")
monster5 = love.graphics.newImage("Characters/monsters/monster-29.png")
chars = love.graphics.newImage("Images/sneak-12.png")
end

function StateCredits:enter()
--y = 600
size = 20
--filename = "Century_Gothic_Bold.ttf"

monster1 = love.graphics.newImage("Characters/monsters/monster-25.png")
monster2 = love.graphics.newImage("Characters/monsters/monster-26.png")
monster3 = love.graphics.newImage("Characters/monsters/monster-27.png")
monster4 = love.graphics.newImage("Characters/monsters/monster-28.png")
monster5 = love.graphics.newImage("Characters/monsters/monster-29.png")
chars = love.graphics.newImage("Images/sneak-12.png")


end

function StateCredits:create()
end

function StateCredits.update(dt)
end

function StateCredits:draw()
	love.graphics.setColor(255, 255, 255)
	print("WTF")

	love.graphics.draw(monster1, 50, y+30)
	love.graphics.draw(monster5, 350, y+80)
	love.graphics.draw(monster3, 80, y+250)
	love.graphics.draw(monster4, 20, y+340)
	love.graphics.draw(monster2, 70, y+450)
	love.graphics.draw(chars, 150, y+600)

	--love.graphics.setNewFont(filename, size)
	love.graphics.print("******** GEOMANCER ********", 300, y, center)
	y = y - 0.01
	love.graphics.print("** A game by PERMADEATH **", 300, y+30)
	y = y - 0.01
	love.graphics.print("Code-mokeys:", 300, y+150)
	y = y - 0.08
	love.graphics.print("> Arne Hassel", 300, y+180)
	y = y - 0.08
	love.graphics.print("> Kjell Wilhelmsen", 300, y+210)
	y = y - 0.08
	love.graphics.print("> Pawel Kozolwski", 300, y+240)
	y = y - 0.08
	love.graphics.print("Music n' fancy rythms 'n pewpew:", 300, y+300)
	y = y - 0.08
	love.graphics.print("> Jan Anders Bremer", 300, y+330)
	y = y - 0.08
	love.graphics.print("Graphics and this credit-thing:", 300, y+390)
	y = y - 0.08
	love.graphics.print("> Veronika Heimsbakk", 300, y+420)

end

function StateCredits:keyreleased(key, unicode)
    if key == "return" then
	--Sound:playmusic(MusicTypes.Exploration)
        Gamestate.switch(StateMenu)
	end
end

function StateCredits:mousepressed(x,y,button)
	Gamestate.switch(StateMenu)
end
