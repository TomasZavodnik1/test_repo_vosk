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
  buildInputs = [  glibc.dev gcc libgcc gnumake pkgs.python39.pkgs.setuptools pkgs.python39.pkgs.cffi pkgs.python39.pkgs.requests pkgs.python39.pkgs.tqdm pkgs.python39.pkgs.srt pkgs.python39.pkgs.websockets  pkgs.python39.pkgs.setuptools coreutils bashInteractiveFHS dash bash  cmake  gfortran.cc perl bash python39 autoconf automake zlib unzip sox libtool ];
  nativeBuildInputs =  [  pkgs.python39.pkgs.setuptools glibc.dev  autoreconfHook perl cmake gnumake binutils gcc libgcc bash ];
  dontUseCmakeConfigure=true;
  autoreconfPhase = ''  
                     ls
                   '';
  doCheck=false;
  
  buildPhase = ''
                #tar -xvf source.tar
                cd tools/
                make openfst cub
                cd extras/OpenBLAS                
                make - ONLY_CBLAS=1 DYNAMIC_ARCH=1 TARGET=ARMV8 USE_LOCKING=1 USE_THREAD=0 NUM_THREADS=512 all
                make PREFIX=/build/kaldi/tools/extras/OpenBLAS/install install
                cd ../clapack
                mkdir -p BUILD && cd BUILD && cmake .. && make -j 10 -C F2CLIBS && make -j 10 -C BLAS && make -j 10 -C SRC && find . -name "*.a" | xargs cp -t ../../OpenBLAS/install/lib
                cd ../../../../src
	        patchShebangs .
                substituteInPlace Makefile --replace /bin/bash ${pkgs.bash}/bin/bash
                substituteInPlace makefiles/default_rules.mk --replace /bin/bash ${pkgs.bash}/bin/bash
                sh configure --openblas-root=/build/kaldi/tools/extras/OpenBLAS/install --static --fst-root=../tools/openfst --fst-version=1.8.0
                make -j 10 online2 lm rnnlm
               '';
 installPhase = '' #mkdir $out
                   mkdir -p $out/share/kaldi
                   cp -r ../egs $out/share/kaldi
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

