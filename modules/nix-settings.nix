{ ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.optimise.automatic = true;

  # Generation cleanup is handled by nh clean (see programs.nh in
  # configuration.nix); enabling nix.gc.automatic alongside it is an error.
  nix.settings = {
    # Emergency valve: if free space drops below min-free during a build,
    # GC until max-free is available.
    min-free = 5 * 1024 * 1024 * 1024;
    max-free = 25 * 1024 * 1024 * 1024;
  };
}
