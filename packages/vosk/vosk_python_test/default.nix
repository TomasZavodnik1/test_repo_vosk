#{ lib, python311Packages, pkgs }:
{ pkgs ? import <nixpkgs> {} }:
with pkgs.python39Packages;
buildPythonApplication {
  pname = "vosk-python-test";
  version = "1.0";

  nativeBuildInputs = [ (callPackage ../vosk_python {}) cffi requests tqdm srt websockets ];
  buildInputs = [ (callPackage ../vosk_python {}) cffi requests tqdm srt websockets ];
  src = ./.;



}
