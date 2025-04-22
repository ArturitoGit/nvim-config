local awk = require('awk.run_awk')
local text = require('awk.buffer_text')
local highlight = require('awk.highlight')
local column_under_cursor = require('awk.cursor_column').column_under_cursor

vim.api.nvim_create_user_command('Awk',
  function(cmd)
    local result = awk(text.current(), cmd.args)
    text.set(0, result)
  end,
  {
    nargs = "*",
    range = true,
    preview = function(opts, _, buf)
      if not buf then
        return
      end

      local preview = awk(text.current(), opts.args)
      text.set(buf, preview)

      local column = column_under_cursor()
      if column then
        highlight.column(column)
      else
        highlight.clear()
      end

      return 2
    end
  }
)

vim.api.nvim_create_autocmd('CmdLineLeave', {
  callback = function()
    highlight.clear()
  end
})
