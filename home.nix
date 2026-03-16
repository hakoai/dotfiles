{ config, pkgs, lib, ... }:

let
  isWsl =
    builtins.pathExists "/proc/sys/kernel/osrelease" &&
    (
      let
        osrelease = lib.toLower (builtins.readFile "/proc/sys/kernel/osrelease");
      in
        lib.hasInfix "microsoft" osrelease || lib.hasInfix "wsl" osrelease
    );
in
{
  programs.fish = {
    enable = true;
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
      #{
      #  name = "fzf";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "PatrickF1";
      #    repo = "fzf.fish";
      #    rev = "0069dbbe06cc05482bfb13063b4b4eac26318992";
      #    sha256 = "sha256-H7HgYT+okuVXo2SinrSs+hxAKCn4Q4su7oMbebKd/7s=";
      #  };
      #}
    ];
  };

  programs.git = {
    enable = true;

    settings = {
      user.name = "hakoai";
      user.email = "hakoai64@gmail.com";
    };

    extraConfig = lib.mkMerge [
      (lib.mkIf isWsl {
        credential.helper =
          "/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe";
      })
    ];
  };

  programs.starship.enable = true;
  # programs.fzf.enable = true;

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

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
      "codex"
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hakoai";
  home.homeDirectory = "/home/hakoai";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.claude-code
    pkgs.codex
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hakoai/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
