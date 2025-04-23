local last = ""

local function update_last(command)
  if command == "" then
    return
  end
  last = command
end

local function exec(command)
  os.execute("tmux send-keys -R -t +1 '"..command.."' Enter")
  update_last(command)
end

-- Create custom Command
vim.api.nvim_create_user_command('NextPane', function(c)
  exec(c.args)
end, { nargs = "+" })

local M = {}

M.interactive = function()
  local command = vim.fn.input("> ", "", "shellcmd")
  exec(command)
end

M.do_last = function()
  print("> "..last)
  exec(last)
end

return M
