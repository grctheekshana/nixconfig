return {
    {
        "echasnovski/mini.base16",
        version = "*",
        priority = 1000,
        config = function()
            require("mini.base16").setup({
                palette = dofile(vim.fn.expand("~/.config/nvim/lua/config/theme.lua"))
            })
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { theme = "base16" },
    },
}
