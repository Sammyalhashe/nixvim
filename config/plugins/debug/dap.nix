{ pkgs, ... }:
let
  codelldbPkg = pkgs.vscode-extensions.vadimcn.vscode-lldb;
  codelldbCmd = "${codelldbPkg}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";

  cppConfigurations = [
    {
      type = "codelldb";
      request = "launch";
      name = "Launch executable";
      program.__raw = ''
        function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end
      '';
      cwd = "\${workspaceFolder}";
      stopOnEntry = false;
    }
    {
      type = "codelldb";
      request = "attach";
      name = "Attach to process";
      pid.__raw = "require('dap.utils').pick_process";
      cwd = "\${workspaceFolder}";
    }
  ];
in
{
  plugins.dap = {
    enable = true;

    adapters.servers.codelldb = {
      port = "\${port}";
      executable = {
        command = codelldbCmd;
        args = [
          "--port"
          "\${port}"
        ];
      };
    };

    configurations = {
      cpp = cppConfigurations;
      c = cppConfigurations;
    };

    signs = {
      dapBreakpoint.text = "";
      dapBreakpointCondition.text = "";
      dapLogPoint.text = "";
      dapStopped.text = "→";
      dapBreakpointRejected.text = "";
    };
  };

  plugins.dap-ui.enable = true;
  plugins.dap-virtual-text.enable = true;

  # Auto open/close the dap-ui panels with the debug session (community idiom;
  # no dedicated nixvim option for it). extraConfigLua concatenates across files.
  extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<F5>";
      action.__raw = "function() require('dap').continue() end";
      options.desc = "Debug: Continue";
    }
    {
      mode = "n";
      key = "<leader>dc";
      action.__raw = "function() require('dap').continue() end";
      options.desc = "Debug: Continue";
    }
    {
      mode = "n";
      key = "<F10>";
      action.__raw = "function() require('dap').step_over() end";
      options.desc = "Debug: Step over";
    }
    {
      mode = "n";
      key = "<leader>do";
      action.__raw = "function() require('dap').step_over() end";
      options.desc = "Debug: Step over";
    }
    {
      mode = "n";
      key = "<F11>";
      action.__raw = "function() require('dap').step_into() end";
      options.desc = "Debug: Step into";
    }
    {
      mode = "n";
      key = "<leader>di";
      action.__raw = "function() require('dap').step_into() end";
      options.desc = "Debug: Step into";
    }
    {
      mode = "n";
      key = "<leader>dO";
      action.__raw = "function() require('dap').step_out() end";
      options.desc = "Debug: Step out";
    }
    {
      mode = "n";
      key = "<F9>";
      action.__raw = "function() require('dap').toggle_breakpoint() end";
      options.desc = "Debug: Toggle breakpoint";
    }
    {
      mode = "n";
      key = "<leader>db";
      action.__raw = "function() require('dap').toggle_breakpoint() end";
      options.desc = "Debug: Toggle breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dB";
      action.__raw = ''
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end
      '';
      options.desc = "Debug: Conditional breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dr";
      action.__raw = "function() require('dap').repl.open() end";
      options.desc = "Debug: Open REPL";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action.__raw = "function() require('dap').run_last() end";
      options.desc = "Debug: Run last";
    }
    {
      mode = "n";
      key = "<leader>du";
      action.__raw = "function() require('dapui').toggle() end";
      options.desc = "Debug: Toggle UI";
    }
    {
      mode = "n";
      key = "<leader>dt";
      action.__raw = "function() require('dap').terminate() end";
      options.desc = "Debug: Terminate";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>de";
      action.__raw = "function() require('dapui').eval() end";
      options.desc = "Debug: Eval/hover";
    }
  ];
}
