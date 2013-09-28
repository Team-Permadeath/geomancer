StateBattle = {}

function StateBattle:enter(previousState)
    battlePlayer = {
        grid_x = 256,
        grid_y = 256,
        act_x = 200,
        act_y = 200,
        speed = 10
    }
    battleMap = {
        { 1, 1, 1, 1, 1, 1, 1, 1 },
        { 1, 2, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 1, 1, 1, 1, 1, 1, 1 }
       
    }
end

function StateBattle:update(dt)
    battlePlayer.act_y = battlePlayer.act_y - ((battlePlayer.act_y - battlePlayer.grid_y) * battlePlayer.speed * dt)
    battlePlayer.act_x = battlePlayer.act_x - ((battlePlayer.act_x - battlePlayer.grid_x) * battlePlayer.speed * dt)
end

function StateBattle:draw()
    love.graphics.rectangle("fill", battlePlayer.act_x, battlePlayer.act_y, 64, 64)
    for y=1, #battleMap do
        for x=1, #battleMap[y] do
			if battleMap[y][x]== 0 then
				love.graphics.setColor(62, 62, 62)
				love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				love.graphics.setColor(255, 255, 255)
            --elseif battleMap[y][x] == 1 then
              --  love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				--
				--elseif battleMap[y][x]== 2 then
				--love.graphics.setColor(255, 0, 0)
				--love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				--love.graphics.setColor(255, 255, 255)
				
            end
        end
    end
	for y=1, #battleMap do
        for x=1, #battleMap[y] do
			if --battleMap[y][x]== 0 then
				--love.graphics.setColor(62, 62, 62)
				--love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				--love.graphics.setColor(255, 255, 255)
--            elseif
			battleMap[y][x] == 1 then
                love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				
				elseif battleMap[y][x]== 2 then
				love.graphics.setColor(255, 0, 0)
				love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				love.graphics.setColor(255, 255, 255)
				
            end
        end
    end
end

function StateBattle:keypressed(key)
    if key == "up" then
        if testbattleMap(0, -1) ~= 1 then
            battlePlayer.grid_y = battlePlayer.grid_y - 64
        end
    elseif key == "down" then
        if testbattleMap(0, 1)  ~= 1 then
            battlePlayer.grid_y = battlePlayer.grid_y + 64
        end
    elseif key == "left" then
        if testbattleMap(-1, 0)  ~= 1 then
            battlePlayer.grid_x = battlePlayer.grid_x - 64
        end
    elseif key == "right" then
        if testbattleMap(1, 0) ~= 1 then
            battlePlayer.grid_x = battlePlayer.grid_x + 64
        end
	elseif key == "return" then
        if  testbattleMap(0,0) == 2 then
            love.graphics.setBackgroundColor( 255, 255, 0 )
        end	
	elseif key == "e" then
		Gamestate.switch(StateExplore)
    end
end

function testbattleMap(x, y)
    if battleMap[(battlePlayer.grid_y / 64) + y][(battlePlayer.grid_x / 64) + x] == 1 then
        return 1
    end
	if battleMap[(battlePlayer.grid_y / 64) + y][(battlePlayer.grid_x / 64) + x] == 2 then
        return 2
    end
    return 0
end