GUI = Class{}

function GUI:init()
  self.border = 2
  self.healthbar_height = LEVEL_OFFSET.y / 2
  local healthbar_offset = tiny.Vector2D(LEVEL_OFFSET.y / 2, 0)
  self.healthbar_pos = tiny.Vector2D(LEVEL_OFFSET.y / 2 - self.healthbar_height / 2 + healthbar_offset.x, LEVEL_OFFSET.y / 2 - self.healthbar_height / 2 + healthbar_offset.y):Floor()
  self.healthbar_thickness = self.healthbar_height / 3
end

function GUI:update(dt)
end

function GUI:render()
  -- background
  love.graphics.setColor(0.1, 0.1, 0.1)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_SIZE.x, LEVEL_OFFSET.y)
  -- frame
  love.graphics.setColor(0.2, 0, 0)
  love.graphics.setLineWidth(self.border * 2)
  love.graphics.rectangle('line', self.border, self.border, VIRTUAL_SIZE.x - self.border * 2, LEVEL_OFFSET.y - self.border * 2)
  -- health cross
  love.graphics.setColor(0.6, 0.2, 0.2)
  love.graphics.rectangle('fill', -- vertical bar
    math.floor(self.healthbar_pos.x + self.healthbar_height / 2 - self.healthbar_thickness / 2), 
    self.healthbar_pos.y, 
    self.healthbar_thickness, 
    self.healthbar_height) 
  love.graphics.rectangle('fill', -- horizontal bar
    self.healthbar_pos.x, 
    math.floor(self.healthbar_pos.y + self.healthbar_height / 2 - self.healthbar_thickness / 2), 
    self.healthbar_height, 
    self.healthbar_thickness)
end
