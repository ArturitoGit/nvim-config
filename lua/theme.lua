local colors = require("onenord.colors").load()

require('onenord').setup({
  theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
  borders = true, -- Split window borders
  fade_nc = false, -- Fade non-current windows, making them more distinguishable
  -- Style that is applied to various groups: see `highlight-args` for options
  styles = {
    comments = "NONE",
    strings = "NONE",
    keywords = "NONE",
    functions = "NONE",
    variables = "NONE",
    diagnostics = "underline",
  },
  disable = {
    background = false, -- Disable setting the background color
    cursorline = false, -- Disable the cursorline
    eob_lines = true, -- Hide the end-of-buffer lines
  },
  -- Inverse highlight for different groups
  inverse = {
    match_paren = false,
  },
  custom_highlights = {
    -- Change java constructor color
    -- Available colors are listed here :
    -- https://github.com/rmehri01/onenord.nvim/blob/main/lua/onenord/colors/onenord.lua
    -- ["@lsp.mod.constructor.java"] = { fg = colors.purple },
  },
  custom_colors = {
    -- red = "#ffffff",
  },
})
