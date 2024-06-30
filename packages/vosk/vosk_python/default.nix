#{ lib, python311Packages, pkgs }:
{ pkgs ? import <nixpkgs> {} }:
with pkgs.python311Packages;
let
   vosk-pkg = callPackage ../vosk {}
in
buildPythonPackage {
  pname = "vosk-python";
  version = "1.0";
  phases = [ "unpackPhase" ];
  unpackPhase = ''  export VOSK_SOURCE=${vosk-pkg}  '';
  nativeBuildInputs = [ vosk-pkg cffi requests tqdm srt websockets ];
  buildInputs = [ vosk-pkg cffi requests tqdm srt websockets ];
  src = ./.;
}
