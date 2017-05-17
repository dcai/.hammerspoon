
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
-- lock screen
hs.hotkey.bind({"cmd"}, "escape", function()
    if hostName == 'dsmbp15' then
        hs.caffeinate.lockScreen()
    else
        hs.caffeinate.startScreensaver()
    end
end)


bindAppKey("`", "iTerm.app")
bindAppKey("-", "Firefox.app")
bindAppKey("1", "Google Chrome.app")
bindAppKey("2", "Sublime Text.app")
bindAppKey("3", "Calendar.app")
bindAppKey("4", "NeteaseMusic.app")
bindAppKey("6", "VLC.app")
bindAppKey("s", "Slack.app")
bindAppKey("o", "Emacs.app")
bindAppKey("\\", "Dictionary.app")
