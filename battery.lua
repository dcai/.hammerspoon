function batteryWatcher()
    local percentage = hs.battery.percentage()
    local powerSource = hs.battery.powerSource()
    local isCharging = hs.battery.isCharging()
    local isCharged = hs.battery.isCharged()
    local cycles = hs.battery.cycles()
    batteryMenu:setTitle(string.format(" %d%%", percentage))
    if isCharging then
        icon = string.format('assets/charging-battery.png')
        batteryMenu:setIcon(icon)
    else
        batteryMenu:setIcon(nil)
    end
    local menuTable = {
        {title = powerSource},
        {title = '-'},
        {title = string.format("%d%%", percentage)},
        {title = string.format('Charging: %s', isCharging and "Yes" or "No")},
        {title = string.format('Charged: %s', isCharged and "Yes" or "No")},
        {title = string.format('Cycles: %s', cycles)},
    }
    batteryMenu:setMenu(menuTable)
end

batteryMenu = hs.menubar.new()
batteryWatcher()
hs.battery.watcher.new(batteryWatcher):start()
