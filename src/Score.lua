Score = Class{}

function Score:init(level, data)
  self.level = level
  self.notes = data['notes']
  -- specify tempo in bpm  
  self.tempo = data['tempo']
  self.beat_period = 60 / self.tempo
  self.timer = 0
  self.last_beat = 0
  self.current_beat = 0
end

function Score:update(dt)
  -- play score
  self.timer = self.timer + dt
  for j, note in ipairs(self.notes) do
    local beat, midi_num = unpack(note)
    if beat > self.last_beat then
      if self.timer > beat * self.beat_period then
        if midi_num == 36 then
          self.level.player:Dash()
          love.audio.play(DRUM_SOUNDS['1'])
        elseif midi_num == 38 then
          self.level.player:Shoot()
          love.audio.play(DRUM_SOUNDS['2'])
        end
        self.current_beat = beat
      else
        break
      end
      -- loop
      --[[
      if j == #self.notes then
        self.last_beat = 0
        self.current_beat = 0
        self.timer = self.timer % self.beat_period
      end]]
    end
  end
  if self.current_beat > self.last_beat then
    self.last_beat = self.current_beat
  end
end

function Score:AddNotes(notes)
  local last_beat = self.notes[#self.notes][1]
  local new_notes = {}
  for k, note in ipairs(notes) do
    local new_note = {}
    new_note[1] = note[1] + last_beat
    for i = 2, #note, 1 do
      table.insert(new_note, note[i])
    end
    table.insert(new_notes, new_note)
  end
  for k, note in ipairs(new_notes) do
    table.insert(self.notes, note)
  end
end

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