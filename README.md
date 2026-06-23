# pluto.jl-cell-nvim
Simple lua function for neovim for generating a new Pluto.jl cell using uuidgen on Linux.

The point of this script is to be able to edit Pluto.jl notebooks inside neovim. 
With Pluto.jl open to the side.

# Setup
By default, Pluto doesn't watch the notebook file. Which is annoying if live-preview is desired. 

Luckily, we can launch Proto with the `auto_reload_from_file = true` argument. So the command from Julia looks like this:

```
julia> Pluto.run(auto_reload_from_file=true)
```
---

Add this function to your neovim `init.lua` file.
```lua
function gen_pluto_cell()
	local uuid = vim.fn.systemlist("uuidgen")
	local cell_line = "# ╔═╡ " .. uuid[1]

	-- Get the current cursor position
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	-- Insert the UUID text into the current line
	vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { cell_line })
end
```

Bind it to a key. For example:
```lua
	vim.keymap.set("n", "<leader>jj", function () gen_pluto_cell() end, { desc = "Generate new cell inside Pluto.jl file" })
```
---

You might have noticed that the function doesn't add any lines to the "Cell order" at the bottom of a Pluto notebook file. 
This is not necessary as Pluto adds the new cells uuid to the bottom by itself.

---

Note: I am not sure if this script works on macOS/Windows as it uses `uuidgen`.
