------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1200@60",
    position = "0x673",
    scale    = 1.20,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "2560x1440@120",
    position = "1600x0",
    scale    = 1.07,
})

hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@75",
    position = "4000x266",
    scale    = 1,
})