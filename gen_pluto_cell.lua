local M = {}

function M.gen_pluto_cell()
	local uuid = vim.fn.systemlist("uuidgen")
	local cell_line = "# ╔═╡ " .. uuid[1]

	-- Get the current cursor position
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	-- Insert the UUID text into the current line
	vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { cell_line })
end

return M
