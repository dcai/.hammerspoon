--
-- Layouts
--
local asusLCD = "ASUS VS247"
local dellLCD = "DELL U2414H"
local mainScreen = hs.screen.mainScreen()

local appChrome = "Google Chrome"
local appSublime = "Sublime Text"
local appiTerm = "iTerm2"

presetLayouts = {
    {
        name="Code",
        description="For fun and profit",
        small={
            {appiTerm, nil, mainScreen, positions.maximized, nil, nil},
        },
        large={
            {appSublime, nil, mainScreen, positions.right50, nil, nil},
            {appiTerm, nil, mainScreen, positions.right50, nil, nil},
        }
    },
    {
        name="Write",
        description="Time to write",
        small={
            {appChrome, nil, mainScreen, positions.left50, nil, nil},
            {appiTerm,   nil, mainScreen, positions.right50, nil, nil},
        }
    },
    {
        name="DELL U2414H",
        description="work",
        small={
            {appChrome, nil, mainScreen, positions.maximized, nil, nil},
            {"Firefox", nil, dellLCD, positions.lower50, nil, nil},
            {"Safari", nil, dellLCD, positions.lower60, nil, nil},
            {"Slack", nil, dellLCD, positions.lower30, nil, nil},
            {appiTerm, nil, dellLCD, positions.large, nil, nil},
            {appSublime, nil, dellLCD, positions.lower40, nil, nil},
            {"VLC", nil, dellLCD, positions.chat, nil, nil},
        }
    },
    {
        name="Standup",
        description="Just Firefox",
        small={
            {"Firefox", nil, mainScreen, positions.maximized, nil, nil},
        }
    },
}
function applyLayout(screen, layout)
    local layoutSize = layout.small
    if layout.large and screen:currentMode().w > 1500 then
        layoutSize = layout.large
    end

    currentLayout = layout
    hs.layout.apply(layoutSize, function(windowTitle, layoutWindowTitle)
        return string.sub(windowTitle, 1, string.len(layoutWindowTitle)) == layoutWindowTitle
    end)
end

function chooseLayout()
    currentLayout = null

    local layoutChooser = hs.chooser.new(function(selection)
        if not selection then return end

        applyLayout(mainScreen, presetLayouts[selection.index])
    end)
    i = 0
    layoutChooser:choices(hs.fnutils.imap(presetLayouts, function(layout)
        i = i + 1

        return {
            index=i,
            text=layout.name,
            subText=layout.description
        }
    end))
    layoutChooser:rows(#presetLayouts)
    layoutChooser:width(60)
    layoutChooser:subTextColor({red=0, green=0, blue=0, alpha=0.4})

    bindKey(';', function()
        layoutChooser:show()
    end)
end

function applyLayoutToScreen()
    if hostName == 'dsmbp15' then
        local dellLCDLayout = presetLayouts[3].small
        hs.layout.apply(dellLCDLayout)
        --hs.layout.apply(asusLCDLayout)
    end
end

chooseLayout();
applyLayoutToScreen();

hs.screen.watcher.new(function()
    -- hs.alert.show("Screen changed")

    --if not currentLayout then return end
    --  applyLayout(currentLayout)
    applyLayoutToScreen();
end):start()
