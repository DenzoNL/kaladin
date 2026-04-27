{ pkgs, ... }:

{
  home.packages = [ pkgs.alacritty ];

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
    icons = "auto";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
