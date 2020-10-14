--[[
    constants
  ]]
GAME_TITLE = 'Suicide Note'
DEBUG_MODE = true

-- OS checks in order to make necessary adjustments to support multiplatform
MOBILE_OS = (love._version_major > 0 or love._version_minor >= 9) and (love.system.getOS() == 'Android' or love.system.getOS() == 'OS X')
WEB_OS = (love._version_major > 0 or love._version_minor >= 9) and love.system.getOS() == 'Web'

-- libraries
Class = require 'libs.class'
push = require 'libs.push'
require 'libs.slam'
tiny = require 'libs.tiny'

-- general purpose / utility
require 'Edge'
require 'Enemy'
require 'GUI'
require 'Level'
require 'Player'
require 'Projectile'
require 'SceneGameOver'
require 'ScenePlay'
require 'SceneLevelClear'
require 'SceneStart'
require 'Score'
require 'util'

-- pixels resolution
local width, height = love.window.getDesktopDimensions(1)
print (width)
print (height)
--WINDOW_SIZE = tiny.Vector2D(width, height)
--VIRTUAL_SIZE = tiny.Vector2D(width, height)
WINDOW_SIZE = tiny.Vector2D(width, height)
VIRTUAL_SIZE = tiny.Vector2D(1280, 720)
--VIRTUAL_SIZE = tiny.Vector2D(384, 216)

PLAYER_SIZE = tiny.Vector2D(math.floor(VIRTUAL_SIZE.x / 50), math.floor(VIRTUAL_SIZE.x / 50))
ENEMY_SIZE = tiny.Vector2D(math.floor(VIRTUAL_SIZE.x / 25), math.floor(VIRTUAL_SIZE.x / 25))
LEVEL_OFFSET = tiny.Vector2D(0, math.floor(VIRTUAL_SIZE.y / 10))

-- resources
FONTS = {
  ['coolvetica-xxl'] = love.graphics.newFont('fonts/coolvetica rg.ttf', 128),
  ['coolvetica-xl'] = love.graphics.newFont('fonts/coolvetica rg.ttf', 96),
  ['coolvetica-l'] = love.graphics.newFont('fonts/coolvetica rg.ttf', 64),
  ['coolvetica-m'] = love.graphics.newFont('fonts/coolvetica rg.ttf', 48),
  ['coolvetica-s'] = love.graphics.newFont('fonts/coolvetica rg.ttf', 32),
  ['music-xxl'] = love.graphics.newFont('fonts/European Jazz American Music.ttf', 128),
  ['music-xl'] = love.graphics.newFont('fonts/European Jazz American Music.ttf', 96),
  ['music-l'] = love.graphics.newFont('fonts/European Jazz American Music.ttf', 64),
  ['music-m'] = love.graphics.newFont('fonts/European Jazz American Music.ttf', 48),
  ['music-s'] = love.graphics.newFont('fonts/European Jazz American Music.ttf', 32),
  ['retro-xxl'] = love.graphics.newFont('fonts/retro.ttf', 128),
  ['retro-xl'] = love.graphics.newFont('fonts/retro.ttf', 96),
  ['retro-l'] = love.graphics.newFont('fonts/retro.ttf', 64),
  ['retro-m'] = love.graphics.newFont('fonts/retro.ttf', 48),
  ['retro-s'] = love.graphics.newFont('fonts/retro.ttf', 32)
}
  
SOUNDS = {
  ['boss-drpad-block'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Block.wav', 'static'),
  ['boss-drpad-chime-long'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Chime-Long.wav', 'static'),
  ['boss-drpad-chime-short'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Chime-Short.wav', 'static'),
  ['boss-drpad-gong-long'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Gong-Long.wav', 'static'),
  ['boss-drpad-gong-medium'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Gong-Medium.wav', 'static'),
  ['boss-drpad-gong-short'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Gong-Short.wav', 'static'),
  ['boss-drpad-kick'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Kick.wav', 'static'),
  ['boss-drpad-snare'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Snare.wav', 'static'),
  ['boss-drpad-steel-drum'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Steel Drum.wav', 'static'),
  ['boss-drpad-tom'] = love.audio.newSource('sounds/Reverb Boss Dr Pad Sample Pack_Tom.wav', 'static'),
  ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav', 'static'),
  ['hit-player'] = love.audio.newSource('sounds/hit_player.wav', 'static'),
  ['roland-tr909-kick'] = love.audio.newSource('sounds/Reverb Roland TR-909 Sample Pack_Kick/Reverb Roland TR-909 Sample Pack_Kick Low Tone Max Attack Max Decay.wav', 'static'),
  ['roland-tr909-snare'] = love.audio.newSource('sounds/Reverb Roland TR-909 Sample Pack_Snare/Reverb Roland TR-909 Sample Pack_Snare Accent Mid Tuning Mid Tone Max Snap.wav', 'static')
}

require 'drum_sounds'