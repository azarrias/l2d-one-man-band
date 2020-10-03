Player = Class{}

function Player:init()
  self.position = tiny.Vector2D(VIRTUAL_SIZE.x / 2, VIRTUAL_SIZE.y / 2)
  self.kinetic_friction = 5
  self.velocity_coeficient = 10
  self.velocity = tiny.Vector2D(0, 0)
end
 
function Player:update(dt)
  
end

function Player:render()
  love.graphics.circle('fill', self.position.x, self.position.y, PLAYER_SIZE.x / 2)
end

function Player:Dash()
  local x, y = push:toGame(love.mouse.getPosition())
  self.velocity = tiny.Vector2D(x - self.position.x, y - self.position.y):Normalize()
  print("("..self.velocity.x..", "..self.velocity.y..")")
end