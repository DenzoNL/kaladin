{ config, ... }:

{
  boot.kernelParams = [ "nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # RTX 5070 Ti — Blackwell. Open kmod is required; closed driver lacks support.
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Enables nvidia-suspend/-resume.service which save and restore VRAM
    # across S3. Without this the GPU state is lost on suspend and the
    # machine hangs on wake (RTX 5070 Ti, Wayland).
    powerManagement.enable = true;
    # Default flips to true on open kmod + driver >=595, which routes
    # suspend through an in-kernel notifier. That path hangs on Blackwell
    # at the moment; force the legacy systemd-services flow instead.
    powerManagement.kernelSuspendNotifier = false;
  };
}
