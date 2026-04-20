{ pkgs, lib, config, ... }:
let
  parsersDir = "~/.local/share/tree-sitter/parsers";
in
{
  # Add a custom parsers directory to Neovim's runtime path.
  # If ~/.local/share/tree-sitter/parsers/ exists with compiled
  # .so files in parser/, nvim-treesitter will pick them up.
  # Silently skipped on hosts where the directory is absent.
  extraConfigLua = ''
    local parsers_dir = vim.fn.expand("${parsersDir}")
    if vim.fn.isdirectory(parsers_dir) == 1 then
      vim.opt.runtimepath:append(parsers_dir)

      require("nvim-treesitter.configs").setup({
        parser_install_dir = parsers_dir,
      })
    end

    vim.filetype.add({
      extension = {
        dmptest = "dmptest",
        dmptool = "dmptool",
      },
    })
    vim.treesitter.language.register("dmptest", "dmptest")
    vim.treesitter.language.register("dmptool", "dmptool")
  '';

  # Injection queries and highlight definitions for custom
  # tree-sitter parsers. These are no-ops if the parser .so
  # files are not installed.
  extraFiles = {
    # Inject dmptest into C++ string literals starting with
    # known test DSL commands
    "after/queries/cpp/injections.scm".text = ''
      ; extends

      ((string_content) @injection.content
        (#match? @injection.content "^(Sub|Resub|Unsub|ReqRecap|UpdateSub|LockModel|UnlockModel|RelockModel|SubEvent|SubResp|ResubResp|ResolveResp|Update|Recap)\\(")
        (#set! injection.language "dmptest"))
    '';

    # dmptest highlights
    "after/queries/dmptest/highlights.scm".text = ''
      [
        "Sub" "Resub" "Unsub" "ReqRecap" "UpdateSub"
        "LockModel" "UnlockModel" "RelockModel"
        "SubEvent" "SubResp" "ResubResp" "ResolveResp"
        "Update" "Recap"
      ] @keyword

      [
        "F" "Group" "Col" "Records" "Deletes"
        "SeqIds" "RecapId" "PrevSubId" "Dist" "SubIds"
      ] @function

      [
        "Int" "Int64" "Double" "Bool" "Null"
        "Date" "Time" "Datetime"
        "DateTz" "TimeTz" "DatetimeTz"
      ] @type

      (event_type) @type
      (resp_error_status) @type
      (resolve_status) @type
      (flag) @constant

      (integer) @number
      (negative_integer) @number

      (cell_value (plain_value) @string)

      (tag_pair key: (tag_key) @attribute)
      (tag_pair value: (plain_value) @string)

      (model_descriptor name: (identifier) @variable)
      (field_list field: (identifier) @variable)
      (field_map_entry symbol: (identifier) @variable)
      (identifier) @variable

      (error_marker) @string.special

      "(" @punctuation.bracket
      ")" @punctuation.bracket
      ":" @punctuation.delimiter
      "|" @punctuation.delimiter
    '';

    # dmptool highlights
    "after/queries/dmptool/highlights.scm".text = ''
      [
        "exit" "help" "hostnames" "introspect" "listen"
        "log" "modelname" "option" "pipe" "print" "pub"
        "registerModel" "rsp" "set" "sleep" "start" "stop"
        "sub" "unblacklist" "hist" "dti" "bas"
        "unregisterModel"
      ] @keyword

      [
        "verb" "stdout" "file" "text" "none" "guts" "tag"
        "command" "event" "connect" "allocators" "host"
        "instance" "updates" "ignore" "expect"
      ] @keyword.directive

      [
        "useEngine" "protocolVersion" "alwaysRecap"
        "priority" "logicalTaskname" "pubLimits"
        "maxModelBacklog" "writeCache"
        "maxThrottleQueueSizeMB" "enableNonTzDateTime"
        "cbrCapabilities" "maxStringLength" "broadcast"
        "enableManualPublisherReady"
        "writeOutstandingSubsWatermarks"
      ] @property

      [
        "useBuffer" "failStartModel" "manualUpdates"
        "publishOnStart" "updateModels" "modelInitialSize"
      ] @function
      (pub_recap_models) @function
      (pub_request_subscription_handover) @function
      (pub_send_publisher_ready) @function

      [
        "subreq" "resubreq" "unsub" "recapreq"
        "consume" "subscribeOnPubLost" "cbr"
        "addCbrOverride"
      ] @function
      (sub_next) @function
      (sub_get_all_events) @function
      (sub_num_events) @function
      (sub_ignore) @function

      [
        "-model" "-tags" "-fields"
        "-subscriptionCorrelator" "-sc"
        "-recapCorrelator" "-rc" "-sessionId"
      ] @attribute

      (severity) @type.qualifier
      (boolean) @constant.builtin
      (set_pub type: _ @type)
      (set_sub type: _ @type)
      ["on" "off"] @constant.builtin

      (option_protocol_version value: _ @number)
      (integer) @number
      (number) @number.float

      (identifier) @variable
      (string_value) @string
      (command_name) @string.special

      (tag_pair ":" @punctuation.delimiter)
      (rsp_endpoint ":" @punctuation.delimiter)
    '';
  };
}
