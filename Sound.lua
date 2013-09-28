Class = require "Lib.hump.class"

MusicTypes = {
	["Menu"] = 1;
	["Exploration"] = 2;
	["Combat"] = 3;
}

EffectTypes = {
	["Sword"] = 1;
	["Transition"] = 2;
}

SoundSystem = Class {
	init = function(self)
		self.playing = nil
		self.prevplaying = nil
		self.music = {}
		self.volume = 0
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
					local m = love.audio.newSource(dir .. file, "stream")
					m:setLooping(true)

					self.music[value][1] = m
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
			self.prevplaying = self.playing
		end
		if (table.getn(self.music[mtype]) > 0) then
			self.playing = self.music[mtype][1]
			love.audio.play(self.playing)
			volume = 0
		end
	end,
	playeffect = function(self, mtype)
		if (table.getn(self.effects[mtype]) > 0) then
			love.audio.play(self.effect[mtype][1])
		end
	end,
	update = function(self, dt)
		if (volume < 1) then
			volume = volume + dt
			if (self.playing ~= nil) then
				self.playing:setVolume(volume^2)
			end
			if (self.prevplaying ~= nil) then
				self.prevplaying:setVolume((1-volume)^2)
			end
			if (volume >= 1) then
				if (self.prevplaying ~= nil) then
					love.audio.pause(self.prevplaying)
				end
				volume = 1
			end
		end
	end
}

