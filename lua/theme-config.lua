require('kanagawa').setup {
  transparent = true,
  keywordStyle = { italic = false },
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  }
}

vim.cmd('colorscheme kanagawa')
