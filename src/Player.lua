Player = Class{}

function Player:init()
  self.position = tiny.Vector2D(VIRTUAL_SIZE.x / 2, VIRTUAL_SIZE.y / 2)
end
 
function Player:update(dt)
end

function Player:render()
  love.graphics.circle('fill', self.position.x, self.position.y, PLAYER_SIZE.x / 2)
end
