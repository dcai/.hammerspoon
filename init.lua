require "lib"

hs.alert.defaultStyle.fillColor = {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius = 10
hs.alert.defaultStyle.textColor = {white = 1, alpha = 0.7}
hs.alert.defaultStyle.textFont = "Menlo"
hs.alert.defaultStyle.textSize = 52
hs.window.animationDuration = 0

logName = "###########"
log = hs.logger.new(logName, "debug")
log.i("Begin hammerspoon init " .. logName)

hostName = hs.host.localizedName()

hammerspoonHome = os.getenv("HOME") .. "/.hammerspoon/"
-- must assign to a variable to avoid gc
configWatcher = hs.pathwatcher.new(hammerspoonHome, reloadConfig):start()

require "app"
require "anycomplete"
require "grid"
require "layout"
require "window"
require "spoons"
-- require "caffeine"
-- require "battery"

bindGlobalKey("r", reloadConfig)
bindGlobalKey("t", showDateAndTime)
-- bindGlobalKey("u", askUnmount)

local msgReload = "hammerspoon loaded on " .. hostName
-- this causes LuaSkin error in console
hs.alert.show(msgReload)
-- hs.notify.show("Hammerspoon", hostName, msgReload)
