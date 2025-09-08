return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-lspconfig.nvim",
            { 'hrsh7th/cmp-nvim-lsp', config = function() end },
        },
        event = { "LazyFile" },
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.marksman.setup({
                cmd = { "marksman", "server", "-v", "1" },
                filetypes = { "markdown" },

            })
            lspconfig.ts_ls.setup({})
            lspconfig.eslint.setup({})
            lspconfig.cssls.setup({})
            lspconfig.html.setup({})
            lspconfig.pyright.setup({
                root_dir = lspconfig.util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git", ".venv"),
            })
            lspconfig.clangd.setup({
                root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
                cmd = {
                    "clangd",
                    "--background-index",
                    "--completion-style=detailed",
                    "--header-insertion=iwyu",
                    "--suggest-missing-includes",
                    "--cross-file-rename",
                    "--offset-encoding=utf-16",
                },
            })

            lspconfig.bashls.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.vimls.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.autotools_ls.setup({})
            lspconfig.dockerls.setup({})
            lspconfig.docker_compose_language_service.setup({})
            lspconfig.yamlls.setup({})
            lspconfig.lemminx.setup({})
            lspconfig.taplo.setup({})
            lspconfig.terraformls.setup({})
            lspconfig.tflint.setup({})
            lspconfig.asm_lsp.setup({})
            lspconfig.solargraph.setup({
                cmd = { "rbenv", "exec", "solargraph", "stdio" },
                root_dir = lspconfig.util.root_pattern("Gemfile", ".git", ".ruby-version"),
            })
            lspconfig.phpactor.setup({})

            local defaults = lspconfig.util.default_config
            defaults.capabilities = vim.tbl_deep_extend(
                'force',
                defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )
        end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = { "Mason" },
        opts = {
            ui = {
                border = LazyUtils.default_border,
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "VeryLazy" },
        dependencies = {"mason.nvim"},
        opts_extend = { "ensure_installed" },
        opts = {
            ensure_installed = {
                'ts_ls', 'eslint', 'cssls', 'html', -- JS
                'pyright',
                'clangd',
                'solargraph', -- Ruby
                'phpactor',

                -- misc
                'bashls',
                'lua_ls',
                'vimls',
                'jsonls',
                'autotools_ls',
                'dockerls',
                'docker_compose_language_service',
                'yamlls',
                'lemminx', -- XML
                'taplo',   -- TOML
                'terraformls',
                'tflint',
                'asm_lsp',
                'marksman', -- Markdown,
            },
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)

            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local status, p = pcall(mr.get_package, tool)
                    if status and not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "LazyFile" },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered({
                        winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                })
            })
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            debug = false,
            library = {
                vim.env.VIMRUNTIME,
                "nvim-cmp/lua/cmp/types",
            },

        }
    },
}
