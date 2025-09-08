return {
    {
        'zbirenbaum/copilot.lua',
        event = "LazyFile",
        config = function()
            local copilot = require("copilot")
            local copilotSuggestion = require("copilot.suggestion")

            copilot.setup({
                panel = {
                    enabled = false,
                    auto_refresh = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    accept = false, -- disable built-in keymapping
                },
                filetypes = {
                    yaml = true,
                    markdown = true,
                },
            })

            -- hide copilot suggestions when cmp menu is open
            -- to prevent odd behavior/garbled up suggestions
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if cmp_status_ok then
                cmp.event:on("menu_opened", function()
                    vim.b.copilot_suggestion_hidden = true
                end)

                cmp.event:on("menu_closed", function()
                    vim.b.copilot_suggestion_hidden = false
                end)
            end

            vim.keymap.set("i", "<A-a>", function() copilotSuggestion.accept() end)

            -- show copilot suggestions when cmp menu is open:

            vim.keymap.set("i", "<A-s>", function()
                if vim.b.copilot_suggestion_hidden then
                    cmp.close()
                    vim.b.copilot_suggestion_hidden = false
                end
            end)
        end
    },
}
