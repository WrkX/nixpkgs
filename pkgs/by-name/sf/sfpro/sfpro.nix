{ lib, stdenvNoCC, ...  }:

stdenvNoCC.mkDerivation {
  name = "sfDisplayProRegular";
  dontConfigue = true;
  dontUnpack = true;
  src = ./sfpro;

  installPhase = ''

    mkdir -p $out/share/fonts/sfProDisplayRegular
    install -Dm644 $src/*.otf -t $out/share/fonts/sfProDisplayRegular/
    '';

  meta =  {
    description = "SF Pro Display Regular";
    homepage = "https://github.com/caheredia/fonts";
  };

}
