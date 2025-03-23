mp.register_event("file-loaded", function()
    local file_size = tonumber(mp.get_property("file-size", "0")) -- Lấy kích thước file (tính bằng byte)
    local duration = tonumber(mp.get_property("duration", "0")) -- Lấy thời lượng video (tính bằng giây)

    if file_size > 0 and duration > 0 then
        local bitrate = (file_size * 8) / (duration * 1000) -- Chuyển đổi từ byte sang kbps
        if bitrate > 3000 then
            mp.set_property("hwdec", "auto-safe")
            -- mp.set_property("vo", "gpu")
            mp.set_property("scale", "bicubic")
            mp.set_property("tone-mapping", "mobius")
            mp.set_property("hdr-compute-peak", "no")
            mp.osd_message("Cấu hình 'bitrate cao' đã được áp dụng", 5)
        else
            mp.set_property("hwdec", "auto-safe")
            -- mp.set_property("vo", "gpu")
            mp.set_property("scale", "bilinear")
            mp.set_property("interpolation", "no")
            mp.osd_message("Cấu hình Non-HDR đã được áp dụng", 5)
        end
    else
        mp.osd_message("Không thể tính toán bitrate!", 5)
    end
end)
