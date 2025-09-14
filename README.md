S T A R R W U L F E ❄️ N I X ❄️ flakes
====================================

This is a modular NixOS + Home Manager flake that was refactored to
use a profiles/hosts layout and make modules available as templates.

#### High-level structure
- `flake.nix` — top-level flake which exposes `nixosConfigurations` for
  multiple hosts (`toyoko`, `virtua`, `randall`) and `darwinConfigurations`.
- `hosts/` — per-host NixOS modules (machine-specific). Each host may import
  profiles and per-host hardware files.
- `modules/` — reusable NixOS/Home Manager modules. Notable folders:
  - `modules/home/` — your Home Manager user module (`modules/home/default.nix`).
  - `modules/nixos/` — shared system modules and assets (wallpaper etc.).
- `profiles/` — composable profile modules (e.g., `profiles/base`,
  `profiles/desktop/gnome.nix`, `profiles/desktop/xfce.nix`) which hosts import.

#### How the flake composes configs
- Each `nixosConfigurations.<host>` calls `nixosSystem` and points to
  `./hosts/<host>/default.nix`. Hosts import profiles and modules.
- Home Manager is wired into each host via `home-manager` in the flake
  `specialArgs` and in `nixosConfigurations` modules.

#### Switching desktop profiles (GNOME <-> xfce)
- Desktop profiles live under `profiles/desktop/`. To switch a host's
  desktop, edit `hosts/<host>/default.nix` and change the imported
  desktop profile (e.g., `../../profiles/desktop/gnome.nix` ->
  `../../profiles/desktop/xfce.nix`). 
  [TODO] Alternatively, create a small
  `variables.nix` for the host and make hosts import the desired profile based
  on that variable (ZaneyOS-style).

#### Notes & highlights
- The repository uses a modular approach so adding a new host is a matter of
  creating `hosts/<name>/default.nix` that imports the proper profiles.
- Bleeding-edge packages can be handled by adding a second nixpkgs input and
  exposing `pkgsUnstable` to modules (see commented examples in `flake.nix`).
- Keep hardware-specific files (fstab, device UUIDs) local to the host and do
  not copy them between machines.

#### Quick commands
- Check the flake:
  `nix flake check --show-trace`
- Build a host config:
  `nixos-rebuild build --flake .#insert-host-name`

#### Still to come:
[ ] wire in a good Hyprland config.
[ ] put my '.configs' into Home-Manager.
[ ] test the Darwin-Nix setup with my Macbook Pro.
[ ] make a self-hosting host/profile so I can serve with NixOS too
 - Do I make LXDs, VMs for Proxmox, or do I do a whole bare-metal server? 🤔

