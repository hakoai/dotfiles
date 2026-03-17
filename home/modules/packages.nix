{ pkgs, ... }:
{
  home.packages = [
    pkgs.nixfmt
    pkgs.dust
  ];
}
