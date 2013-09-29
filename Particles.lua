
Unique = 0
ActiveSystems = {}
ParticleSystems = {}
local Particle = love.graphics.newParticleSystem(love.graphics.newImage("Images/fireparticle.png"), 1000);
Particle:setEmissionRate(1000)
Particle:setSpeed(200, 300)
Particle:setSizes(1, 1)
--Particle:setColors(220, 105, 20, 255, 194, 30, 18, 0)
Particle:setLifetime(0.1)
Particle:setParticleLife(0.2)
Particle:setDirection(0)
Particle:setSpread(360)
Particle:setTangentialAcceleration(1000)
Particle:setRadialAcceleration(-2000)

Particle:stop()
ParticleSystems["Fire"] = Particle

local Particle2 = love.graphics.newParticleSystem(love.graphics.newImage("Images/waterparticle.png"), 1000);
Particle2:setEmissionRate(1000)
Particle2:setSpeed(300, 400)
Particle2:setSizes(1, 1)
--Particle2:setColors(220, 105, 20, 255, 194, 30, 18, 0)
Particle2:setLifetime(0.1)
Particle2:setParticleLife(0.2)
Particle2:setDirection(0)
Particle2:setSpread(360)
Particle2:setTangentialAcceleration(1000)
Particle2:setRadialAcceleration(0)

Particle2:stop()
ParticleSystems["Water"] = Particle2

local Particle3 = love.graphics.newParticleSystem(love.graphics.newImage("Images/sandparticle.png"), 1000);
Particle3:setEmissionRate(1000)
Particle3:setSpeed(300, 400)
Particle3:setSizes(1, 1)
--Particle3:setColors(220, 105, 20, 255, 194, 30, 18, 0)
Particle3:setLifetime(0.1)
Particle3:setParticleLife(0.2)
Particle3:setDirection(0)
Particle3:setSpread(1)
--Particle3:setTangentialAcceleration(1000)
Particle3:setRadialAcceleration(0)

Particle3:stop()
ParticleSystems["Sand"] = Particle3

function StartEffect(x, y, effect)
	effect:setPosition(x, y)
	ActiveSystems[Unique] = {
		[1] = effect;
		[2] = 1;
	}
	Unique = Unique + 1
end


function ParticleUpdate(dt)
	for k, value in pairs(ActiveSystems) do
		value[1]:update(dt)
		value[2] = value[2] - dt
		if (value[2] < 0) then
			value[1]:stop()
		else
			value[1]:start()
		end
		if (value[2] < -1) then
			table.remove(ActiveSystems, k)
		end
	end
	
end

function ParticleDraw()
	for k, value in pairs(ActiveSystems) do
		love.graphics.draw(value[1], 0, 0)
	end
end
