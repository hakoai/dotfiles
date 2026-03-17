{ config, ... }:
let
  agentSock = "${config.home.homeDirectory}/.ssh/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      extraOptions = {
        IdentityAgent = agentSock;
      };
      serverAliveInterval = 60;
      serverAliveCountMax = 3;
      forwardAgent = false;
    };
  };
}
