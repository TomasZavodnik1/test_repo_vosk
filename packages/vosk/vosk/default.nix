# Copyright 2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
 pkgs,
 gnumake,
 cmake,
 gfortran,
 perl,
 bash,
 python39,
 python27,
 autoconf
}:


with pkgs;
let
  kaldi-pkg = callPackage ../kaldi-openfst-openblas {};
in
stdenv.mkDerivation rec {
  pname = "vosk";
  version = "v0.3.50";
  src = ./.;
  buildInputs = [ kaldi-pkg ];
  nativeBuildInputs =  [ ];
  dontUseCmakeConfigure=true;
  doCheck=false;
  
  buildPhase = ''
                #tar -xvf source.tar
                cd src
                
                #ls /nix/store
                find ${openblas} -name "*openblas.a"
                                
                ls -la ${kaldi-pkg}/openblas/lib
                
                #ls ${kaldi}/include
                #ls ${kaldi}/share/kaldi/egs
                #asdasdas
                KALDI_ROOT=${kaldi-pkg}/kaldi OPENFST_ROOT=${kaldi-pkg}/openfst OPENBLAS_ROOT=${kaldi-pkg}/openblas  make
               '';
 installPhase = '' mkdir $out
                   mkdir $out/lib
                   find ${src} -name "*.a"
                   find ${src} -name "*.so"
                   sdadadasd
                   find ${src} -name "*.a" -exec mv {} $out/lib/ \;
                   find ${src} -name "*.so" -exec mv {} $out/lib/ \;
	'';
}

