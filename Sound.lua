Class = require "Lib.hump.class"

SoundEnabled = true
MusicEnabled = true
EffectsEnabled = true

MusicTypes = {
	["Menu"] = 1;
	["Exploration"] = 2;
	["Combat"] = 3;
}

EffectTypes = {
	["Sword"] = 1;
	["Transition"] = 2;
	["FireSpell"] = 3;
	["WaterSpell"] = 4;
	["Error"] = 4;
	["Hit"] = 5;
}

SoundSystem = Class {
	init = function(self)
		self.prevplayingtype = -1
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
		if (self.prevplayingtype == mtype
			or not SoundEnabled
			or not MusicEnabled
			or table.getn(self.music[mtype]) == 0) then
			return
		end
		self.prevplayingtype = mtype
		if (self.playing ~= nil) then
			self.prevplaying = self.playing
		end
		self.playing = self.music[mtype][1]
		love.audio.play(self.playing)
		volume = 0
	end,

	playeffect = function(self, mtype)
		if (not SoundEnabled or not EffectsEnabled) then
			return
		end
		if (table.getn(self.effects[mtype]) > 0) then
			love.audio.play(self.effects[mtype][1])
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

