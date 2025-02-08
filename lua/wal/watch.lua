--[[ wal.nvim/lua/wal/watch.lua
The general idea behind all of this code comes from https://github.com/rktjmp/fwatch.nvim. ]]

local log = vim.log
local uv = vim.uv

---@class FileWatcher
---@field path string
---@field callback function|nil
---@field flags table|nil
---@field event_handle number
local FileWatcher = {}

FileWatcher.file_path = nil
FileWatcher.callback = nil
FileWatcher.flags = nil
FileWatcher.event_handle = nil

---@param opts table|nil
---@param callback function|nil
---@param path string
---@return self FileWatcher
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
	self.event_handle = uv.new_fs_event()
	if not self.event_handle then
		vim.notify("FileWatcher Error: Could not generate event handle.", log.levels.ERROR)
	end
	return self
end

---@return boolean success
function FileWatcher:stop()
	if not uv.fs_event_stop(self.event_handle) then
		vim.notify("FileWatcher Error: Could not generate stop file watcher.", log.levels.ERROR)
		return false
	else
		return true
	end
end

---@return boolean success
function FileWatcher:start()
	local event_callback = function(err, filename, events)
		if err then
			self:stop()
			vim.notify("FileWatcher Error: " .. err, log.levels.ERROR)
		else
			self:stop()
			self.callback(err, filename, events)
		end
	end
	if not uv.fs_event_start(self.event_handle, self.path, self.flags, event_callback) then
		vim.notify("FileWatcher Error: Could not start file watcher.", log.levels.ERROR)
		return false
	else
		return true
	end
end

return FileWatcher
