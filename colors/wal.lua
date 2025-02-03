local watch = require("wal.watch")
local theme = require("wal.theme")

vim.g.colors_name = "wal"
vim.opt.background = "dark"

if not vim.g.wal_path then
	vim.g.wal_path = vim.fn.expand("~/.cache/wal/colors/json")
end

theme:apply(vim.g.wal_path)

local file_watcher
-- callback = function(err, filename, events)
callback = function()
	file_watcher:stop()
	theme:apply(vim.g.wal_path)
	file_watcher:start()
end

file_watcher = watch.new(vim.g.wal_path, callback, nil)
file_watcher:start()
