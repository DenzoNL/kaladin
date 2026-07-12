{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./plasma.nix
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
    zed-editor
  ];

  programs.firefox = {
    enable = true;
    # Fresh install, so adopt the XDG profile path (default from 26.05).
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
