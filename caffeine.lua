-- Got this from https://github.com/voostindie/hammerspoon-config
--
-- Caffeine: prevents the Mac from falling asleep.
--
-- I pulled the icons from here:
-- http://jimmygreen.deviantart.com/art/Retina-Caffeine-menubar-icons-350451587
--

local caffeine = hs.menubar.new()

local function caffeineAlert(status, alert)
    if alert then
        hs.alert("Caffeine " .. status, 1)
    end
end

local function updateCaffeineDisplay(state, alert)
    local result
    if state then
        caffeine:setIcon("caffeine-active.png")
        caffeineAlert('enabled', alert)
    else
        caffeine:setIcon("caffeine-inactive.png")
        caffeineAlert('disabled', alert)
    end
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
