# Development shell for homelab-diagram.
# Usage: run `nix-shell` in this folder, then `python3 build.py`.
{ pkgs ? import <nixpkgs> { } }:

let
  # Make the Fira fonts visible to rsvg-convert and Pillow via fontconfig.
  fonts = pkgs.makeFontsConf {
    fontDirectories = [ pkgs.fira-sans pkgs.fira-code ];
  };
in
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (ps: [ ps.pyyaml ps.pillow ]))
    pkgs.librsvg      # provides rsvg-convert for the PNG export
    pkgs.fontconfig   # provides fc-list / fc-match
  ];

  FONTCONFIG_FILE = fonts;

  shellHook = ''
    echo "homelab-diagram shell ready."
    echo "  python3 fetch_icons.py   # download icons (first time only)"
    echo "  python3 build.py         # build out/homelab.png"
  '';
}
