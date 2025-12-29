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
  '';
}
