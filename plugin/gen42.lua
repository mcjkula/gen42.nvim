if vim.fn.has("nvim-0.7.0") == 0 then
    vim.api.nvim_err_writeln("gen42 requires at least nvim-0.7.0.1")
    return
end

if vim.g.loaded_gen42 == 1 then
    return
end
vim.g.loaded_gen42 = 1

vim.api.nvim_create_user_command("Gen42Complete", function()
    require("gen42").complete()
end, {})
