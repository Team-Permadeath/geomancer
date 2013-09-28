StateBattle = {}

-- local settings
local gridFactor = 1.5
local gridSize = TILE_SIZE * gridFactor
local gridStartX = 5.5
local gridStartY = -1
local startPosX = 3
local startPosY = 3
local battlePlayer
local battleMap

function StateBattle:enter(previousState)
    battlePlayer = {
        grid_x = TILE_SIZE * (gridFactor * startPosX) + gridStartX * gridSize,
        grid_y = TILE_SIZE * (gridFactor * startPosY) + gridStartY * gridSize,
        act_x = 3,
        act_y = 3,
        speed = 10
    }
    battleMap = {
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
        { 1, 2, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
       
    }
end

function StateBattle:update(dt)
    battlePlayer.act_y = battlePlayer.act_y - ((battlePlayer.act_y - battlePlayer.grid_y) * battlePlayer.speed * dt)
    battlePlayer.act_x = battlePlayer.act_x - ((battlePlayer.act_x - battlePlayer.grid_x) * battlePlayer.speed * dt)
end

function StateBattle:draw()
    local gridPosX
    local gridPosY
    love.graphics.rectangle("fill", battlePlayer.act_x, battlePlayer.act_y, gridSize, gridSize)
    for y=1, #battleMap do
        for x=1, #battleMap[y] do
            gridPosX = x - 1 + gridStartX
            gridPosY = y - 1 + gridStartY
			if battleMap[y][x]== 0 then
				love.graphics.setColor(62, 62, 62)
				love.graphics.rectangle("line", gridPosX * gridSize, gridPosY * gridSize, gridSize, gridSize)
				love.graphics.setColor(255, 255, 255)
            elseif battleMap[y][x] == 1 then
                love.graphics.rectangle("line", gridPosX * gridSize, gridPosY * gridSize, gridSize, gridSize)
			elseif battleMap[y][x]== 2 then
				love.graphics.setColor(255, 0, 0)
				love.graphics.rectangle("line", gridPosX * gridSize, gridPosY * gridSize, gridSize, gridSize)
				love.graphics.setColor(255, 255, 255)
				
            end
        end
    end
	for y=1, #battleMap do
        for x=1, #battleMap[y] do
            gridPosX = x - 1 + gridStartX
            gridPosY = y - 1 + gridStartY
			if battleMap[y][x]== 0 then
				love.graphics.setColor(62, 62, 62)
				love.graphics.rectangle("line", gridPosX * gridSize, gridPosY * gridSize, gridSize, gridSize)
				love.graphics.setColor(255, 255, 255)
            elseif battleMap[y][x] == 1 then
                love.graphics.rectangle("line", gridPosX * gridSize, gridPosY * gridSize, gridSize, gridSize)
			elseif battleMap[y][x]== 2 then
				love.graphics.setColor(255, 0, 0)
				love.graphics.rectangle("line", gridPosX * gridSize, gridPosY * gridSize, gridSize, gridSize)
				love.graphics.setColor(255, 255, 255)	
            end
        end
    end
end

function StateBattle:keypressed(key)
    if key == "up" then
        if testbattleMap(0, -1) ~= 1 then
            battlePlayer.grid_y = battlePlayer.grid_y - gridSize
        end
    elseif key == "down" then
        if testbattleMap(0, 1)  ~= 1 then
            battlePlayer.grid_y = battlePlayer.grid_y + gridSize
        end
    elseif key == "left" then
        if testbattleMap(-1, 0)  ~= 1 then
            battlePlayer.grid_x = battlePlayer.grid_x - gridSize
        end
    elseif key == "right" then
        if testbattleMap(1, 0) ~= 1 then
            battlePlayer.grid_x = battlePlayer.grid_x + gridSize
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
    local dtX = x - gridStartX + 1
    local dtY = y - gridStartY + 1
    if battleMap[(battlePlayer.grid_y / gridSize) + dtY][(battlePlayer.grid_x / gridSize) + dtX] == 1 then
        return 1
    end
	if battleMap[(battlePlayer.grid_y / gridSize) + dtY][(battlePlayer.grid_x / gridSize) + dtX] == 2 then
        return 2
    end
    return 0
end