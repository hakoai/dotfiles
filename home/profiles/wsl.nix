{ pkgs, lib, ... }:
let
  # gh は GCM を使えないため、Windows 側 gh.exe のトークンを借りる
  ghWin = "/mnt/c/Program Files/GitHub CLI/gh.exe";
  ghWrapped = pkgs.symlinkJoin {
    name = "gh-wsl-${pkgs.gh.version}";
    paths = [ pkgs.gh ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm $out/bin/gh
      makeWrapper ${lib.getExe pkgs.gh} $out/bin/gh \
        --run 'if [ -z "$GH_TOKEN" ] && [ -x "${ghWin}" ]; then GH_TOKEN=$("${ghWin}" auth token 2>/dev/null | tr -d "\r"); [ -n "$GH_TOKEN" ] && export GH_TOKEN; fi'
    '';
    meta.mainProgram = "gh";
  };
in
{
  programs.gh.package = ghWrapped;

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
