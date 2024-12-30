local M = {}

M.splitString = function(str_arg, sep_arg, prefix_arg)
    local sep, fields = sep_arg or ":", {}
    local prefix = prefix_arg or ""
    for str in string.gmatch(str_arg, "([^" .. sep .. "]+)") do
        table.insert(fields, prefix .. str)
    end
    return fields
end

M.getVisualSelection = function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "nx", false)
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")

    local line_start = vstart[2]
    local line_end = vend[2]
    local column_start = vstart[3]
    local column_end = vend[3]
    local lines = vim.fn.getline(line_start, line_end)

    local coordinates = {
        line_start = line_start,
        line_end = line_end,
        column_start = column_start,
        column_end =
            column_end
    }
    return lines, coordinates
end

return M
