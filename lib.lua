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

function showDateAndTime()
    hs.alert.show(os.date("%R on %e %B %G"))
end
