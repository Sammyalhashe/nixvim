{
  autoCmd = [
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [
        "*.tf"
        "*.tfvars"
        "*.hcl"
      ];
      command = "set ft=terraform";
    }
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [
        "*.bicep"
        "*.bicepparam"
      ];
      command = "set ft=bicep";
    }
  ];
}
