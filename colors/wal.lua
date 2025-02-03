-- Neovim colorscheme file for wal.nvim
local watch = require("wal.watch")
local theme = require("wal.theme")

-- Set colorscheme Name
vim.g.colors_name = "wal"
vim.g.wal_path = "~/.cache/wallust/colors.json"

-- Set dark background for colorscheme
vim.opt.background = "dark"

-- Apply theme
theme:apply(vim.g.wal_path)

local callback = function(err, filename, events)
	theme:apply(vim.g.wal_path)
	vim.cmd("colo wal")
end

local file_watcher = watch.new(vim.g.wal_path, callback, nil)
file_watcher:start()
