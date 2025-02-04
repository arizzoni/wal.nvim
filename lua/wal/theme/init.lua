local Theme = {}

Theme.path = vim.g.wal_path
Theme.ns_id = 0
Theme.termguicolors = false
Theme.colors = {}

function Theme.new(path)
	local self = setmetatable({}, Theme)
	self.__index = Theme
	self.termguicolors = vim.opt.termguicolors
	self.ns_id = vim.api.nvim_create_namespace("wal.nvim@" .. path)
	self.path = path
	return self
end

function Theme:load_colors()
	local fd = vim.uv.fs_open(self.path, "r", 438)
	if fd then
		local stat = vim.uv.fs_fstat(fd)
		if stat then
			local raw_json = vim.uv.fs_read(fd, stat.size, 0)
			vim.uv.fs_close(fd)
			if raw_json then
				local wal = vim.json.decode(raw_json)
				if wal then
					self.colors = wal.colors
					self.colors.background = wal.special.background
					self.colors.foreground = wal.special.foreground
					self.colors.cursor = wal.special.cursor
				else
					vim.notify("Wal.nvim Error: Could not decode json data in " .. self.path, vim.log.levels.ERROR)
					return false
				end
			else
				vim.notify("Wal.nvim Error: Could not close " .. self.path, vim.log.levels.ERROR)
				return false
			end
		else
			vim.notify("Wal.nvim Error: Could not read " .. self.path, vim.log.levels.ERROR)
			return false
		end
	else
		vim.notify("Wal.nvim Error: Could not open " .. self.path, vim.log.levels.ERROR)
		return false
	end
	return true
end

