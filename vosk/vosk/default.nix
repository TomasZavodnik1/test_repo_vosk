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
 kaldi, 
 openfst,
 cmake
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "vosk";
  version = "v0.15";
  src = ./.;
  buildInputs = [ ( pkgs.callPackage ../kaldi {} )  ];
  nativeBuildInputs =  [  ];
  #configurationPhase = ''
  #                     ls  
  #                     '';
  buildPhase = ''
                cmake .
                #make all
               '';
 installPhase = '' touch $out/bin '';
}

