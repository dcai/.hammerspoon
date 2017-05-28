
-- App vars
local chrome    = hs.appfinder.appFromName("Google Chrome")
local iterm     = hs.appfinder.appFromName("iTerm2")
local subl      = hs.appfinder.appFromName("Sublime Text")
local finder    = hs.appfinder.appFromName("Finder")
local mail      = hs.appfinder.appFromName("Mail")
local macvim    = hs.appfinder.appFromName("/Applications/MacVim.app")

--
-- Application launcher
--

-- finder
hs.hotkey.bind({"cmd"}, "e", function()
  hs.application.launchOrFocus("Finder")
end)
bindAppKey("`", "iTerm.app")
if hostName == workLaptopName then
    bindAppKey("1", "Google Chrome.app")
else
    bindAppKey("1", "Safari.app")
end
bindAppKey("2", "Sublime Text.app")
bindAppKey("3", "Calendar.app")
bindAppKey("4", "NeteaseMusic.app")
bindAppKey("6", "VLC.app")
bindAppKey("s", "Slack.app")
bindAppKey("o", "Emacs.app")
bindAppKey("-", "Opera.app")
bindAppKey("\\", "Dictionary.app")
