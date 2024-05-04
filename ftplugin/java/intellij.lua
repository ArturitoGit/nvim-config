vim.lsp.start({
  name = "intellij",
  cmd = {
    "nc", "localhost", "8989"

--     "/home/arturito/java/ideals/server/gradlew",
--     "-p", "/home/arturito/java/ideals/server",
--     "runIde"

    -- "/home/arturito/intellij/idea-IC-231.9414.13/bin/idea.sh",
    -- "lsp-server"
    -- "-Djava.awt.headless=true"
  },
  root_dir = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1])
})

-- Fix bug : "Buffer X newer than edit" on rename
-- See : https://github.com/neovim/neovim/issues/12970
vim.lsp.util.apply_text_document_edit = function(text_document_edit, _, offset_encoding)
    local text_document = text_document_edit.textDocument
    local bufnr = vim.uri_to_bufnr(text_document.uri)
    if offset_encoding == nil then
        vim.notify_once('apply_text_document_edit must be called with valid offset encoding', vim.log.levels.WARN)
    end

    vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
end

-- TMP : Display completion result
vim.lsp.util.extract_completion_items = function(result)
  vim.notify_once(result, vim.log.levels.ERROR)
  vim.lsp.util.extract_completion_items(result)
end
