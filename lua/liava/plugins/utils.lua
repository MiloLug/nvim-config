return {
    {
        'chrishrb/gx.nvim',
        dependencies = { 'plenary.nvim' },
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        opts = {
            handlers = {
                search = true,
            }
        }
    },
    {
        'ChuufMaster/markdown-toc',
        cmd = { "GenerateTOC", "DeleteTOC" },
        opts = {},
    },
    {
        "toppair/peek.nvim",
        cmd = { "PeekOpen", "PeekClose" },
        build = "deno task --quiet build:fast",
        config = function()
            local peek = require("peek")
            peek.setup({})
            vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
            vim.api.nvim_create_user_command("PeekClose", peek.close, {})
        end,
    },
}
