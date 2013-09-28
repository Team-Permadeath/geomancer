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
		self.volume = 1
		for key, value in pairs(MusicTypes) do
			self.music[value] = {}
			self.music[value][0] = 0
			self.music[value][-1] = 0
		end

		self.effects = {}
		for key, value in pairs(EffectTypes) do
			self.effects[value] = {}
			self.effects[value][0] = 0
		end

		local dir = "Sounds/"
		for k, file in ipairs(love.filesystem.enumerate(dir)) do
			for key, value in pairs(MusicTypes) do
				if (string.match(file, key)) then
					local m = love.audio.newSource(dir .. file, "stream")

					self.music[value][0] = self.music[value][0] + 1
					self.music[value][self.music[value][0]] = m
				end
			end

			for key, value in pairs(EffectTypes) do
				if (string.match(file, key)) then
					self.effects[value][0] = self.effects[value][0] + 1
					self.effects[value][self.effects[value][0]] = love.audio.newSource(dir .. file, "static")
				end
			end
		end
	end,
	playmusic = function(self, mtype)
		if (self.prevplayingtype == mtype
			or not SoundEnabled
			or not MusicEnabled
			or self.music[mtype][0] == 0) then
			return
		end
		self.prevplayingtype = mtype
		if (self.playing ~= nil) then
			self.prevplaying = self.playing
		end
		if (self.music[mtype][-1] == 0) then
			self.music[mtype][-1] = math.random(self.music[mtype][0])
		end
		self.playing = self.music[mtype][self.music[mtype][-1]]
		love.audio.play(self.playing)
		self.volume = 0
	end,

	playeffect = function(self, mtype)
		if (not SoundEnabled or not EffectsEnabled) then
			return
		end
		if (self.effects[mtype][0] > 0) then
			love.audio.play(self.effects[mtype][math.random(self.effects[mtype][0])])
		end
	end,

	update = function(self, dt)
		if (self.playing == nil) then
			return
		end
		if (self.volume < 1) then
			self.volume = self.volume + dt
			if (self.playing ~= nil) then
				self.playing:setVolume(self.volume^2)
			end
			if (self.prevplaying ~= nil) then
				self.prevplaying:setVolume((1-self.volume)^2)
			end
			if (self.volume >= 1) then
				if (self.prevplaying ~= nil) then
					love.audio.pause(self.prevplaying)
				end
				self.volume = 1
			end
		end
		if (self.playing:isStopped()) then
			local tmp = self.prevplayingtype
			self.music[tmp][-1] = 0
			self.playing = nil
			self.prevplayingtype = -1
			self:playmusic(tmp)
		end
	end
}

