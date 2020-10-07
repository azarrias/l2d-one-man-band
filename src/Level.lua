Level = Class{}

function Level:init()
  self.world = love.physics.newWorld()
  self.player = Player(self)
  
  -- enemies
  self.enemies = {}

  -- projectiles
  self.projectiles = {}
end

function Level:update(dt)
  self.world:update(dt)

  for k, projectile in pairs(self.projectiles) do
    if projectile.remove_flag then
      table.remove(self.projectiles, k)
    end
  end

  for k, projectile in pairs(self.projectiles) do
    projectile:update(dt)
  end

  self.player:update(dt)
end

function Level:render()
  self.player:render()
  
  for k, enemy in pairs(self.enemies) do
    enemy:render()
  end
  
  for k, projectile in pairs(self.projectiles) do
    projectile:render()
  end
end