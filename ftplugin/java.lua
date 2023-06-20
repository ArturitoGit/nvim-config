-- Variables
    
local java_8_home = "/usr/lib/jvm/java-1.8.0-openjdk-amd64"
local java_17_home = "/usr/lib/jvm/java-17-openjdk-amd64"
local jdtls_home = "/home/arturito/.local/share/nvim/mason/packages/jdtls"
local jdtls_bundles = "/home/arturito/Documents/prog/java/eclipse.jdt.ls/pde/server"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local config = {
  cmd = {
    -- Java version
    java_17_home .. '/bin/java',

    -- Command options
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- Jdtls launcher
    '-jar', jdtls_home .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',

    -- Jdtls configuration file
    '-configuration', jdtls_home .. '/config_linux',

    -- Project folder
    '-data', jdtls_home .. '/projects/' .. project_name,
  },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  -- root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', 'gradlew', '.git', 'mvnw'}, { upward = true })[1]),

  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-1.8.0-openjdk-amd64/",
          },
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-1.11.0-openjdk-amd64/",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-1.17.0-openjdk-amd64/",
          },
          {
            name = "JavaSE-19",
            path = "/usr/lib/jvm/java-1.19.0-openjdk-amd64/",
          },
        },
      },
    },
  },

  init_options = {
    bundles = vim.split(vim.fn.glob(jdtls_bundles .. "/*.jar"), "\n")
  },

  on_init = function(client)

    -- Do I need this ?
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })

    -- Disable LSP highlighting
    client.server_capabilities.semanticTokensProvider = nil

    -- Remap LSP functionnalities
    vim.keymap.set('n', '<A-r>', vim.lsp.buf.rename)
    vim.keymap.set('n', '<A-CR>', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations)
    vim.keymap.set('n', '<A-o>', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<A-,>', vim.lsp.buf.hover)
  end
}

-- Some global java mappings
vim.o.wrap = false
vim.keymap.set('n', '<tab>', [[:call search('[A-Z]')<CR>]]) -- Go to next Uppercase letter

require('jdtls').start_or_attach(config)

-- Indentation
vim.cmd [[set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab]]
