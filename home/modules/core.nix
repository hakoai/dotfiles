{ pkgs, lib, ... }:
{
  home.username = "hakoai";
  home.homeDirectory = "/home/hakoai";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "code --wait";
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
      "codex"
    ];

  programs.home-manager.enable = true;

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.awscli.enable = true;
  programs.vim.enable = true;
  programs.zellij.enable = true;
  programs.claude-code.enable = true;
  programs.codex.enable = true;

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };
}
