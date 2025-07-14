-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Start a 'godothost' server if opening a Godot project
local is_godot_project = vim.fn.filereadable(vim.fn.getcwd() .. "/project.godot")
if is_godot_project == 1 then
  vim.fn.serverstart("./godothost")
end
