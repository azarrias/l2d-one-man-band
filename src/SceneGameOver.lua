SceneGameOver = Class{__includes = tiny.Scene}

function SceneGameOver:init()
  self.text = {
    { string = 'You lose...', font = FONTS['retro-l'], textColor = {89 / 255, 9 / 255, 149 / 255} },
    { string = '\nPress space bar to play again', font = FONTS['retro-s'], textColor = {225 / 255, 225 / 255, 225 / 255} },
    { string = '\nESC to quit', font = FONTS['retro-s'], textColor = {225 / 255, 225 / 255, 225 / 255}  }
  }
end

function SceneGameOver:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    sceneManager:change('play')
  end
end

function SceneGameOver:render()
  RenderCenteredText(self.text)
end