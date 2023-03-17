local M = {}

M.selected_window = nil
M.selected_str = ''

M.openWinByHint = function (init_windows, str)
	if init_windows[str] ~= nil then
			local aimed_win = init_windows[str][3]
		vim.api.nvim_set_current_win(aimed_win)
	end
end

M.closeWinByHint = function (init_windows, str)
	if init_windows[str] ~= nil then
			local aimed_win = init_windows[str][3]
		vim.api.nvim_win_close(aimed_win, true)
	end
end

M.selectWindow = function (init_windows, str)
	-- Return value is true if the switch is done, false otherwise
	if M.selected_window then
		-- Then we're probably ready to swap these guys!
		local window1 = init_windows[str][3]
		local window2 = M.selected_window
		local buffer1 = vim.api.nvim_win_get_buf(window1)
		local buffer2 = vim.api.nvim_win_get_buf(window2)

		vim.api.nvim_win_set_buf(window1, buffer2)
		vim.api.nvim_win_set_buf(window2, buffer1)

		vim.api.nvim_set_current_win(window2)

		return true
	else
		-- Then just set the current win as selected...
		M.selected_window = init_windows[str][3]
		local buf = init_windows[str][2]
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, {M.selected_str})
		return false
	end
end

return M
