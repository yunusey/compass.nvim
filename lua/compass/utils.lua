local M = {}

local lib = require("compass.lib")

M.deleteWindowsAndBuffers = function (init_windows, invisible_win)
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
end

M.createBufferWith = function (win_str, format, hlgoto, hlclose, hlswap)

	-- win_str variable should be fully lower-cased char.
	-- So, we can use this!
	-- Let's say when typed 'j', it will set the current window to {window}
	-- Then, when typed 'J', why not close it?

	local original_format = format
	local go_string = string.lower(win_str)
	local close_string = string.upper(win_str)
	local swap_string = "<A-" .. string.lower(win_str) .. ">"
	format = string.gsub(format, '#g', go_string)
	format = string.gsub(format, '#c', close_string)
	format = string.gsub(format, '#s', swap_string)

	local frep = lib.split(original_format)
	local rep = lib.split(format)

	local new_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, rep)

	for line, i in ipairs(frep) do

		line = line - 1 -- lines are 0-indexed
		local ind = 0

		for j = 1, #i, 1 do
			local char = string.sub(i, j, j)
			if j == 1 or (j > 1 and string.sub(i, j - 1, j - 1) ~= "#") then
				if char ~= '#' then
					ind = ind + 1
				end
				goto continue
			end
			if char == 'g' then
				vim.api.nvim_buf_add_highlight(new_buf, -1, hlgoto,
					line, ind, ind + #go_string)
				ind = ind + #go_string
			elseif char == 'c' then
				vim.api.nvim_buf_add_highlight(new_buf, -1, hlclose,
					line, ind, ind + #close_string)
				ind = ind + #close_string
			elseif char == 's' then
				vim.api.nvim_buf_add_highlight(new_buf, -1, hlswap,
					line, ind, ind + #swap_string)
				ind = ind + #swap_string
			else
				ind = ind + 1
			end
			::continue::
		end

	end

	return new_buf

end

M.createWindowWith = function (buffer, row, col, window_opts)

	local window = vim.api.nvim_open_win(buffer, false, {
		relative = "editor",
		style = "minimal",
		row = row, col = col,
		width = window_opts.width, height = window_opts.height,
		border = window_opts.border,
	})

	return window
end

return M
