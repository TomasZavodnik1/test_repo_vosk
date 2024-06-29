# Copyright 2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
 pkgs,
 gcc,
 glibc,
 gnumake,
 cmake,
 gfortran,
 perl,
 bash,
 python39,
 python27,
 autoconf,
 binutils,
 libgcc
}:
#with import <nixpkgs> {};
with pkgs;
stdenv.mkDerivation rec {
  pname = "kaldi";
  version = "v0.3.50";
  src = ./.;
  buildInputs = [   gnumake pkgs.python39.pkgs.setuptools pkgs.python39.pkgs.cffi pkgs.python39.pkgs.requests pkgs.python39.pkgs.tqdm pkgs.python39.pkgs.srt pkgs.python39.pkgs.websockets  pkgs.python39.pkgs.setuptools coreutils bashInteractiveFHS dash bash  cmake  gfortran.cc perl bash python39 autoconf automake zlib unzip sox libtool ];
  nativeBuildInputs =  [  pkgs.python39.pkgs.setuptools   autoreconfHook perl cmake gnumake binutils  bash ];
  dontUseCmakeConfigure=true;
  autoreconfPhase = ''  
                     ls
                   '';
  doCheck=false;
  
  buildPhase = ''
                #tar -xvf source.tar
                cd tools/openfst/
                sh configure --enable-static
                make
                mkdir $out
                mkdir $out/openfst
                mkdir $out/openfst/include 
                mkdir $out/openfst/lib
                cd ..
                find openfst/ -name "*.a" -exec mv {} $out/openfst/lib/ \;
                cp -r openfst/include/* $out/openfst/include/

                cd extras/OpenBLAS                
                make - ONLY_CBLAS=1 DYNAMIC_ARCH=1 TARGET=ARMV8 USE_LOCKING=1 USE_THREAD=0 NUM_THREADS=512 all
                mkdir -p $out/openblas_install
                make PREFIX=$out/openblas install
                cd ../clapack
                mkdir -p BUILD && cd BUILD && cmake .. && make -j 10 -C F2CLIBS && make -j 10 -C BLAS && make -j 10 -C SRC && find . -name "*.a" | xargs cp -t $out/openblas/lib
                pwd
                cd ../../../../src
	        
                patchShebangs .
                substituteInPlace Makefile --replace /bin/bash ${pkgs.bash}/bin/bash
                substituteInPlace makefiles/default_rules.mk --replace /bin/bash ${pkgs.bash}/bin/bash
                
                sh configure --openblas-root=$out/openblas --static --fst-root=$out/openfst --fst-version=1.8.0
                make -j 10 online2 lm rnnlm
               '';
 installPhase = '' #mkdir $out
                   mkdir $out/kaldi
                   
                   mkdir $out/kaldi/lib
                   mkdir $out/kaldi/include

                   cd ..
                   cp src/* $out/kaldi/include
                   find src/ -name "*.a" -exec mv {} $out/kaldi/lib/ \;
                   
                   #cp tools/openfst/lib/* $out/openfst/lib
                   #cp tools/openfst/include/* $out/openfst/include

                   #cp -r tools/extras/OpenBLAS/install/* $out/openblas/

                   #cp -r ../tools/openfst/* $out/include/openfst_src
                   #cp -r ../tools/extras/OpenBLAS/install/* $out/include/openblas_src
                   #mkdir $out/usr
                   #mkdir $out/usr/lib
                   #mkdir $out/usr/lib/python3.9
                   #mkdir $out/usr/lib/python3.9/site-packages
                   #mkdir $out/usr/lib/python3.9/site-packages/vosk
	           ##mkdir $out/usr/lib/python3.9/site-packages/vosk/transcriber
	           
	           #cp -r build/lib/vosk/* $out/usr/lib/python3.9/site-packages/vosk
               	   #cp build/lib/vosk/transcriber/* $out/usr/lib/python3.9/site-packages/vosk/transcriber
	'';
}

