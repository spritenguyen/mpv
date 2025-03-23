-- Script: mpv_tor_proxy.lua
-- Mục đích: Kết nối MPV qua proxy Tor (127.0.0.1:9050)

local function set_tor_proxy()
    local proxy_address = "socks5://127.0.0.1:9050"
    mp.set_property("http-proxy", proxy_address)
    mp.msg.info("Proxy được thiết lập: " .. proxy_address)
end

mp.register_event("start-file", set_tor_proxy)
