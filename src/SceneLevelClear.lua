SceneLevelClear = Class{__includes = tiny.Scene}

function SceneLevelClear:init()
  self.text = {
    { string = 'Level clear!', font = FONTS['coolvetica-m'], textColor = {53 / 255, 175 / 255, 42 / 255} },
    { string = '\nPress space bar to continue', font = FONTS['coolvetica-s'], textColor = {200 / 255, 225 / 255, 220 / 255} },
    { string = '\nESC to quit', font = FONTS['coolvetica-s'], textColor = {200 / 255, 225 / 255, 220 / 255}  }
  }
  self.player_current_health_points = nil
end

function SceneLevelClear:enter(params)
  self.player_current_health_points = params.current_health_points
end

function SceneLevelClear:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    sceneManager:change('play', { current_health_points = self.player_current_health_points })
  end
end

function SceneLevelClear:render()
  RenderCenteredText(self.text)
end