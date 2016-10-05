--
function bindKey(key, fn)
    hs.hotkey.bind({"cmd", "ctrl", "alt"}, key, fn)
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


function applyLayout(layout)
    local screen = hs.screen.mainScreen()

    local layoutSize = layout.large
    if layout.large and screen:currentMode().w > 1500 then
        layoutSize = layout.large
    end

    currentLayout = layout
    hs.layout.apply(layoutSize, function(windowTitle, layoutWindowTitle)
        return string.sub(windowTitle, 1, string.len(layoutWindowTitle)) == layoutWindowTitle
    end)
end

-- config reload
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

