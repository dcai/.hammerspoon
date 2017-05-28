--
function bindGlobalKey(key, fn)
    hs.hotkey.bind(keyGlobal, key, fn)
end

function bindAppKey(modifier, app)
    hs.hotkey.bind(keyApp, modifier, function()
        hs.application.launchOrFocus("/Applications/" .. app)
    end)
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


-- config reload
function reloadConfig(files)
    -- doReload = false
    -- for _,file in pairs(files) do
    --     if file:sub(-4) == ".lua" then
    --         doReload = true
    --     end
    -- end
    -- if doReload then
    --     hs.reload()
    -- end
    hs.reload()
end

function showDateAndTime()
    -- local screen = hs.screen.mainScreen()
    local style = {};
    local seconds = 3;
    style['textColor'] = { white = 1, alpha = 0.7 }
    style['textFont'] = 'Monaco'
    style['textSize'] = 56
    hs.alert.show(os.date("%R on %e %B %G"), style, seconds)
end
