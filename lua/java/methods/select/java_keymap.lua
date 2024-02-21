local M = {}

M.set = function(mode, key, action)
  vim.api.nvim_create_autocmd(
    {"BufEnter", "BufWinEnter"}, {
      pattern = {"*.java"},
      callback = function(infos)
        vim.keymap.set(mode, key, action, { buffer = infos.buf })
      end
  })
end

return M
