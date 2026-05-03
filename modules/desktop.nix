{ pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [ qtmultimedia qtsvg qtvirtualkeyboard ];
  };
  services.desktopManager.plasma6.enable = true;

  # Theme package must land in /run/current-system/sw so SDDM can discover it
  # via its hard-coded ThemeDir.
  environment.systemPackages = [ pkgs.sddm-astronaut ];

  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
    nerd-fonts.jetbrains-mono
  ];

  # Keyboard layout for console + Wayland (option lives under xserver.xkb
  # for legacy reasons but applies on Wayland too).
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  console.keyMap = "us-acentos";

  # Native Wayland for Chromium/Electron apps (Vivaldi, VS Code, etc.).
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
