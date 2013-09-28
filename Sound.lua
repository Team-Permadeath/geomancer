Class = require "Lib.hump.class"

MusicTypes = {
	["Menu"] = 1;
	["Exploration"] = 2;
	["Combat"] = 3;
}

EffectTypes = {
	["Sword"] = 1;
}

Sound = Class {
	init = function(self)
		self.playing = nil
		self.music = {}
		for key, value in pairs(MusicTypes) do
			self.music[value] = {}
		end

		self.effects = {}
		for key, value in pairs(EffectTypes) do
			self.effects[value] = {}
		end

		local dir = "Sounds/"
		for k, file in ipairs(love.filesystem.enumerate(dir)) do
			for key, value in pairs(MusicTypes) do
				if (string.match(file, key)) then
					self.music[value][1] = love.audio.newSource(dir .. file, "stream")
				end
			end

			for key, value in pairs(EffectTypes) do
				if (string.match(file, key)) then
					self.effects[value][1] = love.audio.newSource(dir .. file, "static")
				end
			end
		end
	end,
	playmusic = function(self, mtype)
		if (self.playing ~= nil) then
			love.audio.pause(self.playing)
		end
		if (table.getn(self.music[mtype]) > 0) then
			love.audio.play(self.music[mtype][1])
		end
	end,
	playeffect = function(self, mtype)
		if (table.getn(self.effects[mtype]) > 0) then
			love.audio.play(self.effect[mtype][1])
		end
	end
}

