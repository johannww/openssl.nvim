local M = {}

M.splitString = function(str_arg, sep_arg, prefix_arg)
    local sep, fields = sep_arg or ":", {}
    local prefix = prefix_arg or ""
    for str in string.gmatch(str_arg, "([^" .. sep .. "]+)") do
        table.insert(fields, prefix .. str)
    end
    return fields
end

return M
