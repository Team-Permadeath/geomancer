Class = require "Lib.hump.class"

Enemy = Class {
	move = function (self, map, player, x, y)
		local all = {{x, y}, {x, y + 1}, {x + 1, y + 1}, {x + 1, y}, {x + 1, y - 1}, {x, y - 1}, {x - 1, y - 1}, {x - 1, y}, {x - 1, y + 1}}
		local available = {}
		for i, v in ipairs(all) do
			if map:isAvailable(v[1], v[2]) then
				table.insert(available, v)
			end
		end
		local lowestRating = 100
		local tmpRating = 0
		for i, v in ipairs(available) do
			v["rating"] = math.abs(player.x - v[1]) + math.abs(player.y - v[2])
			if v["rating"] < lowestRating and v["rating"] ~= 0 then
				lowestRating = v["rating"]
			end
		end
		local finalSelection = {}
		for i, v in ipairs(available) do
			if v["rating"] == lowestRating then
				table.insert(finalSelection, v)
			end
		end
		local final = finalSelection[math.random(1, #finalSelection)]
		return {
			x = final[1],
			y = final[2]
		}
	end,
	attack = function (self, player, x, y)
		local all = {{x, y + 1}, {x + 1, y + 1}, {x + 1, y}, {x + 1, y - 1}, {x, y - 1}, {x - 1, y - 1}, {x - 1, y}, {x - 1, y + 1}}
		local lowestRating = 100
		local tmpRating = 0
		for i, v in ipairs(all) do
			v["rating"] = math.abs(player.x - v[1]) + math.abs(player.y - v[2])
			if v["rating"] < lowestRating and v["rating"] ~= 0 then
				lowestRating = v["rating"]
			end
		end
		local finalSelection = {}
		for i, v in ipairs(all) do
			if v["rating"] == lowestRating then
				table.insert(finalSelection, v)
			end
		end
		local final = finalSelection[math.random(1, #finalSelection)]
		return {{
			x = final[1],
			y = final[2]
		}}
	end,
	reward = function (self, reward)
		return {
			reward:chooseReward(1, 100),
			reward:chooseReward(1, 100)
		}
	end
}