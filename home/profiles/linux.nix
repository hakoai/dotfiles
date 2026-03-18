{ ... }:
{
  programs.fish.shellAliases.hms = "home-manager switch --flake ~/dotfiles#linux";
  programs.fish.shellAliases.hmb = "home-manager build --flake ~/dotfiles#linux";
}
