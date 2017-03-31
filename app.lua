
-- App vars
local chrome    = hs.appfinder.appFromName("Google Chrome")
local iterm     = hs.appfinder.appFromName("iTerm2")
local subl      = hs.appfinder.appFromName("Sublime Text")
local finder    = hs.appfinder.appFromName("Finder")
local mail      = hs.appfinder.appFromName("Mail")
local macvim    = hs.appfinder.appFromName("/Applications/MacVim.app")

function bindAppKey(modifier, app)
    hs.hotkey.bind(keyApp, modifier, function()
        hs.application.launchOrFocus(app)
    end)
end

--
-- Application launcher
--

-- finder
hs.hotkey.bind({"cmd"}, "e", function()
  hs.application.launchOrFocus("Finder")
end)
-- lock screen
hs.hotkey.bind({"cmd"}, "escape", function()
  hs.caffeinate.lockScreen()
  hs.caffeinate.startScreensaver()
end)


bindAppKey("`", "/Applications/iTerm.app")
bindAppKey("-", "/Applications/Firefox.app")
bindAppKey("1", "/Applications/Google Chrome.app")
bindAppKey("2", "/Applications/TextWrangler.app")
bindAppKey("3", "/Applications/Calendar.app")
bindAppKey("4", "/Applications/NeteaseMusic.app")
bindAppKey("6", "/Applications/VLC.app")
bindAppKey("s", "/Applications/Slack.app")
bindAppKey("\\", "/Applications/Dictionary.app")
