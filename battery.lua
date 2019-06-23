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
        { title = string.format('powerSource: %s', powerSource)},
        { title = '-'},
        { title = string.format('isCharging: %s', isCharging)},
        { title = string.format('isCharged: %s', isCharged)},
        { title = string.format('Cycleds: %s', cycles)},
    }
    batteryMenu:setMenu(menuTable)
end

batteryMenu = hs.menubar.newWithPriority(2147483645)
batteryWatcher()
hs.battery.watcher.new(batteryWatcher):start()
