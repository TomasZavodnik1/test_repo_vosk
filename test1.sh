git add --all
git commit -m "sync"
git push
cd ../comms-ghaf-test
nix flake lock --update-input dc-pkg --extra-experimental-features nix-command --extra-experimental-features flakes --accept-flake-config
nix build .#packages.x86_64-linux.som-imx8mp-debug --extra-experimental-features nix-command --extra-experimental-features flakes
