-- Fetch configuration
local config = require('config/config-tree').sub('java')
if config == nil then
  print("No configuration found for java -> JDTLS disabled")
  return
end

-- Build JDTLS config
local java_17 = config.mandatory('java_17')
local jdtls_home = config.mandatory('jdtls_home')
local jdtls_launcher = vim.fn.glob(jdtls_home .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local jdtlsConfig = {
  cmd = {
    -- Java version
    java_17 .. '/bin/java',

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
    '-jar', jdtls_launcher,

    -- Jdtls configuration file
    '-configuration', jdtls_home .. '/config_linux',

    -- Project folder
    '-data', jdtls_home .. '/projects/' .. project_name,
  },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  settings = {
    java = {
      configuration = {
        runtimes = {{"JavaSE-17", java_17}},
      },
    },
  },

  init_options = { --[[ Configured above from config --]] },

  on_init = function(client)

    -- Do I need this ?
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })

    -- Disable LSP highlighting
    -- client.server_capabilities.semanticTokensProvider = nil
  end
}

-- Configure runtimes
local function setRuntime(name, key)
  if config.has(key) then
    table.insert(jdtlsConfig.settings.java.configuration.runtimes, {
      name = name,
      path = config.get(key)
    })
  end
end
setRuntime("JavaSE-1.8", "java_8")
setRuntime("JavaSE-11", "java_11")
setRuntime("JavaSE-19", "java_19")

-- Configure bundle
if config.has('jdtls_bundles') then
    local bundles = vim.fn.glob(config.get('jdtls_bundles') .. "/*.jar")
    jdtlsConfig.init_options.bundles = vim.split(bundles, "\n")
end

-- Apply LSP configuration
require('jdtls').start_or_attach(jdtlsConfig)
