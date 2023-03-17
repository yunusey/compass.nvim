
local actions = require("compass.actions")
local utils   = require("compass.utils")

local init_windows = {} -- initialized windows will be stored here

local compass = function (opts)

	-- Reset init_windows
	init_windows = {}
	-- Reset selected_window
	actions.selected_window = nil
	actions.selected_str = opts.selected_str

	-- Set the highlights
	vim.api.nvim_set_hl(0, opts.hlgoto, opts.highlight_goto)
	vim.api.nvim_set_hl(0, opts.hlclose, opts.highlight_close)
	vim.api.nvim_set_hl(0, opts.hlswap, opts.highlight_swap)

	local tab_page = vim.api.nvim_get_current_tabpage()
	local windows  = vim.api.nvim_tabpage_list_wins(tab_page)

	for j, i in ipairs(windows) do -- For all the windows (i = handle), create a hint window which will have a key

		local win_str = opts.precedence[j]

		-- Get the position of the each window
		local pos = vim.api.nvim_win_get_position(i)
		local row = pos[1]
		local col = pos[2]

		local width  = vim.api.nvim_win_get_width(i)
		local height = vim.api.nvim_win_get_height(i)
		-- Set the position for each window
		local nrow = row + math.ceil(height / 2) - math.ceil(opts.window.height / 2) - 1
		local ncol = col + math.ceil(width / 2) - math.ceil(opts.window.width / 2) - 1

		-- Create new buffer
		local new_buf = utils.createBufferWith(win_str, opts.format,
			opts.hlgoto, opts.hlclose, opts.hlswap)

		-- Create the window
		local new_win = utils.createWindowWith(new_buf, nrow, ncol, opts.window)

		-- For every hint (win_str), we'll have a tuple:
		-- ([window-created], [buffer-created], [window-aimed])
		init_windows[win_str] = {new_win, new_buf, i}
	end

	local buf = vim.api.nvim_create_buf(false, true)
	local row = 0
	local col = 0
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		style = "minimal",
		row = row, col = col,
		width = 2, height = 1
	})

	for _, i in ipairs(opts.precedence) do
		vim.api.nvim_buf_set_keymap(buf, "n", i, "", {
			callback = function ()
				utils.deleteWindowsAndBuffers(init_windows, { win, buf })
				actions.openWinByHint(init_windows, i)
			end
		})
		vim.api.nvim_buf_set_keymap(buf, "n", string.upper(i), "", {
			callback = function ()
				utils.deleteWindowsAndBuffers(init_windows, { win, buf })
				actions.closeWinByHint(init_windows, i)
			end
		})
		vim.api.nvim_buf_set_keymap(buf, "n", "<A-" .. i .. ">", "", {
			callback = function ()
				local ok = actions.selectWindow(init_windows, i)
				-- Selects window as to be swapped. If there are two windows selected;
				-- just swaps them, and sets the current window as the lastly selected win
				if ok then
					utils.deleteWindowsAndBuffers(init_windows, { win, buf })
				end
			end
		})
	end

	-- Set the cancel keymap 
	if opts.cancel ~= '' then
		vim.api.nvim_buf_set_keymap(buf, "n", opts.cancel, "", {
			callback = function ()
				utils.deleteWindowsAndBuffers(init_windows, { win, buf })
			end
		})
	end

end

return compass
