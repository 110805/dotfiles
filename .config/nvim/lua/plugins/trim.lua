return {
  "cappyzawa/trim.nvim",
  opts = {
    ft_blocklist = {"markdown"},

    -- replace multiple blank lines with a single line
    patterns = {
      [[%s/\(\n\n\)\n\+/\1/]],
    },

    -- highlight trailing spaces
    highlight = true,
  }
}
