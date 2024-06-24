#{
#  lib,
#  stdenv,
#  brotlicffi,
#  buildPythonPackage,
#  certifi,
#  chardet,
#  charset-normalizer,
#  fetchPypi,
#  fetchpatch,
#  idna,
#  pysocks,
#  pytest-mock,
#  pytest-xdist,
#  pytestCheckHook,
#  pythonOlder,
#  urllib3,
#}:
with import <nixpkgs> {};
with pkgs;

pkgs.python39.pkgs.buildPythonPackage rec {
  pname = "requests";
  version = "2.31.0";
  format = "setuptools";

  __darwinAllowLocalNetworking = true;

  src = ./.;
  nativeBuildInputs = [
   (  pkgs.callPackage ../../kaldi {} )  pkgs.python39.pkgs.pip  pkgs.python39.pkgs.cffi pkgs.python39.pkgs.requests pkgs.python39.pkgs.tqdm pkgs.python39.pkgs.websockets pkgs.python39.pkgs.srt
  ];

  propagatedBuildInputs = [
    ( pkgs.callPackage ../../kaldi {} )
  ];



  dependencies = [
     pkgs.python39.pkgs.pip  pkgs.python39.pkgs.cffi pkgs.python39.pkgs.requests pkgs.python39.pkgs.tqdm pkgs.python39.pkgs.srt pkgs.python39.pkgs.websockets
  ];


  pythonImportsCheck = [ "requests" ];

  meta = with lib; {
    description = "HTTP library for Python";
    homepage = "http://docs.python-requests.org/";
    changelog = "https://github.com/psf/requests/blob/v${version}/HISTORY.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
