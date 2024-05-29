#{
# pkgs,
# libtool,
# mkl,
# python27,
# subversion,
# python39,
# sox,
# gfortran,
# wget,
# git,
# unzip,
# automake,
# autoconf,
# zlib,
# pkg-config,
# gnumake,
# cmake
#}:
with import <nixpkgs> {};
with pkgs;
stdenv.mkDerivation rec {
  pname = "vosk";
  version = "v0.15";
  src = ./.;
  buildInputs = [ gfortran perl cmake bash python39 autoconf automake zlib unzip sox libtool ];
  nativeBuildInputs =  [ ];
  configurePhase = ''
                       ls  
                       '';
  buildPhase = ''
                cd tools/
                #make openfst cub
                ls
                pwd
                cd extras/OpenBLAS
                #sh extras/install_openblas_clapack.sh
                make  ONLY_CBLAS=1 DYNAMIC_ARCH=1 TARGET=CORTEXA57 USE_LOCKING=1 USE_THREAD=0 NUM_THREADS=512 all
                make install PREFIX=/build/kaldi/tools/extras/OpenBLAS/install
                #cd ../clapack
                #mkdir -p BUILD && cd BUILD && cmake .. && make -j 10 -C F2CLIBS && make -j 10 -C BLAS && make -j 10 -C SRC && find . -name "*.a" | xargs cp -t ../../OpenBLAS/install/lib
                #cd ../../../../src
                #sh configure --mathlib=OPENBLAS_CLAPACK --shared
                #make -j 10 online2 lm rnnlm                
                #cd ../vosk/src
                #KALDI_ROOT=../../ make
                
               '';
 installPhase = '' mkdir $out/bin '';
}

