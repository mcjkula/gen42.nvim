local M = {}
local config = require('gen42.config')
local curl = require('plenary.curl')

function M.setup()
end

function M.get_completion(prompt, callback)
    local url = config.options.api_base .. "/chat/completions"
    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. config.options.api_key
    }
    local data = {
        model = config.options.model,
        messages = {
            {role = "system", content = "You are a helpful assistant that provides information about code."},
            {role = "user", content = prompt}
        },
        max_tokens = 500,
        temperature = 0.7
    }

    curl.post(url, {
        headers = headers,
        body = vim.json.encode(data),
        callback = function(response)
            if response.status == 200 then
                local ok, result = pcall(vim.json.decode, response.body)
                if ok and result.choices and result.choices[1] and result.choices[1].message then
                    callback(result.choices[1].message.content)
                else
                    print("Error: Invalid response format")
                    print("Response body: " .. response.body)
                end
            else
                print("Error: " .. response.body)
            end
        end
    })
end

return M
