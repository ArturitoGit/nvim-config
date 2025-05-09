local utils = require('helpers/utils')
local filter_nil = utils.filter_nil
local if_defined = utils.if_defined

-- Exit if jdtls is disabled
if vim.g.jdtls_disabled then
  return
end

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

local function asRuntimeFor(jreVersion)
  return function(path)
    return { name=jreVersion, path=path }
  end
end

local jdtlsConfig = {

  cmd = filter_nil(
    java_17..'/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    -- For better performances
    '-XX:+UseParallelGC',
    '-XX:GCTimeRatio=4',
    '-XX:AdaptiveSizePolicyWeight=90',
    '-Dsun.zip.disableMemoryMapping=true',
    '-Xmx4G',
    '-Xms100m',
    -- ---
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    if_defined(config.get('lombok_jar'), utils.prefix_it_with('-javaagent:')),
    '-jar', jdtls_launcher,
    '-configuration', jdtls_home..'/config_linux',
    '-data', jdtls_home..'/projects/'..project_name
  ),

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  settings = {
    java = {
      configuration = {
        runtimes = filter_nil(
          { name="JavaSE-17", path=java_17 },
          if_defined(config.get('java_8'), asRuntimeFor('JavaSE-1.8')),
          if_defined(config.get('java_11'), asRuntimeFor('JavaSE-11')),
          if_defined(config.get('java_19'), asRuntimeFor('JavaSE-19'))
        )
      },
    },
  },

  init_options = {
    bundles = {
      -- TODO : Move those paths in local configuration
      vim.fn.glob('/home/abrouart/dev/lab/jdtls/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', true),
      vim.fn.glob('/home/abrouart/dev/lab/jdtls/vscode-java-test/server/*.jar', true)
    },
  },

  on_attach = function()
    vim.keymap.set('n', '<A-CR>', function()
      vim.lsp.buf.code_action({ filter = function(action)
        return action.kind ~= 'quickassist'
      end})
    end, { buffer = 0 })
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  end,

  -- Nvim-cmp provides additional capabilities, let JDTLS know about them
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Apply LSP configuration
require('jdtls').start_or_attach(jdtlsConfig)
