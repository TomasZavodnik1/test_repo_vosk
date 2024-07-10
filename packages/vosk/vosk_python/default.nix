#{ lib, 
#  python311Packages, 
#  pkgs
#}:
{ pkgs ? import <nixpkgs> {} }:

let
   vosk-pkg = pkgs.callPackage ../vosk {};
in
pkgs.python311Packages.buildPythonPackage {
  pname = "vosk-python";
  version = "1.0";
  #phases = [ "unpackPhase" ];
  preBuild = ''  export VOSK_SOURCE=/build;
                 cp -r ${vosk-pkg}/* /build
                 chmod -R 777 /build
                 substituteInPlace vosk_builder.py  --replace %cpp cpp
  '';

  nativeBuildInputs = [ pkgs.which pkgs.gnumake pkgs.python311Packages.wavefile vosk-pkg pkgs.python311Packages.cffi pkgs.python311Packages.requests pkgs.python311Packages.tqdm pkgs.python311Packages.srt pkgs.python311Packages.websockets pkgs.python311Packages.srt pkgs.python311Packages.zipfile2 pkgs.python311Packages.pyzipper ];
  propagatedBuildInputs = [ pkgs.which pkgs.gnumake pkgs.python311Packages.wavefile vosk-pkg pkgs.python311Packages.cffi pkgs.python311Packages.requests pkgs.python311Packages.tqdm pkgs.python311Packages.srt pkgs.python311Packages.websockets pkgs.python311Packages.srt pkgs.python311Packages.zipfile2 pkgs.python311Packages.pyzipper  ];
  
  src = ./.;
  
  preFixup=''  cp ${vosk-pkg}/src/libvosk.so $out/lib/python3.11/site-packages/vosk 
               '';
}
