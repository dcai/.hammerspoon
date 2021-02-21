require "lib"
-- local screen = hs.screen.mainScreen()

hs.alert.defaultStyle.fillColor = {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius = 10
hs.alert.defaultStyle.textColor = {white = 1, alpha = 0.7}
hs.alert.defaultStyle.textFont = "Menlo"
hs.alert.defaultStyle.textSize = 52
hs.window.animationDuration = 0

logName = "###########"
log = hs.logger.new(logName, "debug")
log.i("Begin hammerspoon init " .. logName)

keyApp = {"shift", "ctrl"}
keyGrid = {"cmd", "ctrl"}
keyWindow = {"ctrl", "alt"}
keyGlobal = {"cmd", "ctrl", "alt"}

hostName = hs.host.localizedName()

positions = {
    left25 = hs.layout.left25,
    left30 = hs.layout.left30,
    left50 = hs.layout.left50,
    left70 = hs.layout.left70,
    left75 = hs.layout.left75,
    maximized = hs.layout.maximized,
    right25 = hs.layout.right25,
    right30 = hs.layout.right30,
    right50 = hs.layout.right50,
    right70 = hs.layout.right70,
    right75 = hs.layout.right75,
    centered80 = {x = 0.05, y = 0.1, w = 0.9, h = 0.8},
    centered = {x = 0.05, y = 0.2, w = 0.9, h = 0.6},
    large = {x = 0.01, y = 0.02, w = 0.98, h = 0.96},
    upper30 = {x = 0, y = 0, w = 1, h = 0.3},
    upper40 = {x = 0, y = 0, w = 1, h = 0.4},
    upper50 = {x = 0, y = 0, w = 1, h = 0.5},
    upper66 = {x = 0, y = 0, w = 1, h = 0.66},
    upper50Left50 = {x = 0, y = 0, w = 0.5, h = 0.5},
    upper50Right15 = {x = 0.85, y = 0, w = 0.15, h = 0.5},
    upper50Right30 = {x = 0.7, y = 0, w = 0.3, h = 0.5},
    upper50Right50 = {x = 0.5, y = 0, w = 0.5, h = 0.5},
    lower30 = {x = 0, y = 0.7, w = 1, h = 0.3},
    lower40 = {x = 0, y = 0.6, w = 1, h = 0.4},
    lower50 = {x = 0, y = 0.5, w = 1, h = 0.5},
    lower60 = {x = 0, y = 0.4, w = 1, h = 0.6},
    lower70 = {x = 0, y = 0.3, w = 1, h = 0.7},
    lower50Left50 = {x = 0, y = 0.5, w = 0.5, h = 0.5},
    lower50Right50 = {x = 0.5, y = 0.5, w = 0.5, h = 0.5},
    chat = {x = 0.2, y = 0.6, w = 0.6, h = 0.3}
}

local hammerspoonHome = os.getenv("HOME") .. "/.hammerspoon/"
-- must assign to local variable
configWatcher = hs.pathwatcher.new(hammerspoonHome, reloadConfig):start()

require "app"
require "caffeine"
require "anycomplete"
require "grid"
require "layout"
-- require "window"
-- require "battery"

bindGlobalKey("r", reloadConfig)
bindGlobalKey("t", showDateAndTime)

hs.alert.show("hammerspoon loaded on " .. hostName)
