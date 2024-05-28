git add --all
git commit -m "t"
git push
cd /root/ghaf-mesh-com/
#nix build .#packages.x86_64-linux.som-imx8mp-debug --extra-experimental-features nix-command --extra-experimental-features flakes --impure
nix flake lock --update-input dc-pkg --extra-experimental-features nix-command --extra-experimental-features flakes
nix build .#packages.x86_64-linux.som-imx8mp-debug --extra-experimental-features nix-command --extra-experimental-features flakes --impure
