Player = Class{}

function Player:init()
  self.position = tiny.Vector2D(VIRTUAL_SIZE.x / 2, VIRTUAL_SIZE.y / 2)
  self.kinetic_friction = 3
  self.velocity_coeficient = -180
  self.velocity = tiny.Vector2D(0, 0)
end
 
function Player:update(dt)
  self.velocity = self.velocity - self.velocity * self.kinetic_friction * dt
  self.position = self.position + self.velocity * dt
end

function Player:render()
  love.graphics.circle('fill', self.position.x, self.position.y, PLAYER_SIZE.x / 2)
end

function Player:Dash()
  local x, y = push:toGame(love.mouse.getPosition())
  self.velocity = tiny.Vector2D(x - self.position.x, y - self.position.y):Normalize() * self.velocity_coeficient 
  print("("..self.velocity.x..", "..self.velocity.y..")")
end
