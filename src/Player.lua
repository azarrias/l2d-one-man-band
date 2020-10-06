Player = Class{}

function Player:init(level)
  self.level = level
  self.world = level.world
  self.kinetic_friction = 150
  self.velocity_coeficient = -360
  self.velocity = tiny.Vector2D(0, 0)
  self.position = tiny.Vector2D(math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2))
  
  self.body = love.physics.newBody(self.world, self.position.x, self.position.y, "dynamic")
	self.shape = love.physics.newCircleShape(math.floor(VIRTUAL_SIZE.x / 50))
	self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setRestitution(0.9)
  
  self.ray_vector = nil
  self.ray_max_length = math.sqrt(math.pow(VIRTUAL_SIZE.x, 2) + math.pow(VIRTUAL_SIZE.y, 2))
end
 
function Player:update(dt)
  local vel_x, vel_y = self.body:getLinearVelocity()
  if math.abs(vel_x) > 5 or math.abs(vel_y) > 5 then
    self.body:setLinearVelocity(vel_x / 1.25, vel_y / 1.25) --dt
  else
    self.body:setLinearVelocity(0, 0)
  end
end

function Player:render()
  -- drawing the player
	love.graphics.setColor(0.3, 1, 0.3)
  love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
  if self.ray_vector then
    love.graphics.setColor(1, 1, 0.3)
    love.graphics.setLineWidth(3)
    love.graphics.line(self.body:getX(), self.body:getY(), self.ray_vector.x, self.ray_vector.y)
  end
end

function Player:Dash()
  self.ray_vector = nil
  local mouse_x, mouse_y = push:toGame(love.mouse.getPosition())
  self.velocity = tiny.Vector2D(mouse_x - self.body:getX(), mouse_y - self.body:getY()):Normalize() * self.velocity_coeficient 
  self.body:applyLinearImpulse(self.velocity.x, self.velocity.y)
end

function Player:Shoot()
  local mouse_x, mouse_y = push:toGame(love.mouse.getPosition())
  self.ray_start = self.position
  -- normalized vector between player position and mouse position
  local norm_v = tiny.Vector2D(mouse_x - self.body:getX(), mouse_y - self.body:getY()):Normalize()
  -- check if there is a raycast hit
  local xn, yn, fraction = self.shape:rayCast(
    self.body:getX(), self.body:getY(), 
    self.body:getX() + norm_v.x, self.body:getY() + norm_v.y, self.ray_max_length, 
    self.level.box.body:getX(), self.level.box.body:getY(), self.level.box.body:getAngle())
  -- if there is hit, calculate intersection position
  if xn and yn and fraction then
    local x = self.body:getX() + norm_v.x * fraction
    local y = self.body:getY() + norm_v.y * fraction
    self.ray_vector = tiny.Vector2D(x, y)
    print("pos: ("..xn..", "..yn..") "..fraction)
  else
    local x = self.body:getX() + norm_v.x * self.ray_max_length
    local y = self.body:getY() + norm_v.y * self.ray_max_length
    self.ray_vector = tiny.Vector2D(x, y)
  end
end
