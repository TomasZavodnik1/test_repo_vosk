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
 kaldi
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "kaldi";
  version = "v1.0";
  src = ./.;
  buildInputs = [ libtool ( pkgs.callPackage ../openfst {} )  libtool.lib mkl python27 subversion python39 sox gfortran  wget git unzip automake autoconf  zlib pkg-config gnumake kaldi ];
  nativeBuildInputs =  [ pkg-config gnumake kaldi ];
  #configurationPhase = ''
  #                     ls  
  #                     '';
  buildPhase = ''
                cd tools/
                #sh extras/check_dependencies.sh
                make -j 4
                cd src/
                make -j 4
                ls
                #make all
               '';
 installPhase = '' touch $out/bin '';
}

