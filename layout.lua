--
-- Layouts
--
local screenAsusVs247 = "ASUS VS239"
local screenWork = "VE248"
local screenX1 = "X1"
local screenMain = hs.screen.mainScreen()
local screenLcd = "Color LCD"
local screenSecondary = {
    ["jumpy-panda"] = screenLcd,
    ["default"] = screenLcd
}

local appBrowser = hs.appfinder.appFromName("Firefox")
local appEditor = "Sublime Text"
local appTerminal = hs.appfinder.appFromName("iTerm2")
local appTrade = "富途牛牛"
local appSlack = "Slack"
local appDiscord = "Discord"

layouts = {}
layouts["default"] = {
    name = "Default",
    description = "Default layout",
    definition = {
        {appTerminal, nil, screenMain, positions.maximized, nil, nil}
    }
}

layouts["jumpy-panda"] = {
    name = "jumpy-panda",
    description = "macbook air m1",
    definition = {
        {appEditor, nil, screenMain, positions.centered, nil, nil},
        {appTerminal, nil, screenMain, positions.right66, nil, nil},
        -- {appTrade, nil, screenMain, positions.lower50, nil, nil},
        {appBrowser, nil, screenMain, positions.centered80, nil, nil}
    }
}

layouts["giant-cat"] = {
    name = "giant-cat",
    description = "macbook pro 16 woolworths",
    definition = {
        {appEditor, nil, screenLcd, positions.left30, nil, nil},
        {appTerminal, nil, screenMain, positions.centered80, nil, nil},
        {appBrowser, nil, screenMain, positions.centered80, nil, nil},
        {appSlack, nil, screenMain, positions.chat, nil, nil},
        {appDiscord, nil, screenMain, positions.chat, nil, nil}
    }
}

presetLayouts = {
    layouts["default"],
    layouts["jumpy-panda"]
}
function applyLayout(screen, layout)
    local l = layout.definition
    if layout.large and screen:currentMode().w > 1500 then
        l = layout.large
    end

    currentLayout = layout
    hs.layout.apply(
        l,
        function(windowTitle, layoutWindowTitle)
            return string.sub(windowTitle, 1, string.len(layoutWindowTitle)) == layoutWindowTitle
        end
    )
end

function chooseLayout()
    currentLayout = null

    local layoutChooser =
        hs.chooser.new(
        function(selection)
            if not selection then
                return
            end

            applyLayout(screenMain, presetLayouts[selection.index])
        end
    )
    i = 0
    layoutChooser:choices(
        hs.fnutils.imap(
            presetLayouts,
            function(layout)
                i = i + 1

                return {
                    index = i,
                    text = layout.name,
                    subText = layout.description
                }
            end
        )
    )
    layoutChooser:rows(#presetLayouts)
    layoutChooser:width(60)
    layoutChooser:subTextColor({red = 0, green = 0, blue = 0, alpha = 0.4})

    bindGlobalKey(
        ";",
        function()
            layoutChooser:show()
        end
    )
end

function applyDefaultLayout()
    for _, screen in pairs(hs.screen.allScreens()) do
        log.i("screen info => ", _, " => ", screen, screen:name())
    end
    log.i("Apply default layout for " .. hostName)
    local layout = layouts["default"].definition
    if layouts[hostName] then
        layout = layouts[hostName].definition
    end
    hs.layout.apply(layout)
end

chooseLayout()
applyDefaultLayout()

hs.screen.watcher.new(
    function()
        --if not currentLayout then return end
        --  applyLayout(currentLayout)
        applyDefaultLayout()
    end
):start()
