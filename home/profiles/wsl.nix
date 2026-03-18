{ pkgs, ... }:
{
  programs.fish.shellAliases.hms = "home-manager switch --flake ~/dotfiles#wsl";
  programs.fish.shellAliases.hmb = "home-manager build --flake ~/dotfiles#wsl";

  home.packages = [ pkgs.socat ];

  programs.git.settings.credential.helper =
    "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
}
