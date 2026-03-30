return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "nixfmt" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				qml = { "qmlformat" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true, -- fall back to LSP formatting if no formatter found
			},
		})
	end,
}
