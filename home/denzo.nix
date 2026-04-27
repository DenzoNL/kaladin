{ pkgs, ... }:

{
  home.username = "denzo";
  home.homeDirectory = "/home/denzo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    alacritty
    claude-code
    discord
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

  programs.git = {
    enable = true;
    userName = "Dennis Bogers";
    userEmail = "dennis@bogers.xyz";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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
