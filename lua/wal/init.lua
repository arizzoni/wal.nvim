-- wal.nvim
local M = {}

M.options = nil
M.default_options = {
	wal_path = "~/.cache/wal/colors.json"
}

function M.setup(options)
	options = options or {}
	M.options = vim.tbl_deep_extend("force", M.default_options, options)
	require("lush")(require("wal.theme"))
end

function M.get_colors()
	local json = vim.json

	local function read_file(path)
		local uv = vim.uv
		local fd = assert(uv.fs_open(path, "r", 438))
		local stat = assert(uv.fs_fstat(fd))
		local data = assert(uv.fs_read(fd, stat.size, 0))
		assert(uv.fs_close(fd))
		return data
	end

	local raw_json = read_file(M.options.wal_path)
	return json.decode(raw_json)
end

return M

-- vim: ts=2 sw=2 tw=120
