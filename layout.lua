--
-- Layouts
--
local laptopScreen = "Built-in Retina Display"
local laptopScreenLayout = {
    {"Chrome", nil, laptopScreen, positions.left50,   nil, nil},
}

local asusLCD = "ASUS VS247"
local dellLCD = "DELL U2414H"
local chromeApp = hs.application.applicationsForBundleID('com.google.Chrome')[0]

asusLCDLayout = {
    {"Firefox",   nil, asusLCD, positions.right50, nil, nil},
    {chromeApp, nil, asusLCD, positions.large, nil, nil},
    {"TextWrangler", nil, asusLCD, positions.left50, nil, nil},
}

dellLCDLayout = {
    {"Firefox", nil, dellLCD, positions.lower50, nil, nil},
    {"Slack", nil, dellLCD, positions.lower50, nil, nil},
    {"iTerm2", nil, dellLCD, positions.large, nil, nil},
    {"VLC", nil, dellLCD, positions.chat, nil, nil},
}
hs.layout.apply(dellLCDLayout)
--hs.layout.apply(asusLCDLayout)

layouts = {
    {
        name="Work",
        description="For fun and profit",
        small={
            {"Slack", nil, screen, positions.maximized, nil, nil},
        },
        large={
            {"Slack", nil, screen, positions.maximized, nil, nil},
            {"TextWrangler", nil, screen, positions.right50, nil, nil},
        }
    },
    {
        name="Blogging",
        description="Time to write",
        small={
            {"Chrome", nil, screen, positions.left50, nil, nil},
            {"iTerm",   nil, screen, positions.right50, nil, nil},
        }
    }
}
currentLayout = null

layoutChooser = hs.chooser.new(function(selection)
    if not selection then return end

    applyLayout(layouts[selection.index])
end)
i = 0
layoutChooser:choices(hs.fnutils.imap(layouts, function(layout)
    i = i + 1

    return {
        index=i,
        text=layout.name,
        subText=layout.description
    }
end))
layoutChooser:rows(#layouts)
layoutChooser:width(20)
layoutChooser:subTextColor({red=0, green=0, blue=0, alpha=0.4})

bindKey(';', function()
    layoutChooser:show()
end)

hs.screen.watcher.new(function()
    hs.alert.show("Screen changed")

    --if not currentLayout then return end
    --  applyLayout(currentLayout)
    hs.layout.apply(dellLCDLayout)
end):start()
