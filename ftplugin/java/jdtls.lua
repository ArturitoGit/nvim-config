require('helpers/utils')

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
    return { path, jreVersion }
  end
end

local jdtlsConfig = {

  cmd = FilterNil(
    java_17..'/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    IfDefined(config.get('lombok_jar'), PrefixItWith('-javaagent:')),
    '-jar', jdtls_launcher,
    '-configuration', jdtls_home..'/config_linux',
    '-data', jdtls_home..'/projects/'..project_name
  ),

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  settings = {
    java = {
      configuration = {
        runtimes = FilterNil(
          {"JavaSE-17", java_17},
          IfDefined(config.get('java_8'), asRuntimeFor('JavaSE-1.8')),
          IfDefined(config.get('java_11'), asRuntimeFor('JavaSE-11')),
          IfDefined(config.get('java_19'), asRuntimeFor('JavaSE-19'))
        )
      },
    },
  },

  init_options = {
    bundles = FilterNil(
      IfDefined(config.get('jdtls_bundle'), function(path)
        return vim.split(vim.fn.glob(path .. "/*.jar"), "\n")
      end)
    ),
  },

  -- Nvim-cmp provides additional capabilities, let JDTLS know about them
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Apply LSP configuration
require('jdtls').start_or_attach(jdtlsConfig)
