return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
            -- automatically install missing parsers when entering buffer
            auto_install = true,
        })
    end,
}
