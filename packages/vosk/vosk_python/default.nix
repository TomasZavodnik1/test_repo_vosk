#{ lib, python311Packages, pkgs }:
{ pkgs ? import <nixpkgs> {} }:
with pkgs.python311Packages;

buildPythonApplication {
  pname = "vosk-python";
  version = "1.0";

  nativeBuildInputs = [ (callPackage ../vosk {}) cffi requests tqdm srt websockets ];
  #dontUnpack = false;
  src = ./.;
  #unpackPhase = " find / -name 'source.tar' 
  #                find / -name 'source.tar' -exec tar -xzvf {}";
}
