StateMenu = {}
function StateMenu:init()
	Sound:playmusic(MusicTypes.Menu)
end

function StateMenu:enter()
end

function StateMenu:draw()
	love.graphics.setBackgroundColor(100, 0, 255)
	love.graphics.print("Here will be awesome menu, but for now just press Enter to continue ;-)", 10, 10)
end

function StateMenu:keyreleased(key, unicode)
    if key == "return" then
	Sound:playmusic(MusicTypes.Exploration)
        Gamestate.switch(StateExplore)
	end
end
