{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/hardware.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/nix-settings.nix
  ];

  # Bootloader.
  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    maxGenerations = 10;
    extraEntries = ''
      /Windows
          protocol: efi_chainload
          image_path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "kaladin";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  time.hardwareClockInLocalTime = false;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  services.fstrim.enable = true;
  services.tailscale.enable = true;

  users.users.denzo = {
    isNormalUser = true;
    description = "Dennis Bogers";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # Required when fish is a login shell: adds fish to /etc/shells, wires up
  # vendor completions for system packages, and sources NixOS env in fish.
  programs.fish.enable = true;

  programs.steam.enable = true;
  programs.gamemode.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/denzo/kaladin";
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "denzo" ];
  };

  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      vivaldi-bin
    '';
    mode = "0755";
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";
}
