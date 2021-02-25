-- full screen

hs.hotkey.bind(
    keyWindow,
    "left",
    function()
        local win = hs.window.focusedWindow()
        if not win then
            return
        end
        win:moveToScreen(win:screen():previous())
    end
)

hs.hotkey.bind(
    keyWindow,
    "right",
    function()
        local win = hs.window.focusedWindow()
        if not win then
            return
        end
        win:moveToScreen(win:screen():next())
    end
)

-- Window movement
pixels = 20

-- hs.hotkey.bind(
--     keyWindow,
--     "Y",
--     function()
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--
--         f.x = f.x - pixels
--         f.y = f.y - pixels
--         win:setFrame(f)
--     end
-- )
--
-- hs.hotkey.bind(
--     keyWindow,
--     "K",
--     function()
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--
--         f.y = f.y - pixels
--         win:setFrame(f)
--     end
-- )
--
-- hs.hotkey.bind(
--     keyWindow,
--     "U",
--     function()
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--
--         f.x = f.x + pixels
--         f.y = f.y - pixels
--         win:setFrame(f)
--     end
-- )
--
-- hs.hotkey.bind(
--     keyWindow,
--     "H",
--     function()
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--
--         f.x = f.x - pixels
--         win:setFrame(f)
--     end
-- )
--
-- hs.hotkey.bind(
--     keyWindow,
--     "L",
--     function()
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--
--         f.x = f.x + pixels
--         win:setFrame(f)
--     end
-- )
--
-- hs.hotkey.bind(
--     keyWindow,
--     "B",
--     function()
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--
--         f.x = f.x - pixels
--         f.y = f.y + pixels
--         win:setFrame(f)
--     end
-- )
--
-- hs.hotkey.bind(
--     keyWindow,
--     "J",
--     function()
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--
--         f.y = f.y + 10
--         win:setFrame(f)
--     end
-- )
--
-- hs.hotkey.bind(
--     keyWindow,
--     "N",
--     function()
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--
--         f.x = f.x + pixels
--         f.y = f.y + pixels
--         win:setFrame(f)
--     end
-- )
