mp.register_event("file-loaded", function()
    local is_live = mp.get_property("stream-path", ""):find("http") ~= nil -- Phát hiện luồng trực tiếp
    if is_live then
        mp.set_property("hwdec", "auto-safe")
        mp.set_property("vo", "gpu")
        mp.set_property("scale", "bilinear")
        mp.set_property("interpolation", "no")
        mp.osd_message("Cấu hình 'Luồng trực tiếp' đã được áp dụng", 5)
    else
        local file_size = tonumber(mp.get_property("file-size", "0")) -- Lấy kích thước file
        local duration = tonumber(mp.get_property("duration", "0")) -- Lấy thời lượng video

        if file_size > 0 and duration > 0 then
            local bitrate = (file_size * 8) / (duration * 1000) -- Tính bitrate (kbps)
            if bitrate > 3000 then
                mp.set_property("hwdec", "auto-safe")
                mp.set_property("vo", "gpu-next")
                mp.set_property("scale", "bicubic")
                mp.set_property("tone-mapping", "mobius")
                mp.set_property("hdr-compute-peak", "no")
                mp.osd_message("Cấu hình 'bitrate cao' đã được áp dụng", 5)
            else
                mp.set_property("hwdec", "auto-safe")
                mp.set_property("vo", "gpu")
                mp.set_property("scale", "bilinear")
                mp.set_property("interpolation", "no")
                mp.osd_message("Cấu hình 'Normal' đã được áp dụng", 5)
            end
        else
            mp.osd_message("Không thể tính toán bitrate!", 5)
        end
    end
end)
