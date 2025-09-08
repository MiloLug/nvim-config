-- Fix italics

local exclude_groups = {
    "Comment",
    "Function",
}

local exclude_groups_map = {}
for _, group in ipairs(exclude_groups) do
    exclude_groups_map[group] = true
end

for key, hl_group in pairs(vim.api.nvim_get_hl(0, {})) do
    if (
        hl_group.italic
        and not exclude_groups_map[key]
        and not key:match("italic")
    ) then
        vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, {italic = false}))
    end
end

