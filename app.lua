
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
bindAppKey("1", "Google Chrome.app")
bindAppKey("2", "Sublime Text.app")
bindAppKey("3", "iTerm.app")
bindAppKey("p", "Postman.app")
bindAppKey("6", "VLC.app")
bindAppKey("0", "Emacs.app")
bindAppKey("s", "Slack.app")
bindAppKey("o", "Emacs.app")
bindAppKey("m", "QQMusic.app")
bindAppKey("v", "MacVim.app")
bindAppKey("t", "Microsoft Teams.app")
bindAppKey("-", "Firefox.app")
bindAppKey("\\", "Dictionary.app")
