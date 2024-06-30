#{ lib, python311Packages, pkgs }:
{ pkgs ? import <nixpkgs> {} }:
with pkgs.python311Packages;

buildPythonApplication {
  pname = "vosk-python";
  version = "1.0";

  nativeBuildInputs = [ (callPackage ../vosk {}) ];
  #dontUnpack = false;
  src = ./.;
  #unpackPhase = " find / -name 'source.tar' 
  #                find / -name 'source.tar' -exec tar -xzvf {}";
}
