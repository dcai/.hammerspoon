--

keyApp = {"shift", "ctrl"}
keyGrid = {"cmd", "ctrl"}
keyWindow = {"cmd", "ctrl"}
keyGlobal = {"cmd", "ctrl", "alt"}

positions = {
    left25 = hs.layout.left25,
    left30 = hs.layout.left30,
    left50 = hs.layout.left50,
    left70 = hs.layout.left70,
    left75 = hs.layout.left75,
    maximized = hs.layout.maximized,
    right25 = hs.layout.right25,
    right30 = hs.layout.right30,
    right50 = hs.layout.right50,
    right70 = hs.layout.right70,
    right75 = hs.layout.right75,
    centered80 = {x = 0.05, y = 0.1, w = 0.9, h = 0.8},
    centered = {x = 0.05, y = 0.2, w = 0.9, h = 0.6},
    large = {x = 0.01, y = 0.02, w = 0.98, h = 0.96},
    upper30 = {x = 0, y = 0, w = 1, h = 0.3},
    upper40 = {x = 0, y = 0, w = 1, h = 0.4},
    upper50 = {x = 0, y = 0, w = 1, h = 0.5},
    upper66 = {x = 0, y = 0, w = 1, h = 0.66},
    upper50Left50 = {x = 0, y = 0, w = 0.5, h = 0.5},
    upper50Right15 = {x = 0.85, y = 0, w = 0.15, h = 0.5},
    upper50Right30 = {x = 0.7, y = 0, w = 0.3, h = 0.5},
    upper50Right50 = {x = 0.5, y = 0, w = 0.5, h = 0.5},
    lower30 = {x = 0, y = 0.7, w = 1, h = 0.3},
    lower40 = {x = 0, y = 0.6, w = 1, h = 0.4},
    lower50 = {x = 0, y = 0.5, w = 1, h = 0.5},
    lower60 = {x = 0, y = 0.4, w = 1, h = 0.6},
    lower70 = {x = 0, y = 0.3, w = 1, h = 0.7},
    lower50Left50 = {x = 0, y = 0.5, w = 0.5, h = 0.5},
    lower50Right50 = {x = 0.5, y = 0.5, w = 0.5, h = 0.5},
    chat = {x = 0.2, y = 0.2, w = 0.6, h = 0.8}
}

function bindGlobalKey(key, fn)
    hs.hotkey.bind(keyGlobal, key, fn)
end

function applicationRunning(name)
    apps = hs.application.runningApplications()
    found = false
    for i = 1, #apps do
        app = apps[i]
        if app:title() == name and (#app:allWindows() > 0 or app:mainWindow()) then
            found = true
        end
    end

    return found
end

function isempty(s)
    return s == nil or s == ""
end

if isempty(foo) then
    foo = "default value"
end

-- config reload
function reloadConfig(files)
    doReload = false
    if isempty(files) then
        -- triggered by hotkey
        doReload = true
    else
        for _, file in pairs(files) do
            if file:sub(-4) == ".lua" then
                log.i(file .. " triggers reload.")
                doReload = true
            end
        end
    end
    if doReload then
        log.i("reloading config")
        hs.reload()
    end
end

function ping()
    hs.http.asyncGet(
        "https://httpbin.org/get",
        {},
        function(status, body, headers)
            log.i(body)
        end
    )
end

function showDateAndTime()
    hs.alert.show(os.date("%R on %e %B %G"))
end

function showAllVolumes()
    local vols = hs.fs.volume.allVolumes()
    local msg = "volumes: \n"
    for key, vol in pairs(vols) do
        msg = msg .. key .. "\n"
    end
    return hs.alert(
        msg,
        {
            ["textSize"] = 12
        },
        hs.screen.mainScreen(),
        12
    )
end

function askUnmount()
    local yes = "Yes"
    local no = "No"
    local buttonClicked = hs.dialog.blockAlert("Umount", "Are you sure to unmount all?", "Yes", "No", "critical")

    if buttonClicked == yes then
        local uuid = showAllVolumes()
        log.i(uuid)
        -- local as = 'display dialog "Hello World"'
        local as = 'tell application "Finder" to eject (every disk whose ejectable is true)'
        local result, object, descriptor = hs.osascript.applescript(as)
        if result then
            hs.alert.closeSpecific(uuid)
            hs.alert.show("volumes umounted")
        else
            hs.alert.show("failed unmounting volumes")
        end
    end
end

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end
