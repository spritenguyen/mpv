-- Script: mpv_tor_proxy.lua
-- Mục đích: Kết nối MPV qua proxy Tor (127.0.0.1:9050) và hiển thị thông báo sau 6 giây

local function set_tor_proxy()
    local proxy_address = "socks5://127.0.0.1:9050"
    mp.set_property("http-proxy", proxy_address)
    mp.msg.info("Proxy được thiết lập: " .. proxy_address)

    -- Hiển thị thông báo sau 10 giây
    mp.add_timeout(10, function()
        mp.osd_message("Proxy được thiết lập: " .. proxy_address, 5) -- Hiển thị thông báo trong 5 giây
    end)
end

mp.register_event("start-file", set_tor_proxy)
