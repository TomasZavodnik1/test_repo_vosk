#{ lib, python311Packages, pkgs }:
{ pkgs ? import <nixpkgs> {} }:

pkgs.python311Packages.buildPythonApplication {
  pname = "vosk-python-test";
  version = "1.0";
  
  nativeBuildInputs = [ (pkgs.callPackage ../vosk_python {}) pkgs.python311Packages.cffi pkgs.python311Packages.requests pkgs.python311Packages.tqdm pkgs.python311Packages.srt pkgs.python311Packages.websockets ];
  buildInputs = [ (pkgs.callPackage ../vosk_python {}) pkgs.python311Packages.cffi pkgs.python311Packages.requests pkgs.python311Packages.tqdm pkgs.python311Packages.srt pkgs.python311Packages.websockets ];
  src = ./.;



}
