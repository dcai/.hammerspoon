--
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
