hs.loadSpoon("SpoonInstall")
Install = spoon.SpoonInstall
Install:andUse(
    "EjectMenu",
    {
        config = {
            eject_on_sleep = true,
            eject_on_lid_close = true,
            show_in_menubar = false,
            notify = true
        },
        hotkeys = {ejectAll = {keyGlobal, "u"}},
        start = true
    }
)
