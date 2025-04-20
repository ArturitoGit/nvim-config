-- DAP
local dap = require('dap')

-- Node
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/js/vscode-node-debug2/out/src/nodeDebug.js' }
}

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = { os.getenv('HOME') .. '/js/js-debug/src/dapDebugServer.js', '${port}' }
  }
}

dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = {'?'}
}

dap.configurations.javascript = {
  {
    name = 'Launch Node 2',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal'
  },
  {
    name = 'Attach to process Node2',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch PWA",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "chrome",
    request = "attach",
    name  = 'Attach chrome',
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}"
  }
}

dap.configurations.typescript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal'
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch PWA",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

-- DAP shortcuts
vim.keymap.set('n', '<Leader>dd', function() require'dap'.continue() end)
vim.keymap.set('n', '<Leader>db', function() require'dap'.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dr', function() require'dap'.repl.toggle() end)

-- Ce qu'il me reste à faire :
--
-- Configurer la manière dont le debug est fait avec le typescript
-- Tester nvim-dap-ui
--
-- (Pour l'instant c'est pwa qui compile lui-même le code,
-- il faudrait que je puisse lui dire "tu lances ça et tu debug là")
