vim.g.undotree_SetFocusWhenToggle = true

if vim.fn.has("persistent_undo") == 1 then
	local target_path = vim.fn.expand("~/.vim_undo")

	if vim.fn.isdirectory(target_path) == 0 then
		vim.fn.mkdir(target_path, "p")
	end

	vim.o.undodir = target_path
	vim.o.undofile = true
end
