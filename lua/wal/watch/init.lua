local FileWatcher = {}
-- The general idea behind all of this code comes from https://github.com/rktjmp/fwatch.nvim. I reduced the size of the
-- implementation slightly to better suit the application, but I did not truly understand what I was doing with libuv
-- until I found rktjmp's implementation and played around with it. Big thanks to them for their work on the fwatch.nvim
-- reference implementation at https://github.com/rktjmp/fwatch.nvim.

FileWatcher.file_path = nil
FileWatcher.callback = nil
FileWatcher.flags = nil
FileWatcher.event_handle = nil

function FileWatcher.new(path, callback, opts)
	local self = setmetatable({}, FileWatcher)
	FileWatcher.__index = FileWatcher
	self.path = path
	self.callback = callback
	if opts then
		self.flags = opts.flags
	else
		self.flags = {}
	end
	self.event_handle = vim.uv.new_fs_event()
	if not self.event_handle then
		vim.notify("FileWatcher Error: Could not generate event handle.", vim.log.levels.ERROR)
		return false
	end
	return self
end

function FileWatcher:stop()
	if not vim.uv.fs_event_stop(self.event_handle) then
		vim.notify("FileWatcher Error: Could not generate stop file watcher.", vim.log.levels.ERROR)
		return false
	end
end

function FileWatcher:start()
	local event_callback = function(err, filename, events)
		if err then
			self:stop()
			vim.notify("FileWatcher Error: " .. err, vim.log.levels.ERROR)
		else
			self:stop()
			self.callback(err, filename, events)
		end
	end
	if not vim.uv.fs_event_start(self.event_handle, self.path, self.flags, event_callback) then
		vim.notify("FileWatcher Error: Could not start file watcher.", vim.log.levels.ERROR)
	end
end

return FileWatcher
