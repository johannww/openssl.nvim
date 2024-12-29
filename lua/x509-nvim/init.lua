local util = require("x509-nvim.util")

M = {}

local getVisualSelection = function()
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

local function getPemFromVisualSelction()
    local lines, coords = getVisualSelection()

    local certPemLines = ""
    if coords["line_start"] == coords["line_end"] then
        certPemLines = string.sub(lines[1], coords["column_start"], coords["column_end"])
        certPemLines = string.gsub(certPemLines, "\\n", "\n")
    else
        certPemLines = string.sub(lines[1], coords["column_start"], -1)
        for i = 2, (#lines - 1) do
            certPemLines = certPemLines .. lines[i]
        end
        certPemLines = certPemLines .. string.sub(lines[#lines], 0, coords["column_end"])
    end
    return certPemLines
end

local openOpensslResultInTab = function(certPemLines, opensslCmd)
    local certPemText = table.concat(certPemLines, "\n")

    local tempCertPath = os.tmpname()
    local tempCertFile, err = io.open(tempCertPath, "w")
    if not tempCertFile then
        error("Failed to open cert file: " .. err)
    end

    tempCertFile:write(certPemText)
    io.close(tempCertFile)

    local cmd = string.format(opensslCmd, tempCertPath)

    local result, err = io.popen(cmd, "r")
    if not result then
        error("Failed to run openssl: " .. err)
    end
    local output = result:read("*a")
    result:close()

    local newbufnr = vim.api.nvim_create_buf(false, true) -- (listed = false, scratch = true)

    -- Open a new tab
    vim.cmd("tabnew")
    vim.api.nvim_buf_set_lines(newbufnr, 0, -1, false, util.splitString(output, "\n"))
    vim.api.nvim_win_set_buf(0, newbufnr)
end

local function showCert()
    local bufnr = vim.api.nvim_get_current_buf()
    local certPemLines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    openOpensslResultInTab(certPemLines, "openssl x509 -in %s -text -noout")
end

local function showCertVisual()
    local certPemLines = getPemFromVisualSelction()

    openOpensslResultInTab({certPemLines}, "openssl x509 -in %s -text -noout")
end

local function showAsn1Parse()
    local bufnr = vim.api.nvim_get_current_buf()
    local certPemLines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    openOpensslResultInTab(certPemLines, "openssl asn1parse -in %s")
end

local function showAsn1ParseVisual()
    local certPemLines = getPemFromVisualSelction()
    openOpensslResultInTab({certPemLines}, "openssl asn1parse -in %s")
end

M.setup = function()
    local success, promise = pcall(vim.system, { "openssl", "version" })
    if not success then
        error("could not find")
    end

    local code = promise.wait(promise).code

    if code ~= 0 then
        error("openssl failed to run")
    end

    vim.api.nvim_create_user_command("ViewCert",
        function()
            showCert()
        end,
        {}
    )

    vim.api.nvim_create_user_command("ViewCertVisual",
        function()
            showCertVisual()
        end,
        {}
    )

    vim.api.nvim_create_user_command("ViewCertAsn1",
        function()
            showAsn1Parse()
        end,
        {}
    )

    vim.api.nvim_create_user_command("ViewCertAsn1Visual",
        function()
            showAsn1ParseVisual()
        end,
        {}
    )
end

return M
