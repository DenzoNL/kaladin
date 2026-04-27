{ pkgs, ... }:

{
  home.username = "denzo";
  home.homeDirectory = "/home/denzo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    alacritty
    claude-code
    discord
    git
    gitkraken
    karere
    nixd
    signal-desktop
    vivaldi
    zed-editor
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "nh os switch";
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
