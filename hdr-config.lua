mp.register_event("file-loaded", function()
    local filename = mp.get_property("filename", "")
    local hdr_format = mp.get_property("video-params/primaries", "unknown")
    local hdr_peak = mp.get_property("video-params/hdr-peak", 0)
    local codec = mp.get_property("video-codec", "unknown")

    -- Phát hiện HDR dựa trên metadata hoặc tên tệp
    if hdr_format == "bt.2020" or tonumber(hdr_peak) > 0 or filename:lower():find("hdr") then
        mp.set_property("hwdec", "auto-safe")
       -- mp.set_property("vo", "gpu")
        mp.set_property("scale", "bicubic")
        mp.set_property("tone-mapping", "mobius")
        mp.set_property("hdr-compute-peak", "no")
        mp.osd_message("Cấu hình HDR đã được áp dụng", 5)
    else
        mp.set_property("hwdec", "auto-safe")
       -- mp.set_property("vo", "gpu")
        mp.set_property("scale", "bilinear")
        mp.set_property("interpolation", "no")
        mp.osd_message("Cấu hình Non-HDR đã được áp dụng", 5)
    end
end)
