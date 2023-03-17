local M = {}

M.opts = {}

M.def_opts = { -- Default options
	highlight_goto  = { fg = "#00ff00" },
	highlight_close = { fg = "#ff0000" },
	highlight_swap  = { fg = "#ffff00" },
	hlgoto  = "CompassGotoWindow",
	hlclose = "CompassCloseWindow",
	hlswap  = "CompassSwapWindow",

	format = "#g\n#c\n#s",
	selected_str = '🟢',

	precedence = { -- Sets the precedence for letters to be used
		'j', 'k', 'h',
		'l', 'a', 's',
		'd', 'f', 'g',
		'w', 'e', 'r',
		't', 'y', 'u',
		'i', 'o', 'c',
		'v', 'b', 'n',
	},

	cancel = "q", -- When clicked, closes the compass...

	window = { -- Gets the same argument as |nvim_open_win|
		width  = 5,
		height = 3,
		border = "rounded",
		style  = "minimal",
	},

	keymaps = {
		i = "",
		n = "<leader>ww",
		v = "",
	},

}

M.setup = function (user_opts) -- User options

	for k, v in pairs(M.def_opts) do
		M.opts[k] = user_opts[k] or v
	end

	-- Since window is another table, it needs to be checked
	for k, v in pairs(M.def_opts.window) do
		M.opts.window[k] = M.opts.window[k] or v -- If given by the user, use it; else use default
	end

	for mode, keymap in pairs(M.opts.keymaps) do
		if keymap == "" then
			goto continue
		end
		vim.api.nvim_set_keymap(mode, keymap, "", {
			callback = function ()
				vim.cmd("stopinsert") -- To make sure that we're not in insert mode...
				M.compass() -- Call the main function
			end
		})
	    ::continue::
	end

end

M.compass = function ()
	require("compass.compass")(M.opts) -- Call compass function with the opts
end

return M
