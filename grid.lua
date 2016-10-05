--
-- Grid
--

grid = {
    {key="u", units={positions.upper50Left50}},
    {key="i", units={positions.upper50}},
    {key="o", units={positions.upper50Right50}},

    {key="j", units={positions.left50, positions.left66, positions.left34}},
    {key="k", units={positions.centered, positions.maximized}},
    {key="l", units={positions.right50, positions.right66, positions.right34}},

    {key="m", units={positions.lower50Left50}},
    {key=",", units={positions.lower50}},
    {key=".", units={positions.chat}}
}

hs.fnutils.each(grid, function(entry)
    hs.hotkey.bind(keyGrid, entry.key, function()
        local units = entry.units
        local screen = hs.screen.mainScreen()
        local window = hs.window.focusedWindow()
        local windowGeo = window:frame()

        local index = 0
        hs.fnutils.find(units, function(unit)
            index = index + 1

            local geo = hs.geometry.new(unit):fromUnitRect(screen:frame()):floor()
            return windowGeo:equals(geo)
        end)
        if index == #units then index = 0 end

        currentLayout = null
        window:moveToUnit(units[index + 1])
    end)
end)
