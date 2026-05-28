{ config, ... }:
let
  agentSock = "${config.home.homeDirectory}/.ssh/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      IdentityAgent = agentSock;
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;
      ForwardAgent = false;
    };
  };
}
