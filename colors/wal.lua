local watch = require("wal.watch")
local theme = require("wal.theme")

vim.g.colors_name = "wal"
vim.opt.background = "dark"

theme.new(vim.g.wal_path)
theme:load_colors()
theme:generate()
theme:apply()

local file_watcher
local callback = function()
	file_watcher:stop()
	theme:load_colors()
	theme:generate()
	theme:apply()
	file_watcher:start()
end

file_watcher = watch.new(vim.g.wal_path, callback, nil)
file_watcher:start()
