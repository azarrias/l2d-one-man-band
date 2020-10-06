Projectile = Class{}

function Projectile:init(world, pos_a, pos_b)
  self.body = love.physics.newBody(world, pos_a.x, pos_a.y, 'dynamic')
  self.shape = love.physics.newEdgeShape(0, 0, pos_b.x * 100, pos_b.y * 100)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.force = pos_b * 1000
  self.body:applyLinearImpulse(self.force.x, self.force.y)
end

function Projectile:update(dt)
end

function Projectile:render()
  love.graphics.setColor(1, 1, 0.3)
  love.graphics.setLineWidth(3)
  love.graphics.line(self.body:getWorldPoints(self.shape:getPoints()))
end