local M = {}

M.split = function (str)
	local ans = {}
	while str and #str ~= 0 do
		local ind = string.find(str, '\n') or #str + 1
		local sub = string.sub(str, 0, ind - 1)
		table.insert(ans, sub)
		str = string.sub(str, ind + 1, -1)
	end
	return ans
end

return M
