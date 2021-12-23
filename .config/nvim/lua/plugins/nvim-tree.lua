local vim_globals = {
	quit_on_open = 0,
	indent_markers = 0,
	git_hl = 1,
	highlight_opened_files = 1,
	root_folder_modifier = ":t",
	add_trailing = 0,
	group_empty = 1,
	disable_window_picker = 1,
	icon_padding = " ",
	symlink_arrow = " >> ",
	respect_buf_cwd = 1,
	create_in_closed_folder = 0,
	refresh_wait = 500,
	window_picker_exclude = {
		filetype = {
			"notify",
			"packer",
			"qf",
		},
		buftype = {
			"terminal",
		},
	},
	special_files = {
		["README.md"] = 1,
		["Makefile"] = 1,
		["MAKEFILE"] = 1,
	},
	show_icons = {
		git = 1,
		folders = 1,
		files = 1,
		folder_arrows = 0,
	},
	icons = {
		default = "",
		symlink = "",
		git = {
			unstaged = "",
			staged = "S",
			unmerged = "",
			renamed = "➜",
			deleted = "",
			untracked = "U",
			ignored = "◌",
		},
		folder = {
			default = "",
			open = "",
			empty = "",
			empty_open = "",
			symlink = "",
		},
	},
}

local function global_setup(global_config)
	for key, value in pairs(global_config) do
		vim.g["nvim_tree_" .. key] = value
	end
end

global_setup(vim_globals)

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local keymaps = require("keymaps.nvim-tree")
local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	auto_close = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	update_to_buf_dir = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {
			".git",
		},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "right",
		auto_resize = true,
		mappings = {
			custom_only = true,
			list = keymaps,
		},
		number = false,
		relativenumber = false,
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})
