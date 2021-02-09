--
-- Layouts
--
local screenAsusVs247 = "ASUS VS239"
local screenMain = hs.screen.mainScreen()

local appChrome = "Google Chrome"
local appSublime = "Sublime Text"
local appiTerm = "iTerm2"
local appFutubull = "富途牛牛"

presetLayouts = {
    {
        name = "Code",
        description = "For fun and profit",
        definition = {
            {appiTerm, nil, screenMain, positions.maximized, nil, nil}
        }
    },
    {
        name = "Write",
        description = "Time to write",
        definition = {
            -- {appFutubull, nil, screenAsusVs247, positions.maximized, nil, nil},
            {appSublime, nil, screenAsusVs247, positions.centered, nil, nil},
            {appChrome, nil, screenMain, positions.left50, nil, nil},
            {appiTerm, nil, screenMain, positions.right50, nil, nil}
        }
    }
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
    for k, v in pairs(hs.screen.allScreens()) do print(k, v) end
    if hostName == "jumpy-panda" then
        print("Apply default layout for " .. hostName)
        local layout = presetLayouts[2].definition
        hs.layout.apply(layout)
    end
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
