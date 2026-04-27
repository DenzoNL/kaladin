{ pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
    nerd-fonts.jetbrains-mono
  ];

  # Keyboard layout (used by console + Plasma; the option lives under
  # xserver.xkb for legacy reasons but applies on Wayland too).
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  console.keyMap = "us-acentos";

  # Native Wayland for Chromium/Electron apps (Vivaldi, VS Code, etc.).
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
