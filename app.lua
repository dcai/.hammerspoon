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
            local defaultScreenName = "un-named screen"
            local prevScreenName = defaultScreenName
            local prevFocusedWin = hs.window.focusedWindow()
            if prevFocusedWin then
                local prevScreen = prevFocusedWin:screen()
                if prevScreen then
                    prevScreenName = prevScreen:name() or defaultScreenName
                end
            end

            local launched = hs.application.launchOrFocus(app)
            log.i(string.format("%s %s", app, launched and "found" or "not found"))
            if not launched then
                return
            end

            local nextFocusedWin = hs.window.focusedWindow()
            if not nextFocusedWin then
                return
            end
            local nextScreen = nextFocusedWin:screen()
            local nextScreenName = defaultScreenName
            if nextScreen then
                nextScreenName = nextScreen:name() or defaultScreenName
            end
            if prevScreenName ~= nextScreenName then
                log.i(string.format("Moving cursor to next screen: %s => %s", prevScreenName, nextScreenName))
                local frame = nextFocusedWin:frame()
                local rect = frame:rect()
                local center = hs.geometry.rectMidPoint(rect)
                hs.mouse.setAbsolutePosition(center)
            else
                log.i("Switched to an app on the same screen, cursor stays")
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
    ["1"] = "Firefox",
    ["2"] = "Sublime Text",
    ["3"] = "iTerm",
    ["."] = "Dictionary",
    ["\\"] = "Dictionary",
    ["return"] = "Postman",
    d = "Discord",
    s = "Slack",
    w = "WeChat",
    f = "Firefox"
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
            if (appName == "Finder" or appName == "Slack" or appName == "Sublime Text") then
                -- Bring all Finder windows forward when one gets activated
                appObject:selectMenuItem({"Window", "Bring All to Front"})
            end
        end
    end
)

appFinderWatcher:start()
