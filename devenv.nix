# Docs: https://devenv.sh/basics/
{ pkgs, inputs, ... }:
let
  # Use unstable packages for newer Go version
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  languages = {
    # Docs: https://devenv.sh/languages/
    nix.enable = true;
    go = {
      enable = true;
      # package = pkgs-unstable.go; # Use latest Go from unstable
    };
  };

  packages = with pkgs; [
    # Go development tools from unstable
    # gopls # Go language server
    # gofumpt # Stricter gofmt as required by the project
    # golangci-lint # Linter as used in the project
    # gotools # Additional Go tools

  ];

  git-hooks.hooks = {
    # Docs: https://devenv.sh/pre-commit-hooks/
    # list of pre-configured hooks: https://devenv.sh/reference/options/#pre-commithooks
    nil.enable = true; # nix lsp
    nixpkgs-fmt.enable = true; # nix formatting
    # Go hooks
    # golangci-lint.enable = true;
  };

  difftastic.enable = true; # enable semantic diffs - https://devenv.sh/integrations/difftastic/

  # Environment variables from Taskfile
  env = {
    CGO_ENABLED = "0";
    # GOTOOLCHAIN = "go1.25.0";
    # GOEXPERIMENT commented out as it may not be available in all Go versions
  };
}
