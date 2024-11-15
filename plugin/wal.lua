-- Autocommand to start the cycle at VimEnter
local autogrp = vim.api.nvim_create_augroup("wal", {})
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		local wal = require("wal")
		local uv = vim.uv
		local fullpath = uv.fs_realpath(wal.options.wal_path) or wal.options.wal_path
		local watch = {}
		watch.event = nil

		function watch.on_change(fname)
			wal.setup()
			watch.event:stop()
			watch.event = nil
			watch.file(fname)
		end

		function watch.file(fname)
			watch.event = uv.new_fs_event()
			watch.event:start(fname, {}, vim.schedule_wrap(function()
				watch.on_change(fname)
			end))
		end

		watch.file(fullpath)
	end,
	group = autogrp,
})

-- vim: ts=2 sw=2 tw=120
