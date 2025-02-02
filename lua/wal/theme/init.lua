local lush = require("lush")
local wal_colors = require("wal").get_colors()
local colors, special

if not wal_colors then
	return
else
	colors = wal_colors.colors
	special = wal_colors.special
end

-- colors.color0 = '0'
-- colors.color1 = '1'
-- colors.color2 = '2'
-- colors.color3 = '3'
-- colors.color4 = '4'
-- colors.color5 = '5'
-- colors.color6 = '6'
-- colors.color7 = '7'
-- colors.color8 = '8'
-- colors.color9 = '9'
-- colors.color10 = '10'
-- colors.color11 = '11'
-- colors.color12 = '12'
-- colors.color13 = '13'
-- colors.color14 = '14'
-- colors.color15 = '15'

local function set_terminal_theme()
	-- vim.notify("Setting terminal theme...")
	if not colors then
		return false
	end

	vim.g.terminal_color_0 = colors.color0
	vim.g.terminal_color_1 = colors.color1
	vim.g.terminal_color_2 = colors.color2
	vim.g.terminal_color_3 = colors.color3
	vim.g.terminal_color_4 = colors.color4
	vim.g.terminal_color_5 = colors.color5
	vim.g.terminal_color_6 = colors.color6
	vim.g.terminal_color_7 = colors.color7
	vim.g.terminal_color_8 = colors.color8
	vim.g.terminal_color_9 = colors.color9
	vim.g.terminal_color_10 = colors.color10
	vim.g.terminal_color_11 = colors.color11
	vim.g.terminal_color_12 = colors.color12
	vim.g.terminal_color_13 = colors.color13
	vim.g.terminal_color_14 = colors.color14
	vim.g.terminal_color_15 = colors.color15

	return true
end

local function set_lualine_theme()
	-- vim.notify("Setting lualine theme...")
	if not colors or not special then
		return false
	end

	-- Normal Mode:
	local normal_fg = special.foreground
	local normal_bg = colors.color0

	-- Insert Mode:
	local insert_fg = special.foreground
	local insert_bg = colors.color1

	-- Visual Mode:
	local visual_fg = special.foreground
	local visual_bg = colors.color2

	-- Replace Mode:
	local replace_fg = special.foreground
	local replace_bg = colors.color3

	-- Command Mode:
	local command_fg = special.foreground
	local command_bg = colors.color4

	-- Statusline:
	local statusline_active_fg = special.foreground
	local statusline_active_bg = special.background
	local statusline_inactive_fg = special.foreground
	local statusline_inactive_bg = special.background

	local wal = {
		visual = {
			a = { fg = visual_fg, bg = visual_bg, gui = "bold" },
			b = { fg = visual_fg, bg = colors.color0 },
		},
		replace = {
			a = { fg = replace_fg, bg = replace_bg, gui = "bold" },
			b = { fg = replace_fg, bg = colors.color0 },
		},
		command = {
			a = { fg = command_fg, bg = command_bg, gui = "bold" },
			b = { fg = command_fg, bg = colors.color0 },
		},
		inactive = {
			a = { fg = statusline_inactive_fg, bg = statusline_inactive_bg },
			b = { fg = statusline_inactive_fg, bg = statusline_inactive_bg },
			c = { fg = statusline_inactive_fg, bg = statusline_inactive_bg },
		},
		normal = {
			a = { fg = normal_fg, bg = normal_bg, gui = "bold" },
			b = { fg = normal_fg, bg = colors.color0 },
			c = { fg = statusline_active_fg, bg = statusline_active_bg },
		},
		insert = {
			a = { fg = insert_fg, bg = insert_bg, gui = "bold" },
			b = { fg = insert_fg, bg = colors.color0 },
		},
	}
	require("lualine").setup({ options = { theme = wal } })

	return true
end

