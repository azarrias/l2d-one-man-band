--[[
    constants
  ]]
GAME_TITLE = 'On Another Note'
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
require 'Enemy'
require 'Level'
require 'Player'
require 'Projectile'
require 'SceneLevel1'
require 'util'

-- pixels resolution
WINDOW_SIZE = tiny.Vector2D(1280, 720)
--VIRTUAL_SIZE = tiny.Vector2D(384, 216)
VIRTUAL_SIZE = tiny.Vector2D(1280, 720)

PLAYER_SIZE = tiny.Vector2D(math.floor(VIRTUAL_SIZE.x / 50), math.floor(VIRTUAL_SIZE.x / 50))

-- resources
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
  ['roland-tr909-kick'] = love.audio.newSource('sounds/Reverb Roland TR-909 Sample Pack_Kick/Reverb Roland TR-909 Sample Pack_Kick Low Tone Max Attack Max Decay.wav', 'static'),
  ['roland-tr909-snare'] = love.audio.newSource('sounds/Reverb Roland TR-909 Sample Pack_Snare/Reverb Roland TR-909 Sample Pack_Snare Accent Mid Tuning Mid Tone Max Snap.wav', 'static')
}

require 'drum_sounds'