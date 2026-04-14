{ ... }:
{
  programs.fish.shellAliases.hms = "home-manager switch --flake ~/dotfiles#darwin";
  programs.fish.shellAliases.hmb = "home-manager build --flake ~/dotfiles#darwin";

  programs.fish.functions.hmd = {
    description = "Update flake and show home-manager diff with nvd";
    body = ''
      set -l dotfiles ~/dotfiles
      home-manager build --flake $dotfiles#darwin
      and nvd diff ~/.local/state/nix/profiles/home-manager $dotfiles/result
    '';
  };
}
