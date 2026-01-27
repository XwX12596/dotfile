-- 自动为当前目录加载 fonts/
local utils = require 'mp.utils'

mp.register_event("file-loaded", function()
    -- local path = mp.get_property("working-directory")
    -- local font_dir = utils.join_path(path, "fonts")
    local font_dir = "/home/xwx/Files/fonts"

    local stat = utils.file_info(font_dir)
    if stat and stat.is_dir then
        mp.msg.info("Loading font dir: " .. font_dir)
        mp.set_property("sub-fonts-dir", font_dir)
    end
end)
