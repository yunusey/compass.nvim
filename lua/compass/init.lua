local M = {}

M.opts = {}

M.def_opts = { -- Default options
	highlight = { fg = "#00ff00" },
	hlname = "CompassHintWindow",
	precedence = { -- Sets the precedence for letters to be used
		'j', 'k', 'h',
		'l', 'a', 's',
		'd', 'f', 'g',
		'w', 'e', 'r',
		't', 'y', 'u',
		'i', 'o', 'c',
		'v', 'b', 'n',
	},
	window = { -- Gets the same argument as |nvim_open_win|
		width  = 2,
		height = 1,
		border = "rounded",
		style  = "minimal",
	}
}

M.setup = function (user_opts) -- User options

	for k, v in pairs(M.def_opts) do
		M.opts[k] = user_opts[k] or v
	end

	-- Since window is another table, it needs to be checked
	for k, v in pairs(M.def_opts.window) do
		M.opts.window[k] = M.opts.window[k] or v -- If given by the user, use it; else use default
	end


end

M.compass = function ()
	require("compass.compass")(M.opts) -- Call compass function with the opts
end

return M
