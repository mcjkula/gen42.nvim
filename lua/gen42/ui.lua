local M = {}

function M.open_input_window(selected_text, callback)
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = 'minimal',
        border = 'rounded'
    })

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(selected_text, '\n'))
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, {'', 'Enter your question:'})
    vim.api.nvim_win_set_cursor(win, {vim.api.nvim_buf_line_count(buf), 0})

    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
        callback = function()
            local lines = vim.api.nvim_buf_get_lines(buf, -1, -1, false)
            local question = ""
            if #lines > 0 then
                question = lines[1]:gsub('^Enter your question: ?', '')
            end
            vim.api.nvim_win_close(win, true)
            callback(question)
        end,
        noremap = true,
        silent = true
    })

    vim.cmd('startinsert!')
end

function M.show_response(response)
    vim.schedule(function()
        local buf = vim.api.nvim_create_buf(false, true)
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local win = vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = width,
            height = height,
            col = math.floor((vim.o.columns - width) / 2),
            row = math.floor((vim.o.lines - height) / 2),
            style = 'minimal',
            border = 'rounded'
        })

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, '\n'))
        vim.api.nvim_buf_set_option(buf, 'modifiable', false)
        vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', {noremap = true, silent = true})
    end)
end

return M
