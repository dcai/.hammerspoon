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

            local appPath = "/Applications/" .. app
            local launched = hs.application.launchOrFocus(appPath)
            log.i("Launch or focus " .. appPath, launched)

            local focusedWin = hs.window.focusedWindow()
            if not focusedWin then
                return
            end
            local nextScreen = focusedWin:screen()
            if prevScreen:name() ~= nextScreen:name() then
                log.i("move cursor to next screen", prevScreen:name() .. " => " .. nextScreen:name())
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

local key2app = {
    ["1"] = "Firefox.app",
    ["2"] = "Sublime Text.app",
    ["3"] = "iTerm.app",
    p = "Postman.app",
    d = "Discord.app",
    s = "Slack.app",
    m = "QQMusic.app",
    f = "Firefox.app",
    w = "Dictionary.app"
}

for key, app in pairs(key2app) do
    bindAppKey(key, app)
end

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
