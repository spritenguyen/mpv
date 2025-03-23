mp.register_event("file-loaded", function()
    local stream_path = mp.get_property("stream-path", "")
    local is_live = stream_path:find("http") ~= nil -- Phát hiện luồng HTTP
    local is_stremio_torrent = stream_path:find("127.0.0.1") ~= nil -- Kiểm tra nếu luồng được tạo bởi Stremio (chạy cục bộ)

    if is_live then
        if is_stremio_torrent then
            -- Áp dụng cấu hình giống với bitrate cao
            mp.set_property("hwdec", "auto")
            mp.set_property("vo", "gpu-next")
            mp.set_property("scale", "ewa_lanczos")
            mp.set_property("tone-mapping", "reinhard")
            mp.set_property("hdr-compute-peak", "yes") -- Hỗ trợ HDR
            mp.set_property("hdr-tone-mapping", "hdr2sdr")
            mp.osd_message("Cấu hình 'Stremio torrent - bitrate cao' đã được áp dụng", 5)
        else
            -- Cấu hình cho luồng trực tiếp thông thường
            mp.set_property("hwdec", "auto")
            mp.set_property("vo", "gpu")
            mp.set_property("scale", "bilinear")
            mp.set_property("interpolation", "no")
            mp.osd_message("Cấu hình 'Luồng trực tiếp' đã được áp dụng", 5)
        end
    else
        -- Xử lý file video như trong script gốc
        local file_size = tonumber(mp.get_property("file-size", "0"))
        local duration = tonumber(mp.get_property("duration", "0"))

        if file_size > 0 and duration > 0 then
            local bitrate = (file_size * 8) / (duration * 1000)
            if bitrate > 3000 then
                mp.set_property("hwdec", "auto")
                mp.set_property("vo", "gpu-next")
                mp.set_property("scale", "ewa_lanczos")
                mp.set_property("tone-mapping", "reinhard")
                mp.set_property("hdr-compute-peak", "yes")
                mp.set_property("hdr-tone-mapping", "hdr2sdr")
                mp.osd_message("Cấu hình 'bitrate cao' đã được áp dụng", 5)
            else
                mp.set_property("hwdec", "auto")
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
