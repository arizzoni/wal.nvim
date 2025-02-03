local Wal = {}

Wal.options = {}
Wal.default_options = { wal_path = "~/.cache/wal/colors.json" }

function Wal.setup(opts)
	vim.notify("Entering function wal.setup()")
	if opts then
		Wal.options = vim.tbl_extend("force", Wal.options, opts)
	else
		Wal.options = vim.tbl_extend("force", Wal.options, Wal.default_options)
	end
end

return Wal

-- vim: ts=2 sw=2 tw=120
