{ pkgs, ... }:

{
  home.username = "denzo";
  home.homeDirectory = "/home/denzo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    claude-code
    git
    kdePackages.kate
    vivaldi
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
}
