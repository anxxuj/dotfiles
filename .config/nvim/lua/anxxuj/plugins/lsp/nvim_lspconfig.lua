return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- keymaps
        local keymap = vim.keymap

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "go to declaration"
                keymap.set("n", "<leader>gd", vim.lsp.buf.declaration, opts)
                
                opts.desc = "smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                
                opts.desc = "show documentation"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                opts.desc = "go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                opts.desc = "restart lsp"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })

        -- add border to diagnostic window
        vim.diagnostic.config {
            float = {
                border = "rounded",
            },
        }

        -- add border to floating window
        local handlers =  {
            ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        }

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    handlers = handlers,
                })
            end,
            -- custom handlers
            ["pyright"] = function()
                lspconfig["pyright"].setup({
                    capabilities = capabilities,
                    handlers = handlers,
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "off",
                            },
                        },
                    },
                })
            end,
        })
    end,
}
