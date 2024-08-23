local M = {}

M.defaults = {
    api_key = "",
    api_base = "http://api.gen42.ai/v1",
    model = "code"
}

function M.setup(opts)
    M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
