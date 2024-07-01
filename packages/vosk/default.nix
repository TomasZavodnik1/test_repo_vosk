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
  vosk-pkg = pkgs.callPackage ./vosk_python {};

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
