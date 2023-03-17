-- This file creates the command 'Compass' needed to call main function

vim.api.nvim_create_user_command("Compass", function (args)
	local compass = require("compass")
	-- Arguments are not implemented yet!..
	local arguments = args["args"]
	compass.compass(--[[arguments]])
end, { nargs = "?" })

