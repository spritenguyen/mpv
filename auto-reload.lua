local timeout = 13  -- Thời gian chờ trước khi reload (tính bằng giây)

mp.observe_property("eof-reached", "bool", function(_, eof)
    if eof then
        mp.msg.warn("Mất kết nối với luồng. Đang chờ " .. timeout .. " giây để tải lại...")
        mp.add_timeout(timeout, function()
            mp.command("loadfile " .. mp.get_property("path"))
        end)
    end
end)
