#{ lib, python311Packages, pkgs }:
{ pkgs ? import <nixpkgs> {} }:
with pkgs.python39Packages;
buildPythonPackage {
  pname = "vosk-python";
  version = "1.0";

  nativeBuildInputs = [ (callPackage ../vosk {}) cffi requests tqdm srt websockets ];
  buildInputs = [ (callPackage ../vosk {}) cffi requests tqdm srt websockets ];
  src = ./.;
}
