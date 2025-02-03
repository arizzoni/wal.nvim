local FileWatcher = {}

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
	return self
end

function FileWatcher:stop()
	vim.uv.fs_event_stop(self.event_handle)
end

function FileWatcher:start()
	local event_callback = function(err, filename, events)
		if err then
			self:stop()
			vim.notify("FileWatcher Error")
		else
			self:stop()
			self.callback(err, filename, events)
		end
	end
	vim.uv.fs_event_start(self.event_handle, self.path, self.flags, event_callback)
end

return FileWatcher
