GUI = Class{}

function GUI:init(level)
  self.level = level
  
  -- health icon
  self.border = 2
  self.health_icon_height = LEVEL_OFFSET.y / 2
  local health_icon_offset = tiny.Vector2D(LEVEL_OFFSET.y / 3, 0)
  self.health_icon_pos = tiny.Vector2D(LEVEL_OFFSET.y / 2 - self.health_icon_height / 2 + health_icon_offset.x, LEVEL_OFFSET.y / 2 - self.health_icon_height / 2 + health_icon_offset.y):Floor()
  self.health_icon_thickness = self.health_icon_height / 3
  
  -- health bar
  local hp_bars_offset = tiny.Vector2D(15, 8)
  self.hp_bars_pos = self.health_icon_pos + tiny.Vector2D(self.health_icon_height, 0) + hp_bars_offset
  self.hp_bars_size = tiny.Vector2D(math.floor(self.health_icon_thickness * 0.75), self.health_icon_height - hp_bars_offset.y)
  self.hp_bars_gap_x = 10
  
  -- sheet music lines
  self.lines_gap_y = 15
  self.note_radius = math.floor(self.lines_gap_y * 0.6)
  self.note_pos_x_multiplier = 200
  self.lines_pos_a = tiny.Vector2D(VIRTUAL_SIZE.x * 0.4, LEVEL_OFFSET.y / 2 - self.lines_gap_y / 2):Floor()
  self.lines_pos_b = tiny.Vector2D(VIRTUAL_SIZE.x - self.health_icon_pos.x, LEVEL_OFFSET.y / 2 - self.lines_gap_y / 2):Floor()
  self.vertical_bar_pos = tiny.Vector2D(math.floor(self.lines_pos_a.x + (self.lines_pos_b.x - self.lines_pos_a.x) / 3), self.lines_pos_a.y - self.lines_gap_y)
end

function GUI:update(dt)
end

function GUI:render()
  -- background
  love.graphics.setColor(17 / 255, 3 / 255, 106 / 255)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_SIZE.x, LEVEL_OFFSET.y)
  
  -- frame
  --love.graphics.setColor(0.2, 0, 0)
  --love.graphics.setLineWidth(self.border * 2)
  --love.graphics.rectangle('line', self.border, self.border, VIRTUAL_SIZE.x - self.border * 2, LEVEL_OFFSET.y - self.border * 2)
  
  -- health cross
  love.graphics.setColor(198 / 255, 42 / 255, 136 / 255)
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
      self.hp_bars_pos.x + self.hp_bars_size.x * (i - 1) + self.hp_bars_gap_x * (i - 1), 
      self.hp_bars_pos.y, 
      self.hp_bars_size.x, 
      self.hp_bars_size.y)
    if self.level.player.current_health_points >= i then
      love.graphics.rectangle('fill', 
        self.hp_bars_pos.x + self.hp_bars_size.x * (i - 1) + self.hp_bars_gap_x * (i - 1), 
        self.hp_bars_pos.y, 
        self.hp_bars_size.x, 
        self.hp_bars_size.y)
    end
  end
  
  -- sheet music
  love.graphics.setColor(0.6, 0.6, 0.6)
  love.graphics.line(self.lines_pos_a.x, self.lines_pos_a.y, self.lines_pos_b.x, self.lines_pos_b.y)
  love.graphics.line(self.lines_pos_a.x, self.lines_pos_a.y + self.lines_gap_y, self.lines_pos_b.x, self.lines_pos_b.y + self.lines_gap_y)
  love.graphics.setColor(3 / 255, 196 / 255, 161 / 255)
  love.graphics.line(self.vertical_bar_pos.x, self.vertical_bar_pos.y, self.vertical_bar_pos.x, self.vertical_bar_pos.y + self.lines_gap_y * 3)

  -- sheet music notes
  love.graphics.setColor(0.95, 0.95, 0.95)
  for k, note in ipairs(self.level.score.notes) do
    local beat, midi_num = unpack(note)
    local position_x = (beat * self.level.score.beat_period - self.level.score.timer) * self.note_pos_x_multiplier + self.vertical_bar_pos.x
    local position_y = nil
    if midi_num == 36 then
      position_y = self.lines_pos_b.y + self.lines_gap_y
    elseif midi_num == 38 then
      position_y = self.lines_pos_b.y
    end
    if position_x > self.lines_pos_a.x + self.note_radius then
      if position_x < self.lines_pos_b.x then
        --love.graphics.circle('line', position_x, position_y, self.note_radius)
        love.graphics.ellipse('line', position_x, position_y, self.note_radius, self.note_radius * 0.8)
      else
        break
      end
    end
  end
end
