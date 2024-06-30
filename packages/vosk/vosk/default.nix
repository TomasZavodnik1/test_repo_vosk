# Copyright 2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
 pkgs,
 gnumake,
 bash
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
  nativeBuildInputs =  [ kaldi-pkg  ];

  dontUseCmakeConfigure=true;
  
  buildPhase = ''
                #tar -xvf source.tar
                cd src
                
                #compile the vosk lib, set manually the required inputs
                KALDI_ROOT=${kaldi-pkg}/kaldi OPENFST_ROOT=${kaldi-pkg}/openfst OPENBLAS_ROOT=${kaldi-pkg}/openblas  make
               '';
 installPhase = '' #create output dir
                   mkdir -p $out/lib
           
                   #copy created libs to output directory
                   find ../ -name "*.so" -exec mv {} $out/lib/ \;
	'';
}

