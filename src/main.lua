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
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  -- Set up window
  push:setupScreen(VIRTUAL_SIZE.x, VIRTUAL_SIZE.y, WINDOW_SIZE.x, WINDOW_SIZE.y, {
    vsync = true,
    fullscreen = MOBILE_OS,
    resizable = not (MOBILE_OS or WEB_OS),
    stencil = not WEB_OS and true or false
  })
  love.window.setTitle(GAME_TITLE)
  
  love.graphics.setNewFont(20)
  fontHeight = love.graphics.getFont():getHeight()
  
  -- specify tempo in bpm
  tempo = 100
  beat_period = 60 / tempo
  timer = 0
  last_beat = 0
  current_beat = 0
  
  --[[
      MIDI note numbers
      -----------------
      A0 - 21, A#0 - 22, B0 - 23
      C1 - 24, C#1 - 25, D1 - 26, D#1 - 27, E1 - 28, F1 - 29, F#1 - 30, G1 - 31, G#1 - 32, A1 - 33, A#1 - 34, B1 - 35
      C2 - 36, C#2 - 37, D2 - 38, D#2 - 39, E2 - 40, F2 - 41, F#2 - 42, G2 - 43, G#2 - 44, A2 - 45, A#2 - 46, B2 - 47
      C3 - 48, C#3 - 49, D3 - 50, D#3 - 51, E3 - 52, F3 - 53, F#3 - 54, G3 - 55, G#3 - 56, A3 - 57, A#3 - 58, B3 - 59
      C4 - 60, C#4 - 61, D4 - 62, D#4 - 63, E4 - 64, F4 - 65, F#4 - 66, G4 - 67, G#4 - 68, A4 - 69, A#4 - 70, B4 - 71
      C5 - 72, C#5 - 73, D5 - 74, D#5 - 75, E5 - 76, F5 - 77, F#5 - 78, G5 - 79, G#5 - 80, A5 - 81, A#5 - 82, B5 - 83
      C6 - 84, C#6 - 85, D6 - 86, D#6 - 87, E6 - 88, F6 - 89, F#6 - 90, G6 - 91, G#6 - 92, A6 - 93, A#6 - 94, B6 - 95
      C7 - 96, C#7 - 97, D7 - 98, D#7 - 99, E7 - 100, F7 - 101, F#7 - 102, G7 - 103, G#7 - 104, A7 - 105, A#7 - 106, B7 - 107
      C8 - 108
      
      Drum assignment
      ---------------
      Kick Drum 1 - 35
      Kick Drum 2 - 36
      Side Stick / Rim - 37
      Snare Drum 1 - 38
      Hand Clap - 39
      Snare Drum 2 - 40
      Low Tom 2 - 41
      Close Hi-hat - 42
      Low Tom 1 - 43
      Pedal Hi-hat - 44
      Mid Tom 2 - 45
      Open Hi-hat - 46
      Mid Tom 1 - 47
      High Tom 2 - 48
      Crash Cymbal 1 - 49
      High Tom 1 - 50
      Ride Cymbal - 51
      Chinese Cymbal - 52
      Ride Cymbal Bell - 53
      Tambourine - 54
      Splash Cymbal - 55
      Cowbell - 56
      Crash Cymbal 2 - 57
      Vibra-slap - 58
      Ride Cymbal 2 - 59
  ]]
      
  -- each note will be a table composed by:
  -- beat, midi number (note), (TODO - add velocity and duration)
  -- the notes table must have all beats in ascending order
  score = {
    ['notes'] = { { 1, 36 }, { 2, 36 }, { 2, 38 }, { 3, 36 }, { 4, 36 }, { 4, 38 } }
  }
  
  love.keyboard.keysPressed = {}
  love.mouse.buttonPressed = {}
  love.mouse.buttonReleased = {}
end

function love.update(dt)
  -- exit if esc is pressed
  if love.keyboard.keysPressed['escape'] then
    love.event.quit()
  end
  
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
  
  -- play score
  timer = timer + dt
  for key, note in ipairs(score['notes']) do
    beat, midi_num = unpack(note)
    if beat > last_beat then
      if timer > beat * beat_period then
        if midi_num == 36 then
          love.audio.play(DRUM_SOUNDS['1'])
        elseif midi_num == 38 then
          love.audio.play(DRUM_SOUNDS['2'])
        end
        current_beat = beat
      else
        break
      end
    end
  end
  if current_beat > last_beat then
    last_beat = current_beat
  end
    
  --[[
  if timer > beat_period then
    love.audio.play(DRUM_SOUNDS['1'])
  end
  if timer > beat_period * 2 then
    love.audio.play(DRUM_SOUNDS['2'])
    timer = timer % beat_period
  end
  ]]
  
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
  love.graphics.printf("Hello world!", 0, VIRTUAL_SIZE.y / 2 - fontHeight / 2, VIRTUAL_SIZE.x, 'center')
  push:finish()
end