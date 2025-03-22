mp.register_event("file-loaded", function()
    -- Hàm áp dụng cấu hình
    local function apply_config(hwdec, vo, scale, dscale, tone_mapping, hdr_compute_peak, message)
        mp.set_property("hwdec", hwdec)
        mp.set_property("vo", vo)
        mp.set_property("scale", scale)
        mp.set_property("dscale", dscale)
        if tone_mapping then
            mp.set_property("tone-mapping", tone_mapping)
        end
        if hdr_compute_peak then
            mp.set_property("hdr-compute-peak", hdr_compute_peak)
        end
        mp.osd_message(message, 6)
    end

    -- Nhận diện thiết bị và thông tin video
    local os_name = mp.get_property("os-name", "unknown")
    local gpu_context = mp.get_property("gpu-context", "unknown")
    local filename = mp.get_property("filename", "")
    local hdr_format = mp.get_property("video-params/primaries", "unknown")
    local color_space = mp.get_property("video-params/space", "unknown")
    local hdr_peak = mp.get_property("video-params/hdr-peak", 0)
    local codec = mp.get_property("video-codec", "unknown")

    -- Kiểm tra video có HDR hay không
    local is_hdr = (hdr_format == "bt.2020" or color_space == "hdr" or tonumber(hdr_peak) > 0 or codec:find("hevc") or filename:find("HDR") or filename:find("hdr"))

    if is_hdr then
        if os_name == "android" then
            apply_config("mediacodec", "gpu", "bilinear", "mitchell", "linear", "no", "HDR Configuration Applied for Android!")
        else
            apply_config("auto-safe", "gpu", "ewa_lanczos", "mitchell", "hable", "yes", "HDR Configuration Applied for PC!")
        end
    else
        if os_name == "android" then
            apply_config("mediacodec", "gpu", "bilinear", "bilinear", nil, nil, "Non-HDR Configuration Applied for Android!")
        else
            apply_config("auto-safe", "gpu", "bilinear", "bilinear", nil, nil, "Non-HDR Configuration Applied for PC!")
        end
    end
end)
