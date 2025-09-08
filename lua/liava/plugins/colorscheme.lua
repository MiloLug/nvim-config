return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        version = '*',
        lazy = false,
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                variant = 'main',
                dark_variant = 'main',
                styles = {
                    transparency = true,
                },
            })

            vim.cmd.colorscheme('rose-pine')
        end,
    }
}
