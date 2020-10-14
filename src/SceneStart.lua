SceneStart = Class{__includes = tiny.Scene}

function SceneStart:init()
  self.text = {
    { string = GAME_TITLE, font = FONTS['music-xxl'], textColor = {255 / 255, 5 / 255, 5 / 255} },
    { string = '\nPress space bar to start', font = FONTS['coolvetica-s'], textColor = {225 / 255, 225 / 255, 225 / 255} },
    { string = '\nESC to quit', font = FONTS['coolvetica-s'], textColor = {225 / 255, 225 / 255, 225 / 255}  }
  }
end

function SceneStart:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    sceneManager:change('play')
  end
end

function SceneStart:render()
  RenderCenteredText(self.text)
end