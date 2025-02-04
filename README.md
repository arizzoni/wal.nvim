# wal.nvim

## A Wal Theme for Neovim v0.10+
This is a Neovim colorscheme written in Lua that can load colors from any
colorscheme generation program like Wal, Pywal, etc., as long as the program
can produce a .json file in the standard wal colorscheme format. The author
recommends Wallust, linked below, for the project's use of advanced and varied
clustering algorithms.

The colorscheme reads a standard Wal-format colors.json file and uses the
colors to create a nice colorscheme. The only planned configuration option is
to specify the filesystem location of the colors.json file. Some additional
configuration options may be considered in the future. If there is a plugin
that the colorscheme does not support, and that you would like to see support
for, please submit a pull request.

The plugin uses Neovim's integrated libuv library to watch the colors.json file
specified as a path string in vim.g.wal_path and update the colorscheme when
the file changes. Neovim's built in highlighting functions are used so there
are no dependencies and wherever possible the use of legacy vimscript functions
has been minimized.

### Inspiration and Referenced Works
I am extremely grateful to the open source community for their help in writing
this plugin. I referenced several other projects during this work, and I would
like to give lots of credit to where it is due. This plugin was inspired by
the great work done on the following projects:

- [oncomouse/lushwal.nvim](https://github.com/oncomouse/lushwal.nvim)
- [rktjmp/fwatch.nvim](https://github.com/rktjmp/fwatch.nvim)
- [explosion-mental/wallust](https://codeberg.org/explosion-mental/wallust)
- [eylles/pywal16](https://github.com/eylles/pywal16)
- [dylanaraps/pywal](https://github.com/dylanaraps/pywal)
- [zenbones-theme/zenbones.nvim](https://github.com/zenbones-theme/zenbones.nvim)

### Installation (lazy.nvim)
```Lua
return {
	url = "https://www.github.com/arizzoni/wal.nvim",
	config = function()
		vim.g.wal_path = "/path/to/colors.json"
	end,
}
```
