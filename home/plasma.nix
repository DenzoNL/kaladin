{ pkgs, ... }:

let
  catppuccinKde = pkgs.catppuccin-kde.override {
    flavour = [ "mocha" ];
    accents = [ "mauve" ];
    winDecStyles = [ "modern" ];
  };

  catppuccinKvantum = pkgs.catppuccin-kvantum.override {
    variant = "mocha";
    accent = "mauve";
  };
in
{
  home.packages = [
    catppuccinKde
    catppuccinKvantum
    pkgs.catppuccin-cursors.mochaMauve
    pkgs.papirus-icon-theme
    pkgs.kdePackages.qtstyleplugin-kvantum
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "Catppuccin-Mocha-Mauve";
      colorScheme = "CatppuccinMochaMauve";
      iconTheme = "Papirus-Dark";
      widgetStyle = "kvantum";
      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__CatppuccinMocha-Modern";
      };
      cursor = {
        theme = "catppuccin-mocha-mauve-cursors";
        size = 24;
      };
    };

    # Tell Kvantum which theme to render Qt apps with.
    configFile."Kvantum/kvantum.kvconfig"."General"."theme" = "catppuccin-mocha-mauve";
  };
}
