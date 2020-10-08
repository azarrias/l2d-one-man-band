GUI = Class{}

function GUI:init(level)
  self.level = level
  self.border = 2
  self.health_icon_height = LEVEL_OFFSET.y / 2
  local health_icon_offset = tiny.Vector2D(LEVEL_OFFSET.y / 3, 0)
  self.health_icon_pos = tiny.Vector2D(LEVEL_OFFSET.y / 2 - self.health_icon_height / 2 + health_icon_offset.x, LEVEL_OFFSET.y / 2 - self.health_icon_height / 2 + health_icon_offset.y):Floor()
  self.health_icon_thickness = self.health_icon_height / 3
  local hp_bars_offset = tiny.Vector2D(15, 8)
  self.hp_bars_pos = self.health_icon_pos + tiny.Vector2D(self.health_icon_height, 0) + hp_bars_offset
  self.hp_bars_size = tiny.Vector2D(math.floor(self.health_icon_thickness * 0.75), self.health_icon_height - hp_bars_offset.y)
  self.hp_bars_gap = tiny.Vector2D(10, 0)
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
    math.floor(self.health_icon_pos.x + self.health_icon_height / 2 - self.health_icon_thickness / 2), 
    self.health_icon_pos.y, 
    self.health_icon_thickness, 
    self.health_icon_height) 
  love.graphics.rectangle('fill', -- horizontal bar
    self.health_icon_pos.x, 
    math.floor(self.health_icon_pos.y + self.health_icon_height / 2 - self.health_icon_thickness / 2), 
    self.health_icon_height, 
    self.health_icon_thickness)

  -- hp bars
  love.graphics.setLineWidth(self.border)
  for i = 1, self.level.player.max_health_points, 1 do
    love.graphics.rectangle('line', 
      self.hp_bars_pos.x + self.hp_bars_size.x * (i - 1) + self.hp_bars_gap.x * (i - 1), 
      self.hp_bars_pos.y, 
      self.hp_bars_size.x, 
      self.hp_bars_size.y)
    if self.level.player.current_health_points >= i then
      love.graphics.rectangle('fill', 
        self.hp_bars_pos.x + self.hp_bars_size.x * (i - 1) + self.hp_bars_gap.x * (i - 1), 
        self.hp_bars_pos.y, 
        self.hp_bars_size.x, 
        self.hp_bars_size.y)
    end
  end
end
