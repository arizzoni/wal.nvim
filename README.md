# wal.nvim
## A Lush Theme for Neovim

This is a small Neovim colorscheme written in Lua that gets colors from any
colorscheme generation program like Wal, Pywal, etc., as long as the program
can produce a .json file in the standard wal colorscheme format. This plugin is
a spiritual successor to Lushwal.nvim, but is written in pure Lua.

The colorscheme reads a standard Wal-format .json file and uses the colors to
create a nice colorscheme with Lush. The only planned configuration option is
to specify the filesystem location of the colors.json file. Some additional
configuration options may be considered in the future. If there is a plugin
that the colorscheme does not support, and that you would like to see support
for, please submit a pull request.

## TODO
1.  Get file watcher working
2.  Finalize color assignments

## Future Improvements
1.  Asynchronous file watch + file read
2.  Add debug/error messages + logging

## Installation (lazy.nvim)
```Lua
return {
  url = "https://www.github.com/arizzoni/wal.nvim",
  dependencies = {
    { url = "https://www.github.com/rktjmp/lush.nvim" },
  },
  lazy = true,
  opts = {
    wal_path = "/home/air/.cache/wal/colors.json",
  },
}
```
