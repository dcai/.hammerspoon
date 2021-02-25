--
-- Grid
--

local leftGrids = {positions.left30, positions.left50, positions.left70}
local rightGrids = {positions.right30, positions.right50, positions.right70}
local topGrids = {positions.upper50}
local bottomGrids = {positions.lower50}

grid = {
    -- up
    {key = "k", units = topGrids},
    -- down
    {key = "j", units = bottomGrids},
    -- left
    {key = "l", units = rightGrids},
    -- right
    {key = "h", units = leftGrids},
    -- center and max
    {key = "return", units = {positions.maximized, positions.centered80, positions.centered}},
    -- {key="return", units={positions.maximized}},

    -- others
    {key = "o", units = {positions.upper50Right50}},
    {key = "m", units = {positions.lower50Left50}},
    {key = ",", units = {positions.chat}},
    {key = "u", units = {positions.upper50Left50}},
    {key = ".", units = {positions.lower50Right50}}
}

hs.fnutils.each(
    grid,
    function(entry)
        hs.hotkey.bind(
            keyGrid,
            entry.key,
            function()
                local units = entry.units
                local screen = hs.screen.mainScreen()
                local window = hs.window.focusedWindow()
                local windowGeo = window:frame()

                local index = 0
                hs.fnutils.find(
                    units,
                    function(unit)
                        index = index + 1

                        local geo = hs.geometry.new(unit):fromUnitRect(screen:frame()):floor()
                        return windowGeo:equals(geo)
                    end
                )
                if index == #units then
                    index = 0
                end

                currentLayout = null
                window:moveToUnit(units[index + 1])
            end
        )
    end
)
