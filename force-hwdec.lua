-- force-hwdec.lua
-- Ép mpv-android reload file với hardware decoder MediacoDEC
local reloaded = false

mp.register_event("file-loaded", function()
    if reloaded then return end
    reloaded = true
    local path = mp.get_property("path")
    mp.msg.info("Forcing hwdec=mediacodec-copy, reloading: " .. path)
    mp.commandv("loadfile", path, "replace", "--hwdec=mediacodec-copy")
end)
