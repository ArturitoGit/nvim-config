-- Get source paths from LSP Server
--local buf -- TODO : Get current buffer
--lvim.lsp.buf_request(buf,
--
--  -- Command
--  'workspace/executeCommand', { command='java.project.listSourcePaths' },
--
--  -- Callback
--  function(status, result)
--    local sourcePaths = result.data   
--
--    -- Find source path under current file
--    local appropriateSourcePath=nil
--    for path in sourcePaths do
--      if pathOf(buf) contains path then
--        appropriateSourcePath=path
--    end
--    if appropriateSourcePath=nil then return end
--    
--  end
--)
--
-- Build package declaration
-- Build file content
-- Parse it to current file
-- Save file
