{ config, pkgs, lib, ... }:
let
  agentSock = "${config.home.homeDirectory}/.ssh/agent.sock";
  npiperelay = import ../lib/npiperelay.nix { inherit pkgs; };
in
{
  programs.fish.interactiveShellInit = lib.mkAfter ''
    set -gx SSH_AUTH_SOCK "${agentSock}"

    if test -S "$SSH_AUTH_SOCK"
      ssh-add -l >/dev/null 2>&1
      or rm -f "$SSH_AUTH_SOCK"
    end

    if not test -S "$SSH_AUTH_SOCK"
      ${pkgs.socat}/bin/socat \
        UNIX-LISTEN:"$SSH_AUTH_SOCK",fork \
        EXEC:"${npiperelay}/bin/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork \
        >/dev/null 2>&1 &

      disown
    end
  '';
}
