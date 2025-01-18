{ lib, pkgs, pkg-config, rustPlatform, makeWrapper }: let
  package = (builtins.fromTOML (builtins.readFile ./Cargo.toml)).package;
in
  rustPlatform.buildRustPackage rec {
    name = package.name;
    version = package.version;

    src = fetchFromGitHub {
        owner = "H3rmt";
        repo = "hyprswitch";
        rev = "v3.2.0";
        fetchSubmodules = true;
        hash = "";
      };
    cargoLock.lockFile = ./Cargo.lock;

    nativeBuildInputs = [ pkg-config makeWrapper ];
    buildInputs = with pkgs; [ glib gtk4 gtk4-layer-shell ];

    postInstall = ''
      wrapProgram $out/bin/${name}
    '';

    meta = {
      description = package.description;
      homepage = package.repository;
      license = package.license;
    };
  }
