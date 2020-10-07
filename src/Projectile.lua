Projectile = Class{}

function Projectile:init(world, pos_a, pos_b)
  self.body = love.physics.newBody(world, pos_a.x, pos_a.y, 'dynamic')
  self.shape = love.physics.newEdgeShape(0, 0, pos_b.x * 100, pos_b.y * 100)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData('Projectile')
  self.force = pos_b * 1000
  self.body:applyLinearImpulse(self.force.x, self.force.y)
  self.time_to_live = 2
  self.remove_flag = false
end

function Projectile:update(dt)
  self.time_to_live = self.time_to_live - dt
  if self.time_to_live < 0 or self.body:isDestroyed() then
    self.remove_flag = true
  end
end

function Projectile:render()
  love.graphics.setColor(1, 1, 0.3)
  love.graphics.setLineWidth(3)
  love.graphics.line(self.body:getWorldPoints(self.shape:getPoints()))
end