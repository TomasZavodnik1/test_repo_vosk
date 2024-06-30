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
  buildInputs = [ ( callPackage ../kaldi{} )  gnumake pkgs.python39.pkgs.setuptools pkgs.python39.pkgs.cffi pkgs.python39.pkgs.requests pkgs.python39.pkgs.tqdm pkgs.python39.pkgs.srt pkgs.python39.pkgs.websockets  pkgs.python39.pkgs.setuptools coreutils bashInteractiveFHS dash bash  cmake  gfortran.cc perl bash python39 autoconf automake zlib unzip sox libtool ];
  nativeBuildInputs =  [  pkgs.python39.pkgs.setuptools   autoreconfHook perl cmake gnumake binutils  bash ];
  dontUseCmakeConfigure=true;
  autoreconfPhase = ''  
                     ls
                   '';
  doCheck=false;
  
  buildPhase = ''
                #tar -xvf source.tar
                cd src
                #ls ${kaldi}/bin
                #ls ${kaldi}/lib
                ls ${kaldi}/share
                #ls ${kaldi}/include
                ls ${kaldi}/share/kaldi/egs
                KALDI_ROOT=${kaldi}/kaldi OPENFST_ROOT=${kaldi}/openfst OPENBLAS_ROOT=${kaldi}/openblas  make
               '';
 installPhase = '' mkdir $out
                   mkdir $out/vosk
                   
                   find src/ -name "*.a" -exec mv {} $out/vosk/ \;
	'';
}

