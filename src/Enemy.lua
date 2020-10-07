Enemy = Class{}

function Enemy:init(world, position)
	self.body = love.physics.newBody(world, position.x, position.y, "dynamic")
	self.shape = love.physics.newRectangleShape(math.floor(VIRTUAL_SIZE.x / 25), math.floor(VIRTUAL_SIZE.x / 25))
	self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData('Enemy')
  
  -- Giving the box a gentle spin.
	self.body:setAngularVelocity(0.5)
  
  self.remove_flag = false
end

function Enemy:update(dt)
  if self.body:isDestroyed() then
    self.remove_flag = true
  end
end

function Enemy:render()
	-- drawing the box
	love.graphics.setColor(1, 0.3, 0.3)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end