local background = love.graphics.newImage("Images/main_menu_bg-01.png")

StateMenu = {}

function StateMenu:init()
	local started = false
	color =	 {	background = {240, 243, 247},
				main = {63, 193, 245},
				text = {0, 0, 0},
				overlay = {255, 255, 255, 235} }
	font = {	default = love.graphics.newFont(24),
				large = love.graphics.newFont(32),
				huge = love.graphics.newFont(72),
				small = love.graphics.newFont(22) }
	state   =	StateMenu.create()
end

function StateMenu:enter()
	if started ~= true then
		Sound:playEffect(EffectTypes.Transition)
		started = true
	end
	Sound:playMusic(MusicTypes.Menu)
end

function StateMenu:create()
	local temp = {}
	temp.button = {	new = Button.create("New Game", 600, 450),
					instructions = Button.create("Instructions", 600, 500),
					options = Button.create("Options", 600, 550),
					quit = Button.create("Quit", 600, 750),
					inventory = Button.create("Inventory", 100, 50) }
	return temp
end

function StateMenu.update(dt)
	for n,b in pairs(state.button) do
		b:update(dt)
	end
end

function StateMenu:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(background, 0, 0)
	
	state.button.new:draw()
	--state.button.instructions:draw()
	--state.button.options:draw()
	state.button.quit:draw()
	ParticleDraw()

end

function StateMenu:keyreleased(key, unicode)
    if key == "return" then
	--Sound:playmusic(MusicTypes.Exploration)
        Gamestate.switch(StateExplore)
	end
end

function StateMenu:mousepressed(x,y,button)
	for n,b in pairs(state.button) do
		if b:mousepressed(x,y,button) then
			if n == "new" then
				Gamestate.switch(StateExplore)
			elseif n == "quit" then
				love.event.push("quit")
			end
		end
	end
end
