return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	init = function()
		-- Must happen BEFORE the plugin loads
		local parser_install_dir = vim.fn.stdpath("data") .. "/site"
		vim.opt.runtimepath:prepend(parser_install_dir)
	end,
	config = function()
		local parser_install_dir = vim.fn.stdpath("data") .. "/site"
		require("nvim-treesitter").setup({
			parser_install_dir = parser_install_dir,
			ensure_installed = { "nix", "lua", "bash", "c", "cpp", "qmljs" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
