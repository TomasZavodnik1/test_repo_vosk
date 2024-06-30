#{ lib, python311Packages, pkgs }:
{ pkgs ? import <nixpkgs> {} }:

pkgs.python39PackagesbuildPythonApplication {
  pname = "vosk-python-test";
  version = "1.0";
  
  nativeBuildInputs = [ (pkgs.callPackage ../vosk_python {}) pkgs.python39Packages.pkgs.cffi pkgs.python39Packages.pkgs.requests pkgs.python39Packages.pkgs.tqdm pkgs.python39Packages.pkgs.srt pkgs.python39Packages.pkgs.websockets ];
  buildInputs = [ (pkgs.callPackage ../vosk_python {}) pkgs.python39Packages.pkgs.cffi pkgs.python39Packages.pkgs.requests pkgs.python39Packages.pkgs.tqdm pkgs.python39Packages.pkgs.srt pkgs.python39Packages.pkgs.websockets ];
  src = ./.;



}
