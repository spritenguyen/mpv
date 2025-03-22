-- Cải tiến nhận diện hệ điều hành
local function detect_os()
    local os_name = mp.get_property("os-name", "unknown")
    local gpu_context = mp.get_property("gpu-context", "unknown")

    -- Kiểm tra Android
    if os_name == "android" or gpu_context:find("mediacodec") then
        return "android"
    end

    -- Kiểm tra Windows
    if os_name:lower():find("windows") then
        return "windows"
    end

    -- Kiểm tra Linux
    if os_name:lower():find("linux") then
        return "linux"
    end

    -- Kiểm tra macOS
    if os_name:lower():find("darwin") then
        return "macos"
    end

    -- Mặc định
    return "unknown"
end

-- Sử dụng hàm detect_os
local detected_os = detect_os()

if is_hdr then
    if detected_os == "android" then
        apply_config("mediacodec", "gpu", "bilinear", "mitchell", "linear", "no", "HDR Configuration Applied for Android!")
    elseif detected_os == "windows" or detected_os == "linux" or detected_os == "macos" then
        apply_config("auto-safe", "gpu", "ewa_lanczos", "mitchell", "hable", "yes", "HDR Configuration Applied for PC!")
    else
        mp.osd_message("Unknown OS - Cannot Apply Configuration", 6)
    end
else
    if detected_os == "android" then
        apply_config("mediacodec", "gpu", "bilinear", "bilinear", nil, nil, "Non-HDR Configuration Applied for Android!")
    elseif detected_os == "windows" or detected_os == "linux" or detected_os == "macos" then
        apply_config("auto-safe", "gpu", "bilinear", "bilinear", nil, nil, "Non-HDR Configuration Applied for PC!")
    else
        mp.osd_message("Unknown OS - Cannot Apply Configuration", 6)
    end
end
