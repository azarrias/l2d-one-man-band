SceneLevelClear = Class{__includes = tiny.Scene}

function SceneLevelClear:init()
  self.text = {
    { string = 'Level clear!', font = FONTS['coolvetica-m'], textColor = {53 / 255, 175 / 255, 42 / 255} },
    { string = '\nPress space bar to continue', font = FONTS['coolvetica-s'], textColor = {200 / 255, 225 / 255, 220 / 255} },
    { string = '\nESC to quit', font = FONTS['coolvetica-s'], textColor = {200 / 255, 225 / 255, 220 / 255}  }
  }
end

function SceneLevelClear:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    sceneManager:change('play')
  end
end

function SceneLevelClear:render()
  RenderCenteredText(self.text)
end