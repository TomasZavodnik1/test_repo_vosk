{
 pkgs,
 libtool,
 mkl,
 python27,
 subversion,
 python39,
 sox,
 gfortran,
 wget,
 git,
 unzip,
 automake,
 autoconf,
 zlib,
 pkg-config,
 gnumake,
 openfst,
 cmake
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "vosk";
  version = "v0.15";
  src = ./.;
  buildInputs = [ pkgs.kaldi cmake ];
  nativeBuildInputs =  [ cmake ];
  #configurationPhase = ''
  #                     ls  
  #                     '';
  buildPhase = ''
                cmake .
                make all
               '';
 installPhase = '' mkdir $out/bin '';
}

