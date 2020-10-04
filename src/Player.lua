Player = Class{}

function Player:init(world)
  self.world = world
  self.kinetic_friction = 3
  self.velocity_coeficient = -180
  self.velocity = tiny.Vector2D(0, 0)
  
  self.body = love.physics.newBody(self.world, math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2), "dynamic")
	self.shape = love.physics.newCircleShape(math.floor(VIRTUAL_SIZE.x / 50))
	self.fixture = love.physics.newFixture(self.body, self.shape)
end
 
function Player:update(dt)
  local x, y = self.body:getWorldPoints(self.shape:getPoint())
  local position = tiny.Vector2D(x, y)
  self.velocity = self.velocity - self.velocity * self.kinetic_friction * dt
  position = position + self.velocity * dt
  self.body:setPosition(position.x, position.y)
end

function Player:render()
  -- drawing the player
  local x, y = self.body:getWorldPoints(self.shape:getPoint())
	love.graphics.setColor(0.3, 1, 0.3)
  love.graphics.circle('fill', x, y, self.shape:getRadius())
end

function Player:Dash()
  local x1, y1 = self.body:getWorldPoints(self.shape:getPoint())
  local x2, y2 = push:toGame(love.mouse.getPosition())
  self.velocity = tiny.Vector2D(x2 - x1, y2 - y1):Normalize() * self.velocity_coeficient 
end

function Player:Shoot()
end
