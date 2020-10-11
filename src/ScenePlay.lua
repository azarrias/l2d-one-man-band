ScenePlay = Class{__includes = tiny.Scene}

function ScenePlay:init()
  self.level = Level()
  
  -- bounds
  -- up
  local edge_pos = LEVEL_OFFSET
  local edge_size = tiny.Vector2D(VIRTUAL_SIZE.x - LEVEL_OFFSET.x, 0)
  local edge = Edge(self.level.world, edge_pos, edge_size)
  table.insert(self.level.edges, edge)
  -- left
  edge_size = tiny.Vector2D(0, VIRTUAL_SIZE.y - LEVEL_OFFSET.y)
  edge = Edge(self.level.world, edge_pos, edge_size)
  table.insert(self.level.edges, edge)
  -- right
  edge_pos = tiny.Vector2D(VIRTUAL_SIZE.x - LEVEL_OFFSET.x, LEVEL_OFFSET.y)
  edge = Edge(self.level.world, edge_pos, edge_size)
  table.insert(self.level.edges, edge)
  -- bottom
  edge_pos = tiny.Vector2D(0, VIRTUAL_SIZE.y)
  edge_size = tiny.Vector2D(VIRTUAL_SIZE.x - LEVEL_OFFSET.x, 0)
  edge = Edge(self.level.world, edge_pos, edge_size)
  table.insert(self.level.edges, edge)
  
  -- enemies
  for i = 1, 6, 1 do
    local enemy_pos = tiny.Vector2D(math.random(math.floor(ENEMY_SIZE.x / 2), math.floor(VIRTUAL_SIZE.x - ENEMY_SIZE.x / 2)), 
      math.random(math.floor(LEVEL_OFFSET.y + ENEMY_SIZE.y / 2), math.floor(VIRTUAL_SIZE.y - ENEMY_SIZE.y / 2)))
    local enemy = Enemy(self.level.world, enemy_pos)
    local force = tiny.Vector2D(math.random() * 150000 * (math.random(2) == 2 and 1 or -1), math.random() * 150000 * (math.random(2) == 2 and 1 or -1))
    enemy.body:applyForce(force.x, force.y)
    enemy.spin = math.random() * math.pi * (math.random(2) == 2 and 1 or -1)
    table.insert(self.level.enemies, enemy)
  end
 
  -- score
  -- each note will be a table composed by:
  -- beat, midi number (note), (TODO - add velocity and duration)
  -- the notes table must have all beats in ascending order
  --local score_segment = { { 1, 36 }, { 2, 36 }, { 2, 38 }, { 3, 36 }, { 4, 36 }, { 4, 38 } }
  local score_segment = { { 1, 36 }, { 2, 38 }, { 3, 36 }, { 4, 38 } }
  self.level.score = Score(self.level, {
    ['tempo'] = 100,
    ['notes'] = score_segment
  })
  -- this doubles note count every time
  self.level.score:AddNotes(score_segment)
  self.level.score:AddNotes(score_segment)
  self.level.score:AddNotes(score_segment)
  self.level.score:AddNotes(score_segment)
  self.level.score:AddNotes(score_segment)
  self.level.score:AddNotes(score_segment)
  self.level.score:AddNotes(score_segment)
end

function ScenePlay:enter(params)
  if params and params.current_health_points then
    self.level.player.current_health_points = params.current_health_points
  end
end

function ScenePlay:update(dt)
  self.level:update(dt)
end

function ScenePlay:render()
  self.level:render()
end
