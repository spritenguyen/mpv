mp.register_event("file-loaded", function()
    -- Nhận diện thiết bị: PC hoặc Android
    local os_name = mp.get_property("os-name", "unknown")
    local gpu_context = mp.get_property("gpu-context", "unknown")
    local filename = mp.get_property("filename", "")
    local hdr_format = mp.get_property("video-params/primaries", "unknown")
    local color_space = mp.get_property("video-params/space", "unknown")
    local hdr_peak = mp.get_property("video-params/hdr-peak", 0)
    local codec = mp.get_property("video-codec", "unknown")

    -- Trường hợp video từ YouTube, sử dụng cấu hình mặc định mpv.conf
    --local demuxer = mp.get_property("demuxer", "unknown")
   -- if demuxer == "lavf" and (filename:find("youtube.com") or filename:find("youtu.be")) then
      --  mp.osd_message("YouTube video detected. Using default mpv.conf.", 6)
       -- return
    --end

    -- Kiểm tra HDR dựa trên metadata và tên file
    if hdr_format == "bt.2020" or color_space == "hdr" or tonumber(hdr_peak) > 0 or codec:find("hevc") or filename:find("HDR") or filename:find("hdr") then
        -- Áp dụng cấu hình HDR cho thiết bị Android
        if os_name == "android" then
            mp.set_property("hwdec", "mediacodec")
            mp.set_property("vo", "gpu")
            mp.set_property("scale", "bilinear")
            mp.set_property("dscale", "mitchell")
            mp.set_property("tone-mapping", "linear")
            mp.set_property("hdr-compute-peak", "no")
            mp.osd_message("HDR Configuration Applied for Android!", 6)
        else
            -- Áp dụng cấu hình HDR cho PC
            mp.set_property("hwdec", "auto-safe")
            mp.set_property("vo", "gpu")
            mp.set_property("scale", "ewa_lanczos")
            mp.set_property("dscale", "mitchell")
            mp.set_property("tone-mapping", "hable")
            mp.set_property("hdr-compute-peak", "yes")
            mp.osd_message("HDR Configuration Applied for PC!", 6)
        end
    else
        -- Áp dụng cấu hình đơn giản cho Non-HDR
        if os_name == "android" then
            mp.set_property("hwdec", "mediacodec")
            mp.set_property("vo", "gpu")
            mp.set_property("scale", "bilinear")
            mp.set_property("dscale", "bilinear")
            mp.set_property("interpolation", "no")
            mp.osd_message("Non-HDR Configuration Applied for Android!", 6)
        else
            -- Cấu hình Non-HDR cho PC
            mp.set_property("hwdec", "auto-safe")
            --mp.set_property("vo", "gpu")
            mp.set_property("scale", "bilinear")
            mp.set_property("dscale", "bilinear")
            mp.set_property("interpolation", "no")
            --mp.set_property("volume-max", "100")
            --mp.set_property("volume", "80")
            mp.osd_message("Non-HDR Configuration Applied for PC!", 6)
        end
    end
end)
