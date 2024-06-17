vim.api.nvim_create_user_command("MarkdownToPdf", function()
    if not vim.fn.executable("pandoc") == 1 then
        vim.api.nvim_err_writeln("pandoc not found")
        return
    else
        if vim.bo.filetype == "markdown" then
            -- local md_path = vim.fn.expand('%:p')
            local md_path = vim.api.nvim_buf_get_name(0)
            local pdf_path = string.gsub(md_path, "md$", "pdf")
            local header_path = debug.getinfo(1).source:match("@?(.*/)") .. "resources/head.tex"
            -- add --table-of-content to add an additional page of table of contents at starting
            local cmd = "pandoc --pdf-engine=xelatex --highlight-style=zenburn --include-in-header="
                .. header_path
                .. " -V fontsize=10pt -V colorlinks -V toccolor=NavyBlue -V linkcolor=red -V urlcolor=teal -V filecolor=magenta -s "
                .. md_path
                .. " -o "
                .. pdf_path

            local res = vim.fn.jobstart(cmd, {
                on_exit = function(job_id, data, event)
                    if data == 0 then
                        print("Conversion successfull!")
                    else
                        vim.api.nvim_err_writeln("Some error occured with pandoc")
                        vim.api.nvim_err_writeln("Check your pandoc and texlive installations")
                    end
                end,
            })
            if res == 0 or res == -1 then
                vim.api.nvim_err_writeln("Error running command")
            else
                print("Converting to pdf...")
            end
        else
            vim.api.nvim_err_writeln("Filetype is not markdown")
        end
    end
end, {})
