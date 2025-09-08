vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Using function to avoid highlighting and losing previous search term
vim.api.nvim_exec2([[
function! NoSpaceJ()
    s/\n\s*//
endfunction
]], { output = true })
vim.keymap.set("n", "J", ":call NoSpaceJ()<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-j>", ":tabprevious<CR>")
vim.keymap.set("n", "<C-k>", ":tabnext<CR>")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>ay", "m':keepjumps norm! gg0vG$\"+y<CR>``") -- yank all buffer

vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

vim.keymap.set("n", "<leader>T", ":tabnew | term<CR>")
vim.keymap.set("n", "<leader>st", ":bot 10 :split | term<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- start something in a split
vim.keymap.set("n", "<leader>vs", ":vsplit | ")
vim.keymap.set("n", "<leader>hs", ":split | ")

-- Floating windows
vim.keymap.set("n", "<leader>fd", ":lua vim.diagnostic.open_float()<CR>")


vim.keymap.set({ "n", "i", "v", "x", "t" }, "<A-n>", "<Esc>")


local function setup_binds(opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>sh", function() vim.lsp.buf.signature_help() end, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Setup LSP binds',
    callback = function(event)
        pcall(setup_binds, { buffer = event.buf, remap = false })
    end
})


local langmapper = require("langmapper")

langmapper.automapping({ buffer = false })
