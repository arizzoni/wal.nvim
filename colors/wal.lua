-- Neovim colorscheme file for wal.nvim

-- Set dark background for colorscheme
vim.opt.background = "dark"

-- Set colorscheme Name
vim.g.colors_name = "wal"

-- Clear cache
package.loaded["wal"] = nil

-- Apply the theme
require("wal").setup()

-- vim: ts=2 sw=2 tw=120
