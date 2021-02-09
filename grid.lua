--
-- Grid
--

local leftGrids = {positions.left50, positions.left66, positions.left34}
local rightGrids = {positions.right50, positions.right66, positions.right34}
local topGrids = {positions.upper50}
local bottomGrids = {positions.lower50}

grid = {
    -- up
    {key = "k", units = topGrids},
    {key = "up", units = topGrids},
    
    -- down
    {key = "down", units = bottomGrids},
    {key = "j", units = bottomGrids},
    
    -- left
    {key = "left", units = leftGrids},
    {key = "l", units = rightGrids},
    
    -- right
    {key = "h", units = leftGrids},
    {key = "right", units = rightGrids},
    
    -- center and max
    {key = "return", units = {positions.centered, positions.maximized}},
    -- {key="return", units={positions.maximized}},
    
    -- others
    {key = "o", units = {positions.upper50Right50}},
    {key = "m", units = {positions.lower50Left50}},
    {key = ".", units = {positions.chat}},
    {key = "u", units = {positions.upper50Left50}},
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
