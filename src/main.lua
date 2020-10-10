require 'globals'

function love.load()
  if DEBUG_MODE then
    if arg[#arg] == "-debug" then 
      require("mobdebug").start() 
    end
    io.stdout:setvbuf("no")
  end
  
  math.randomseed(os.time())

  -- use nearest-neighbor (point) filtering on upscaling and downscaling to prevent blurring of text and 
  -- graphics instead of the bilinear filter that is applied by default 
  --love.graphics.setDefaultFilter('nearest', 'nearest')
  
  -- Set up window
  push:setupScreen(VIRTUAL_SIZE.x, VIRTUAL_SIZE.y, WINDOW_SIZE.x, WINDOW_SIZE.y, {
    vsync = true,
    fullscreen = MOBILE_OS,
    resizable = not (MOBILE_OS or WEB_OS),
    stencil = not WEB_OS and true or false
  })
  love.window.setTitle(GAME_TITLE)
  
  -- set volume for sound fxs
  SOUNDS['hit-enemy']:setVolume(0.05)
  SOUNDS['hit-player']:setVolume(0.05)
  
  scenes = {
    ['game-over'] = function() return SceneGameOver() end,
    ['play'] = function() return ScenePlay() end,
    ['level-clear'] = function() return SceneLevelClear() end,
    ['start'] = function() return SceneStart() end
  }
  sceneManager = tiny.SceneManager(scenes)
  sceneManager:change('start')
  
  love.keyboard.keysPressed = {}
  love.mouse.buttonPressed = {}
  love.mouse.buttonReleased = {}
end

function love.update(dt)
  -- exit if esc is pressed
  if love.keyboard.keysPressed['escape'] then
    love.event.quit()
  end
  
  sceneManager:update(dt)
  
  -- for later removal - just for testing samples
  if love.keyboard.keysPressed['1'] then
    love.audio.play(DRUM_SOUNDS['1'])
  end
  if love.keyboard.keysPressed['2'] then
    love.audio.play(DRUM_SOUNDS['2'])
  end    
  if love.keyboard.keysPressed['3'] then
    love.audio.play(DRUM_SOUNDS['3'])
  end    
  if love.keyboard.keysPressed['4'] then
    love.audio.play(DRUM_SOUNDS['4'])
  end    
  if love.keyboard.keysPressed['5'] then
    love.audio.play(DRUM_SOUNDS['5'])
  end    
  if love.keyboard.keysPressed['6'] then
    love.audio.play(DRUM_SOUNDS['6'])
  end    
  if love.keyboard.keysPressed['7'] then
    love.audio.play(DRUM_SOUNDS['7'])
  end    
  if love.keyboard.keysPressed['8'] then
    love.audio.play(DRUM_SOUNDS['8'])
  end    
  if love.keyboard.keysPressed['9'] then
    love.audio.play(DRUM_SOUNDS['9'])
  end    
  if love.keyboard.keysPressed['0'] then
    love.audio.play(DRUM_SOUNDS['0'])
  end    
  
  love.keyboard.keysPressed = {}
  love.mouse.buttonPressed = {}
  love.mouse.buttonReleased = {}
end

function love.resize(w, h)
  push:resize(w, h)
end
  
-- Callback that processes key strokes just once
-- Does not account for keys being held down
function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.mousepressed(x, y, button)
  love.mouse.buttonPressed[button] = true
end

function love.mousereleased(x, y, button)
  love.mouse.buttonReleased[button] = true
end

function love.draw()
  push:start()
  sceneManager:render()
  push:finish()
end