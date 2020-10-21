# git clone https://github.com/JSBSim-Team/jsbsim/
# export DESTDIR="./bin" && make install
{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs-channels/archive/b58ada326aa612ea1e2fb9a53d550999e94f1985.tar.gz") {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "jsbsim";
  version = "1.1.0";

  src = pkgs.fetchurl {
    url = "https://github.com/JSBSim-Team/jsbsim/archive/v${version}.tar.gz";
    sha256 = "0kicwcl2qb5bsrdm6fyc7fdiwhx1vbdphqkms2s6a7sypgddpbwp";
  };
  # src = pkgs.fetchFromGithub {
  #   owner = "JSBSim-Team";
  #   repo = "jsbsim";
  #   rev = "v${version}";
  #   sha256 = "1ixgv6flx1yb8f6baawa7hr3vbcq906fcxdcrzg9l6kaig37iw30";
  # };

   # buildInputs = with pkgs; [
   buildInputs = with pkgs; [
    cmake
    gnumake
    gcc
    doxygen
    graphviz
    python3
    python36Packages.cython
    fontconfig
    pkgconfig
    cxxtest
    #tools
    sudo
    fasd
   ];

   buildPhases = ["unpackPhase" "configurePhase" "buildPhase" "installPhase" ];

   unpackPhase = ''
     tar zxvf $src
     cd jsbsim-${version}
   '';

   configurePhase = ''
     export FONTCONFIG_PATH=/etc/fonts
     cmake .
   '';

   buildPhase = ''
     nbcore=$(nproc)
     make -j$nbcore 
     make install
   '';

   installPhase = ''
     mkdir -p $out/bin
     mv jsbsim $out/bin
   '';
}
