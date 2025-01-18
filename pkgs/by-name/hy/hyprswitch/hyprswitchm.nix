{ lib, pkgs, pkg-config, rustPlatform, makeWrapper, fetchFromGitHub }: let
  pdescription = "Window Switcher for Hyprland";
  pversion = "v3.2.0";
in
  rustPlatform.buildRustPackage rec {
    name = "hyprswitch";
    version = pversion;

    src = fetchFromGitHub {
       owner = "WrkX";
       repo = "hyprswitch";
       rev = "v3.2.0";
       hash = "";
     };

    cargoLock.lockFile = ./Cargo.lock;

    nativeBuildInputs = [ pkg-config makeWrapper ];
    buildInputs = with pkgs; [ glib gtk4 gtk4-layer-shell ];

    postInstall = ''
      wrapProgram $out/bin/${name}
    '';

    meta = {
      description = pdescription;
    };
  }
