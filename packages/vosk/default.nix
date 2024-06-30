# Copyright 2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  pkgs,
  lib,
  autoconf,
  ...
}: let
  cfg = config.vosk;
  kaldi = pkgs.callPackage ../kaldi-openfst-openblas {} ;
  vosk-pkg = pkgs.callPackage ./vosk { inherit kaldi; };
in
   with lib; {
    options.vosk = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          If enabled, voice speech recognition will be built and included
        '';
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = [
        vosk-pkg
      ];
  };

}
