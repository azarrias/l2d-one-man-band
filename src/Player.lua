Player = Class{}

function Player:init(level)
  self.level = level
  self.world = level.world
  self.kinetic_friction = 3
  self.velocity_coeficient = -180
  self.velocity = tiny.Vector2D(0, 0)
  self.position = tiny.Vector2D(math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2))
  
  self.body = love.physics.newBody(self.world, self.position.x, self.position.y, "dynamic")
	self.shape = love.physics.newCircleShape(math.floor(VIRTUAL_SIZE.x / 50))
	self.fixture = love.physics.newFixture(self.body, self.shape)
  
  self.ray_intersection = nil
end
 
function Player:update(dt)
  local x, y = self.body:getWorldPoints(self.shape:getPoint())
  self.position = tiny.Vector2D(x, y)
  self.velocity = self.velocity - self.velocity * self.kinetic_friction * dt
  self.position = self.position + self.velocity * dt
  self.body:setPosition(self.position.x, self.position.y)
end

function Player:render()
  -- drawing the player
	love.graphics.setColor(0.3, 1, 0.3)
  love.graphics.circle('fill', self.position.x, self.position.y, self.shape:getRadius())
  if self.ray_intersection then
    love.graphics.setColor(1, 1, 0.3)
    love.graphics.setLineWidth(3)
    love.graphics.line(self.position.x, self.position.y, self.ray_intersection.x, self.ray_intersection.y)
  end
end

function Player:Dash()
  self.ray_intersection = nil
  local mouse_x, mouse_y = push:toGame(love.mouse.getPosition())
  self.velocity = tiny.Vector2D(mouse_x - self.position.x, mouse_y - self.position.y):Normalize() * self.velocity_coeficient 
end

function Player:Shoot()
  local mouse_x, mouse_y = push:toGame(love.mouse.getPosition())
  self.ray_start = self.position
  -- normalized vector between player position and mouse position
  local norm_v = tiny.Vector2D(mouse_x - self.position.x, mouse_y - self.position.y):Normalize()
  -- check if there is a raycast hit
  local xn, yn, fraction = self.shape:rayCast(
    self.position.x, self.position.y, 
    self.position.x + norm_v.x, self.position.y + norm_v.y, 500, 
    self.level.box.body:getX(), self.level.box.body:getY(), self.level.box.body:getAngle())
  -- if there is hit, calculate intersection position
  if xn and yn and fraction then
    local x = self.position.x + norm_v.x * fraction
    local y = self.position.y + norm_v.y * fraction
    self.ray_intersection = tiny.Vector2D(x, y)
    print("pos: ("..xn..", "..yn..") "..fraction)
  end
end
