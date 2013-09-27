function love.load()
    player = {
        grid_x = 256,
        grid_y = 256,
        act_x = 200,
        act_y = 200,
        speed = 10
    }
    map = {
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

function love.update(dt)
    player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
    player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)
end

function love.draw()
    love.graphics.rectangle("fill", player.act_x, player.act_y, 64, 64)
    for y=1, #map do
        for x=1, #map[y] do
			if map[y][x]== 0 then
				love.graphics.setColor(62, 62, 62)
				love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				love.graphics.setColor(255, 255, 255)
            --elseif map[y][x] == 1 then
              --  love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				--
				--elseif map[y][x]== 2 then
				--love.graphics.setColor(255, 0, 0)
				--love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				--love.graphics.setColor(255, 255, 255)
				
            end
        end
    end
	for y=1, #map do
        for x=1, #map[y] do
			if --map[y][x]== 0 then
				--love.graphics.setColor(62, 62, 62)
				--love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				--love.graphics.setColor(255, 255, 255)
--            elseif
			map[y][x] == 1 then
                love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				
				elseif map[y][x]== 2 then
				love.graphics.setColor(255, 0, 0)
				love.graphics.rectangle("line", x * 64, y * 64, 64, 64)
				love.graphics.setColor(255, 255, 255)
				
            end
        end
    end
end

function love.keypressed(key)
    if key == "up" then
        if testMap(0, -1) ~= 1 then
            player.grid_y = player.grid_y - 64
        end
    elseif key == "down" then
        if testMap(0, 1)  ~= 1 then
            player.grid_y = player.grid_y + 64
        end
    elseif key == "left" then
        if testMap(-1, 0)  ~= 1 then
            player.grid_x = player.grid_x - 64
        end
    elseif key == "right" then
        if testMap(1, 0) ~= 1 then
            player.grid_x = player.grid_x + 64
        end
	elseif key == "enter" then
        if  testMap(0,0) == 2 then
            love.graphics.setBackgroundColor( 255, 255, 0 )
        end	
		
    end
end

function testMap(x, y)
    if map[(player.grid_y / 64) + y][(player.grid_x / 64) + x] == 1 then
        return 1
    end
	if map[(player.grid_y / 64) + y][(player.grid_x / 64) + x] == 2 then
        return 2
    end
    return 0
end

function love.keyreleased(key)
   if key == "escape" then
      love.event.push("quit")   -- actually causes the app to quit
   end
end