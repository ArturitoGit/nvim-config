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
vim.g.NERDTreeMapQuit='<C-j>'

-- Enter NERDTree
vim.keymap.set('n', '<C-j>', toggle)
vim.keymap.set('n', '<Leader>j', openAtCurrentFile)
