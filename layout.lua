--
-- Layouts
--
local screenAsusVs247 = "ASUS VS247"
local screenDellU2414H = "DELL U2414H"
local screenMain = hs.screen.mainScreen()

local appChrome = "Google Chrome"
local appSublime = "Sublime Text"
local appiTerm = "iTerm2"

presetLayouts = {
    {
        name="Code",
        description="For fun and profit",
        definition={
            {appiTerm, nil, screenMain, positions.maximized, nil, nil},
        }
    },
    {
        name="Write",
        description="Time to write",
        definition={
            {appChrome, nil, screenMain, positions.left50, nil, nil},
            {appiTerm,  nil, screenMain, positions.right50, nil, nil},
        }
    },
    {
        name="Work",
        description="Lrn",
        definition={
            {appChrome,  nil, screenMain, positions.maximized, nil, nil},
            {"Firefox",  nil, screenDellU2414H, positions.lower50, nil, nil},
            {"Safari",   nil, screenDellU2414H, positions.lower60, nil, nil},
            {"Slack",    nil, screenDellU2414H, positions.lower30, nil, nil},
            {appiTerm,   nil, screenDellU2414H, positions.large, nil, nil},
            {appSublime, nil, screenDellU2414H, positions.lower40, nil, nil},
            {"VLC",      nil, screenDellU2414H, positions.chat, nil, nil},
        }
    },
    {
        name="Standup",
        description="Just Firefox",
        definition={
            {"Firefox", nil, screenMain, positions.maximized, nil, nil},
        }
    },
}
function applyLayout(screen, layout)
    local l = layout.definition
    if layout.large and screen:currentMode().w > 1500 then
        l = layout.large
    end

    currentLayout = layout
    hs.layout.apply(l, function(windowTitle, layoutWindowTitle)
        return string.sub(windowTitle, 1, string.len(layoutWindowTitle)) == layoutWindowTitle
    end)
end

function chooseLayout()
    currentLayout = null

    local layoutChooser = hs.chooser.new(function(selection)
        if not selection then return end

        applyLayout(screenMain, presetLayouts[selection.index])
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

    bindGlobalKey(';', function()
        layoutChooser:show()
    end)
end

function applyDefaultLayout()
    if hostName == 'dsmbp15' then
        local screenDellU2414HLayout = presetLayouts[3].definition
        hs.layout.apply(screenDellU2414HLayout)
    end
end

chooseLayout();
applyDefaultLayout();

hs.screen.watcher.new(function()
    -- hs.alert.show("Screen changed")

    --if not currentLayout then return end
    --  applyLayout(currentLayout)
    applyDefaultLayout();
end):start()
