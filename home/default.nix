{ lib, isWsl, isDarwin, ... }:
{
  imports =
    [
      ./modules/core.nix
      ./modules/fish.nix
      ./modules/git.nix
      ./modules/packages.nix
      ./modules/ssh.nix
      ./modules/tmux.nix
    ]
    ++ lib.optionals isWsl [
      ./modules/wsl-agent.nix
      ./profiles/wsl.nix
    ]
    ++ lib.optionals isDarwin [
      ./profiles/darwin.nix
    ]
    ++ lib.optionals (!isWsl && !isDarwin) [
      ./profiles/linux.nix
    ];
}
