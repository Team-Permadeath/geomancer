StateMenu = {}
function StateMenu:init()
	local started = false
		color =	 {	background = {240,243,247},
				main = {63,193,245},
				text = {76,77,78},
				overlay = {255,255,255,235} }
	font = {	default = love.graphics.newFont(24),
				large = love.graphics.newFont(32),
				huge = love.graphics.newFont(72),
				small = love.graphics.newFont(22) }
	graphics = {background = love.graphics.newImage("Images/temp.jpg") ,
				logo = love.graphics.newImage("Images/sneak-12.png")
				--fmas = love.graphics.newImage("media/fmas.png"),
				--set = love.graphics.newImage("media/set.png"),
				--notset = love.graphics.newImage("media/notset.png") 
			}
	state   =	StateMenu.create()
end

function StateMenu:enter()
	if (started) then
		Sound:playEffect(EffectTypes.Transition)
		started = true
	end
	Sound:playMusic(MusicTypes.Menu)

	--init stuff for buttons



end

function StateMenu:create()
	local temp = {}
	setmetatable(temp, StateMenu)
	temp.button = {	new = Button.create("New Game", 600, 450),
					instructions = Button.create("Instructions", 600, 500),
					options = Button.create("Options", 600, 550),
					quit = Button.create("Quit", 600, 750) ,
					testButton = Button.create("Exit", 100,100) }
	return temp
end

function StateMenu.update(dt)
		
	for n,b in pairs(state.button) do
		b:update(dt)
	end
end

function StateMenu:draw()
	--love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(graphics["background"], 0, 0, 0, 3, 3, 100, 75)
	love.graphics.draw(graphics["logo"], 400, 225, 0, 1, 1, 100, 75)
	
	for n,b in pairs(state.button) do
		b:draw()
	end
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
				--state = Game.create()
				love.graphics.setColor(unpack(color["text"])) 
				Gamestate.switch(StateExplore)
			elseif n == "instructions" then
				state = Instructions.create()
			elseif n == "options" then
				state = Options.create()
			elseif n == "quit" then
				love.event.push("quit")
			elseif n == "testButton" then
				love.event.push("quit")
			end
		end
	end
	
end
