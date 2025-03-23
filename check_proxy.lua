-- Script: check_proxy_delay.lua
-- Mục đích: Hiển thị thông báo proxy sau 5 giây khi video được phát

local function check_proxy_with_delay()
    -- Hàm để kiểm tra proxy và hiển thị thông báo
    local function check_proxy()
        local proxy = mp.get_property("http-proxy")
        local message = ""

        if proxy and proxy ~= "" then
            message = "Proxy đang sử dụng: " .. proxy
            mp.msg.info("Proxy hiện tại đang sử dụng: " .. proxy)
        else
            message = "Không có proxy được thiết lập!"
            mp.msg.warn("Không có proxy được thiết lập!")
        end

        -- Hiển thị thông báo OSD
        mp.osd_message(message, 5) -- Thông báo hiển thị trong 5 giây
    end

    -- Chờ 5 giây trước khi gọi hàm check_proxy
    mp.add_timeout(5, check_proxy)
end

-- Đăng ký sự kiện kích hoạt
mp.register_event("file-loaded", check_proxy_with_delay)
