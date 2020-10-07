Enemy = Class{}

function Enemy:init(world, position)
	self.body = love.physics.newBody(world, position.x, position.y, "dynamic")
	self.shape = love.physics.newRectangleShape(math.floor(VIRTUAL_SIZE.x / 25), math.floor(VIRTUAL_SIZE.x / 25))
	self.fixture = love.physics.newFixture(self.body, self.shape)
  
  -- Giving the box a gentle spin.
	self.body:setAngularVelocity(0.5)
end

function Enemy:render()
	-- drawing the box
	love.graphics.setColor(1, 0.3, 0.3)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end