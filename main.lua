Gamestate = require "Lib.hump.gamestate"
math.randomseed( os.time() )

require "Sound"
Sound = SoundSystem()
require "Player"
require("lua/button")

-- globals being used in different game states
player = nil
cards = nil -- representation of cards
globalFontFile = "Fonts/Century_Gothic_Bold.ttf"
globalFont = love.graphics.newFont(globalFontFile, 40)

-- game states
require "StateMenu"
require "StateExplore"
require "StateBattle"
require "StateInventory"
-- cards
require "Cards.CardsRepository"

function love.load()
	-- init player
	local animSpriteImg = love.graphics.newImage("Characters/main_char_anim-05.png")
	local animSprite = newAnimation(animSpriteImg, TILE_SIZE, TILE_SIZE, 0.15, 0)
	love.graphics.setFont(globalFont)
	-- 15, 15
	player = Player(90, 11, TILE_SIZE, animSprite, 5, 5)
	Gamestate.registerEvents()
	Gamestate.switch(StateMenu)
	cards = CardsRepository(3, 3, 3)
end

function love.update(dt)
	Sound:update(dt)
end

function love.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
  	if key == "escape" then
    	love.event.push("quit")   -- actually causes the app to quit
  	end
end
