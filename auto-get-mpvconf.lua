mp.register_event("file-loaded", function()
    local hdr_format = mp.get_property("video-params/primaries", "unknown")
    if hdr_format == "bt.2020" then
        mp.commandv("load-config", "hdr-config.conf")
        mp.osd_message("HDR Configuration Applied!")
    else
        mp.commandv("load-config", "sdr-config.conf")
        mp.osd_message("SDR Configuration Applied!")
    end
end)
