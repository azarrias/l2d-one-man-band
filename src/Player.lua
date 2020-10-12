Player = Class{}

function Player:init(level)
  self.objType = 'Player'
  self.level = level
  self.world = level.world
  self.kinetic_friction = 4
  self.impulse_coeficient = -500
  
  local player_pos = (VIRTUAL_SIZE - LEVEL_OFFSET) / 2
  player_pos = player_pos:Floor() + LEVEL_OFFSET

  self.body = love.physics.newBody(self.world, player_pos.x, player_pos.y, "dynamic")
	self.shape = love.physics.newCircleShape(PLAYER_SIZE.x / 2)
	self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData(self)
  self.fixture:setRestitution(0.8)
  
  self.max_health_points = 8
  self.current_health_points = self.max_health_points
  self.invulnerable = false
  self.invulnerableDuration = 0
  self.invulnerableTimer = 0
  self.flashTimer = 0
end
 
function Player:update(dt)
  if self.invulnerable then
    self.flashTimer = self.flashTimer + dt
    self.invulnerableTimer = self.invulnerableTimer + dt

    if self.invulnerableTimer > self.invulnerableDuration then
      self.invulnerable = false
      self.invulnerableTimer = 0
      self.invulnerableDuration = 0
      self.flashTimer = 0
    end
  end
  
  local vel_x, vel_y = self.body:getLinearVelocity()
  if math.abs(vel_x) > 5 or math.abs(vel_y) > 5 then
    self.body:setLinearVelocity(vel_x - vel_x * self.kinetic_friction * dt, vel_y - vel_y * self.kinetic_friction * dt)
  else
    self.body:setLinearVelocity(0, 0)
  end
end

function Player:render()
  -- drawing the player
  if self.invulnerable and self.flashTimer > 0.1 then
    self.flashTimer = 0
  elseif self.invulnerable and self.flashTimer > 0.06 then
    love.graphics.setColor(1, 1, 1)
  else
    love.graphics.setColor(0.3, 1, 0.3)
  end
  love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
end

function Player:Dash()
  self.ray_vector = nil
  local mouse_x, mouse_y = push:toGame(love.mouse.getPosition())
  local impulse = tiny.Vector2D(mouse_x - self.body:getX(), mouse_y - self.body:getY()):Normalize() * self.impulse_coeficient 
  self.body:applyLinearImpulse(impulse.x, impulse.y)
end

function Player:MakeInvulnerable(duration)
  self.invulnerable = true
  self.invulnerableDuration = duration
end

function Player:ReduceHP(hp)
  self.current_health_points = self.current_health_points - hp
  self:MakeInvulnerable(1.5)
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
