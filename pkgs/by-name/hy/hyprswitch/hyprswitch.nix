{ lib, pkgs, pkg-config, rustPlatform, makeWrapper, fetchFromGitHub}: let
  package = (builtins.fromTOML (builtins.readFile ./Cargo.toml)).package;
in
  rustPlatform.buildRustPackage rec {
    name = package.name;
    version = package.version;

    src = fetchFromGitHub {
        owner = "WrkX";
        repo = "hyprswitch";
        rev = "v3.2.5";
        fetchSubmodules = true;
        hash = "sha256-Zc42gp9ZoYE3/yWAQtBa+cBSjaam/e3OffJkrQTUvWc";
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
