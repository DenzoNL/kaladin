# kaladin

NixOS configuration for my personal machine, `kaladin`. Flake-based, with
[home-manager](https://github.com/nix-community/home-manager) integrated as a
NixOS module.

## Layout

- `flake.nix` — entry point, wires nixpkgs + home-manager
- `configuration.nix` — system-level config (boot, networking, users, programs)
- `hardware-configuration.nix` — generated, machine-specific
- `modules/` — split-out system modules (hardware, desktop, audio, nix settings)
- `home/denzo.nix` — home-manager config for my user

## Rebuild

```sh
rebuild   # alias for `nh os switch`
```

Pulls from this flake at `/home/denzo/kaladin`.
