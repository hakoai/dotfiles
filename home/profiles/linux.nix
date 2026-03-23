{ pkgs, ... }:
{
  programs.fish.shellAliases.hms = "home-manager switch --flake ~/dotfiles#linux";
  programs.fish.shellAliases.hmb = "home-manager build --flake ~/dotfiles#linux";

  programs.fish.functions.hmd = {
    description = "Update flake and show home-manager diff with nvd";
    body = ''
      set -l dotfiles ~/dotfiles
      home-manager build --flake $dotfiles#linux
      and nvd diff ~/.local/state/nix/profiles/home-manager $dotfiles/result
    '';
  };

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.nerd-fonts.fira-code
  ];
}
