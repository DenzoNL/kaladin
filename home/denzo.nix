{ pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.default
    inputs.walker.homeManagerModules.default
    ./shell.nix
    ./git.nix
    ./hyprland.nix
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  home.username = "denzo";
  home.homeDirectory = "/home/denzo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    claude-code
    discord
    gitkraken
    karere
    kdePackages.dolphin
    nixd
    plexamp
    signal-desktop
    vivaldi
    zed-editor
  ];
}
