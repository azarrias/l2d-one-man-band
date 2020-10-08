SceneLevel1 = Class{__includes = tiny.Scene}

function SceneLevel1:init()
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
  local enemy_pos = (VIRTUAL_SIZE - LEVEL_OFFSET) * 0.75
  enemy_pos = enemy_pos:Floor() + LEVEL_OFFSET
  local enemy = Enemy(self.level.world, enemy_pos)
  table.insert(self.level.enemies, enemy)
 
  -- score
  -- each note will be a table composed by:
  -- beat, midi number (note), (TODO - add velocity and duration)
  -- the notes table must have all beats in ascending order
  local score_segment = { { 1, 36 }, { 2, 36 }, { 2, 38 }, { 3, 36 }, { 4, 36 }, { 4, 38 } }
  self.level.score = Score(self.level, {
    ['tempo'] = 110,
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
 
function SceneLevel1:update(dt)
  self.level:update(dt)
end

function SceneLevel1:render()
  self.level:render()
end
