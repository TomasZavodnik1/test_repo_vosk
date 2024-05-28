# Copyright 2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.vosk;
  vosk-pkg = pkgs.callPackage ./vosk {};
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
