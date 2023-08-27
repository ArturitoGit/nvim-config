require'nvim-treesitter.configs'.setup {

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = function(lang)
      -- Enable custom Markdown syntax
      if lang == "markdown" then return true end
      return false
    end
  },
}
