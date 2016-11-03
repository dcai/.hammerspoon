
-- App vars
local chrome    = hs.appfinder.appFromName("Google Chrome")
local iterm     = hs.appfinder.appFromName("iTerm2")
local subl      = hs.appfinder.appFromName("Sublime Text")
local finder    = hs.appfinder.appFromName("Finder")
local mail      = hs.appfinder.appFromName("Mail")
local macvim    = hs.appfinder.appFromName("/Applications/MacVim.app")

-- lock screen
hs.hotkey.bind({"cmd"}, "escape", function()
  -- hs.caffeinate.lockScreen()
  hs.caffeinate.startScreensaver()
end)

--
-- Application launcher
--

-- finder
hs.hotkey.bind({"cmd"}, "e", function()
  hs.application.launchOrFocus("Finder")
end)

hs.hotkey.bind(keyApp, "escape", function()
  --hs.application.launchOrFocus("/Applications/MacVim.app")
  hs.application.launchOrFocus("/Applications/iTerm.app")
end)
hs.hotkey.bind(keyApp, "`", function()
  hs.application.launchOrFocus("/Applications/iTerm.app")
end)
hs.hotkey.bind(keyApp, "0", function()
  hs.application.launchOrFocus("/Applications/WeChat.app")
end)
hs.hotkey.bind(keyApp, "1", function()
  hs.application.launchOrFocus("/Applications/Google Chrome.app")
end)
hs.hotkey.bind(keyApp, "2", function()
  hs.application.launchOrFocus("/Applications/TextWrangler.app")
end)
hs.hotkey.bind(keyApp, "3", function()
  hs.application.launchOrFocus("/Applications/Calendar.app")
end)
hs.hotkey.bind(keyApp, "\\", function()
  hs.application.launchOrFocus("/Applications/Dictionary.app")
end)

hs.hotkey.bind(keyApp, "/", function()
  hs.application.launchOrFocus("/Applications/VOX.app")
end)
hs.hotkey.bind(keyApp, "5", function()
  hs.application.launchOrFocus("/Applications/Slack.app")
end)
