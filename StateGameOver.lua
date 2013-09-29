StateGameOver = {}
function StateGameOver:draw()
	love.graphics.setColor(255, 255, 255)
	local gameOverImage = love.graphics.newImage("Characters/dead_char-01.png")
	love.graphics.print("GAME OVER", (WINDOW_WIDTH - 334) / 2, 250)
	love.graphics.draw(gameOverImage, (WINDOW_WIDTH - 334) / 2, 400)
end

function StateGameOver:keyreleased(key)
    if key == "return" then
        Gamestate.switch(StateMenu)
    end
end

function StateGameOver:enter()
	Sound:playMusic(MusicTypes.GameOver)
end
