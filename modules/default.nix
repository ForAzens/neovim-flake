{ lib, ... }:

with lib;

{

  options.vim.luaFiles = mkOption {
    description = "List of lua files to source";
    type = with types; listOf package;
    default = [ ];
  };

  options.vim.plugins = mkOption {
    description = "List of plugins to install";
    type = with types; listOf package;
    default = [ ];
  };

  options.vim.runtimeDeps = mkOption {
    description = "List of runtime deps to install";
    type = with types; listOf package;
    default = [ ];
  };


  # Reverse the list because order is important, but the arrays are merged adding the last element first
  imports = lib.lists.reverseList [
    ./core
    ./which-key
    ./telescope
    ./lazygit
    ./lsp
  ];
}
