local script_path = debug.getinfo(1, "S").source:sub(2)
local header_path = vim.fn.fnamemodify(script_path, ":p:h") .. "/resources/head.tex"
local error_level = vim.log.levels.ERROR

vim.api.nvim_create_user_command("ToPdfFromMarkdown", function()
    if vim.bo.filetype ~= "markdown" then
        vim.notify("Filetype is not Markdown", error_level)
        return
    end

    if vim.fn.executable("pandoc") ~= 1 then
        vim.notify("Pandoc not found", error_level)
        return
    end

    local md_path = vim.api.nvim_buf_get_name(0)
    if md_path == "" or vim.fn.filereadable(md_path) ~= 1 then
        vim.notify("Save the Markdown file before converting", error_level)
        return
    end

    local pdf_path = vim.fn.fnamemodify(md_path, ":r") .. ".pdf"
    if pdf_path == md_path then
        vim.notify("The PDF output path matches the input file", error_level)
        return
    end

    local cmd = {
        "pandoc",
        "--pdf-engine=xelatex",
        "--syntax-highlighting=zenburn",
        -- "--highlight-style=zenburn", -- older versions
        "--include-in-header=" .. header_path,
        "-V",
        "fontsize=10pt",
        "-V",
        "colorlinks",
        "-V",
        "toccolor=NavyBlue",
        "-V",
        "linkcolor=red",
        "-V",
        "urlcolor=teal",
        "-V",
        "filecolor=magenta",
        "-s",
        md_path,
        "-o",
        pdf_path,
    }

    local on_exit = vim.schedule_wrap(function(result)
        if result.code == 0 and result.signal == 0 then
            vim.notify("PDF written to " .. pdf_path)
            return
        end

        local detail = vim.trim(result.stderr or "")
        if detail == "" then
            detail = ("exit code %d, signal %d"):format(result.code, result.signal)
        end
        vim.notify("Pandoc failed\n" .. detail, error_level)
    end)

    local ok, err = pcall(vim.system, cmd, { text = true }, on_exit)
    if ok then
        vim.notify("Converting to PDF…")
    else
        vim.notify("Could not start Pandoc\n" .. tostring(err), error_level)
    end
end, {})
