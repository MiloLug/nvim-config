return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'plenary.nvim'
        },
        keys = {
            { '<leader>pf', '<cmd>lua require("telescope.builtin").find_files({ hidden = true })<CR>',                                               mode = 'n' },
            { '<leader>ps', '<cmd>lua require("telescope.builtin").live_grep()<CR>',                                                                 mode = 'n' },
            { '<leader>pc', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',                                                 mode = 'n' },
            { '<leader>pr', '<cmd>lua require("telescope.builtin").resume()<CR>' },
            { '<leader>pb', '<cmd>lua require("telescope.builtin").buffers()<CR>' },

            { '<leader>pf', '<cmd>lua require("telescope.builtin").find_files({ hidden = true, default_text = LazyUtils.get_selected_text() })<CR>', mode = 'v' },
            { '<leader>ps', '<cmd>lua require("telescope.builtin").live_grep({ default_text = LazyUtils.get_selected_text() })<CR>',                 mode = 'v' },
            { '<leader>pc', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({ default_text = LazyUtils.get_selected_text() })<CR>', mode = 'v' },
        },
        opts = {
            defaults = {
                file_ignore_patterns = { "node_modules", "Cargo.lock", "yarn.lock", "package-lock.json", ".git", ".venv" },
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close,
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                    },
                },
            }
        }
    },
    {
        'mbbill/undotree',
        keys = {
            { '<leader>u', '<cmd>UndotreeToggle<CR>' }
        },
        cmd = { 'UndotreeToggle' },
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_ShortIndicators = 1
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_TreeNodeShape = ''
            vim.g.undotree_TreeVertShape = '│'
            vim.g.undotree_TreeSplitShape = '⟋'
            vim.g.undotree_TreeReturnShape = '⟍'
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-web-devicons'
        },
        keys = {
            { '<leader>fl', '<cmd>NvimTreeToggle<CR>' }
        },
        cmd = { 'NvimTreeToggle' },
        lazy = false,
        opts = {
            update_focused_file = {
                enable = true,
            },
            git = {
                enable = true,
                disable_for_dirs = { 'node_mosules', '.venv', 'venv' },
            },
            modified = {
                enable = true,
            },
            view = {
                float = {
                    enable = true,
                    quit_on_focus_loss = true,
                }
            }
        },
    },
    {
        'nanozuki/tabby.nvim',
        lazy = false,
        config = function()
            local tabline = require("tabby.tabline")

            local theme = {
                fill = 'TabLineFill',
                -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
                head = 'TabLine',
                current_tab = 'TabLineSel',
                tab = 'TabLine',
                win = 'TabLine',
                tail = 'TabLine',
            }
            tabline.set(function(line)
                return {
                    {
                        { hl = theme.head },
                        line.sep('', theme.head, theme.fill),
                    },
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.current_tab or theme.tab
                        return {
                            line.sep('', hl, theme.fill),
                            tab.is_current() and '' or '󰆣',
                            tab.name(),
                            tab.close_btn(''),
                            line.sep('', hl, theme.fill),
                            hl = hl,
                            margin = ' ',
                        }
                    end),
                    line.spacer(),
                    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                        return {
                            line.sep('', theme.win, theme.fill),
                            win.is_current() and '' or '',
                            win.buf_name(),
                            line.sep('', theme.win, theme.fill),
                            hl = theme.win,
                            margin = ' ',
                        }
                    end),
                    {
                        line.sep('', theme.tail, theme.fill),
                        { '  ', hl = theme.tail },
                    },
                    hl = theme.fill,
                }
            end)
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-web-devicons'
        },
        lazy = false,
        config = function()
            local lualine = require("lualine")
            local sessionLib = require("auto-session.lib")

            lualine.setup({
                options = {
                    theme = 'auto',
                },
                sections = {
                    lualine_a = { sessionLib.current_session_name },
                    lualine_b = {
                        function()
                            return require('direnv').statusline()
                        end
                    }

                },
            })
        end
    },
    { 'nvim-lua/plenary.nvim',       event = { 'VeryLazy' } },
    { 'nvim-tree/nvim-web-devicons', event = { 'VeryLazy' } },
    {
        'lukas-reineke/headlines.nvim',
        dependencies = { "nvim-treesitter" },
        ft = { "markdown" },
        opts = {
            markdown = {
                fat_headline_upper_string = "▃",
                bullets = { "󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳" },
                fat_headline_lower_string = "▀"
            },
        },
    },
    {
        'hedyhli/outline.nvim',
        keys = { { "<leader>o", "<cmd>Outline<cr>" } },
        cmd = { "Outline" },
        opts = {},
    },
}
