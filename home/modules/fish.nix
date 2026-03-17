{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      if not test -d "$HOME/.ssh"
        mkdir -p "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"
      end
    '';

    shellInitLast = ''
      starship init fish | source
    '';

    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "d2f502f5575b18a32e1bee2f2b3f869a5053c159";
          sha256 = "sha256-4c9ScQVf55b2ANaR7Lp/oqLeuK+FxH/wKmSNLV+b/CE=";
        };
      }
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "0069dbbe06cc05482bfb13063b4b4eac26318992";
          sha256 = "sha256-H7HgYT+okuVXo2SinrSs+hxAKCn4Q4su7oMbebKd/7s=";
        };
      }
    ];
  };
}
