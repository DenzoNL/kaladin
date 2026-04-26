{ pkgs, ... }:

{
  home.username = "denzo";
  home.homeDirectory = "/home/denzo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    claude-code
    git
    gitkraken
    kdePackages.kate
    signal-desktop
    vivaldi
    zapzap
    zed-editor
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/kaladin#kaladin";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };
}