local set_theme = lush(function(injected_functions)
	-- set_lualine_theme()
	set_terminal_theme()

	local sym = injected_functions.sym
	local spec = {
		-- selene: allow(undefined_variable)
		---@diagnostic disable: undefined-global
		Normal({ fg = special.foreground, bg = special.background }),
		Bold({ Normal, gui = "bold" }),
		Italic({ Normal, gui = "italic" }),

		Debug({ fg = colors.color1 }),
		Directory({ fg = colors.color4 }),
		Error({ fg = colors.color1, bg = colors.color15 }),
		ErrorMsg({ fg = colors.color1, bg = special.background }),
		Exception({ fg = colors.color1 }),
		FoldColumn({ fg = colors.color4, bg = special.background }),
		Folded({ fg = colors.color7, bg = colors.color15, gui = "italic" }),
		IncSearch({ fg = colors.color15, bg = colors.color2 }),

		VertSplit({ fg = colors.color7, bg = special.background }),
		WinSeparator({ VertSplit }),

		Macro({ fg = colors.color1 }),
		MatchParen({ fg = special.foreground, bg = colors.color8 }),
		ModeMsg({ fg = colors.color2 }),
		MoreMsg({ fg = colors.color2 }),
		Question({ fg = colors.color4 }),
		Search({ fg = colors.color8, bg = colors.color3 }),
		SpecialKey({ fg = colors.color8 }),
		TooLong({ fg = colors.color1 }),
		Underlined({ Normal, sp = Normal.fg, gui = "underlined" }),
		Visual({ bg = colors.color7, fg = special.background }),
		VisualNOS({ fg = colors.color1 }),
		WarningMsg({ fg = colors.color1 }),
		WildMenu({ fg = special.foreground, bg = colors.color4 }),
		Title({ fg = colors.color4, gui = "bold" }),
		Conceal({ fg = colors.color15, bg = special.background }),
		Whitespace({ Conceal }),
		Cursor({ fg = special.background, bg = colors.color14 }),
		NonText({ fg = colors.color8 }),
		EndOfBuffer({ fg = special.foreground, bg = special.background }),
		SignColumn({ fg = colors.color7, bg = special.background }),
		LineNr({ fg = colors.color8, bg = special.background }),
		ColorColumn({ fg = colors.color7, bg = colors.color6 }),
		CursorColumn({ fg = colors.color7 }),
		CursorLine({ fg = colors.color15, gui = "None" }),
		CursorLineNr({ fg = special.foreground, bg = special.background, gui = "bold" }),
		PMenu({ fg = colors.color7, bg = colors.color15 }),
		PMenuSel({ fg = special.foreground, bg = colors.color4 }),
		PmenuSbar({ fg = colors.color7 }),
		PmenuThumb({ fg = special.foreground }),
		TabLine({ fg = colors.color8, bg = colors.color15 }),
		TabLineFill({ fg = colors.color8, bg = colors.color15 }),
		TabLineSel({ fg = colors.color2, bg = colors.color15 }),
		helpExample({ fg = colors.color3 }),
		helpCommand({ fg = colors.color3 }),

		Boolean({ fg = colors.color2 }),
		Character({ fg = colors.color1 }),
		Comment({ fg = colors.color7, gui = "italic" }),
		Conditional({ fg = colors.color5 }),
		Constant({ fg = colors.color2 }),
		Define({ fg = colors.color5 }),
		Delimiter({ fg = colors.color6 }),
		Float({ fg = colors.color2 }),
		Function({ fg = colors.color4, gui = "bold" }),

		Identifier({ fg = colors.color6 }),
		Include({ fg = colors.color4 }),
		Keyword({ fg = colors.color5, gui = "bold" }),

		Label({ fg = colors.color3 }),
		Number({ fg = colors.color2 }),
		Operator({ fg = special.foreground }),
		PreProc({ fg = colors.color3 }),
		Repeat({ fg = colors.color3 }),
		Special({ fg = colors.color6 }),
		SpecialChar({ fg = colors.color6 }),
		Statement({ fg = colors.color1 }),
		StorageClass({ fg = colors.color3 }),
		String({ fg = colors.color2, gui = "italic" }),
		Structure({ fg = colors.color5 }),
		Tag({ fg = colors.color3 }),
		Todo({ fg = colors.color3, bg = colors.color15 }),
		Type({ fg = colors.color3 }),
		Typedef({ fg = colors.color3 }),

		-- Spelling
		SpellBad({ gui = "underline", fg = colors.color1, sp = colors.color1 }),
		SpellLocal({ gui = "underline", fg = colors.color6, sp = colors.color6 }),
		SpellCap({ gui = "underline", fg = colors.color3, sp = colors.color3 }),
		SpellRare({ gui = "underline", fg = colors.color5, sp = colors.color5 }),

		-- Statusline
		StatusLine({ fg = colors.color7, bg = colors.color15 }),
		StatusLineNC({ fg = colors.color7, bg = colors.color15 }),
		StatusLineTerm({ fg = colors.color10, bg = colors.color2 }),
		StatusLineTermNC({ fg = colors.color11, bg = colors.color15 }),
		WinBar({ fg = colors.color7, bg = special.background }),
		WinBarNC({ fg = colors.color7, bg = special.background }),
		User({ Normal }),

		-- Diff
		DiffAdd({ fg = colors.color2, bg = colors.color15, gui = "bold" }),
		DiffChange({ fg = colors.color8, bg = colors.color15 }),
		DiffDelete({ fg = colors.color1, bg = colors.color15, gui = "bold" }),
		DiffText({ fg = colors.color4, bg = colors.color15 }),
		DiffFile({ fg = colors.color1, bg = special.background }),
		DiffNewFile({ fg = colors.color2, bg = special.background }),
		DiffLine({ fg = colors.color4, bg = special.background }),
		DiffAdded({ DiffAdd }),
		DiffRemoved({ DiffDelete }),
		diffRemoved({ DiffDelete }),

		-- Git
		gitCommitOverflow({ fg = colors.color1 }),
		gitCommitSummary({ fg = colors.color2 }),
		GitSignsAdd({ fg = colors.color6 }),
		GitSignsChange({ fg = colors.color3 }),
		GitSignsDelete({ fg = colors.color1 }),

		-- Indent Blankline
		IndentBlanklineChar({ gui = "nocombine", fg = colors.color15 }),
		IndentBlanklineContextChar({ gui = "nocombine", fg = colors.color7 }),
		IndentBlanklineContextStart({ gui = "underline", sp = colors.color7 }),

		-- Markdown
		mkdCode({ fg = colors.color2 }),
		mkdCodeBlock({ fg = colors.color2 }),
		mkdHeadingDelimiter({ fg = colors.color4 }),
		mkdH1({ fg = colors.color4, gui = "bold" }),
		mkdH2({ fg = colors.color4, gui = "bold" }),
		mkdItalic({ fg = colors.color5, gui = "italic" }),
		mkdBold({ fg = colors.color3, gui = "bold" }),
		mkdCodeDelimiter({ fg = colors.color6, gui = "italic" }),
		mkdError({ fg = special.foreground, bg = special.background }),
		markdownCode({ mkdCode }),
		markdownCodeBlock({ mkdCodeBlock }),
		markdownHeadingDelimiter({ mkdHeadingDelimiter }),
		markdownH1({ mkdH1 }),
		markdownH2({ mkdH2 }),
		markdownItalic({ mkdItalic }),
		markdownBold({ mkdBold }),
		markdownCodeDelimiter({ mkdCodeDelimiter }),
		markdownError({ mkdError }),

		-- LSP Diagnostics
		DiagnosticError({ fg = colors.color1 }),
		DiagnosticWarn({ fg = colors.color3 }),
		DiagnosticInfo({ fg = colors.color4 }),
		DiagnosticHint({ fg = colors.color6 }),
		DiagnosticUnderlineError({ DiagnosticError, sp = DiagnosticError.fg, gui = "underline" }),
		DiagnosticUnderlineWarn({ DiagnosticWarn, sp = DiagnosticWarn.fg, gui = "underline" }),
		DiagnosticUnderlineInfo({ DiagnosticInfo, sp = DiagnosticInfo.fg, gui = "underline" }),
		DiagnosticUnderlineHint({ DiagnosticHint, sp = DiagnosticHint.fg, gui = "underline" }),
		DiagnosticUnderlineOk({ Underlined }),
		DiagnosticFloatingError({ DiagnosticError }),
		DiagnosticFloatingWarn({ DiagnosticWarn }),
		DiagnosticFloatingInfo({ DiagnosticInfo }),
		DiagnosticFloatingHint({ DiagnosticHint }),
		DiagnosticFloatingOk({ Normal }),
		DiagnosticSignError({ DiagnosticError }),
		DiagnosticSignWarn({ DiagnosticWarn }),
		DiagnosticSignInfo({ DiagnosticInfo }),
		DiagnosticSignHint({ DiagnosticHint }),
		DiagnosticSignOk({ Normal }),

		-- Neogit
		NeogitBranch({ fg = colors.color1 }),
		NeogitRemote({ fg = colors.color1 }),
		NeogitHunkHeader({ bg = colors.color6, fg = colors.color7 }),
		NeogitHunkHeaderHighlight({ bg = colors.color7, fg = colors.color6 }),
		NeogitDiffContextHighlight({ bg = colors.color0, fg = colors.color8 }),
		NeogitDiffDeleteHighlight({ fg = colors.color1, bg = colors.color0 }),
		NeogitDiffAddHighlight({ fg = colors.color6, bg = colors.color0 }),

		-- Nvim-cmp
		CmpItemAbbr({ fg = colors.color8 }),
		CmpItemAbbrDeprecated({ fg = colors.color8, gui = "strikethrough" }),
		CmpItemAbbrMatch({ fg = colors.color8, gui = "bold" }),
		CmpItemAbbrMatchFuzzy({ fg = colors.color8, gui = "bold" }),
		CmpItemKind({ fg = colors.color6 }),
		CmpItemMenu({ fg = colors.color7 }),

		-- Telescope
		TelescopeBorder({ fg = colors.color8 }),
		TelescopePromptBorder({ fg = colors.color8 }),
		TelescopeSelectionCaret({ fg = colors.color14 }),
		TelescopeSelection({ fg = colors.color14, bg = colors.color15 }),
		TelescopeMatching({ fg = colors.color11 }),
		TelescopePromptCounter({ fg = colors.color4 }),
		TelescopeMultiSelection({ fg = colors.color3, gui = "bold" }),

		-- Treesitter
		sym("@attribute")({ Identifier }),
		sym("@boolean")({ Boolean }),
		sym("@character")({ Character }),
		sym("@character.special")({ SpecialChar }),
		sym("@comment")({ Comment }),
		sym("@conditional")({ Conditional }),
		sym("@constant")({ Constant }),
		sym("@constant.builtin")({ Constant }),
		sym("@constant.macro")({ Macro }),
		sym("@constructor")({ Function }),
		sym("@debug")({ Debug }),
		sym("@define")({ Define }),
		sym("@exception")({ Exception }),
		sym("@field")({ String }),
		sym("@float")({ Float }),
		sym("@function")({ Function }),
		sym("@function.builtin")({ Function }),
		sym("@function.macro")({ Macro }),
		sym("@include")({ Include }),
		sym("@keyword")({ Keyword }),
		sym("@keyword.function")({ Function }),
		sym("@keyword.operator")({ Operator }),
		sym("@label")({ Label }),
		sym("@method")({ Function }),
		sym("@namespace")({ Structure }),
		sym("@none")({ bg = "NONE", fg = "NONE" }),
		sym("@number")({ Number }),
		sym("@operator")({ Operator }),
		sym("@parameter")({ Constant }),
		sym("@preproc")({ PreProc }),
		sym("@property")({ Identifier }),
		sym("@punctuation.bracket")({ Normal }),
		sym("@punctuation.delimiter")({ Delimiter }),
		sym("@punctuation.special")({ Bold }),
		sym("@repeat")({ Repeat }),
		sym("@storageclass")({ StorageClass }),
		sym("@string")({ String }),
		sym("@string.escape")({ String }),
		sym("@string.regex")({ String }),
		sym("@string.special")({ Special }),
		sym("@symbol")({ Character }),
		sym("@tag")({ Tag }),
		sym("@tag.attribute")({ Tag }),
		sym("@tag.delimiter")({ Tag }),
		sym("@text")({ Normal }),
		sym("@text.bold")({ Bold }),
		sym("@text.danger")({ Error }),
		sym("@text.diff.add")({ DiffAdd }),
		sym("@text.diff.delete")({ DiffDelete }),
		sym("@text.emphasis")({ Italic }),
		sym("@text.environment")({ Bold }),
		sym("@text.environment.name")({ Bold }),
		sym("@text.literal")({ Character }),
		sym("@text.math")({ Float }),
		sym("@text.note")({ Label }),
		sym("@text.reference")({ Tag }),
		sym("@text.strike")({ Normal, gui = "strikethrough" }),
		sym("@text.title")({ Title }),
		sym("@text.todo")({ Exception }),
		sym("@text.underline")({ Underlined }),
		sym("@text.uri")({ Underlined, fg = special.foreground, bg = colors.color15 }),
		sym("@type")({ Type }),
		sym("@type.builtin")({ Type }),
		sym("@type.definition")({ Typedef }),
		sym("@variable")({ Float }),
		sym("@variable.builtin")({ Float }),

		-- WhichKey
		WhichKey({ fg = colors.color2 }),
		WhichKeyGroup({ fg = colors.color6 }),
		WhichKeyDesc({ fg = colors.color1 }),
		WhichKeySeperator({ fg = colors.color8 }),
		WhichKeySeparator({ fg = colors.color8 }),
		WhichKeyFloat({ bg = colors.color0 }),
		WhichKeyValue({ fg = colors.color8 }),

		-- selene: deny(undefined_variable)
		---@diagnostic enable: undefined-global
	}

	return spec
end)

return set_theme

-- vim: ts=2 sw=2 tw=120
