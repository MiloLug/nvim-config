return {
    {
        'rmagatti/auto-session',
        lazy = false,
        keys = {
            { "<C-s>", "<cmd>AutoSession search<cr>", desc = "Search Session" },
        },
        opts = {
            log_level = "error",
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },

            pre_save_cmds = { "NvimTreeClose" },
            post_restore_cmds = {
                function()
                  -- Restore nvim-tree after a session is restored
                  local nvim_tree_api = require("nvim-tree.api")
                  nvim_tree_api.tree.change_root(vim.fn.getcwd())
                end,
            },
            session_lens = {
                load_on_setup = true,
                picker_opts = {
                    preview = false,
                }
            },
            lsp_stop_on_restore = true,
        },
    },
    {
        'NotAShelf/direnv.nvim',
        lazy = false,
        config = function()
            require("direnv").setup({
                autoload_direnv = true,
                statusline = {
                    enabled = true,
                    icon = '',
                },
                notifications = {
                    silent_autoload = false,
                },
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "DirenvLoaded",
                callback = function(ev)
                    local timer = vim.uv.new_timer()
                    timer:start(500, 0, function()
                        vim.schedule(function()
                            local clients = vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients())
                            for _, client in pairs(clients) do
                                vim.cmd("LspRestart " .. client)
                            end
                            vim.notify("Direnv -> Lsps Restarted: " .. table.concat(clients, ', '), vim.log.levels.INFO)
                        end)
                        timer:stop()
                        timer:close()
                    end)
                end
            })
        end
    },
}
