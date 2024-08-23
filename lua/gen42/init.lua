local M = {}
local api = require('gen42.api')
local ui = require('gen42.ui')

function M.setup(opts)
    require('gen42.config').setup(opts)
    api.setup()
    
    vim.api.nvim_create_user_command('Gen42Question', function()
        M.ask_question()
    end, {range = true})
end

function M.ask_question()
    local start_line, end_line = vim.fn.line("'<"), vim.fn.line("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local selected_text = table.concat(lines, '\n')
    
    ui.open_input_window(selected_text, function(question)
        api.get_completion(selected_text .. '\n\nQuestion: ' .. question, function(response)
            if response then
                ui.show_response(response)
            else
                print("Error: No response received from the API")
            end
        end)
    end)
end

return M
