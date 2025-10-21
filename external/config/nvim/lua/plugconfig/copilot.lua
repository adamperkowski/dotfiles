require("copilot").setup {
  panel = {
		enabled = false,
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = "<M-Tab>",
		},
	},
	filetypes = {
    ["*"] = true,
	}
}
