# git clone https://github.com/JSBSim-Team/jsbsim/
# export DESTDIR="./bin" && make install
{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs-channels/archive/b58ada326aa612ea1e2fb9a53d550999e94f1985.tar.gz") {}
}:
pkgs.mkShell rec {
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
}
