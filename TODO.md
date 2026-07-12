# kaladin audit — 2026-07-12

Findings from the full config + live-system review, ranked by impact.
Working through these one at a time; delete items as they're resolved.

## Monitor (no action yet)

- kwin_wayland logs bursts of `GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT` — known
  NVIDIA/kwin noise on the open kmod; revisit after next driver bump.
- One vivaldi-bin coredump this boot (10:37). One-off unless it recurs.

## Checked, fine (don't re-flag)

- fwupd + dual-boot: no BitLocker on the Windows side (confirmed 2026-07-12),
  so UEFI updates are safe; after one, check `sbctl status` in case the
  update reset Secure Boot keys (re-enroll with `sbctl enroll-keys` if so).
- Bluetooth left disabled (2026-07-12) — nothing uses it; enable
  `hardware.bluetooth` only if controllers/headphones ever get paired.
- GPG signing key + SSH key are backed up in 1Password (confirmed 2026-07-12)
  — no separate backup service needed for them.
- Secure Boot: enabled (user mode), sbctl present, Limine chainloads Windows.
- Firewall active; only Steam (LAN discovery, blocked by firewall) and
  tailscaled listen externally.
- RTC in UTC with `hardwareClockInLocalTime = false` — deliberate; Windows
  side presumably has the `RealTimeIsUniversal` registry fix.
- Flake inputs locked 2026-06-29 (~2 weeks old); running system matches the
  lock. `nix flake check` passes.
- GC (weekly, 14d) + `nix.optimise` + Limine `maxGenerations = 10` are
  consistent; /boot at 25%, / at 17%, store 53G.
- 1Password `custom_allowed_browsers` with mode 0755 — documented upstream
  pattern.
- statix `repeated_keys` warnings — house style says ignore.
- Tailscale "can't reach coordination server" (2026-07-12) — stale tailscaled
  connections after a router reboot; fixed with a daemon restart. The
  remaining `--accept-routes is false` advisory is intentional (no need for
  the router's subnet routes; everything is on the tailnet directly).
