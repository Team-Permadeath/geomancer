StateMenu = {}
function StateMenu:init()
	local started = false
end

function StateMenu:enter()
	if (started) then
		Sound:playEffect(EffectTypes.Transition)
		started = true
	end
	Sound:playMusic(MusicTypes.Menu)
end

function StateMenu:draw()
	love.graphics.setBackgroundColor(100, 0, 255)
	love.graphics.print("Here will be awesome menu, but for now just press Enter to continue ;-)", 10, 10)
end

function StateMenu:keyreleased(key, unicode)
    if key == "return" then
        Gamestate.switch(StateExplore)
	end
end
