local LazyConfig = require("lazy.core.config")
local LazyPlugin = require("lazy.core.plugin")

local M = {}

M.default_border = "rounded"

function M.is_loaded(name)
    return LazyConfig.plugins[name] and LazyConfig.plugins[name]._.loaded
end

function M.get_plugin(name)
    return LazyConfig.spec.plugins[name]
end

function M.opts(name)
    local plugin = M.get_plugin(name)
    if not plugin then
        return {}
    end
    return LazyPlugin.values(plugin, "opts", false)
end

function M.get_selected_text()
    local start = vim.fn.getpos("'<")
    local finish = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start[2], finish[2])
    if #lines == 1 then
        return lines[1]:sub(start[3], finish[3])
    end
    lines[1] = lines[1]:sub(start[3])
    lines[#lines] = lines[#lines]:sub(1, finish[3])
    return table.concat(lines, "\n")
end


return M
