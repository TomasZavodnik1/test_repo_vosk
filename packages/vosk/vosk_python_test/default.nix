#{ lib, python311Packages, pkgs }:
{ pkgs ? import <nixpkgs> {} }:

pkgs.python311Packages.buildPythonApplication {
  pname = "vosk-python-test";
  version = "1.0";
  
  nativeBuildInputs = [ (pkgs.callPackage ../vosk_python {}) pkgs.python311Packages.cffi pkgs.python311Packages.pkgs.requests pkgs.python311Packages.pkgs.tqdm pkgs.python311Packages.pkgs.srt pkgs.python311Packages.pkgs.websockets ];
  buildInputs = [ (pkgs.callPackage ../vosk_python {}) pkgs.python311Packages.cffi pkgs.python311Packages.pkgs.requests pkgs.python311Packages.pkgs.tqdm pkgs.python311Packages.pkgs.srt pkgs.python311Packages.pkgs.websockets ];
  src = ./.;



}
