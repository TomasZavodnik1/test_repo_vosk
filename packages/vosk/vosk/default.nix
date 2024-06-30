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
  pname = "vosk";
  version = "v0.3.50";
  src = ./.;
  buildInputs = [  ];
  nativeBuildInputs =  [ ];
  dontUseCmakeConfigure=true;
  doCheck=false;
  
  buildPhase = ''
                #tar -xvf source.tar
                cd src
                #ls ${kaldi}/bin
                #ls ${kaldi}/lib
                cd ${kaldi}
                pwd
                
                #ls ${kaldi}/share
                #ls ${kaldi}/include
                #ls ${kaldi}/share/kaldi/egs
                KALDI_ROOT=${kaldi}/kaldi OPENFST_ROOT=${kaldi}/openfst OPENBLAS_ROOT=${kaldi}/openblas  make
               '';
 installPhase = '' mkdir $out
                   mkdir $out/vosk
                   
                   find src/ -name "*.a" -exec mv {} $out/vosk/ \;
	'';
}

