mp.register_event("file-loaded", function()
    local hdr_format = mp.get_property("video-params/primaries", "unknown")
    if hdr_format == "bt.2020" then
        mp.commandv("load-config", "hdr-config-android.conf")
        mp.osd_message("HDR detected: Applying HDR config!")
    else
        mp.commandv("load-config", "sdr-config-android.conf")
        mp.osd_message("SDR detected: Applying SDR config!")
    end
end)
