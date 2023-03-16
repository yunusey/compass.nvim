local init_windows = {} -- initialized windows will be stored here

local openWinByHint = function (str, invisible_win)

	local win = invisible_win[1]
	local buf = invisible_win[2]
	vim.api.nvim_win_close(win, true)
	vim.api.nvim_buf_delete(buf, {
		force = true
	})

	for _, wins in pairs(init_windows) do
		local win_c = wins[1]
		vim.api.nvim_win_close(win_c, true)
		local buf_c = wins[2]
		vim.api.nvim_buf_delete(buf_c, {
			force = true
		})
	end
	if init_windows[str] ~= nil then
		local aimed_win = init_windows[str][3]
		vim.api.nvim_set_current_win(aimed_win)
	end
	init_windows = {}
end

local createBufferWith = function (win_str, hlname)

	local new_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, {win_str})
	vim.api.nvim_buf_add_highlight(new_buf, -1, hlname, 0, 0, -1)

	return new_buf

end

local createWindowWith = function (buffer, row, col, window_opts)

	local window = vim.api.nvim_open_win(buffer, false, {
		relative = "editor",
		style = "minimal",
		row = row, col = col,
		width = window_opts.width, height = window_opts.height,
		border = window_opts.border,
	})

	return window
end

local compass = function (opts)


	-- Set the highlight
	vim.api.nvim_set_hl(0, opts.hlname, opts.highlight)

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
		local nrow = row + math.ceil(height / 2) - 1
		local ncol = col + math.ceil(width / 2) - 1

		-- Create new buffer
		local new_buf = createBufferWith(win_str, opts.hlname)

		-- Create the window
		local new_win = createWindowWith(new_buf, nrow, ncol, opts.window)

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
				openWinByHint(i, { win, buf })
			end
		})
	end

end

return compass
