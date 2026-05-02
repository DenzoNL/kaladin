{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
  ];

  home.username = "denzo";
  home.homeDirectory = "/home/denzo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    claude-code
    discord
    gitkraken
    karere
    nixd
    plexamp
    signal-desktop
    vivaldi
    zed-editor
  ];
}
