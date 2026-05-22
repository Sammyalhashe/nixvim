{ lib, ... }:
{
  extraConfigLua = ''
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp", "cuda" },
      callback = function()
        vim.opt_local.formatoptions:append("cro")
        vim.bo.commentstring = "/* %s */"
        vim.opt_local.cindent = true
        vim.opt_local.indentexpr = ""
      end,
    })

    vim.api.nvim_create_user_command("Hdr", function(opts)
      local border = opts.args ~= "" and opts.args:sub(1, 1) or "-"
      local line = vim.api.nvim_get_current_line()
      local indent = line:match("^(%s*)") or ""
      local text = vim.fn.trim(line)
      local ft = vim.bo.filetype
      local cs = vim.tbl_contains({ "c", "cpp", "cuda", "java", "javascript", "typescript", "go", "rust", "zig" }, ft)
        and "// " or "# "
      local width = 79
      local full = cs .. text
      local pad = string.rep(" ", math.max(0, math.floor((width - #full) / 2) - #indent))
      local sep = indent .. pad .. cs .. string.rep(border, #text)
      local mid = indent .. pad .. cs .. text
      local row = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(0, row - 1, row, false, { sep, mid, sep })
    end, { nargs = "?", desc = "Wrap line in centered comment header" })
  '';
}
