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
  pname = "vosk-kaldi-openblas";
  version = "v0.3.50";
  src = ./.;
  buildInputs = [ (  pkgs.callPackage ../kaldi {} )  glibc.dev gcc libgcc gnumake pkgs.python39.pkgs.setuptools pkgs.python39.pkgs.cffi pkgs.python39.pkgs.requests pkgs.python39.pkgs.tqdm pkgs.python39.pkgs.srt pkgs.python39.pkgs.websockets  pkgs.python39.pkgs.setuptools coreutils bashInteractiveFHS dash bash  cmake  gfortran.cc perl bash python39 autoconf automake zlib unzip sox libtool ];
  nativeBuildInputs =  [ (  pkgs.callPackage ../kaldi {} )  pkgs.python39.pkgs.setuptools glibc.dev  autoreconfHook perl cmake gnumake binutils gcc libgcc bash ];
  dontUseCmakeConfigure=true;
  autoreconfPhase = ''  
                     ls
                   '';
  doCheck=false;
  
  buildPhase = ''
                cd src
                cp -r ../../tools/extras/OpenBLAS ../../tools
                patchShebangs .
                KALDI_ROOT=../.. make
                cd ../c
                KALDI_ROOT=../.. make
                cd ../python
                KALDI_ROOT=../.. python3 setup.py build
                KALDI_ROOT=../.. python3 setup.py install --prefix=$out --root=$out
               
               '';
 installPhase = '' #mkdir $out
                   mkdir $out/bin
                   cp -r ../c/* $out/bin
	'';
}

