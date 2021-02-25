-- App vars
local chrome = hs.appfinder.appFromName("Google Chrome")
local iterm = hs.appfinder.appFromName("iTerm2")
local subl = hs.appfinder.appFromName("Sublime Text")
local finder = hs.appfinder.appFromName("Finder")
local mail = hs.appfinder.appFromName("Mail")
local macvim = hs.appfinder.appFromName("/Applications/MacVim.app")

function bindAppKey(modifier, app)
    hs.hotkey.bind(
        keyApp,
        modifier,
        function()
            local prevScreen = hs.window.focusedWindow():screen()

            hs.application.launchOrFocus("/Applications/" .. app)
            local focusedWin = hs.window.focusedWindow()
            if not focusedWin then
                return
            end
            local nextScreen = focusedWin:screen()
            if prevScreen:name() == nextScreen:name() then
            else
                local frame = focusedWin:frame()
                local rect = frame:rect()
                local center = hs.geometry.rectMidPoint(rect)
                hs.mouse.setAbsolutePosition(center)
            end
        end
    )
end

--
-- Application launcher
--

-- finder
hs.hotkey.bind(
    {"cmd"},
    "e",
    function()
        hs.application.launchOrFocus("Finder")
    end
)
-- bindAppKey("1", "Google Chrome.app")
-- bindAppKey("1", "Safari.app")
bindAppKey("1", "Firefox.app")
bindAppKey("2", "Sublime Text.app")
bindAppKey("3", "iTerm.app")
bindAppKey("p", "Postman.app")
bindAppKey("d", "Discord.app")
bindAppKey("6", "VLC.app")
bindAppKey("s", "Slack.app")
bindAppKey("m", "QQMusic.app")
bindAppKey("f", "Firefox.app")
bindAppKey("\\", "Dictionary.app")

-- -- move mouse to current app area
-- local hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}
-- hs.hotkey.bind(hyperShift, '`', function()
--     local screen = hs.mouse.getCurrentScreen()
--     local nextScreen = screen:next()
--     local rect = nextScreen:fullFrame()
--     local center = hs.geometry.rectMidPoint(rect)hs.mouse.setAbsolutePosition(center)
-- end)
appFinderWatcher =
    hs.application.watcher.new(
    function(appName, eventType, appObject)
        if (eventType == hs.application.watcher.activated) then
            if (appName == "Finder" or appName == "Slack") then
                -- Bring all Finder windows forward when one gets activated
                appObject:selectMenuItem({"Window", "Bring All to Front"})
            end
        end
    end
)

appFinderWatcher:start()
