{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    historyLimit = 10000;
    terminal = "screen-256color";
    clock24 = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = tmux-colors-solarized;
        extraConfig = ''
          set -g @colors-solarized 'dark'
        '';
      }
    ];

    extraConfig = ''
      set -g terminal-overrides 'xterm:colors=256'
    '';
  };
}
