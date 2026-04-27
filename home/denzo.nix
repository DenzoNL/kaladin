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
    plexamp
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
    settings.user = {
      name = "Dennis Bogers";
      email = "dennis@bogers.xyz";
    };
    signing = {
      format = "openpgp";
      key = "5FE2A9AD81F0FAD0";
      signByDefault = true;
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
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
    icons = "auto";
  };
}
