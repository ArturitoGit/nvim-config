local function toggle()
  vim.cmd('NERDTreeToggle')
end

local function openAtCurrentFile()
  vim.cmd('NERDTreeFind')
end

-- Do not open NerdTree as first buffer
vim.g.NERDTreeHijackNetrw=0

-- In NERDTree
vim.g.NERDTreeMapJumpNextSibling='<C-K>' -- Make <C-j> free

-- Enter NERDTree
vim.keymap.set('n', '<Leader>j', toggle)
vim.keymap.set('n', '<Leader>k', openAtCurrentFile)
