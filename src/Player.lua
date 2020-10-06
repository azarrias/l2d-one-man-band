Player = Class{}

function Player:init(level)
  self.level = level
  self.world = level.world
  self.kinetic_friction = 3
  self.impulse_coeficient = -180
  
  self.body = love.physics.newBody(self.world, math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2), "dynamic")
	self.shape = love.physics.newCircleShape(PLAYER_SIZE.x / 2)
	self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setRestitution(1)
end
 
function Player:update(dt)
  local vel_x, vel_y = self.body:getLinearVelocity()
  if math.abs(vel_x) > 5 or math.abs(vel_y) > 5 then
    self.body:setLinearVelocity(vel_x - vel_x * self.kinetic_friction * dt, vel_y - vel_y * self.kinetic_friction * dt)
  else
    self.body:setLinearVelocity(0, 0)
  end
end

function Player:render()
  -- drawing the player
  love.graphics.setColor(0.3, 1, 0.3)
  love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
end

function Player:Dash()
  self.ray_vector = nil
  local mouse_x, mouse_y = push:toGame(love.mouse.getPosition())
  local impulse = tiny.Vector2D(mouse_x - self.body:getX(), mouse_y - self.body:getY()):Normalize() * self.impulse_coeficient 
  self.body:applyLinearImpulse(impulse.x, impulse.y)
end

function Player:Shoot()
  -- normalized vector between player position and mouse position
  local mouse_x, mouse_y = push:toGame(love.mouse.getPosition())
  local player_pos = tiny.Vector2D(self.body:getX(), self.body:getY())
  local norm_v = tiny.Vector2D(mouse_x - player_pos.x, mouse_y - player_pos.y):Normalize()
  local radius = self.shape:getRadius()
  
  -- create projectile
  local projectile_pos = player_pos + norm_v * radius
  local projectile = Projectile(self.world, projectile_pos, norm_v)
  table.insert(self.level.projectiles, projectile)
end
