-- Got this from https://github.com/voostindie/hammerspoon-config
--
-- Caffeine: prevents the Mac from falling asleep.
--
-- I pulled the icons from here:
-- http://jimmygreen.deviantart.com/art/Retina-Caffeine-menubar-icons-350451587
--

local useAscii = false
local iconSetIndex = 2

local iconOn =
    [[ASCII:
.....1a..........AC..........E
..............................
......4.......................
1..........aA..........CE.....
e.2......4.3...........h......
..............................
..............................
.......................h......
e.2......6.3..........t..q....
5..........c..........s.......
......6..................q....
......................s..t....
.....5c.......................
]]

local iconOff =
    [[ASCII:
.....1a.....x....AC.y.......zE
..............................
......4.......................
1..........aA..........CE.....
e.2......4.3...........h......
..............................
..............................
.......................h......
e.2......6.3..........t..q....
5..........c..........s.......
......6..................q....
......................s..t....
...x.5c....y.......z..........
]]

local caffeine = hs.menubar.new()

local function caffeineAlert(status, alert)
    if alert then
        hs.alert(string.format("Caffeine %s", status), 1)
    end
end

local function setIcon(state)
    local icon
    if state then
        if useAscii then
            icon = iconOn
        else
            icon = string.format("assets/caffeine/active-%d.png", iconSetIndex)
        end
    else
        if useAscii then
            icon = iconOff
        else
            icon = string.format("assets/caffeine/inactive-%d.png", iconSetIndex)
        end
    end
    caffeine:setIcon(icon)
end

local function updateCaffeineDisplay(state, alert)
    local result
    if state then
        caffeineAlert("enabled", alert)
    else
        caffeineAlert("disabled", alert)
    end
    setIcon(state)
end

function toggleCaffeine()
    updateCaffeineDisplay(hs.caffeinate.toggle("displayIdle"), true)
end

function removeCaffeine()
    caffeine:delete()
    caffeine = nil
end

if caffeine then
    caffeine:setClickCallback(toggleCaffeine)
    updateCaffeineDisplay(hs.caffeinate.get("displayIdle"), false)
end
