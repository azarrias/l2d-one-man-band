Enemy = Class{}

function Enemy:init(world, position)
  self.objType = 'Enemy'
	self.body = love.physics.newBody(world, position.x, position.y, "dynamic")
	self.shape = love.physics.newRectangleShape(math.floor(VIRTUAL_SIZE.x / 25), math.floor(VIRTUAL_SIZE.x / 25))
	self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData(self)
  self.fixture:setRestitution(1)
  self.spin = 0
  
  -- make enemies heavy, so that they don't move much when the player collides with them
  self.body:setMass(50)
  self.remove_flag = false
end

function Enemy:update(dt)
  if self.body:isDestroyed() then
    self.remove_flag = true
  else
    -- Giving the box a gentle spin.
    self.body:setAngularVelocity(self.spin)
  end
end

function Enemy:render()
	-- drawing the box
	love.graphics.setColor(112 / 255, 91 / 255, 122 / 255)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end