------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    disabled = true
})

-- hl.monitor({
--     output   = "eDP-1",
--     mode     = "2560x1440@165",
--     position = "0x720",
--     scale    = 1,
-- })

hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@180",
    position = "2560x0",
    scale    = 1,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@75",
    position = "5120x360",
    scale    = 1,
})