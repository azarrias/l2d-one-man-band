Level = Class{}

function Level:init()
  self.world = love.physics.newWorld()
  self.player = Player(self)
  self.gui = GUI(self)
  
  -- music
  self.score = nil
  
  -- other physics entities
  self.edges = {}
  self.enemies = {}
  self.projectiles = {}
  
  -- bodies to be destroyed after the world update cycle; destroying these in the
  -- actual collision callbacks could cause stack overflow and other errors
  self.destroyedBodies = {}
  
  --[[ 
     Collision callbacks
     When called, each function will be passed three arguments:
     The two colliding fixtures and the contact between them
  ]]
  -- Gets called when two fixtures begin to overlap.
  function BeginContact(fixtureA, fixtureB, contact)
    local types = {}
    types[fixtureA:getUserData().objType] = true
    types[fixtureB:getUserData().objType] = true
    
    -- projectile collides with enemy
    if types['Projectile'] and types['Enemy'] then
      local projectile, enemy
      if fixtureA:getUserData().objType == 'Projectile' then
        projectile, enemy = fixtureA, fixtureB
      else
        projectile, enemy = fixtureB, fixtureA
      end
      
      -- destroy projectile and enemy, and disable contact to avoid physics response
      table.insert(self.destroyedBodies, projectile:getBody())
      table.insert(self.destroyedBodies, enemy:getBody())
      contact:setEnabled(false)
      
    elseif types['Player'] and types['Enemy'] then
      local player, enemy
      if fixtureA:getUserData().objType == 'Player' then
        player, enemy = fixtureA, fixtureB
      else
        player, enemy = fixtureB, fixtureA
      end
      
      player:getUserData():ReduceHP(1)
    end
  end
  
  -- Gets called when two fixtures cease to overlap. 
  -- This will also be called outside of a world update, when colliding 
  -- objects are destroyed.
  function EndContact(fixtureA, fixtureB, contact)
  end

  -- Gets called before a collision gets resolved.
  function PreSolve(fixtureA, fixtureB, contact)
  end

  -- Gets called after the collision has been resolved.
  function PostSolve(fixtureA, fixtureB, contact, normalImpulse, tangentImpulse)
  end

  self.world:setCallbacks(BeginContact, EndContact, PreSolve, PostSolve)
end

function Level:update(dt)
  self.score:update(dt)
  self.world:update(dt)

  for k, body in pairs(self.destroyedBodies) do
    if not body:isDestroyed() then
      body:destroy()
    end
  end

  -- iterate backwards for safe table removal
  for k = #self.projectiles, 1, -1 do
    self.projectiles[k]:update(dt)
    if self.projectiles[k].remove_flag then
      if not self.projectiles[k].body:isDestroyed() then
        self.projectiles[k].body:destroy()
      end
      table.remove(self.projectiles, k)
    end
  end
  
  for k = #self.enemies, 1, -1 do
    self.enemies[k]:update(dt)
    if self.enemies[k].remove_flag then
      table.remove(self.enemies, k)
    end
  end

  self.player:update(dt)
  self.gui:update(dt)
end

function Level:render()
  self.player:render()
  
  for k, enemy in pairs(self.enemies) do
    enemy:render()
  end
  
  for k, projectile in pairs(self.projectiles) do
    projectile:render()
  end
  
  self.gui:render()
end