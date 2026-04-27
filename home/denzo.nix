{ pkgs, ... }:

{
  home.username = "denzo";
  home.homeDirectory = "/home/denzo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    alacritty
    claude-code
    git
    gitkraken
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
    interactiveShellInit = ''
      set fish_greeting
    '';
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