function Theme:generate()
	if not self.colors.color15 then
		self:load_colors()
	end

	local allow_bold = true
	local allow_italic = true
	local allow_underline = true
	local allow_strikethrough = true

	local function set_hl(group, options)
		vim.schedule(function()
			vim.api.nvim_set_hl(self.ns_id, group, options)
		end)
		return true
	end

	set_hl("Comment", { italic = allow_italic, fg = self.colors.color5, ctermfg = 8 })
	set_hl("ColorColumn", { fg = self.colors.color8, bg = self.colors.color8, ctermfg = 8, ctermbg = 8 })
	set_hl("Conceal", { fg = self.colors.color0, ctermfg = 0 })
	set_hl("Cursor", { fg = self.colors.color0, bg = self.colors.color15, ctermfg = 0, ctermbg = 15 })
	set_hl("lCursor", { link = "Cursor" })
	set_hl("CursorIM", { link = "Cursor" })
	set_hl("CursorColumn", { fg = self.colors.color0, bg = self.colors.color0, ctermfg = 0, ctermbg = 0 })
	set_hl("CursorLine", { fg = self.colors.color15, bg = self.colors.color0, ctermfg = 15, ctermbg = 0 })
	set_hl("CursorLineNr", {
		link = "CursorLine",
		fg = self.colors.color0,
		bg = self.colors.color15,
		ctermfg = 0,
		ctermbg = 15,
		bold = allow_bold,
	})
	set_hl("Directory", { fg = self.colors.color4, ctermfg = 4 })
	set_hl("DiffAdd", { fg = self.colors.color1, ctermfg = 1 })
	set_hl("DiffChange", { fg = self.colors.color2, ctermfg = 2 })
	set_hl("DiffDelete", { fg = self.colors.color3, ctermfg = 3 })
	set_hl("DiffText", { link = "Normal", bg = self.colors.color8, ctermbg = 8 })
	set_hl("EndOfBuffer", { link = "Normal", bg = self.colors.color8, ctermbg = 8 })
	set_hl("ErrorMsg", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("VertSplit", { fg = self.colors.color8, bg = self.colors.background, ctermfg = 8, ctermbg = 0 })
	set_hl("WinSeparator", { fg = self.colors.color8, bg = self.colors.color0, ctermfg = 8, ctermbg = 0 })
	set_hl("Folded", { fg = self.colors.color8, bg = self.colors.color0, ctermfg = 8, ctermbg = 0 })
	set_hl("FoldColumn", { fg = self.colors.color8, bg = self.colors.color0, ctermfg = 8, ctermbg = 0 })
	set_hl("SignColumn", { fg = self.colors.color8, ctermfg = 8 })
	set_hl("SignColumnSB", { fg = self.colors.color8, ctermfg = 8 })
	set_hl("Substitute", { fg = self.colors.color9, bg = self.colors.color1, ctermfg = 9, ctermbg = 1 })
	set_hl("LineNr", { fg = self.colors.color15, ctermfg = 15, bold = allow_bold })
	set_hl("LineNrAbove", { fg = self.colors.color8, ctermfg = 8, bold = allow_bold })
	set_hl("LineNrBelow", { link = "LineNrAbove" })
	set_hl(
		"MatchParen",
		{ bold = allow_bold, fg = self.colors.color0, bg = self.colors.color15, ctermfg = 0, ctermbg = 15 }
	)
	set_hl("ModeMsg", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("MsgArea", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("MoreMsg", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("NonText", { ctermfg = 8 })
	set_hl("Normal", { fg = self.colors.color15, bg = self.colors.background, ctermfg = 15, ctermbg = 0 })
	set_hl("NormalNC", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("NormalSB", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("NormalFloat", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("Float", { fg = self.colors.color15, ctermfg = 15 })
	set_hl(
		"FloatBorder",
		{ bold = allow_bold, fg = self.colors.color15, bg = self.colors.color8, ctermfg = 15, ctermbg = 8 }
	)
	set_hl(
		"FloatTitle",
		{ bold = allow_bold, fg = self.colors.color15, bg = self.colors.color8, ctermfg = 15, ctermbg = 8 }
	)
	set_hl("Pmenu", { fg = self.colors.color15, bg = self.colors.color0, ctermfg = 15, ctermbg = 0 })
	set_hl("PmenuMatch", { fg = self.colors.color15, bg = self.colors.color8, ctermfg = 15, ctermbg = 8 })
	set_hl("PmenuSel", { link = "Normal", bold = allow_bold })
	set_hl("PmenuMatchSel", { link = "PmenuSel", bg = self.colors.color8, ctermbg = 8 })
	set_hl("PmenuSbar", { link = "PmenuSel" })
	set_hl("PmenuThumb", { link = "Normal" })
	set_hl("Question", { fg = self.colors.color9, bg = self.colors.color0, ctermfg = 9, ctermbg = 0 })
	set_hl("QuickFixLine", { fg = self.colors.color10, bg = self.colors.color0, ctermfg = 10, ctermbg = 0 })
	set_hl("Search", { fg = self.colors.color15, bg = self.colors.color11, ctermfg = 15, ctermbg = 11 })
	set_hl("IncSearch", { fg = self.colors.color15, bg = self.colors.color11, ctermfg = 15, ctermbg = 11 })
	set_hl("CurSearch", { link = "IncSearch" })
	set_hl("SpecialKey", { fg = self.colors.color0, ctermfg = 0 })
	set_hl("SpellBad", { underline = allow_underline, fg = self.colors.color1, ctermfg = 1 })
	set_hl("SpellCap", { underline = allow_underline, fg = self.colors.color2, ctermfg = 2 })
	set_hl("SpellLocal", { underline = allow_underline, fg = self.colors.color3, ctermfg = 3 })
	set_hl("SpellRare", { underline = allow_underline, fg = self.colors.color4, ctermfg = 4 })
	set_hl("StatusLine", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("StatusLineNC", { fg = self.colors.color8, bg = self.colors.color0, ctermfg = 8, ctermbg = 0 })
	set_hl(
		"StatusLineNormal",
		{ bold = allow_bold, fg = self.colors.color15, bg = self.colors.color1, ctermfg = 15, ctermbg = 1 }
	)
	set_hl("StatusLineInsert", { link = "StatusLineNormal", bg = self.colors.color2, ctermbg = 2 })
	set_hl("StatusLineVisual", { link = "StatusLineNormal", bg = self.colors.color3, ctermbg = 3 })
	set_hl("StatusLineCommand", { link = "StatusLineNormal", bg = self.colors.color4, ctermbg = 4 })
	set_hl("StatusLineReplace", { link = "StatusLineNormal", bg = self.colors.color5, ctermbg = 5 })
	set_hl("StatusLineSelect", { link = "StatusLineNormal", bg = self.colors.color6, ctermbg = 6 })
	set_hl("StatusLineTerminal", { link = "StatuslineNormal", bg = self.colors.color8, ctermbg = 8 })
	set_hl("StatusLineDiagnostics", { fg = self.colors.color15, bg = self.colors.color0, ctermfg = 15, ctermbg = 0 })
	set_hl("StatusLineFilepath", { fg = self.colors.color12, ctermfg = 12 })
	set_hl("StatusLineLSP", { fg = self.colors.color8, ctermfg = 8 })
	set_hl("StatusLineFileInfo", { fg = self.colors.color8, ctermfg = 8 })
	set_hl("StatusLineModified", { fg = self.colors.color8, ctermfg = 8 })
	set_hl("StatusLineVersionControl", { fg = self.colors.color5, ctermfg = 5 })
	set_hl("StatusLineCursorPos", { fg = self.colors.color15, bg = self.colors.color1, ctermfg = 15, ctermbg = 1 })
	set_hl("TabLineCurrentTab", { fg = self.colors.color15, bg = self.colors.color1, ctermfg = 15, ctermbg = 1 })
	set_hl("TabLineTabs", { fg = self.colors.color15, bg = self.colors.color2, ctermfg = 15, ctermbg = 2 })
	set_hl("TabLineCurrentBuf", { fg = self.colors.color15, bg = self.colors.color3, ctermfg = 15, ctermbg = 3 })
	set_hl("TabLineBufs", { fg = self.colors.color15, bg = self.colors.color4, ctermfg = 15, ctermbg = 4 })
	set_hl("TabLine", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("TabLineFill", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("TabLineSel", { fg = self.colors.color15, bg = self.colors.color0, ctermfg = 15, ctermbg = 0 })
	set_hl("Title", { bold = allow_bold, fg = self.colors.color15, bg = self.colors.color0, ctermfg = 15, ctermbg = 0 })
	set_hl("Visual", { fg = self.colors.color0, bg = self.colors.color15, ctermfg = 0, ctermbg = 15 })
	set_hl("VisualNOS", { fg = self.colors.color0, bg = self.colors.color8, ctermfg = 0, ctermbg = 8 })
	set_hl("WarningMsg", { fg = self.colors.color15, bg = self.colors.color12, ctermfg = 15, ctermbg = 12 })
	set_hl("Whitespace", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("WildMenu", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("WinBar", { fg = self.colors.color15, bg = self.colors.color0, ctermfg = 15, ctermbg = 0 })
	set_hl("WinBarNC", { fg = self.colors.color15, bg = self.colors.color8, ctermfg = 15, ctermbg = 8 })

	set_hl("Array", { link = "Float" })
	set_hl("Class", { link = "Structure" })
	set_hl("Color", { link = "Special" })
	set_hl("Constructor", { link = "Function" })
	set_hl("Enum", { link = "Constant" })
	set_hl("EnumMember", { link = "Constant" })
	set_hl("Event", { link = "Special" })
	set_hl("Field", { link = "Variable" })
	set_hl("File", { link = "Normal" })
	set_hl("Folder", { link = "Directory" })
	set_hl("Interface", { link = "Function" })
	set_hl("Key", { link = "Variable" })
	set_hl("Method", { link = "Function" })
	set_hl("Module", { link = "Include" })
	set_hl("Namespace", { link = "Include" })
	set_hl("Null", { link = "Constant" })
	set_hl("Number", { link = "Normal", ctermfg = 2 })
	set_hl("Object", { link = "Constant" })
	set_hl("Package", { link = "Include" })
	set_hl("Reference", { link = "Special" })
	set_hl("Snippet", { link = "Conceal" })
	set_hl("Struct", { link = "Structure" })
	set_hl("Unit", { link = "Structure" })
	set_hl("Text", { link = "Normal" })
	set_hl("TypeParameter", { link = "Type" })
	set_hl("Variable", { fg = self.colors.color4, ctermfg = 4 })
	set_hl("Value", { link = "String", italic = false })

	set_hl("Boolean", { bold = allow_bold, fg = self.colors.color3, ctermfg = 3 })
	set_hl("Bold", { link = "Normal", bold = allow_bold })
	set_hl("Character", { italic = allow_italic, fg = self.colors.color12, ctermfg = 12 })
	set_hl("Constant", { fg = self.colors.color5, ctermfg = 5 })
	set_hl("Constructor", { fg = self.colors.color2, ctermfg = 2 })
	set_hl("Debug", { bold = allow_bold, fg = self.colors.color5, ctermfg = 5 })
	set_hl("Delimiter", { fg = self.colors.color15, ctermfg = 15 })
	set_hl("Define", { bold = allow_bold, fg = self.colors.color3, ctermfg = 3 })
	set_hl("Error", { fg = self.colors.color9, ctermfg = 9 })
	set_hl("Exception", { fg = self.colors.color9, ctermfg = 9 })
	set_hl("Function", { bold = allow_bold, fg = self.colors.color2, ctermfg = 2 })
	set_hl("Identifier", { fg = self.colors.color14, ctermfg = 14 })
	set_hl("Italic", { link = "Normal", italic = allow_italic })
	set_hl("Include", { bold = allow_bold, fg = self.colors.color10, ctermfg = 10 })
	set_hl("Keyword", { bold = allow_bold, fg = self.colors.color2, ctermfg = 2 })
	set_hl("Label", { fg = self.colors.color12, ctermfg = 12 })
	set_hl("Macro", { fg = self.colors.color2, ctermfg = 2 })
	set_hl("Operator", { link = "Normal", bold = allow_bold })
	set_hl("PreProc", { fg = self.colors.color1, ctermfg = 1 })
	set_hl("Property", { fg = self.colors.color13, ctermfg = 13 })
	set_hl("Repeat", { bold = allow_bold, fg = self.colors.color10, ctermfg = 10 })
	set_hl("SpecialChar", { bold = allow_bold, fg = self.colors.color12, ctermfg = 12 })
	set_hl("Special", { fg = self.colors.color6, ctermfg = 6 })
	set_hl("Statement", { fg = self.colors.color2, ctermfg = 2 })
	set_hl("StorageClass", { fg = self.colors.color3, ctermfg = 3 })
	set_hl("String", { italic = allow_italic, fg = self.colors.color4, ctermfg = 4 })
	set_hl("Structure", { bold = allow_bold, fg = self.colors.color3, ctermfg = 3 })
	set_hl("Todo", { bold = allow_bold, fg = self.colors.color0, bg = self.colors.color15, ctermfg = 0, ctermbg = 15 })
	set_hl("Type", { fg = self.colors.color13, ctermfg = 13 })
	set_hl("Typedef", { fg = self.colors.color13, ctermfg = 13 })
	set_hl("Underlined", { link = "Normal", underline = allow_underline })

	set_hl("DiagnosticError", { link = "Error" })
	set_hl("DiagnosticWarn", { link = "WarningMsg" })
	set_hl("DiagnosticInfo", { link = "Normal" })
	set_hl("DiagnosticHint", { link = "Normal" })
	set_hl("DiagnosticUnnecessary", { link = "WarningMsg" })
	set_hl("DiagnosticVirtualTextError", { link = "DiagnosticError" })
	set_hl("DiagnosticVirtualTextWarn", { link = "DiagnosticWarningMsg" })
	set_hl("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
	set_hl("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
	set_hl("DiagnosticUnderlineError", { link = "DiagnosticError" })
	set_hl("DiagnosticUnderlineWarn", { link = "DiagnosticWarningMsg" })
	set_hl("DiagnosticUnderlineInfo", { link = "DiagnosticHint" })
	set_hl("DiagnosticUnderlineHint", { link = "DiagnosticHint" })

	set_hl("healthError", { link = "Error" })
	set_hl("healthSuccess", { link = "Normal" })
	set_hl("healthWarning", { link = "WarningMsg" })

	set_hl("diffAdded", { link = "DiffAdd" })
	set_hl("diffRemoved", { link = "DiffDelete" })
	set_hl("diffChanged", { link = "DiffChange" })
	set_hl("diffOldFile", { link = "DiffChange", italic = allow_italic })
	set_hl("diffNewFile", { link = "DiffChange", bold = allow_bold })
	set_hl("diffFile", { link = "Comment" })
	set_hl("diffLine", { link = "Comment" })
	set_hl("diffIndexLine", { link = "DiffChange", fg = self.colors.color4, ctermfg = 4 })
	set_hl("helpExample", { link = "Comment" })

	set_hl("CmpDocumentation", { link = "Float" })
	set_hl("CmpDocumentation", { link = "FloatBorder" })
	set_hl("CmpGhostText", { link = "Conceal" })
	set_hl("CmpItemAbbr", { link = "Float" })
	set_hl("CmpItemAbbrDeprecated", { link = "Float", strikethrough = allow_strikethrough })
	set_hl("CmpItemAbbrMatch", { link = "Float", bold = allow_bold })
	set_hl("CmpItemAbbrMatchFuzzy", { link = "Float", bold = allow_bold })
	set_hl("CmpItemKindDefault", { link = "Float" })
	set_hl("CmpItemMenu", { link = "Float" })

	set_hl("DapStoppedLine", { link = "WarningMsg" })

	set_hl("GitSignsAdd", { link = "DiffAdd" })
	set_hl("GitSignsChange", { link = "DiffChange" })
	set_hl("GitSignsDelete", { link = "DiffDelete" })

	set_hl("IndentBlankLineChar", { fg = self.colors.color0, ctermfg = 0 })
	set_hl("IndentBlankLineContextChar", { fg = self.colors.color8, ctermfg = 8 })
	set_hl("IblIndent", { link = "IndentBlankLineChar", nocombine = true })
	set_hl("IblScope", { link = "IndentBlankLineContextChar", nocombine = true })

	set_hl("LazyProgressDone", { link = "Float", bold = allow_bold })
	set_hl("LazyProgressTodo", { link = "Float", bold = allow_bold })

	set_hl("TreesitterContext", { link = "Comment" })
	set_hl("TreesitterContextBottom", { link = "Comment" })
	set_hl("TreesitterContextSeparator", { link = "Comment" })
	set_hl("TreesitterContextLineNumber", { link = "Comment" })
	set_hl("TreesitterContextLineNumberBottom", { link = "Comment" })

	set_hl("WhichKey", { link = "Float" })
	set_hl("WhichKeyGroup", { link = "Float" })
	set_hl("WhichKeyDesc", { link = "Float" })
	set_hl("WhichKeySeparator", { link = "Float" })
	set_hl("WhichKeyNormal", { link = "Float" })
	set_hl("WhichKeyValue", { link = "Float" })

	set_hl("@annotation", { link = "PreProc" })
	set_hl("@attribute", { link = "PreProc" })
	set_hl("@boolean", { link = "Boolean" })
	set_hl("@character", { link = "Character" })
	set_hl("@character.printf", { link = "SpecialChar" })
	set_hl("@character.special", { link = "SpecialChar" })
	set_hl("@comment", { link = "Comment" })
	set_hl("@constant", { link = "Constant" })
	set_hl("@constant.builtin", { link = "Special" })
	set_hl("@constant.macro", { link = "Define" })
	set_hl("@constructor", { link = "Constructor" })
	set_hl("@diff.delta", { link = "DiffChange" })
	set_hl("@diff.minus", { link = "DiffDelete" })
	set_hl("@diff.plus", { link = "DiffAdd" })
	set_hl("@exception", { link = "Exception" })
	set_hl("@field", { link = "String" })
	set_hl("@function", { link = "Function" })
	set_hl("@function.builtin", { link = "Special" })
	set_hl("@function.call", { link = "Function" })
	set_hl("@function.macro", { link = "Macro" })
	set_hl("@function.method", { link = "Function" })
	set_hl("@function.method.call", { link = "Function" })
	set_hl("@keyword", { link = "Keyword" })
	set_hl("@keyword.conditional", { link = "Conditional" })
	set_hl("@keyword.coroutine", { link = "Keyword" })
	set_hl("@keyword.debug", { link = "Debug" })
	set_hl("@keyword.directive", { link = "PreProc" })
	set_hl("@keyword.directive.define", { link = "Define" })
	set_hl("@keyword.exception", { link = "Exception" })
	set_hl("@keyword.function", { link = "Function" })
	set_hl("@keyword.import", { link = "Include" })
	set_hl("@keyword.operator", { link = "Operator" })
	set_hl("@keyword.repeat", { link = "Repeat" })
	set_hl("@keyword.return", { link = "Keyword" })
	set_hl("@keyword.storage", { link = "StorageClass" })
	set_hl("@label", { link = "Label" })
	set_hl("@markup", { link = "Normal" })
	set_hl("@markup.emphasis", { link = "Normal" })
	set_hl("@markup.environment", { link = "Macro" })
	set_hl("@markup.environment.name", { link = "Type" })
	set_hl("@markup.heading", { link = "Title" })
	set_hl("@markup.italic", { link = "Normal" })
	set_hl("@markup.link", { link = "Special" })
	set_hl("@markup.link.label", { link = "SpecialChar" })
	set_hl("@markup.link.label.symbol", { link = "Identifier" })
	set_hl("@markup.link.url", { link = "Underlined" })
	set_hl("@markup.list", { link = "Function" })
	set_hl("@markup.list.checked", { link = "Function" })
	set_hl("@markup.list.markdown", { link = "PreProc" })
	set_hl("@markup.list.unchecked", { link = "Macro" })
	set_hl("@markup.math", { link = "Special" })
	set_hl("@markup.raw", { link = "String" })
	set_hl("@markup.raw.markdown_inline", { link = "String" })
	set_hl("@markup.strikethrough", { link = "Normal" })
	set_hl("@markup.strong", { link = "Normal" })
	set_hl("@markup.underline", { link = "Normal" })
	set_hl("@method", { link = "Function" })
	set_hl("@module", { link = "Include" })
	set_hl("@module.builtin", { link = "Include" })
	set_hl("@namespace", { link = "Structure" })
	set_hl("@namespace.builtin", { link = "Structure" })
	set_hl("@none", {})
	set_hl("@number", { link = "Number" })
	set_hl("@number.float", { link = "Float" })
	set_hl("@operator", { link = "Operator" })
	set_hl("@preproc", { link = "PreProc" })
	set_hl("@property", { link = "Property" })
	set_hl("@punctuation.bracket", { link = "Normal" })
	set_hl("@punctuation.delimiter", { link = "Normal" })
	set_hl("@punctuation.special", { link = "Normal" })
	set_hl("@punctuation.special.markdown", { link = "Normal" })
	set_hl("@string", { link = "String" })
	set_hl("@string.documentation", { link = "Normal" })
	set_hl("@string.escape", { link = "String" })
	set_hl("@string.regexp", { link = "String" })
	set_hl("@symbol", { link = "Character" })
	set_hl("@tag", { link = "Label" })
	set_hl("@tag.attribute", { link = "Property" })
	set_hl("@tag.delimiter", { link = "Property" })
	set_hl("@text", { link = "Normal" })
	set_hl("@text.bold", { link = "Bold" })
	set_hl("@text.danger", { link = "Error" })
	set_hl("@text.diff.add", { link = "DiffAdd" })
	set_hl("@text.diff.delete", { link = "DiffDelete" })
	set_hl("@text.emphasis", { link = "Italic" })
	set_hl("@text.environment", { link = "Bold" })
	set_hl("@text.environment.name", { link = "Bold" })
	set_hl("@text.literal", { link = "Character" })
	set_hl("@text.math", { link = "Float" })
	set_hl("@text.note", { link = "Label" })
	set_hl("@text.reference", { link = "Tag" })
	set_hl("@text.strike", { link = "Normal" })
	set_hl("@text.strong", { link = "Bold" })
	set_hl("@text.title", { link = "Title" })
	set_hl("@text.todo", { link = "Exception" })
	set_hl("@text.underline", { link = "Underlined" })
	set_hl("@text.uri", { link = "Underlined" })
	set_hl("@type", { link = "Type" })
	set_hl("@type.builtin", { link = "Type" })
	set_hl("@type.definition", { link = "Typedef" })
	set_hl("@type.qualifier", { link = "Keyword" })
	set_hl("@variable", { link = "Variable" })
	set_hl("@variable.builtin", { link = "Variable" })
	set_hl("@variable.member", { link = "Variable" })
	set_hl("@variable.parameter", { link = "Variable" })
	set_hl("@variable.parameter.builtin", { link = "Variable" })

	set_hl("@lsp.type.boolean", { link = "@boolean" })
	set_hl("@lsp.type.builtinType", { link = "@type.builtin" })
	set_hl("@lsp.type.comment", { link = "@comment" })
	set_hl("@lsp.type.decorator", { link = "@attribute" })
	set_hl("@lsp.type.deriveHelper", { link = "@attribute" })
	set_hl("@lsp.type.enum", { link = "@type" })
	set_hl("@lsp.type.enumMember", { link = "@constant" })
	set_hl("@lsp.type.escapeSequence", { link = "@string.escape" })
	set_hl("@lsp.type.formatSpecifier", { link = "@markup.list" })
	set_hl("@lsp.type.generic", { link = "@variable" })
	set_hl("@lsp.type.interface", { link = "@attribute" })
	set_hl("@lsp.type.keyword", { link = "@keyword" })
	set_hl("@lsp.type.lifetime", { link = "@keyword.storage" })
	set_hl("@lsp.type.namespace", { link = "@module" })
	set_hl("@lsp.type.namespace.python", { link = "@variable" })
	set_hl("@lsp.type.number", { link = "@number" })
	set_hl("@lsp.type.operator", { link = "@operator" })
	set_hl("@lsp.type.parameter", { link = "@variable.parameter" })
	set_hl("@lsp.type.property", { link = "@property" })
	set_hl("@lsp.type.selfKeyword", { link = "@variable.builtin" })
	set_hl("@lsp.type.selfTypeKeyword", { link = "@variable.builtin" })
	set_hl("@lsp.type.string", { link = "@string" })
	set_hl("@lsp.type.typeAlias", { link = "@type.definition" })
	set_hl("@lsp.type.unresolvedReference", { link = "@annotation" })
	set_hl("@lsp.type.variable", { link = "@variable" })
	set_hl("@lsp.typemod.class.defaultLibrary", { link = "@type.builtin" })
	set_hl("@lsp.typemod.enum.defaultLibrary", { link = "@type.builtin" })
	set_hl("@lsp.typemod.enumMember.defaultLibrary", { link = "@constant.builtin" })
	set_hl("@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
	set_hl("@lsp.typemod.keyword.async", { link = "@keyword.coroutine" })
	set_hl("@lsp.typemod.keyword.injected", { link = "@keyword" })
	set_hl("@lsp.typemod.macro.defaultLibrary", { link = "@function.builtin" })
	set_hl("@lsp.typemod.method.defaultLibrary", { link = "@function.builtin" })
	set_hl("@lsp.typemod.operator.injected", { link = "@operator" })
	set_hl("@lsp.typemod.string.injected", { link = "@string" })
	set_hl("@lsp.typemod.struct.defaultLibrary", { link = "@type.builtin" })
	set_hl("@lsp.typemod.type.defaultLibrary", { link = "@type.builtin" })
	set_hl("@lsp.typemod.typeAlias.defaultLibrary", { link = "@type.builtin" })
	set_hl("@lsp.typemod.variable.callable", { link = "@function" })
	set_hl("@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
	set_hl("@lsp.typemod.variable.injected", { link = "@variable" })
	set_hl("@lsp.typemod.variable.static", { link = "@constant" })
end

function Theme:apply(winnr)
	vim.schedule(function()
		if winnr then
			vim.api.nvim_win_set_hl_ns(winnr, self.ns_id)
		else
			local wins = vim.api.nvim_list_wins()
			for _, win in pairs(wins) do
				vim.api.nvim_win_set_hl_ns(win, self.ns_id)
			end
		end
	end)

	if self.termguicolors then
		vim.g.terminal_color_0 = 0
		vim.g.terminal_color_1 = 1
		vim.g.terminal_color_2 = 2
		vim.g.terminal_color_3 = 3
		vim.g.terminal_color_4 = 4
		vim.g.terminal_color_5 = 5
		vim.g.terminal_color_6 = 6
		vim.g.terminal_color_7 = 7
		vim.g.terminal_color_8 = 8
		vim.g.terminal_color_9 = 9
		vim.g.terminal_color_10 = 10
		vim.g.terminal_color_11 = 11
		vim.g.terminal_color_12 = 12
		vim.g.terminal_color_13 = 13
		vim.g.terminal_color_14 = 14
		vim.g.terminal_color_15 = 15
	else
		vim.g.terminal_color_0 = self.colors.color0
		vim.g.terminal_color_1 = self.colors.color1
		vim.g.terminal_color_2 = self.colors.color2
		vim.g.terminal_color_3 = self.colors.color3
		vim.g.terminal_color_4 = self.colors.color4
		vim.g.terminal_color_5 = self.colors.color5
		vim.g.terminal_color_6 = self.colors.color6
		vim.g.terminal_color_7 = self.colors.color7
		vim.g.terminal_color_8 = self.colors.color8
		vim.g.terminal_color_9 = self.colors.color9
		vim.g.terminal_color_10 = self.colors.color10
		vim.g.terminal_color_11 = self.colors.color11
		vim.g.terminal_color_12 = self.colors.color12
		vim.g.terminal_color_13 = self.colors.color13
		vim.g.terminal_color_14 = self.colors.color14
		vim.g.terminal_color_15 = self.colors.color15
	end

	return true
end

return Theme
