# `nix flake check` gates: formatting, lints, dead code. Evaluating the
# nixosConfiguration itself is part of `nix flake check` by default.
{ nixpkgs, self }:
let
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
in
{
  x86_64-linux = {
    format = pkgs.runCommand "check-format" { nativeBuildInputs = [ pkgs.nixfmt ]; } ''
      find ${self} -name '*.nix' -exec nixfmt --check {} +
      touch $out
    '';

    statix = pkgs.runCommand "check-statix" { nativeBuildInputs = [ pkgs.statix ]; } ''
      cd ${self} && statix check .
      touch $out
    '';

    deadnix = pkgs.runCommand "check-deadnix" { nativeBuildInputs = [ pkgs.deadnix ]; } ''
      deadnix --fail ${self}
      touch $out
    '';
  };
}
