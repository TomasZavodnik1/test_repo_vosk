{ lib, 
  python311Packages, 
  pkgs
}:
#{ pkgs ? import <nixpkgs> {} }:
let
   vosk-pkg = pkgs.python311Packages.callPackage ../vosk_python {};
in
pkgs.python311Packages.buildPythonApplication {
  pname = "vosk-python-test";
  version = "1.0";
  
  propagatedBuildInputs = [ vosk-pkg pkgs.python311Packages.wavefile vosk-pkg pkgs.python311Packages.cffi pkgs.python311Packages.requests pkgs.python311Packages.tqdm pkgs.python311Packages.srt pkgs.python311Packages.websockets ];
  buildInputs = [ vosk-pkg pkgs.python311Packages.wavefile vosk-pkg pkgs.python311Packages.cffi pkgs.python311Packages.requests pkgs.python311Packages.tqdm pkgs.python311Packages.srt pkgs.python311Packages.websockets ];
  src = ./.;



}
