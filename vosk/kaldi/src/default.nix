with import <nixpkgs> {};

with pkgs;
stdenv.mkDerivation rec {
  pname = "kaldi";
  version = "v1.0";
  src = ./.;
  buildInputs = [ openfst libtool  libtool.lib mkl python27 subversion python39 sox gfortran  wget git unzip automake autoconf  zlib pkg-config gnumake kaldi openfst ];
  nativeBuildInputs =  [ openfst pkg-config gnumake kaldi openfst ];
  configurePhase = ''
                       ls  
                       '';
  buildPhase = ''
                sh configure --shared
                #sh extras/check_dependencies.sh
                make -j 4
                #make all
               '';
}

