Edge = Class{}

function Edge:init(world, position, size)
  self.body = love.physics.newBody(world, position.x, position.y, 'static')
  self.shape = love.physics.newEdgeShape(0, 0, size.x, size.y)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData('Edge')
end