-- Autocommand to start the cycle at VimEnter
local autogrp = vim.api.nvim_create_augroup("wal", {})
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		print("1")
	end,
	group = autogrp,
})

-- vim: ts=2 sw=2 tw=120
