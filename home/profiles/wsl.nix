{ pkgs, ... }:
{
  programs.fish.shellAliases.hms = "home-manager switch --flake ~/dotfiles#wsl";
  programs.fish.shellAliases.hmb = "home-manager build --flake ~/dotfiles#wsl";

  programs.fish.functions.hmd = {
    description = "Update flake and show home-manager diff with nvd";
    body = ''
      set -l dotfiles ~/dotfiles
      home-manager build --flake $dotfiles#wsl
      and nvd diff ~/.local/state/nix/profiles/home-manager $dotfiles/result
    '';
  };

  home.packages = [ pkgs.socat ];

  programs.git.settings.credential.helper =
    "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
}
